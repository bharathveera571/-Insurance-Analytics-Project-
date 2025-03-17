create database insurance_analytics_project;
use insurance_analytics_project;
select * from customer_information;
select * from policy_details;
select * from claims;
select * from payment_history;
select * from additional_fields;
ALTER TABLE additional_fields
CHANGE `Policy ID` policy_id VARCHAR(255);
ALTER TABLE policy_details
CHANGE `Policy ID` policy_id VARCHAR(255);
ALTER TABLE customer_information
CHANGE `Customer ID` customer_id VARCHAR(255);
ALTER TABLE claims
CHANGE `Claim Amount` claim_amount VARCHAR(255);
ALTER TABLE policy_details
CHANGE `Policy Type` policy_type VARCHAR(255);
ALTER TABLE policy_details
CHANGE `Policy End Date` Policy_End_Date VARCHAR(255);
ALTER TABLE policy_details
CHANGE `Premium Amount` Premium_Amount VARCHAR(255);
ALTER TABLE policy_details
CHANGE `Policy Start Date` Policy_Start_Date VARCHAR(255);

--------------------------- KPI-1--------------------------------------
select count(policy_id) from additional_fields;

--------------------------- KPI-2--------------------------------------
select count(customer_id) from customer_information;

--------------------------- KPI-3--------------------------------------
SELECT SUM(Claim_Amount) /(1000000) AS Claim_Amount_in_Millions FROM claims;

--------------------------- KPI-4--------------------------------------
ALTER TABLE customer_information
ADD COLUMN age_bucket VARCHAR(50);

UPDATE customer_information
SET age_bucket = CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    WHEN age BETWEEN 51 AND 65 THEN '51-65'
    ELSE 'Above 65'
END;
SELECT age_bucket, COUNT(*) AS policy_count
FROM customer_information
GROUP BY age_bucket;
--------------------------- KPI-5--------------------------------------
SELECT Gender, COUNT(*) AS policy_count
FROM customer_information
GROUP BY Gender;
--------------------------- KPI-6--------------------------------------
SELECT policy_type, COUNT(*) AS policy_count
FROM policy_details
GROUP BY policy_type;
--------------------------- KPI-7--------------------------------------
SELECT YEAR(Policy_End_Date) AS policy_end_year, COUNT(policy_id) AS policy_count FROM policy_details
GROUP BY YEAR(Policy_End_Date);
--------------------------- KPI-8--------------------------------------
select Status,COUNT(policy_id) AS policy_count FROM policy_details group by Status;
--------------------------- KPI-9--------------------------------------
SELECT 
    YEAR(policy_start_date) AS policy_year,
    ROUND((SUM(Premium_Amount) / (SELECT SUM(Premium_Amount) FROM policy_details)) * 100, 2) AS growth_rate
FROM 
    policy_details
GROUP BY 
    YEAR(policy_start_date);



