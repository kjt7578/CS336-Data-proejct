# CS336-Data-proejct

0. Please write down the full names and netids of both your team members.
jk2065, tm858, jv500

1. Are there known issues or functions that aren't working currently in your
   attached code? If so, explain. (note that you will get half credit for any reasonably sized bug that is fully explained in the readme)

2. Collaboration: Who did you collaborate with on this project? What resources and refer-
ences did you consult? Please also specify on what aspect of the project you collaborated or
consulted.
jk2065: Participated normalized_schema.sql. Created codes for videos(error, output, selecting table) and Recorded videos.
tm858: Participated normalized_schema.sql. Designed the database structure, implemented key components like the Ethnicity_Code table, properly handled race normalization.
rc1250: Found and wrote out functional dependencies and aided in mapping out structure for normalized tables
jv500: Wrote out the normalized relations in 3rd Normal Form, ensuring it is lossless and dependancy preserving.

3.What are some interesting questions about mortgages in NJ your database can answer?
How do loan approval rates differ across various counties in New Jersey, and are there disparities by income level?
What are the most common reasons for loan denials, and how do these reasons vary by applicant race or ethnicity?
Are there disparities in loan approval rates based on applicant demographics that persist even when controlling for income levels?

4. What problems did you face developing code for this project? Around how long did you spend on this project (This helps me decide what I need to explain more clearly for the next projects)
We encountered several challenges while developing this project. The main difficulty was properly structuring the location data with appropriate composite keys and handling the multi-valued race attributes in a way that maintained referential integrity. Working with the complex joins for the LocationMapping was particularly tricky, as was ensuring proper type conversions from text to appropriate numeric types while handling empty strings.
We spent approximately 15-20 hours on this project, with most of the time devoted to normalizing the tables and debugging the complex data relationships.

5. If you prefer, you can turn in your videos here as links instead of uploading them to canvas. These links must remain live until you recieve your final grade in this course, and should include some dating indication such as upload date to show they were done before the deadline.



CSV.mp4
https://drive.google.com/file/d/1PoMRMPKNDJOdEL1YARwiNL6BiixSa3aR/view?usp=drive_link

Error.mp4
https://drive.google.com/file/d/1mdv4aUeE_EsaGyUx0HEwF6LXHRRRAwrD/view?usp=drive_link

TableLookup.mp4
https://drive.google.com/file/d/1uUUuWtDE0PNTSPdfpkuEm5f2WFPk7A_k/view?usp=drive_link
