-- 0. 실행 타임아웃 해제 (쿼리 실행 시간이 오래 걸릴 경우 대비)
SET statement_timeout = 0;

-------------------------------------------------------
-- 1. 기존 테이블 삭제 (CASCADE로 연결된 제약조건도 삭제)
-------------------------------------------------------
DROP TABLE IF EXISTS Loan_Type CASCADE;
DROP TABLE IF EXISTS Property_Type CASCADE;
DROP TABLE IF EXISTS Loan_Purpose CASCADE;
DROP TABLE IF EXISTS Agency CASCADE;
DROP TABLE IF EXISTS OwnOcc CASCADE;
DROP TABLE IF EXISTS PreApprove CASCADE;
DROP TABLE IF EXISTS Action_Taken CASCADE;
DROP TABLE IF EXISTS Purchaser_Type CASCADE;
DROP TABLE IF EXISTS HOEPA_Status CASCADE;
DROP TABLE IF EXISTS Lien_Status CASCADE;
DROP TABLE IF EXISTS Denial_Reason CASCADE;
DROP TABLE IF EXISTS Race_Code CASCADE;
DROP TABLE IF EXISTS Ethnicity_Code CASCADE;
DROP TABLE IF EXISTS Sex_Code CASCADE;
DROP TABLE IF EXISTS Nulls CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Application CASCADE;
DROP TABLE IF EXISTS Applicant_Race CASCADE;
DROP TABLE IF EXISTS Co_Applicant_Race CASCADE;

-------------------------------------------------------
-- 2. 코드(lookup) 테이블들 생성 및 데이터 삽입
-------------------------------------------------------

-- Loan_Type
CREATE TABLE IF NOT EXISTS Loan_Type (
  loan_type INT PRIMARY KEY,
  loan_type_name TEXT
);
INSERT INTO Loan_Type
SELECT DISTINCT loan_type::INT, loan_type_name
FROM preliminary
WHERE loan_type IS NOT NULL AND loan_type <> ''
  AND loan_type::INT NOT IN (SELECT loan_type FROM Loan_Type);

-- Property_Type
CREATE TABLE IF NOT EXISTS Property_Type (
  property_type INT PRIMARY KEY,
  property_type_name TEXT
);
INSERT INTO Property_Type
SELECT DISTINCT property_type::INT, property_type_name
FROM preliminary
WHERE property_type IS NOT NULL AND property_type <> ''
  AND property_type::INT NOT IN (SELECT property_type FROM Property_Type);

-- Loan_Purpose
CREATE TABLE IF NOT EXISTS Loan_Purpose (
  loan_purpose INT PRIMARY KEY,
  loan_purpose_name TEXT
);
INSERT INTO Loan_Purpose
SELECT DISTINCT loan_purpose::INT, loan_purpose_name
FROM preliminary
WHERE loan_purpose IS NOT NULL AND loan_purpose <> ''
  AND loan_purpose::INT NOT IN (SELECT loan_purpose FROM Loan_Purpose);

-- Agency
CREATE TABLE IF NOT EXISTS Agency (
  agency_code INT PRIMARY KEY,
  agency_name TEXT,
  agency_abbr TEXT
);
INSERT INTO Agency
SELECT DISTINCT agency_code::INT, agency_name, agency_abbr
FROM preliminary
WHERE agency_code IS NOT NULL AND agency_code <> ''
  AND agency_code::INT NOT IN (SELECT agency_code FROM Agency);

-- OwnOcc
CREATE TABLE IF NOT EXISTS OwnOcc (
  owner_occupancy INT PRIMARY KEY,
  owner_occupancy_name TEXT
);
INSERT INTO OwnOcc
SELECT DISTINCT owner_occupancy::INT, owner_occupancy_name
FROM preliminary
WHERE owner_occupancy IS NOT NULL AND owner_occupancy <> ''
  AND owner_occupancy::INT NOT IN (SELECT owner_occupancy FROM OwnOcc);

-- PreApprove
CREATE TABLE IF NOT EXISTS PreApprove (
  preapproval INT PRIMARY KEY,
  preapproval_name TEXT
);
INSERT INTO PreApprove
SELECT DISTINCT preapproval::INT, preapproval_name
FROM preliminary
WHERE preapproval IS NOT NULL AND preapproval <> ''
  AND preapproval::INT NOT IN (SELECT preapproval FROM PreApprove);

-- Action_Taken
CREATE TABLE IF NOT EXISTS Action_Taken (
  action_taken INT PRIMARY KEY,
  action_taken_name TEXT
);
INSERT INTO Action_Taken
SELECT DISTINCT action_taken::INT, action_taken_name
FROM preliminary
WHERE action_taken IS NOT NULL AND action_taken <> ''
  AND action_taken::INT NOT IN (SELECT action_taken FROM Action_Taken);

-- Purchaser_Type
CREATE TABLE IF NOT EXISTS Purchaser_Type (
  purchaser_type INT PRIMARY KEY,
  purchaser_type_name TEXT
);
INSERT INTO Purchaser_Type
SELECT DISTINCT purchaser_type::INT, purchaser_type_name
FROM preliminary
WHERE purchaser_type IS NOT NULL AND purchaser_type <> ''
  AND purchaser_type::INT NOT IN (SELECT purchaser_type FROM Purchaser_Type);

-- HOEPA_Status
CREATE TABLE IF NOT EXISTS HOEPA_Status (
  hoepa_status INT PRIMARY KEY,
  hoepa_status_name TEXT
);
INSERT INTO HOEPA_Status
SELECT DISTINCT hoepa_status::INT, hoepa_status_name
FROM preliminary
WHERE hoepa_status IS NOT NULL AND hoepa_status <> ''
  AND hoepa_status::INT NOT IN (SELECT hoepa_status FROM HOEPA_Status);

-- Lien_Status
CREATE TABLE IF NOT EXISTS Lien_Status (
  lien_status INT PRIMARY KEY,
  lien_status_name TEXT
);
INSERT INTO Lien_Status
SELECT DISTINCT lien_status::INT, lien_status_name
FROM preliminary
WHERE lien_status IS NOT NULL AND lien_status <> ''
  AND lien_status::INT NOT IN (SELECT lien_status FROM Lien_Status);

-- Denial_Reason
CREATE TABLE IF NOT EXISTS Denial_Reason (
  denial_reason_code INT PRIMARY KEY,
  denial_reason_name TEXT
);
INSERT INTO Denial_Reason
SELECT DISTINCT denial_reason_1::INT, denial_reason_name_1
FROM preliminary
WHERE denial_reason_1 IS NOT NULL AND denial_reason_1 <> ''
  AND denial_reason_1::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason)
UNION
SELECT DISTINCT denial_reason_2::INT, denial_reason_name_2
FROM preliminary
WHERE denial_reason_2 IS NOT NULL AND denial_reason_2 <> ''
  AND denial_reason_2::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason)
UNION
SELECT DISTINCT denial_reason_3::INT, denial_reason_name_3
FROM preliminary
WHERE denial_reason_3 IS NOT NULL AND denial_reason_3 <> ''
  AND denial_reason_3::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason);

-- Race_Code
CREATE TABLE IF NOT EXISTS Race_Code (
  race_code INT PRIMARY KEY,
  race_name TEXT
);
INSERT INTO Race_Code
SELECT DISTINCT applicant_race_1::INT, applicant_race_name_1
FROM preliminary
WHERE applicant_race_1 IS NOT NULL AND applicant_race_1 <> ''
  AND applicant_race_1::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_2::INT, applicant_race_name_2
FROM preliminary
WHERE applicant_race_2 IS NOT NULL AND applicant_race_2 <> ''
  AND applicant_race_2::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_3::INT, applicant_race_name_3
FROM preliminary
WHERE applicant_race_3 IS NOT NULL AND applicant_race_3 <> ''
  AND applicant_race_3::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_4::INT, applicant_race_name_4
FROM preliminary
WHERE applicant_race_4 IS NOT NULL AND applicant_race_4 <> ''
  AND applicant_race_4::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_5::INT, applicant_race_name_5
FROM preliminary
WHERE applicant_race_5 IS NOT NULL AND applicant_race_5 <> ''
  AND applicant_race_5::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_1::INT, co_applicant_race_name_1
FROM preliminary
WHERE co_applicant_race_1 IS NOT NULL AND co_applicant_race_1 <> ''
  AND co_applicant_race_1::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_2::INT, co_applicant_race_name_2
FROM preliminary
WHERE co_applicant_race_2 IS NOT NULL AND co_applicant_race_2 <> ''
  AND co_applicant_race_2::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_3::INT, co_applicant_race_name_3
FROM preliminary
WHERE co_applicant_race_3 IS NOT NULL AND co_applicant_race_3 <> ''
  AND co_applicant_race_3::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_4::INT, co_applicant_race_name_4
FROM preliminary
WHERE co_applicant_race_4 IS NOT NULL AND co_applicant_race_4 <> ''
  AND co_applicant_race_4::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_5::INT, co_applicant_race_name_5
FROM preliminary
WHERE co_applicant_race_5 IS NOT NULL AND co_applicant_race_5 <> ''
  AND co_applicant_race_5::INT NOT IN (SELECT race_code FROM Race_Code);

-- Ethnicity_Code
CREATE TABLE IF NOT EXISTS Ethnicity_Code (
  ethnicity_code INT PRIMARY KEY,
  ethnicity_name TEXT
);
INSERT INTO Ethnicity_Code
SELECT DISTINCT applicant_ethnicity::INT, applicant_ethnicity_name
FROM preliminary
WHERE applicant_ethnicity IS NOT NULL AND applicant_ethnicity <> ''
  AND applicant_ethnicity::INT NOT IN (SELECT ethnicity_code FROM Ethnicity_Code)
UNION
SELECT DISTINCT co_applicant_ethnicity::INT, co_applicant_ethnicity_name
FROM preliminary
WHERE co_applicant_ethnicity IS NOT NULL AND co_applicant_ethnicity <> ''
  AND co_applicant_ethnicity::INT NOT IN (SELECT ethnicity_code FROM Ethnicity_Code);

-- Sex_Code
CREATE TABLE IF NOT EXISTS Sex_Code (
  sex_code INT PRIMARY KEY,
  sex_name TEXT
);
INSERT INTO Sex_Code
SELECT DISTINCT applicant_sex::INT, applicant_sex_name
FROM preliminary
WHERE applicant_sex IS NOT NULL AND applicant_sex <> ''
  AND applicant_sex::INT NOT IN (SELECT sex_code FROM Sex_Code)
UNION
SELECT DISTINCT co_applicant_sex::INT, co_applicant_sex_name
FROM preliminary
WHERE co_applicant_sex IS NOT NULL AND co_applicant_sex <> ''
  AND co_applicant_sex::INT NOT IN (SELECT sex_code FROM Sex_Code);

-- Nulls table (for columns that are always NULL)
CREATE TABLE IF NOT EXISTS Nulls (
  id SERIAL PRIMARY KEY,
  edit_status_name TEXT,
  edit_status TEXT,
  sequence_number TEXT,
  application_date_indicator TEXT
);
INSERT INTO Nulls (edit_status_name, edit_status)
SELECT NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM Nulls);

-------------------------------------------------------
-- 3. Location table
-------------------------------------------------------
CREATE TABLE IF NOT EXISTS Location (
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
  UNIQUE(
    county_code, msamd, state_code, census_tract_number,
    population, minority_population, hud_median_family_income,
    tract_to_msamd_income, number_of_owner_occupied_units, number_of_1_to_4_family_units
  )
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
FROM preliminary
WHERE (NULLIF(county_code, ''), NULLIF(msamd, ''), state_code, NULLIF(census_tract_number, ''),
       CASE WHEN population = '' THEN NULL ELSE population::INT END,
       CASE WHEN minority_population = '' THEN NULL ELSE minority_population::NUMERIC END,
       CASE WHEN hud_median_family_income = '' THEN NULL ELSE hud_median_family_income::INT END,
       CASE WHEN tract_to_msamd_income = '' THEN NULL ELSE tract_to_msamd_income::NUMERIC END,
       CASE WHEN number_of_owner_occupied_units = '' THEN NULL ELSE number_of_owner_occupied_units::INT END,
       CASE WHEN number_of_1_to_4_family_units = '' THEN NULL ELSE number_of_1_to_4_family_units::INT END)
      NOT IN (
        SELECT county_code, msamd, state_code, census_tract_number,
               population, minority_population, hud_median_family_income,
               tract_to_msamd_income, number_of_owner_occupied_units, number_of_1_to_4_family_units
        FROM Location
      );

-------------------------------------------------------
-- 4. Application table (create without foreign keys)
-------------------------------------------------------
DROP TABLE IF EXISTS Application CASCADE;
CREATE TABLE Application (
  id INT PRIMARY KEY,
  as_of_year INT,
  respondent_id TEXT,
  agency_code INT,
  loan_type INT,
  property_type INT,
  loan_purpose INT,
  owner_occupancy INT,
  loan_amount_000s INT,
  preapproval INT,
  action_taken INT,
  location_id INT,
  applicant_ethnicity INT,
  co_applicant_ethnicity INT,
  applicant_sex INT,
  co_applicant_sex INT,
  applicant_income_000s INT,
  purchaser_type INT,
  denial_reason_1 INT,
  denial_reason_2 INT,
  denial_reason_3 INT,
  rate_spread TEXT,
  hoepa_status INT,
  lien_status INT,
  sequence_number TEXT,
  application_date_indicator TEXT
);

-- Create TEMP table for LocationMapping to speed up the join.
DROP TABLE IF EXISTS LocationMapping;
-- Note: To obtain the correct location_id for each application row,
-- join on the full set of location attributes.
CREATE TEMP TABLE LocationMapping AS
SELECT 
  p.id AS application_id,
  l.location_id
FROM preliminary p
JOIN Location l
  ON (NULLIF(p.county_code, '') = l.county_code OR (p.county_code = '' AND l.county_code IS NULL))
 AND (NULLIF(p.msamd, '') = l.msamd OR (p.msamd = '' AND l.msamd IS NULL))
 AND p.state_code = l.state_code
 AND (NULLIF(p.census_tract_number, '') = l.census_tract_number OR (p.census_tract_number = '' AND l.census_tract_number IS NULL))
 -- Optionally, if the other location attributes (population, etc.) vary,
 -- include them in the join. For brevity, they are omitted if they are functionally determined.
;

-- Insert data into Application using the TEMP LocationMapping.
INSERT INTO Application (
  id, as_of_year, respondent_id, agency_code, loan_type, property_type, loan_purpose,
  owner_occupancy, loan_amount_000s, preapproval, action_taken, location_id,
  applicant_ethnicity, co_applicant_ethnicity, applicant_sex, co_applicant_sex,
  applicant_income_000s, purchaser_type, denial_reason_1, denial_reason_2, denial_reason_3,
  rate_spread, hoepa_status, lien_status, sequence_number, application_date_indicator
)
SELECT 
  p.id,
  NULLIF(p.as_of_year, '')::INT,
  p.respondent_id,
  NULLIF(p.agency_code, '')::INT,
  NULLIF(p.loan_type, '')::INT,
  NULLIF(p.property_type, '')::INT,
  NULLIF(p.loan_purpose, '')::INT,
  NULLIF(p.owner_occupancy, '')::INT,
  NULLIF(p.loan_amount_000s, '')::INT,
  NULLIF(p.preapproval, '')::INT,
  NULLIF(p.action_taken, '')::INT,
  lm.location_id,
  NULLIF(p.applicant_ethnicity, '')::INT,
  NULLIF(p.co_applicant_ethnicity, '')::INT,
  NULLIF(p.applicant_sex, '')::INT,
  NULLIF(p.co_applicant_sex, '')::INT,
  NULLIF(p.applicant_income_000s, '')::INT,
  NULLIF(p.purchaser_type, '')::INT,
  NULLIF(p.denial_reason_1, '')::INT,
  NULLIF(p.denial_reason_2, '')::INT,
  NULLIF(p.denial_reason_3, '')::INT,
  NULLIF(p.rate_spread, ''),
  NULLIF(p.hoepa_status, '')::INT,
  NULLIF(p.lien_status, '')::INT,
  NULLIF(p.sequence_number, ''),
  NULLIF(p.application_date_indicator, '')
FROM preliminary p
JOIN LocationMapping lm ON p.id = lm.application_id;

-- Now add foreign key constraints to Application.
ALTER TABLE Application
  ADD FOREIGN KEY (agency_code) REFERENCES Agency(agency_code),
  ADD FOREIGN KEY (loan_type) REFERENCES Loan_Type(loan_type),
  ADD FOREIGN KEY (property_type) REFERENCES Property_Type(property_type),
  ADD FOREIGN KEY (loan_purpose) REFERENCES Loan_Purpose(loan_purpose),
  ADD FOREIGN KEY (owner_occupancy) REFERENCES OwnOcc(owner_occupancy),
  ADD FOREIGN KEY (preapproval) REFERENCES PreApprove(preapproval),
  ADD FOREIGN KEY (action_taken) REFERENCES Action_Taken(action_taken),
  ADD FOREIGN KEY (location_id) REFERENCES Location(location_id),
  ADD FOREIGN KEY (applicant_ethnicity) REFERENCES Ethnicity_Code(ethnicity_code),
  ADD FOREIGN KEY (co_applicant_ethnicity) REFERENCES Ethnicity_Code(ethnicity_code),
  ADD FOREIGN KEY (applicant_sex) REFERENCES Sex_Code(sex_code),
  ADD FOREIGN KEY (co_applicant_sex) REFERENCES Sex_Code(sex_code),
  ADD FOREIGN KEY (purchaser_type) REFERENCES Purchaser_Type(purchaser_type),
  ADD FOREIGN KEY (denial_reason_1) REFERENCES Denial_Reason(denial_reason_code),
  ADD FOREIGN KEY (denial_reason_2) REFERENCES Denial_Reason(denial_reason_code),
  ADD FOREIGN KEY (denial_reason_3) REFERENCES Denial_Reason(denial_reason_code),
  ADD FOREIGN KEY (hoepa_status) REFERENCES HOEPA_Status(hoepa_status),
  ADD FOREIGN KEY (lien_status) REFERENCES Lien_Status(lien_status);

-------------------------------------------------------
-- 5. Applicant_Race table and data insertion
-------------------------------------------------------
CREATE TABLE IF NOT EXISTS Applicant_Race (
  application_id INT REFERENCES Application(id),
  race_number INT CHECK (race_number BETWEEN 1 AND 5),
  race_code INT REFERENCES Race_Code(race_code),
  PRIMARY KEY (application_id, race_number)
);

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 1, p.applicant_race_1::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_1 IS NOT NULL AND p.applicant_race_1 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 2, p.applicant_race_2::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_2 IS NOT NULL AND p.applicant_race_2 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 3, p.applicant_race_3::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_3 IS NOT NULL AND p.applicant_race_3 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 4, p.applicant_race_4::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_4 IS NOT NULL AND p.applicant_race_4 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 5, p.applicant_race_5::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_5 IS NOT NULL AND p.applicant_race_5 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

-------------------------------------------------------
-- 6. Co_Applicant_Race table and data insertion
-------------------------------------------------------
CREATE TABLE IF NOT EXISTS Co_Applicant_Race (
  application_id INT REFERENCES Application(id),
  race_number INT CHECK (race_number BETWEEN 1 AND 5),
  race_code INT REFERENCES Race_Code(race_code),
  PRIMARY KEY (application_id, race_number)
);

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 1, p.co_applicant_race_1::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_1 IS NOT NULL AND p.co_applicant_race_1 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 2, p.co_applicant_race_2::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_2 IS NOT NULL AND p.co_applicant_race_2 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 3, p.co_applicant_race_3::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_3 IS NOT NULL AND p.co_applicant_race_3 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 4, p.co_applicant_race_4::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_4 IS NOT NULL AND p.co_applicant_race_4 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 5, p.co_applicant_race_5::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_5 IS NOT NULL AND p.co_applicant_race_5 <> ''
ON CONFLICT (application_id, race_number) DO NOTHING;
