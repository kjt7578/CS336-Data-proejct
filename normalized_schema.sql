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

-- Ethnicity Code
DROP TABLE IF EXISTS Ethnicity_Code CASCADE;
CREATE TABLE Ethnicity_Code (
  ethnicity_code INT PRIMARY KEY,
  ethnicity_name TEXT
);
INSERT INTO Ethnicity_Code
SELECT DISTINCT applicant_ethnicity, applicant_ethnicity_name
FROM preliminary
WHERE applicant_ethnicity IS NOT NULL
UNION
SELECT DISTINCT co_applicant_ethnicity, co_applicant_ethnicity_name
FROM preliminary
WHERE co_applicant_ethnicity IS NOT NULL;

-- Sex Code
DROP TABLE IF EXISTS Sex_Code CASCADE;
CREATE TABLE Sex_Code (
  sex_code INT PRIMARY KEY,
  sex_name TEXT
);
INSERT INTO Sex_Code
SELECT DISTINCT applicant_sex, applicant_sex_name
FROM preliminary
WHERE applicant_sex IS NOT NULL
UNION
SELECT DISTINCT co_applicant_sex, co_applicant_sex_name
FROM preliminary
WHERE co_applicant_sex IS NOT NULL;

-- Nulls Table
DROP TABLE IF EXISTS Nulls CASCADE;
CREATE TABLE Nulls (
  id SERIAL PRIMARY KEY,
  edit_status_name TEXT,
  edit_status TEXT,
  sequence_number TEXT,
  application_date_indicator TEXT
);
INSERT INTO Nulls (edit_status_name, edit_status)
VALUES (NULL, NULL);

-- 17. Location
DROP TABLE IF EXISTS Location CASCADE;
CREATE TABLE Location (
  location_id SERIAL PRIMARY KEY,
  county_code TEXT REFERENCES County(county_code),
  msamd TEXT REFERENCES MSAMD(msamd),
  state_code TEXT REFERENCES State(state_code),
  census_tract_number TEXT,
  population INT,
  minority_population NUMERIC,
  hud_median_family_income INT,
  tract_to_msamd_income NUMERIC,
  number_of_owner_occupied_units INT,
  number_of_1_to_4_family_units INT,
  UNIQUE(county_code, msamd, state_code, census_tract_number)
);
INSERT INTO Location (county_code, msamd, state_code, census_tract_number, 
                     population, minority_population, hud_median_family_income, 
                     tract_to_msamd_income, number_of_owner_occupied_units, 
                     number_of_1_to_4_family_units)
SELECT DISTINCT
    NULLIF(county_code, '') AS county_code, 
    NULLIF(msamd, '') AS msamd,
    state_code,
    NULLIF(census_tract_number, '') AS census_tract_number,
    CASE WHEN population = '' THEN NULL ELSE population::INT END AS population,
    CASE WHEN minority_population = '' THEN NULL ELSE minority_population::NUMERIC END AS minority_population,
    CASE WHEN hud_median_family_income = '' THEN NULL ELSE hud_median_family_income::INT END AS hud_median_family_income,
    CASE WHEN tract_to_msamd_income = '' THEN NULL ELSE tract_to_msamd_income::NUMERIC END AS tract_to_msamd_income,
    CASE WHEN number_of_owner_occupied_units = '' THEN NULL ELSE number_of_owner_occupied_units::INT END AS number_of_owner_occupied_units,
    CASE WHEN number_of_1_to_4_family_units = '' THEN NULL ELSE number_of_1_to_4_family_units::INT END AS number_of_1_to_4_family_units
FROM preliminary;

-- 18. Application
DROP TABLE IF EXISTS Application CASCADE;
CREATE TABLE Application (
  id INT PRIMARY KEY,
  as_of_year INT,
  respondent_id TEXT,
  agency_code INT REFERENCES Agency(agency_code),
  loan_type INT REFERENCES Loan_Type(loan_type),
  property_type INT REFERENCES Property_Type(property_type),
  loan_purpose INT REFERENCES Loan_Purpose(loan_purpose),
  owner_occupancy INT REFERENCES OwnOcc(owner_occupancy),
  loan_amount_000s INT,
  preapproval INT REFERENCES PreApprove(preapproval),
  action_taken INT REFERENCES Action_Taken(action_taken),
  location_id INT REFERENCES Location(location_id),
  applicant_ethnicity INT REFERENCES Ethnicity_Code(ethnicity_code),
  co_applicant_ethnicity INT REFERENCES Ethnicity_Code(ethnicity_code),
  applicant_sex INT REFERENCES Sex_Code(sex_code),
  co_applicant_sex INT REFERENCES Sex_Code(sex_code),
  applicant_income_000s INT,
  purchaser_type INT REFERENCES Purchaser_Type(purchaser_type),
  denial_reason_1 INT REFERENCES Denial_Reason(denial_reason_code),
  denial_reason_2 INT REFERENCES Denial_Reason(denial_reason_code),
  denial_reason_3 INT REFERENCES Denial_Reason(denial_reason_code),
  rate_spread TEXT,
  hoepa_status INT REFERENCES HOEPA_Status(hoepa_status),
  lien_status INT REFERENCES Lien_Status(lien_status),
  sequence_number TEXT,
  application_date_indicator TEXT
);
WITH LocationMapping AS (
  SELECT l.location_id, 
         NULLIF(p.county_code, '') AS county_code,
         NULLIF(p.msamd, '') AS msamd,
         p.state_code,
         NULLIF(p.census_tract_number, '') AS census_tract_number
  FROM preliminary p, Location l
  WHERE (NULLIF(p.county_code, '') = l.county_code OR (p.county_code = '' AND l.county_code IS NULL))
    AND (NULLIF(p.msamd, '') = l.msamd OR (p.msamd = '' AND l.msamd IS NULL))
    AND p.state_code = l.state_code
    AND (NULLIF(p.census_tract_number, '') = l.census_tract_number OR 
         (p.census_tract_number = '' AND l.census_tract_number IS NULL))
)
INSERT INTO Application
SELECT 
  p.id,
  CASE WHEN p.as_of_year = '' THEN NULL ELSE p.as_of_year::INT END,
  p.respondent_id,
  CASE WHEN p.agency_code = '' THEN NULL ELSE p.agency_code::INT END,
  CASE WHEN p.loan_type = '' THEN NULL ELSE p.loan_type::INT END,
  CASE WHEN p.property_type = '' THEN NULL ELSE p.property_type::INT END,
  CASE WHEN p.loan_purpose = '' THEN NULL ELSE p.loan_purpose::INT END,
  CASE WHEN p.owner_occupancy = '' THEN NULL ELSE p.owner_occupancy::INT END,
  CASE WHEN p.loan_amount_000s = '' THEN NULL ELSE p.loan_amount_000s::INT END,
  CASE WHEN p.preapproval = '' THEN NULL ELSE p.preapproval::INT END,
  CASE WHEN p.action_taken = '' THEN NULL ELSE p.action_taken::INT END,
  lm.location_id,
  CASE WHEN p.applicant_ethnicity = '' THEN NULL ELSE p.applicant_ethnicity::INT END,
  CASE WHEN p.co_applicant_ethnicity = '' THEN NULL ELSE p.co_applicant_ethnicity::INT END,
  CASE WHEN p.applicant_sex = '' THEN NULL ELSE p.applicant_sex::INT END,
  CASE WHEN p.co_applicant_sex = '' THEN NULL ELSE p.co_applicant_sex::INT END,
  CASE WHEN p.applicant_income_000s = '' THEN NULL ELSE p.applicant_income_000s::INT END,
  CASE WHEN p.purchaser_type = '' THEN NULL ELSE p.purchaser_type::INT END,
  CASE WHEN p.denial_reason_1 = '' THEN NULL ELSE p.denial_reason_1::INT END,
  CASE WHEN p.denial_reason_2 = '' THEN NULL ELSE p.denial_reason_2::INT END,
  CASE WHEN p.denial_reason_3 = '' THEN NULL ELSE p.denial_reason_3::INT END,
  NULLIF(p.rate_spread, ''),
  CASE WHEN p.hoepa_status = '' THEN NULL ELSE p.hoepa_status::INT END,
  CASE WHEN p.lien_status = '' THEN NULL ELSE p.lien_status::INT END,
  NULLIF(p.sequence_number, ''),
  NULLIF(p.application_date_indicator, '')
FROM preliminary p
JOIN LocationMapping lm ON 
  (NULLIF(p.county_code, '') = lm.county_code OR (p.county_code = '' AND lm.county_code IS NULL))
  AND (NULLIF(p.msamd, '') = lm.msamd OR (p.msamd = '' AND lm.msamd IS NULL))
  AND p.state_code = lm.state_code
  AND (NULLIF(p.census_tract_number, '') = lm.census_tract_number OR 
       (p.census_tract_number = '' AND lm.census_tract_number IS NULL));

-- 19. Applicant_Race
DROP TABLE IF EXISTS Applicant_Race CASCADE;
CREATE TABLE Applicant_Race (
  application_id INT REFERENCES Application(id),
  race_number INT CHECK (race_number BETWEEN 1 AND 5),
  race_code INT REFERENCES Race_Code(race_code),
  PRIMARY KEY (application_id, race_number)
);
INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT id, 1, applicant_race_1::INT
FROM preliminary
WHERE applicant_race_1 IS NOT NULL AND applicant_race_1 != '';

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT id, 2, applicant_race_2::INT
FROM preliminary
WHERE applicant_race_2 IS NOT NULL AND applicant_race_2 != '';

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT id, 3, applicant_race_3::INT
FROM preliminary
WHERE applicant_race_3 IS NOT NULL AND applicant_race_3 != '';

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT id, 4, applicant_race_4::INT
FROM preliminary
WHERE applicant_race_4 IS NOT NULL AND applicant_race_4 != '';

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT id, 5, applicant_race_5::INT
FROM preliminary
WHERE applicant_race_5 IS NOT NULL AND applicant_race_5 != '';


-- 20. Co_Applicant_Race
DROP TABLE IF EXISTS Co_Applicant_Race CASCADE;
CREATE TABLE Co_Applicant_Race (
  application_id INT REFERENCES Application(id),
  race_number INT CHECK (race_number BETWEEN 1 AND 5),
  race_code INT REFERENCES Race_Code(race_code),
  PRIMARY KEY (application_id, race_number)
);
INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT id, 1, co_applicant_race_1::INT
FROM preliminary
WHERE co_applicant_race_1 IS NOT NULL AND co_applicant_race_1 != '';
INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT id, 2, co_applicant_race_2::INT
FROM preliminary
WHERE co_applicant_race_2 IS NOT NULL AND co_applicant_race_2 != '';
INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT id, 3, co_applicant_race_3::INT
FROM preliminary
WHERE co_applicant_race_3 IS NOT NULL AND co_applicant_race_3 != '';
INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT id, 4, co_applicant_race_4::INT
FROM preliminary
WHERE co_applicant_race_4 IS NOT NULL AND co_applicant_race_4 != '';
INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT id, 5, co_applicant_race_5::INT
FROM preliminary
WHERE co_applicant_race_5 IS NOT NULL AND co_applicant_race_5 != '';


-- 21. Applicant_Ethnicity

-- 22. Co_Applicant_Ethnicity



