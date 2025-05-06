DROP TABLE IF EXISTS Preliminary;

CREATE TABLE Preliminary(
   as_of_year VARCHAR(4),
   respondent_id  VARCHAR(12),
   agency_name  VARCHAR(45),
   agency_abbr VARCHAR(4),
   agency_code VARCHAR(1),
   loan_type_name VARCHAR(20),
   loan_type VARCHAR(1),
   property_type_name VARCHAR(61),
   property_type VARCHAR(1),
   loan_purpose_name VARCHAR(16),
   loan_purpose VARCHAR(1),
   owner_occupancy_name VARCHAR(42),
   owner_occupancy VARCHAR(1),
   loan_amount_000s VARCHAR(6),
   preapproval_name VARCHAR(29),
   preapproval VARCHAR(1),
   action_taken_name VARCHAR(51),
   action_taken VARCHAR(1),
   msamd_name VARCHAR(44),
   msamd VARCHAR(5),
   state_name VARCHAR(10),
   state_abbr VARCHAR(2),
   state_code VARCHAR(2),
   county_name VARCHAR(17),
   county_code VARCHAR(2),
   census_tract_number VARCHAR(7),
   applicant_ethnicity_name VARCHAR(81),
   applicant_ethnicity VARCHAR(1),
   co_applicant_ethnicity_name VARCHAR(81),
   co_applicant_ethnicity VARCHAR(1),
   applicant_race_name_1 VARCHAR(81),
   applicant_race_1 VARCHAR(1),
   applicant_race_name_2 VARCHAR(41),
   applicant_race_2 VARCHAR(1),
   applicant_race_name_3 VARCHAR(41),
   applicant_race_3 VARCHAR(1),
   applicant_race_name_4 VARCHAR(41),
   applicant_race_4 VARCHAR(1),
   applicant_race_name_5 VARCHAR(41),
   applicant_race_5 VARCHAR(1),
   co_applicant_race_name_1 VARCHAR(81),
   co_applicant_race_1 VARCHAR(1),
   co_applicant_race_name_2 VARCHAR(41),
   co_applicant_race_2 VARCHAR(1),
   co_applicant_race_name_3 VARCHAR(41),
   co_applicant_race_3 VARCHAR(1),
   co_applicant_race_name_4 VARCHAR(41),
   co_applicant_race_4 VARCHAR(1),
   co_applicant_race_name_5 VARCHAR(81),
   co_applicant_race_5 VARCHAR(1),
   applicant_sex_name VARCHAR(81),
   applicant_sex VARCHAR(1),
   co_applicant_sex_name VARCHAR(81),
   co_applicant_sex VARCHAR(1),
   applicant_income_000s VARCHAR(7),
   purchaser_type_name VARCHAR(76),
   purchaser_type VARCHAR(1),
   denial_reason_name_1 VARCHAR(46),
   denial_reason_1 VARCHAR(46),
   denial_reason_name_2 VARCHAR(46),
   denial_reason_2 VARCHAR(46),
   denial_reason_name_3 VARCHAR(46),
   denial_reason_3 VARCHAR(46),
   rate_spread VARCHAR(5),
   hoepa_status_name VARCHAR(16),
   hoepa_status VARCHAR(1),
   lien_status_name VARCHAR(29),
   lien_status VARCHAR(1),
   edit_status_name VARCHAR(50) NULL,
   edit_status VARCHAR(50) NULL,
   sequence_number VARCHAR(50) NULL,
   "population" VARCHAR(5),
   minority_population VARCHAR(20),
   hud_median_family_income VARCHAR(5),
   tract_to_msamd_income VARCHAR(20),
   number_of_owner_occupied_units VARCHAR(4),
   number_of_1_to_4_family_units VARCHAR(4),
   application_date_indicator VARCHAR(50) NULL,
   ID SERIAL PRIMARY KEY
);


CREATE TABLE IF NOT EXISTS Loan_Type (
   loan_type VARCHAR(1) PRIMARY KEY,
   loan_type_name VARCHAR(20)
);


INSERT INTO Loan_Type (loan_type, loan_type_name) VALUES
('1', 'Conventional'),
('2', 'FHA-insured'),
('3', 'VA-guaranteed'),
('4', 'USDA');

-- Sample INSERT statements for Preliminary (using fabricated data for demonstration)
INSERT INTO Preliminary (
   as_of_year, respondent_id, agency_name, loan_type_name, loan_type, property_type_name,
   property_type, loan_purpose_name, loan_purpose, owner_occupancy_name, owner_occupancy, 
   loan_amount_000s, action_taken_name, action_taken, state_name, applicant_income_000s, 
   denial_reason_name_1
) VALUES 
('2017', '0000000123', 'Federal Reserve System', 'Conventional', '1', 'Single Family', 
 '1', 'Home Purchase', '1', 'Owner-occupied', '1', '250', 'Loan originated', 
 '1', 'New Jersey', '80', NULL),

('2017', '0000000124', 'FDIC', 'FHA-insured', '2', 'Single Family', 
 '1', 'Refinancing', '2', 'Owner-occupied', '1', '180', 'Loan originated', 
 '1', 'New Jersey', '65', NULL),

('2017', '0000000125', 'OCC', 'Conventional', '1', 'Multifamily', 
 '3', 'Home Purchase', '1', 'Not owner-occupied', '2', '400', 'Application denied', 
 '3', 'New Jersey', '75', 'Debt-to-income ratio'),

('2017', '0000000126', 'CFPB', 'VA-guaranteed', '3', 'Single Family', 
 '1', 'Home Purchase', '1', 'Owner-occupied', '1', '320', 'Loan originated', 
 '1', 'New Jersey', '95', NULL),

('2017', '0000000127', 'Federal Reserve System', 'Conventional', '1', 'Single Family', 
 '1', 'Refinancing', '2', 'Owner-occupied', '1', '210', 'Application denied', 
 '3', 'New Jersey', '60', 'Credit history');
