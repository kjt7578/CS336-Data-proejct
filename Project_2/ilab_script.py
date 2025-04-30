import sys
import psycopg2
import pandas as pd
import os

DB_NAME = 'jk2065' #Change this into the Group DB name
DB_USER = 'jk2065' #Change this into your NetID
DB_HOST = 'postgres.cs.rutgers.edu'
DB_PASSWORD = None

def execute_query(sql_query):
    """
    Connects to the database, executes the given SQL query,
    and prints the results as a formatted table.

    Args:
        sql_query (str): The SQL SELECT query to execute.
    """
    conn = None
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            host='postgres.cs.rutgers.edu',
            port='5432',
            password=DB_PASSWORD
        )
        conn.autocommit = True
        cur = conn.cursor()

        if not sql_query.strip().upper().startswith("SELECT"):
             print("Error: Only SELECT queries are allowed.", file=sys.stderr)
             return

        print(f"Executing query: {sql_query}", file=sys.stderr) # Log query to stderr
        cur.execute(sql_query)

        if cur.description:
            col_names = [desc[0] for desc in cur.description]

            results = cur.fetchall()

            if results:
                df = pd.DataFrame(results, columns=col_names)
                pd.set_option('display.max_rows', None)
                pd.set_option('display.max_columns', None)
                pd.set_option('display.width', None)
                print(df.to_string(index=False))
            else:
                print("Query executed successfully, but returned no results.")

        else:
             print("Query executed successfully. No results to display (e.g., DDL or non-SELECT).")

        cur.close()

    except psycopg2.Error as e:
        print(f"Database Error: {e}", file=sys.stderr)
        print(f"SQLSTATE: {e.pgcode}", file=sys.stderr)
        print(f"Message: {e.pgerror}", file=sys.stderr)

    except pd.errors.PandasError as e:
         print(f"Pandas Formatting Error: {e}", file=sys.stderr)

    except Exception as e:
        # Catch any other unexpected errors
        print(f"An unexpected error occurred: {e}", file=sys.stderr)

    finally:
        # Ensure the connection is closed even if errors occur
        if conn:
            conn.close()
            print("Database connection closed.", file=sys.stderr) # Log closure to stderr

if __name__ == "__main__":
    sql_query_to_run = None

    if len(sys.argv) > 1:
        sql_query_to_run = sys.argv[1]
        print("Received query via command-line argument.", file=sys.stderr)
    else:
        # --- Extra Credit Part ---
        print("No command-line argument provided. Reading query from stdin...", file=sys.stderr)
        if not sys.stdin.isatty():
             sql_query_to_run = sys.stdin.read().strip()
             if not sql_query_to_run:
                  print("Error: Received empty query from stdin.", file=sys.stderr)
                  sys.exit(1)
             print("Received query via stdin.", file=sys.stderr)
        else:
             print("Error: No query provided via argument or stdin pipe.", file=sys.stderr)
             print("Usage (Argument): python3 ilab_script.py \"SELECT * FROM your_table LIMIT 5;\"", file=sys.stderr)
             print("Usage (Stdin): echo \"SELECT * FROM your_table LIMIT 5;\" | python3 ilab_script.py", file=sys.stderr)
             sys.exit(1)

    execute_query(sql_query_to_run)
