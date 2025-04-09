CREATE TABLE IF NOT EXISTS Loan_Type (
  loan_type INT PRIMARY KEY,
  loan_type_name TEXT
);
INSERT INTO Loan_Type
SELECT DISTINCT loan_type::INT, loan_type_name
FROM preliminary
WHERE loan_type IS NOT NULL AND loan_type != ''
  AND loan_type::INT NOT IN (SELECT loan_type FROM Loan_Type);

CREATE TABLE IF NOT EXISTS Property_Type (
  property_type INT PRIMARY KEY,
  property_type_name TEXT
);
INSERT INTO Property_Type
SELECT DISTINCT property_type::INT, property_type_name
FROM preliminary
WHERE property_type IS NOT NULL AND property_type != ''
  AND property_type::INT NOT IN (SELECT property_type FROM Property_Type);

CREATE TABLE IF NOT EXISTS Loan_Purpose (
  loan_purpose INT PRIMARY KEY,
  loan_purpose_name TEXT
);
INSERT INTO Loan_Purpose
SELECT DISTINCT loan_purpose::INT, loan_purpose_name
FROM preliminary
WHERE loan_purpose IS NOT NULL AND loan_purpose != ''
  AND loan_purpose::INT NOT IN (SELECT loan_purpose FROM Loan_Purpose);

CREATE TABLE IF NOT EXISTS Agency (
  agency_code INT PRIMARY KEY,
  agency_name TEXT,
  agency_abbr TEXT
);
INSERT INTO Agency
SELECT DISTINCT agency_code::INT, agency_name, agency_abbr
FROM preliminary
WHERE agency_code IS NOT NULL AND agency_code != ''
  AND agency_code::INT NOT IN (SELECT agency_code FROM Agency);

CREATE TABLE IF NOT EXISTS OwnOcc (
  owner_occupancy INT PRIMARY KEY,
  owner_occupancy_name TEXT
);
INSERT INTO OwnOcc
SELECT DISTINCT owner_occupancy::INT, owner_occupancy_name
FROM preliminary
WHERE owner_occupancy IS NOT NULL AND owner_occupancy != ''
  AND owner_occupancy::INT NOT IN (SELECT owner_occupancy FROM OwnOcc);

CREATE TABLE IF NOT EXISTS PreApprove (
  preapproval INT PRIMARY KEY,
  preapproval_name TEXT
);
INSERT INTO PreApprove
SELECT DISTINCT preapproval::INT, preapproval_name
FROM preliminary
WHERE preapproval IS NOT NULL AND preapproval != ''
  AND preapproval::INT NOT IN (SELECT preapproval FROM PreApprove);

CREATE TABLE IF NOT EXISTS Action_Taken (
  action_taken INT PRIMARY KEY,
  action_taken_name TEXT
);
INSERT INTO Action_Taken
SELECT DISTINCT action_taken::INT, action_taken_name
FROM preliminary
WHERE action_taken IS NOT NULL AND action_taken != ''
  AND action_taken::INT NOT IN (SELECT action_taken FROM Action_Taken);

CREATE TABLE IF NOT EXISTS Purchaser_Type (
  purchaser_type INT PRIMARY KEY,
  purchaser_type_name TEXT
);
INSERT INTO Purchaser_Type
SELECT DISTINCT purchaser_type::INT, purchaser_type_name
FROM preliminary
WHERE purchaser_type IS NOT NULL AND purchaser_type != ''
  AND purchaser_type::INT NOT IN (SELECT purchaser_type FROM Purchaser_Type);

CREATE TABLE IF NOT EXISTS HOEPA_Status (
  hoepa_status INT PRIMARY KEY,
  hoepa_status_name TEXT
);
INSERT INTO HOEPA_Status
SELECT DISTINCT hoepa_status::INT, hoepa_status_name
FROM preliminary
WHERE hoepa_status IS NOT NULL AND hoepa_status != ''
  AND hoepa_status::INT NOT IN (SELECT hoepa_status FROM HOEPA_Status);

CREATE TABLE IF NOT EXISTS Lien_Status (
  lien_status INT PRIMARY KEY,
  lien_status_name TEXT
);
INSERT INTO Lien_Status
SELECT DISTINCT lien_status::INT, lien_status_name
FROM preliminary
WHERE lien_status IS NOT NULL AND lien_status != ''
  AND lien_status::INT NOT IN (SELECT lien_status FROM Lien_Status);

CREATE TABLE IF NOT EXISTS Denial_Reason (
  denial_reason_code INT PRIMARY KEY,
  denial_reason_name TEXT
);
INSERT INTO Denial_Reason
SELECT DISTINCT denial_reason_1::INT, denial_reason_name_1
FROM preliminary
WHERE denial_reason_1 IS NOT NULL AND denial_reason_1 != ''
  AND denial_reason_1::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason)
UNION
SELECT DISTINCT denial_reason_2::INT, denial_reason_name_2
FROM preliminary
WHERE denial_reason_2 IS NOT NULL AND denial_reason_2 != ''
  AND denial_reason_2::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason)
UNION
SELECT DISTINCT denial_reason_3::INT, denial_reason_name_3
FROM preliminary
WHERE denial_reason_3 IS NOT NULL AND denial_reason_3 != ''
  AND denial_reason_3::INT NOT IN (SELECT denial_reason_code FROM Denial_Reason);

CREATE TABLE IF NOT EXISTS Race_Code (
  race_code INT PRIMARY KEY,
  race_name TEXT
);
INSERT INTO Race_Code
SELECT DISTINCT applicant_race_1::INT, applicant_race_name_1 FROM preliminary
WHERE applicant_race_1 IS NOT NULL AND applicant_race_1 != ''
  AND applicant_race_1::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_2::INT, applicant_race_name_2 FROM preliminary
WHERE applicant_race_2 IS NOT NULL AND applicant_race_2 != ''
  AND applicant_race_2::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_3::INT, applicant_race_name_3 FROM preliminary
WHERE applicant_race_3 IS NOT NULL AND applicant_race_3 != ''
  AND applicant_race_3::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_4::INT, applicant_race_name_4 FROM preliminary
WHERE applicant_race_4 IS NOT NULL AND applicant_race_4 != ''
  AND applicant_race_4::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT applicant_race_5::INT, applicant_race_name_5 FROM preliminary
WHERE applicant_race_5 IS NOT NULL AND applicant_race_5 != ''
  AND applicant_race_5::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_1::INT, co_applicant_race_name_1 FROM preliminary
WHERE co_applicant_race_1 IS NOT NULL AND co_applicant_race_1 != ''
  AND co_applicant_race_1::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_2::INT, co_applicant_race_name_2 FROM preliminary
WHERE co_applicant_race_2 IS NOT NULL AND co_applicant_race_2 != ''
  AND co_applicant_race_2::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_3::INT, co_applicant_race_name_3 FROM preliminary
WHERE co_applicant_race_3 IS NOT NULL AND co_applicant_race_3 != ''
  AND co_applicant_race_3::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_4::INT, co_applicant_race_name_4 FROM preliminary
WHERE co_applicant_race_4 IS NOT NULL AND co_applicant_race_4 != ''
  AND co_applicant_race_4::INT NOT IN (SELECT race_code FROM Race_Code)
UNION
SELECT DISTINCT co_applicant_race_5::INT, co_applicant_race_name_5 FROM preliminary
WHERE co_applicant_race_5 IS NOT NULL AND co_applicant_race_5 != ''
  AND co_applicant_race_5::INT NOT IN (SELECT race_code FROM Race_Code);

CREATE TABLE IF NOT EXISTS MSAMD (
  msamd TEXT PRIMARY KEY,
  msamd_name TEXT
);
INSERT INTO MSAMD
SELECT DISTINCT msamd, msamd_name
FROM preliminary
WHERE msamd IS NOT NULL AND msamd != ''
  AND msamd NOT IN (SELECT msamd FROM MSAMD);

CREATE TABLE IF NOT EXISTS State (
  state_code TEXT PRIMARY KEY,
  state_name TEXT,
  state_abbr TEXT
);
INSERT INTO State
SELECT DISTINCT state_code, state_name, state_abbr
FROM preliminary
WHERE state_code IS NOT NULL AND state_code != ''
  AND state_code NOT IN (SELECT state_code FROM State);

CREATE TABLE IF NOT EXISTS County (
  county_code TEXT PRIMARY KEY,
  county_name TEXT
);
INSERT INTO County
SELECT DISTINCT county_code, county_name
FROM preliminary
WHERE county_code IS NOT NULL AND county_code != ''
  AND county_code NOT IN (SELECT county_code FROM County);

CREATE TABLE IF NOT EXISTS Sex_Code (
  sex_code INT PRIMARY KEY,
  sex_name TEXT
);
INSERT INTO Sex_Code
SELECT DISTINCT applicant_sex::INT, applicant_sex_name FROM preliminary
WHERE applicant_sex IS NOT NULL AND applicant_sex != ''
  AND applicant_sex::INT NOT IN (SELECT sex_code FROM Sex_Code)
UNION
SELECT DISTINCT co_applicant_sex::INT, co_applicant_sex_name FROM preliminary
WHERE co_applicant_sex IS NOT NULL AND co_applicant_sex != ''
  AND co_applicant_sex::INT NOT IN (SELECT sex_code FROM Sex_Code);

  CREATE TABLE IF NOT EXISTS Ethnicity_Code (
  ethnicity_code INT PRIMARY KEY,
  ethnicity_name TEXT
);
INSERT INTO Ethnicity_Code
SELECT DISTINCT applicant_ethnicity::INT, applicant_ethnicity_name
FROM preliminary
WHERE applicant_ethnicity IS NOT NULL AND applicant_ethnicity != ''
  AND applicant_ethnicity::INT NOT IN (SELECT ethnicity_code FROM Ethnicity_Code)
UNION
SELECT DISTINCT co_applicant_ethnicity::INT, co_applicant_ethnicity_name
FROM preliminary
WHERE co_applicant_ethnicity IS NOT NULL AND co_applicant_ethnicity != ''
  AND co_applicant_ethnicity::INT NOT IN (SELECT ethnicity_code FROM Ethnicity_Code);

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
FROM preliminary
WHERE (NULLIF(county_code, ''), NULLIF(msamd, ''), state_code, NULLIF(census_tract_number, ''))
  NOT IN (SELECT county_code, msamd, state_code, census_tract_number FROM Location);

CREATE TABLE IF NOT EXISTS Application (
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
JOIN LocationMapping lm ON 
  (NULLIF(p.county_code, '') = lm.county_code OR (p.county_code = '' AND lm.county_code IS NULL))
  AND (NULLIF(p.msamd, '') = lm.msamd OR (p.msamd = '' AND lm.msamd IS NULL))
  AND p.state_code = lm.state_code
  AND (NULLIF(p.census_tract_number, '') = lm.census_tract_number OR 
       (p.census_tract_number = '' AND lm.census_tract_number IS NULL));

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
WHERE p.applicant_race_1 IS NOT NULL AND p.applicant_race_1 != ''
  AND (p.id, 1) NOT IN (SELECT application_id, race_number FROM Applicant_Race);

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 2, p.applicant_race_2::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_2 IS NOT NULL AND p.applicant_race_2 != ''
  AND (p.id, 2) NOT IN (SELECT application_id, race_number FROM Applicant_Race);

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 3, p.applicant_race_3::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_3 IS NOT NULL AND p.applicant_race_3 != ''
  AND (p.id, 3) NOT IN (SELECT application_id, race_number FROM Applicant_Race);

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 4, p.applicant_race_4::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_4 IS NOT NULL AND p.applicant_race_4 != ''
  AND (p.id, 4) NOT IN (SELECT application_id, race_number FROM Applicant_Race);

INSERT INTO Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 5, p.applicant_race_5::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.applicant_race_5 IS NOT NULL AND p.applicant_race_5 != ''
  AND (p.id, 5) NOT IN (SELECT application_id, race_number FROM Applicant_Race);

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
WHERE p.co_applicant_race_1 IS NOT NULL AND p.co_applicant_race_1 != ''
  AND (p.id, 1) NOT IN (SELECT application_id, race_number FROM Co_Applicant_Race);

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 2, p.co_applicant_race_2::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_2 IS NOT NULL AND p.co_applicant_race_2 != ''
  AND (p.id, 2) NOT IN (SELECT application_id, race_number FROM Co_Applicant_Race);

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 3, p.co_applicant_race_3::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_3 IS NOT NULL AND p.co_applicant_race_3 != ''
  AND (p.id, 3) NOT IN (SELECT application_id, race_number FROM Co_Applicant_Race);

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 4, p.co_applicant_race_4::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_4 IS NOT NULL AND p.co_applicant_race_4 != ''
  AND (p.id, 4) NOT IN (SELECT application_id, race_number FROM Co_Applicant_Race);

INSERT INTO Co_Applicant_Race (application_id, race_number, race_code)
SELECT p.id, 5, p.co_applicant_race_5::INT
FROM preliminary p
JOIN Application a ON p.id = a.id
WHERE p.co_applicant_race_5 IS NOT NULL AND p.co_applicant_race_5 != ''
  AND (p.id, 5) NOT IN (SELECT application_id, race_number FROM Co_Applicant_Race);
