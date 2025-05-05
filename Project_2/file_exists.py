def exists(ssh, path, file_name, home_dir):
    if not ssh or not ssh.get_transport().is_active():
        print("Error in file_exists: Received inactive SSH client.")
        return False
    if not home_dir:
        print("Error in file_exists: Invalid home directory provided.")
        return False

    init_path = f"{path}/{file_name}"
    check = None

    if init_path.startswith('~/'):
        check = home_dir.rstrip('/') + '/' + init_path[2:]
    elif init_path.startswith('~'):
         check = home_dir.rstrip('/') + '/' + init_path[1:]
    else:
        check = init_path

    sftp = None
    try:
        with ssh.open_sftp() as sftp:
            with sftp.open(check, 'r'):
                return True
    except FileNotFoundError:
        print(f"File not found at {check}")
        return False
    except IOError as e:
        print(f"Error accessing file at {check}. Reason: {e}")
        return False
    except Exception as e:
        print(f"Something weird happened (path: {check}): {e}")
        return False