-- 01. LOAN TYPE
DROP TABLE IF EXISTS Loan_Type CASCADE;
CREATE TABLE Loan_Type (
  loan_type INT PRIMARY KEY,
  loan_type_name TEXT
);
INSERT INTO Loan_Type
SELECT DISTINCT loan_type, loan_type_name
FROM preliminary
WHERE loan_type IS NOT NULL;

-- 02. PROPERTY TYPE
DROP TABLE IF EXISTS Property_Type CASCADE;
CREATE TABLE Property_Type (
  property_type INT PRIMARY KEY,
  property_type_name TEXT
);
INSERT INTO Property_Type
SELECT DISTINCT property_type, property_type_name
FROM preliminary
WHERE property_type IS NOT NULL;

-- 03. LOAN PURPOSE
DROP TABLE IF EXISTS Loan_Purpose CASCADE;
CREATE TABLE Loan_Purpose (
  loan_purpose INT PRIMARY KEY,
  loan_purpose_name TEXT
);
INSERT INTO Loan_Purpose
SELECT DISTINCT loan_purpose, loan_purpose_name
FROM preliminary
WHERE loan_purpose IS NOT NULL;

-- 04. AGENCY
DROP TABLE IF EXISTS Agency CASCADE;
CREATE TABLE Agency (
  agency_code INT PRIMARY KEY,
  agency_name TEXT,
  agency_abbr TEXT
);
INSERT INTO Agency
SELECT DISTINCT agency_code, agency_name, agency_abbr
FROM preliminary
WHERE agency_code IS NOT NULL;

-- 05. OWNER OCCUPANCY
DROP TABLE IF EXISTS OwnOcc CASCADE;
CREATE TABLE OwnOcc (
  owner_occupancy INT PRIMARY KEY,
  owner_occupancy_name TEXT
);
INSERT INTO OwnOcc
SELECT DISTINCT owner_occupancy, owner_occupancy_name
FROM preliminary
WHERE owner_occupancy IS NOT NULL;

-- 06. PREAPPROVAL
DROP TABLE IF EXISTS PreApprove CASCADE;
CREATE TABLE PreApprove (
  preapproval INT PRIMARY KEY,
  preapproval_name TEXT
);
INSERT INTO PreApprove
SELECT DISTINCT preapproval, preapproval_name
FROM preliminary
WHERE preapproval IS NOT NULL;

-- 07. ACTION TAKEN
DROP TABLE IF EXISTS Action_Taken CASCADE;
CREATE TABLE Action_Taken (
  action_taken INT PRIMARY KEY,
  action_taken_name TEXT
);
INSERT INTO Action_Taken
SELECT DISTINCT action_taken, action_taken_name
FROM preliminary
WHERE action_taken IS NOT NULL;

-- 08. PURCHASER TYPE
DROP TABLE IF EXISTS Purchaser_Type CASCADE;
CREATE TABLE Purchaser_Type (
  purchaser_type INT PRIMARY KEY,
  purchaser_type_name TEXT
);
INSERT INTO Purchaser_Type
SELECT DISTINCT purchaser_type, purchaser_type_name
FROM preliminary
WHERE purchaser_type IS NOT NULL;

-- 09. HOEPA STATUS
DROP TABLE IF EXISTS HOEPA_Status CASCADE;
CREATE TABLE HOEPA_Status (
  hoepa_status INT PRIMARY KEY,
  hoepa_status_name TEXT
);
INSERT INTO HOEPA_Status
SELECT DISTINCT hoepa_status, hoepa_status_name
FROM preliminary
WHERE hoepa_status IS NOT NULL;

-- 10. LIEN STATUS
DROP TABLE IF EXISTS Lien_Status CASCADE;
CREATE TABLE Lien_Status (
  lien_status INT PRIMARY KEY,
  lien_status_name TEXT
);
INSERT INTO Lien_Status
SELECT DISTINCT lien_status, lien_status_name
FROM preliminary
WHERE lien_status IS NOT NULL;

-- 11. DENIAL REASON
DROP TABLE IF EXISTS Denial_Reason CASCADE;
CREATE TABLE Denial_Reason (
  denial_reason_code INT PRIMARY KEY,
  denial_reason_name TEXT
);
INSERT INTO Denial_Reason
SELECT DISTINCT denial_reason_1, denial_reason_name_1
FROM preliminary
WHERE denial_reason_1 IS NOT NULL
UNION
SELECT DISTINCT denial_reason_2, denial_reason_name_2
FROM preliminary
WHERE denial_reason_2 IS NOT NULL
UNION
SELECT DISTINCT denial_reason_3, denial_reason_name_3
FROM preliminary
WHERE denial_reason_3 IS NOT NULL;

-- 12. RACE CODE
DROP TABLE IF EXISTS Race_Code CASCADE;
CREATE TABLE Race_Code (
  race_code INT PRIMARY KEY,
  race_name TEXT
);
INSERT INTO Race_Code
SELECT DISTINCT applicant_race_1, applicant_race_name_1
FROM preliminary
WHERE applicant_race_1 IS NOT NULL
UNION
SELECT DISTINCT applicant_race_2, applicant_race_name_2
FROM preliminary
WHERE applicant_race_2 IS NOT NULL
UNION
SELECT DISTINCT applicant_race_3, applicant_race_name_3
FROM preliminary
WHERE applicant_race_3 IS NOT NULL
UNION
SELECT DISTINCT applicant_race_4, applicant_race_name_4
FROM preliminary
WHERE applicant_race_4 IS NOT NULL
UNION
SELECT DISTINCT applicant_race_5, applicant_race_name_5
FROM preliminary
WHERE applicant_race_5 IS NOT NULL
UNION
SELECT DISTINCT co_applicant_race_1, co_applicant_race_name_1
FROM preliminary
WHERE co_applicant_race_1 IS NOT NULL
UNION
SELECT DISTINCT co_applicant_race_2, co_applicant_race_name_2
FROM preliminary
WHERE co_applicant_race_2 IS NOT NULL
UNION
SELECT DISTINCT co_applicant_race_3, co_applicant_race_name_3
FROM preliminary
WHERE co_applicant_race_3 IS NOT NULL
UNION
SELECT DISTINCT co_applicant_race_4, co_applicant_race_name_4
FROM preliminary
WHERE co_applicant_race_4 IS NOT NULL
UNION
SELECT DISTINCT co_applicant_race_5, co_applicant_race_name_5
FROM preliminary
WHERE co_applicant_race_5 IS NOT NULL;

-- 13. MSAMD
DROP TABLE IF EXISTS MSAMD CASCADE;
CREATE TABLE MSAMD (
  msamd TEXT PRIMARY KEY,
  msamd_name TEXT
);
INSERT INTO MSAMD
SELECT DISTINCT msamd, msamd_name
FROM preliminary
WHERE msamd IS NOT NULL;

-- 14. STATE
DROP TABLE IF EXISTS State CASCADE;
CREATE TABLE State (
  state_code TEXT PRIMARY KEY,
  state_name TEXT,
  state_abbr TEXT
);
INSERT INTO State
SELECT DISTINCT state_code, state_name, state_abbr
FROM preliminary
WHERE state_code IS NOT NULL;

-- 15. COUNTY
DROP TABLE IF EXISTS County CASCADE;
CREATE TABLE County (
  county_code TEXT PRIMARY KEY,
  county_name TEXT
);
INSERT INTO County
SELECT DISTINCT county_code, county_name
FROM preliminary
WHERE county_code IS NOT NULL;

-- 17. Location

-- 18. Application

-- 19. Applicant_Race

-- 20. Co_Applicant_Race

-- 21. Applicant_Ethnicity

-- 22. Co_Applicant_Ethnicity

