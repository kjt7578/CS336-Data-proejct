import sys
import psycopg2
import pandas as pd

def read_query():
    if len(sys.argv) > 1:
        return ' '.join(sys.argv[1:])
    else:
        print("Enter your SQL query below. Press Ctrl+D (Linux/macOS) or Ctrl+Z (Windows) to finish:")
        return sys.stdin.read()

def main():
    query = read_query().strip()

    if not query.lower().startswith("select"):
        print("ERROR: Only SELECT statements are allowed.")
        return

    try:
        conn = psycopg2.connect(
            dbname="jk2065",
            user="jk2065",
            host="localhost"
        )

        df = pd.read_sql_query(query, conn)
        if df.empty:
            print("Query executed successfully, but no rows returned.")
        else:
            print(df.to_string(index=False))

    except Exception as e:
        print("ERROR during query execution:", e)

    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    main()
