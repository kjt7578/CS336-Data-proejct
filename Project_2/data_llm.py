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
            n_threads=4
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
        
        The user will provide the question here: {user_question} 
        
        You are to generate simply an SQL SELECT query. No explanations are allowed, so do not generate them. Only generate the query that best works with the question. It should be a valid PostGRES SQL SELECT statement. 
        
        SQL Query:"""
        
        output = self.llm(
            prompt,
            max_tokens=200,
            stop=["</s>", "\n\n"],
            echo=False
        )
        
        return output['choices'][0]['text'].strip()
    
    def extract_sql_query(self, llm_response):
        patterns = [
            r'SELECT.*?;',
            r'SELECT.*?(?=\n|$)',
            r'SQL Query:?\s*(SELECT.*?)(?=\n|$)',
            r'```sql\s*(SELECT.*?)\s*```',
            r'```\s*(SELECT.*?)\s*```'
        ]
        
        for pattern in patterns:
            match = re.search(pattern, llm_response, re.IGNORECASE | re.DOTALL)
            if match:
                sql_query = match.group(1 if pattern.count('(') > 0 else 0)
                sql_query = sql_query.strip()
                if not sql_query.endswith(';'):
                    sql_query += ';'
                return sql_query

        return llm_response.strip()
    
    def execute_query_on_ilab(self, sql_query, use_stdin=False):
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
                stdin, stdout, stderr = ssh.exec_command(command, get_pty=True)
                stdin.write(sql_query + '\n')
                stdin.flush()
                stdin.channel.shutdown_write()
            else:
                command = f'python3 {script_path} "{sql_query.replace('"', '\\"')}"'
                stdin, stdout, stderr = ssh.exec_command(command, get_pty=True)

            error_output = stderr.read().decode()
            std_output = stdout.read().decode()
            
            ssh.close()
            
            if error_output and "Database Error" in error_output:
                return f"Error: {error_output}"
            else:
                return std_output
            
        except Exception as e:
            return f"SSH Error: {str(e)}"
    
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
            llm_response = self.generate_query(user_question)
            print(f"LLM Response: \n {llm_response}")
            
            sql_query = self.extract_sql_query(llm_response)
            print(f"Extracted SQL Query: \n {sql_query}")
            
            print("\nExecuting query on ILAB...")
            result = self.execute_query_on_ilab(sql_query, use_stdin=True)  # Use stdin for extra credit
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
