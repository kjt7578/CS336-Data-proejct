###
# This is the main file, where all execution should begin!
# Make sure that the following files are in the same directory:
# schema_subset.sql, database_llm.py, processing_prompt.py, authenticator.py, cleaner.py, file_exists.py, ilab_exec.py, and the model (Phi-3.5-mini-instruct-Q4_K_M.gguf).
# Paths or URLs are not hardcoded, so choose whatever iLab you like, as well as where your
# iLab script is located. Give only the path to the folder it is within, not the actual path of the file.
# Trailing slashes are ignored.
###

# import packages
import sys
import os
import time
import paramiko
from llama_cpp import Llama

# import required modules
import authenticator
import file_exists
import ilab_exec as run
import processing_prompt as data_llm

class LLM:
    def __init__(self):
        print("Loading LLM...")
        self.llm = Llama(
            model_path="./Phi-3.5-mini-instruct-Q4_K_M.gguf",
            n_ctx=2048,
            n_threads=4,
            verbose=False
        )
        self.schema = self.schematic()
        self.ssh_config = {}
        self.persist_sshclient = None

    def schematic(self):
        try:
            with open('schema_subset.sql', 'r') as f:
                return f.read()
        except FileNotFoundError:
            print("Error: schema_subset.sql not found!")
            sys.exit(1)


    def setup_ssh(self, timeout=10):
        self.ssh_config = authenticator.up_connect()
        print("\nEstablishing persistent SSH connection...")
        try:
            self.persist_sshclient = paramiko.SSHClient()
            self.persist_sshclient.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            self.persist_sshclient.connect(
                hostname=self.ssh_config['hostname'],
                username=self.ssh_config['username'],
                password=self.ssh_config['password'],
                timeout=timeout
            )
            print("Storing connection...")
            time.sleep(1)
            print("Created persistent SSH connection.")
            print("SSH configuration loaded successfully.")

        except paramiko.AuthenticationException:
            print(f"Authentication failed when establishing persistent connection for {self.ssh_config.get('username')}@{self.ssh_config.get('hostname')}.")
            self.persist_sshclient = None
            sys.exit(1)
        except Exception as e:
            print(f"Failed to establish persistent SSH connection for some other reason: {e}")
            self.close_ssh()
            sys.exit(1)

    def close_ssh(self):
        if self.persist_sshclient:
            print("\nClosing persistent connection...")
            try:
                self.persist_sshclient.close()
                print("SSH connection closed.")
                self.persist_sshclient = None
            except Exception as e:
                print(f"Error closing SSH connection: {e}")

    def script_exists(self):
        if not self.persist_sshclient or not self.persist_sshclient.get_transport().is_active():
             print("Error: SSH connection is not active for file check.")
             sys.exit(1)
        if 'home_directory' not in self.ssh_config:
            print("Error: Remote home directory was not determined during setup.")
            sys.exit(1)

        f = file_exists.exists(
            ssh=self.persist_sshclient,
            path=self.ssh_config['script_location'],
            file_name='ilab_script.py',
            home_dir=self.ssh_config['home_directory']
        )
        if f:
            print("ilab_script.py exists. Proceed.")
            time.sleep(1)
            os.system('cls' if os.name == 'nt' else 'clear')
            return True
        else:
            print("ilab_script.py doesn't exist! Maybe you typed the directory name wrong?")
            self.close_ssh()
            sys.exit(1)

    def loop(self):
        print("\nData LLM: Ask about the database.")
        print("Type 'exit' to quit")
        print("==========================")

        while True:
            try:
                user_question = input("\nEnter your question: ")
            except EOFError:
                print("\nInput stream closed.")
                break

            if user_question.strip().lower() == "exit":
                print("Goodbye!")
                break

            if not user_question.strip():
                 continue

            print("\nGenerating SQL...")
            sql_query = data_llm.gen(self.llm, self.schema, user_question)

            if not sql_query:
                print("\nQuery Result:\nError: LLM did not generate a valid SQL query after cleaning.")
            else:
                print(f"Using SQL Query: \n{sql_query}")
                print("\nExecuting query on ILAB...")
                result = run.ilab(sql_query, self.persist_sshclient, self.ssh_config)
                print("\nQuery Result:")
                print(result)

            print("-" * 50)

def main():
    db_llm = None
    try:
        db_llm = LLM()
        os.system('cls' if os.name == 'nt' else 'clear')
        db_llm.setup_ssh()
        db_llm.script_exists()
        db_llm.loop()

    except KeyboardInterrupt:
        print("\nExiting...")

    finally:
        if db_llm:
            db_llm.close_ssh()
        print("Exiting program.")
        sys.exit(0)

if __name__ == "__main__":
    main()