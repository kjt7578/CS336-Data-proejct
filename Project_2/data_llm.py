###
# Make sure that the schema_subset.sql, data_llm.py, and the model (Phi-3.5-mini-instruct-Q4_K_M.gguf)
# are in the same folder. Paths or URLs are not hardcoded, so choose whatever iLab you like, as well as where your
# iLab script is located. Give only the path to the folder it is within, not the actual path of the file. Trailing
# slashes are ignored.
###

#!/usr/bin/env python3
import sys
import os
import re
import paramiko
import subprocess
from getpass import getpass
from llama_cpp import Llama

class DatabaseLLM:
    def __init__(self):
        print("Loading LLM...")
        self.llm = Llama(
            model_path="./Phi-3.5-mini-instruct-Q4_K_M.gguf",
            n_ctx=2048,
            n_threads=4,
            verbose=False
        )

        self.schema = self._load_schema()

        self.ssh_config = {
            'hostname': None,
            'username': None,
            'password': None,
            'script_location': None
        }
        
    def _load_schema(self):
        try:
            with open('schema_subset.sql', 'r') as f:
                return f.read()
        except FileNotFoundError:
            print("Error: schema_subset.sql not found!")
            sys.exit(1)

    def test_ssh_conn(self, host, user, pwd, timeout):
        cl = paramiko.SSHClient()
        cl.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        try:
            cl.connect(hostname=host, port=22, username=user, password=pwd, timeout=timeout)
            tp = cl.get_transport()
            if tp and tp.is_active():
                cl.close()
                return True
            else:
                return False
        except Exception as e:
            print(f"Error connecting to {host}:{22}: {e}")
            return False
        finally:
            cl.close()

    def setup_ssh(self):
        self.ssh_config['hostname'] = input("Enter the iLab address: ")
        self.ssh_config['username'] = input("Enter your iLab username: ")
        self.ssh_config['password'] = getpass("Enter your iLab password: ")
        self.ssh_config['script_location'] = input("Where is your ilab_script.py located on the iLab (just to the folder it lives within)? ").rstrip('/')
        if self.test_ssh_conn(self.ssh_config['hostname'], self.ssh_config['username'], self.ssh_config['password'], 5):
            print("SSH connection successful!")
        else:
            print("Failed to connect to SSH. Please check your credentials and try again.")
            sys.exit(1)

    def generate_query(self, user_question):
        prompt = f"""You are an SQL query generator that works with the provided database schema:

        {self.schema}

        Based on the schema, generate ONLY the single SELECT SQL query required for this question.
        Do NOT include transaction control statements like BEGIN, COMMIT, or ROLLBACK.
        Wrap the SQL query in ```sql ... ``` fences. Do not add any text before or after the fences.

        Question: {user_question}

        SQL Query:"""

        output = self.llm(
            prompt,
            max_tokens=200,
            stop=["</s>"],
            echo=False
        )

        raw_response = output['choices'][0]['text'].strip()

        sql_query = ""

        match = re.search(r"```(?:sql)?\s*(.*?)\s*```", raw_response, re.IGNORECASE | re.DOTALL)
        if match:
            sql_query = match.group(1).strip()
        else:
            sql_query = raw_response

        if sql_query:
            sql_query = sql_query.removeprefix("BEGIN;").strip()
            sql_query = sql_query.removesuffix("COMMIT;").strip()
            if sql_query and not sql_query.endswith(';'):
                sql_query += ';'
            if sql_query == ';':
                sql_query = ""

        print(f"Cleaned Query from generate_query: '{sql_query}'")

        return sql_query

    '''def extract_sql_query(self, llm_response):
        match = re.search(r"```(?:sql)?\s*(.*?)\s*```", llm_response, re.IGNORECASE | re.DOTALL)
        if match:
            sql_query = match.group(1).strip()
        else:
            sql_query = llm_response.strip()

        if sql_query and not sql_query.endswith(';'):
            sql_query += ';'

        if sql_query == ';':
            print("Warning: Extracted query is empty ';'. Check LLM generation.", file=sys.stderr)
            return ""

        return sql_query'''
    
    def execute_query_on_ilab(self, sql_query, use_stdin=False):
        if not sql_query:
            return "Error: Cannot execute an empty SQL query."
        try:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(
                hostname=self.ssh_config['hostname'],
                username=self.ssh_config['username'],
                password=self.ssh_config['password']
            )

            script_path = f"{self.ssh_config['script_location']}/ilab_script.py"

            if use_stdin:
                command = f'python3 {script_path}'
                stdin, stdout, stderr = ssh.exec_command(command, get_pty=False)
                stdin.write(sql_query.replace('\n', ' ') + '\n')
                stdin.flush()
                stdin.channel.shutdown_write()
            else:
                command = f'python3 {script_path} "{sql_query.replace('"', '\\"')}"'
                stdin, stdout, stderr = ssh.exec_command(command, get_pty=False)

            std_output = stdout.read().decode()
            error_output = stderr.read().decode()
            
            ssh.close()

            if error_output:
                return f"Error Output (stderr):\n{error_output}\nStandard Output (stdout):\n{std_output}"
            else:
                return std_output

        except Exception as e:
            return f"SSH Connection/Execution Error: {str(e)}"

    def run_interactive_loop(self):
        print("Data LLM: Ask about the database.")
        print("Type 'exit' to quit")
        print("==========================")

        while True:
            user_question = input("\nEnter your question: ")

            if user_question.lower() == "exit":
                print("Goodbye!")
                break

            print("\nGenerating SQL query...")
            sql_query = self.generate_query(user_question)

            print(f"Using SQL Query: \n {sql_query}")

            print("\nExecuting query on ILAB...")
            if not sql_query:
                print("\nQuery Result:\nError: LLM did not generate a valid SQL query after cleaning.")
            else:
                result = self.execute_query_on_ilab(sql_query, use_stdin=True)
                print("\nQuery Result:")
                print(result)
            print("-" * 50)

def main():
    try:
        db_llm = DatabaseLLM()
        os.system('cls' if os.name == 'nt' else 'clear')
        db_llm.setup_ssh()
        db_llm.run_interactive_loop()
    except KeyboardInterrupt:
        print("\nExiting...")
        sys.exit(0)
    except Exception as e:
        print(f"Error: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
