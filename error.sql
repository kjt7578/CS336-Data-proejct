INSERT INTO Application (id, as_of_year, respondent_id, agency_code, loan_type, property_type, loan_purpose, owner_occupancy, loan_amount_000s, preapproval, action_taken, location_id, applicant_ethnicity, co_applicant_ethnicity, applicant_sex, co_applicant_sex, applicant_income_000s, purchaser_type, denial_reason_1, denial_reason_2, denial_reason_3, rate_spread, hoepa_status, lien_status, sequence_number, application_date_indicator)
VALUES (99999999, 2017, 'fake_id', 999, 1, 1, 1, 1, 100, 1, 1, 1, 1, 1, 1, 1, 100, 1, NULL, NULL, NULL, NULL, 1, 1, '123456', 'A');


INSERT INTO Application (
  id, as_of_year, respondent_id, agency_code, loan_type, property_type,
  loan_purpose, owner_occupancy, loan_amount_000s, preapproval,
  action_taken, location_id, applicant_ethnicity, co_applicant_ethnicity,
  applicant_sex, co_applicant_sex, applicant_income_000s, purchaser_type,
  denial_reason_1, denial_reason_2, denial_reason_3,
  rate_spread, hoepa_status, lien_status, sequence_number, application_date_indicator
)
VALUES (
  2, 2023, '8888888', 1, 999, 1,
  1, 1, 100, 1,
  1, 1, NULL, NULL,
  NULL, NULL, 100, 1,
  NULL, NULL, NULL,
  NULL, 1, 1, '123457', 'A'
);


INSERT INTO Applicant_Race (application_id, race_number, race_code)
VALUES (1, 6, 1);
