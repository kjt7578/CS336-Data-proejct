-- Creating tables 
CREATE TABLE Loan_Type (
  loan_type INT PRIMARY KEY,
  loan_type_name TEXT
);







-- Inserting data
INSERT INTO Loan_Type
SELECT DISTINCT loan_type, loan_type_name
FROM preliminary
WHERE loan_type IS NOT NULL;
