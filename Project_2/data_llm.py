###
# The prompt for the LLM. The LLM and schema are passed through
# to this method, and cleaner is called to clean the response
# The cleaned response is returned to the main function
###

import cleaner as cut

def gen(llm, schematic, user_question):
    prompt = f"""You are an SQL query generator that works with the provided database schema:

    {schematic}
    
    Based on the schema, generate ONLY the single SELECT SQL query required for this question.
    Do NOT include transaction control statements like BEGIN, COMMIT, or ROLLBACK.
    Wrap the SQL query in ```sql ... ``` fences. Do not add any text before or after the fences.

    Question: {user_question}

    SQL Query:"""

    out = llm(prompt, max_tokens=200, stop=["</s>"], echo=False)

    cleaned = cut.cleaner(out)

    return cleaned
