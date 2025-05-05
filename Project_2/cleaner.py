###
# Handles cleaning the output of the LLM and returns the cleaned version
###

import re

def cleaner(raw):
    resp = raw['choices'][0]['text'].strip()
    sql = ""
    match = re.search(r"```(?:sql)?\s*(.*?)\s*```", resp, re.IGNORECASE | re.DOTALL)
    if match:
        sql = match.group(1).strip()
    else:
        sql = resp
    if sql:
        sql = re.sub(r"^\s*BEGIN\s*;\s*", "", sql, flags=re.IGNORECASE).strip()
        sql = re.sub(r"\s*COMMIT\s*;\s*$", "", sql, flags=re.IGNORECASE).strip()
        if sql.endswith(';'):
            sql = sql[:-1].strip()
        if sql:
            sql += ';'
        if sql == ';':
            sql = ""
    return sql