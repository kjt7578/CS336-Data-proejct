# CS336-Data-project

start.py -> **Main file to run. Houses loop and calls all other modules. Keeps SSH configuration, persistent connection.**
authenticator.py -> **Handles ssh authentication, testing its success, and finding the proper home path. Used to locate where ilab_script.py lives.**
cleaner.py -> **Cleans the output from data_llm.py**
data_llm.py -> **Where the prompt and logic for the LLM is kept. Passes raw response to cleaner which processes and strips it, then returns the cleaned SQL query.**
file_exists.py -> **Checks whether the ilab_script.py file exists in the directory given by authenticator.py. Closes program if it doesn't.**
ilab_exec.py -> **Handles passing the query to the ilab server specified in authenticator.py**

1. Name of all team members
JEONG TAE KIM jk2065, Tayyar Mustamir tm858, Jiwanshu Verma jv500, RITHI CHAUHAN rc1250

2. Contributions
jk2065: Implemented ilab_script.py including extra credit
tm858: created schema_subset.sql
jv500: created start.py and its related modules for ssh auth, response cleaning, llm calling, passing to ilab, and file existence/automatic home path checks.
rc1250: create_database.sql

3. What you found challenging

jv500 - What was challenging was debugging the prompt, as well as cleaning its responses. Additionally, sometimes I ran into issues with the file existence check, which I was able to debug with the LLMs. Most of the debugging took my own time though, as the LLMs were unhelpful most of the time and gave me boilerplate code which had the exact same issues. I eventually managed to find the issues and fixed it (had to do with how paths are in the iLab). Also, there was an issue at the beginning where the ilab_script.py wasn't properly receiving the generated query, but managed to iron that out (it had to be compressed into a single line).

4. What you found interesting

5. Did you do the extra credit
Yes

Referenced code:

llama-cpp-python docs for implementing LLM usage: https://github.com/abetlen/llama-cpp-python

Paramiko usage and API:
https://docs.paramiko.org/en/stable/
https://docs.paramiko.org/en/stable/api/sftp.html
https://qxf2.com/blog/ssh-using-python-paramiko/
https://www.linode.com/docs/guides/use-paramiko-python-to-ssh-into-a-server/
https://medium.com/featurepreneur/ssh-in-python-using-paramiko-e08fd8a039f7
https://medium.com/nerd-for-tech/paramiko-how-to-transfer-files-with-remote-system-sftp-servers-using-python-52d3e51d2cfa

Regular Expressions (VERY USEFUL):
https://docs.python.org/3/library/re.html
https://www.w3schools.com/python/python_regex.asp

Try/Except and Exceptions, very useful compared to debug statements and the like (especially with Paramiko):
https://docs.python.org/3/library/exceptions.html
https://www.w3schools.com/python/python_try_except.asp
