\copy (SELECT a.as_of_year, a.respondent_id, ag.agency_name, ag.agency_abbr, a.agency_code, lt.loan_type_name, a.loan_type, pt.property_type_name, a.property_type, lp.loan_purpose_name, a.loan_purpose, oo.owner_occupancy_name, a.owner_occupancy, a.loan_amount_000s, pa.preapproval_name, a.preapproval, at.action_taken_name, a.action_taken, m.msamd_name, s.state_name, s.state_abbr, s.state_code, c.county_name, c.county_code, l.census_tract_number, ec.ethnicity_name AS applicant_ethnicity_name, a.applicant_ethnicity, ec2.ethnicity_name AS co_applicant_ethnicity_name, a.co_applicant_ethnicity, rc1.race_name AS applicant_race_name_1, ar1.race_code AS applicant_race_1, rc2.race_name AS applicant_race_name_2, ar2.race_code AS applicant_race_2, rc3.race_name AS applicant_race_name_3, ar3.race_code AS applicant_race_3, rc4.race_name AS applicant_race_name_4, ar4.race_code AS applicant_race_4, rc5.race_name AS applicant_race_name_5, ar5.race_code AS applicant_race_5, rcc1.race_name AS co_applicant_race_name_1, car1.race_code AS co_applicant_race_1, rcc2.race_name AS co_applicant_race_name_2, car2.race_code AS co_applicant_race_2, rcc3.race_name AS co_applicant_race_name_3, car3.race_code AS co_applicant_race_3, rcc4.race_name AS co_applicant_race_name_4, car4.race_code AS co_applicant_race_4, rcc5.race_name AS co_applicant_race_name_5, car5.race_code AS co_applicant_race_5, sc.sex_name AS applicant_sex_name, a.applicant_sex, sc2.sex_name AS co_applicant_sex_name, a.co_applicant_sex, a.applicant_income_000s, pt2.purchaser_type_name, a.purchaser_type, dr1.denial_reason_name AS denial_reason_name_1, a.denial_reason_1, dr2.denial_reason_name AS denial_reason_name_2, a.denial_reason_2, dr3.denial_reason_name AS denial_reason_name_3, a.denial_reason_3, a.rate_spread, hs.hoepa_status_name, a.hoepa_status, ls.lien_status_name, a.lien_status, n.edit_status_name, n.edit_status, a.sequence_number, a.application_date_indicator, a.id FROM Application a LEFT JOIN Agency ag ON a.agency_code = ag.agency_code LEFT JOIN Loan_Type lt ON a.loan_type = lt.loan_type LEFT JOIN Property_Type pt ON a.property_type = pt.property_type LEFT JOIN Loan_Purpose lp ON a.loan_purpose = lp.loan_purpose LEFT JOIN OwnOcc oo ON a.owner_occupancy = oo.owner_occupancy LEFT JOIN PreApprove pa ON a.preapproval = pa.preapproval LEFT JOIN Action_Taken at ON a.action_taken = at.action_taken LEFT JOIN Location l ON a.location_id = l.location_id LEFT JOIN MSAMD m ON l.msamd = m.msamd LEFT JOIN State s ON l.state_code = s.state_code LEFT JOIN County c ON l.county_code = c.county_code LEFT JOIN Ethnicity_Code ec ON a.applicant_ethnicity = ec.ethnicity_code LEFT JOIN Ethnicity_Code ec2 ON a.co_applicant_ethnicity = ec2.ethnicity_code LEFT JOIN Applicant_Race ar1 ON a.id = ar1.application_id AND ar1.race_number = 1 LEFT JOIN Race_Code rc1 ON ar1.race_code = rc1.race_code LEFT JOIN Applicant_Race ar2 ON a.id = ar2.application_id AND ar2.race_number = 2 LEFT JOIN Race_Code rc2 ON ar2.race_code = rc2.race_code LEFT JOIN Applicant_Race ar3 ON a.id = ar3.application_id AND ar3.race_number = 3 LEFT JOIN Race_Code rc3 ON ar3.race_code = rc3.race_code LEFT JOIN Applicant_Race ar4 ON a.id = ar4.application_id AND ar4.race_number = 4 LEFT JOIN Race_Code rc4 ON ar4.race_code = rc4.race_code LEFT JOIN Applicant_Race ar5 ON a.id = ar5.application_id AND ar5.race_number = 5 LEFT JOIN Race_Code rc5 ON ar5.race_code = rc5.race_code LEFT JOIN Co_Applicant_Race car1 ON a.id = car1.application_id AND car1.race_number = 1 LEFT JOIN Race_Code rcc1 ON car1.race_code = rcc1.race_code LEFT JOIN Co_Applicant_Race car2 ON a.id = car2.application_id AND car2.race_number = 2 LEFT JOIN Race_Code rcc2 ON car2.race_code = rcc2.race_code LEFT JOIN Co_Applicant_Race car3 ON a.id = car3.application_id AND car3.race_number = 3 LEFT JOIN Race_Code rcc3 ON car3.race_code = rcc3.race_code LEFT JOIN Co_Applicant_Race car4 ON a.id = car4.application_id AND car4.race_number = 4 LEFT JOIN Race_Code rcc4 ON car4.race_code = rcc4.race_code LEFT JOIN Co_Applicant_Race car5 ON a.id = car5.application_id AND car5.race_number = 5 LEFT JOIN Race_Code rcc5 ON car5.race_code = rcc5.race_code LEFT JOIN Sex_Code sc ON a.applicant_sex = sc.sex_code LEFT JOIN Sex_Code sc2 ON a.co_applicant_sex = sc2.sex_code LEFT JOIN Purchaser_Type pt2 ON a.purchaser_type = pt2.purchaser_type LEFT JOIN Denial_Reason dr1 ON a.denial_reason_1 = dr1.denial_reason_code LEFT JOIN Denial_Reason dr2 ON a.denial_reason_2 = dr2.denial_reason_code LEFT JOIN Denial_Reason dr3 ON a.denial_reason_3 = dr3.denial_reason_code LEFT JOIN HOEPA_Status hs ON a.hoepa_status = hs.hoepa_status LEFT JOIN Lien_Status ls ON a.lien_status = ls.lien_status LEFT JOIN Nulls n ON true ORDER BY a.id) TO 'normalized_output.csv' WITH CSV HEADER;
