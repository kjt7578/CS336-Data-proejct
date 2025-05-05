import paramiko
import sys
import os
from getpass import getpass


def test_conn(host, user, pwd, timeout):
    cl = paramiko.SSHClient()
    cl.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    temp = None
    try:
        cl.connect(hostname=host, port=22, username=user, password=pwd, timeout=timeout)
        tp = cl.get_transport()
        if tp and tp.is_active():
            return True
        else:
            return False
    except paramiko.AuthenticationException:
        print(f"Authentication failed for {user}@{host}. Please check username/password.")
        return False
    except paramiko.SSHException as sshException:
        print(f"Unable to establish SSH connection to {host}: {sshException}")
        return False
    finally:
        if cl:
            cl.close()

def home(host, user, pwd, timeout=5):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    home_dir = None
    try:
        client.connect(hostname=host, port=22, username=user, password=pwd, timeout=timeout)
        stdin, stdout, stderr = client.exec_command('pwd')
        exit_status = stdout.channel.recv_exit_status()
        if exit_status == 0:
             home_dir = stdout.read().decode().strip()
        else:
             error = stderr.read().decode().strip()
             print(f"Authenticator: Error getting home directory: {error}")
    finally:
        if client:
            client.close()
    return home_dir


def up_connect():
    print('==========Begin SSH Authentication Module==========')
    host = input("Enter the iLab address: ")
    user = input("Enter your iLab username: ")
    pwd = getpass("Enter your iLab password: ")
    script_path = None

    if test_conn(host, user, pwd, 5):
        print("Initial SSH connection test successful!")
        home_dir = home(host, user, pwd)

        if home_dir:
            print(f"Determined remote home directory: {home_dir}")
            ans = input(f"Is your iLab script directory within {home_dir}? (y/n): ").lower().strip()
            if ans == 'y':
                relative_path = input(f"Enter path relative to {home_dir}: ").strip().strip('/')
                script_path = home_dir.rstrip('/') + '/' + relative_path
            elif ans == 'n':
                script_path = input("Enter the full path to the directory containing ilab_script.py: ").rstrip('/')
            else:
                print("Invalid input. Please enter 'y' or 'n'.")
                sys.exit(1)

            print("==========Finish SSH Authentication Module==========")
            os.system('cls' if os.name == 'nt' else 'clear')
            print("==========================")
            print("SSH Credentials Processed")
            print("==========================")
            return {
                'hostname': host,
                'username': user,
                'password': pwd,
                'script_location': script_path,
                'home_directory': home_dir
            }
        else:
            print("********************")
            print(f"Failed to determine the home directory on {host}. Cannot proceed.")
            print("********************")
            sys.exit(1)
    else:
        print("********************")
        print(f"Failed to connect to {host} via SSH. Please check your credentials and try again.")
        print("********************")
        sys.exit(1)