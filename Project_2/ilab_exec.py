###
# Execute generated SQL on remote iLab via remote script.
# Gets passed the persistent SSH connection established in start.py
# and the config for the script location
###

def ilab(sql, ssh, config):
    if not sql:
        return "Error: Cannot execute an empty SQL query."

    if not ssh or not ssh.get_transport().is_active():
        error_msg = "Error: SSH connection is not active. Cannot execute query."
        print(error_msg)
        return error_msg

    try:
        script_path = f"{config['script_location']}/ilab_script.py"
        command = f'python3 {script_path}'
        stdin, stdout, stderr = ssh.exec_command(command, get_pty=False)
        stdin.write(sql.replace('\n', ' ') + '\n')
        stdin.flush()
        stdin.channel.shutdown_write()

        std_output = stdout.read().decode()
        error_output = stderr.read().decode()

        if error_output:
            return f"Error Output (stderr):\n{error_output}\nStandard Output (stdout):\n{std_output}"
        else:
            return std_output

    except Exception as e:
        print(f"Error during SSH command execution: {str(e)}")
        return f"SSH Execution Error: {str(e)}"
