-- Create Database
CREATE DATABASE AwardProject1;

-- Pick the Database
USE AwardProject1;

---------------------------------------------------------------------------------------------------------------------------------
-- TABLE CREATION
---------------------------------------------------------------------------------------------------------------------------------


-- Table: application
CREATE TABLE application (
    application_id INTEGER PRIMARY KEY,
    content TEXT NOT NULL,
	student_id INTEGER REFERENCES student (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    reviewer_id INTEGER REFERENCES university_financial_services_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: approve_award_report
CREATE TABLE approve_award_report (
    report_id INTEGER PRIMARY KEY,
    approve_award_list TEXT NOT NULL,
    maintainer_id INTEGER REFERENCES approve_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    reviewer_id INTEGER REFERENCES university_financial_services_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: approve_office
CREATE TABLE approve_office (
    officer_id INTEGER PRIMARY KEY,
    email TEXT NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    branch TEXT,
    pre_approve_permission INTEGER
);

-- Table: award
CREATE TABLE award (
    award_id INTEGER PRIMARY KEY,
    name TEXT    NOT NULL,
    award_value INTEGER NOT NULL,
    category TEXT NOT NULL,
    approve_officer INTEGER REFERENCES approve_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    pre_approve_by  INTEGER DEFAULT NULL REFERENCES approve_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    payment_id INTEGER REFERENCES payment (payment_id) ON DELETE CASCADE  ON UPDATE CASCADE,
    request_id INTEGER REFERENCES request_for_approval (request_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: payment
CREATE TABLE payment (
    payment_id INTEGER PRIMARY KEY,
    type TEXT NOT NULL,
    paid_by_prd INTEGER REFERENCES payment_request_document (document_id) ON DELETE CASCADE ON UPDATE CASCADE,
    paid_by_card INTEGER REFERENCES student_payment_procurement_cardholder (holder_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: payment_request_document
CREATE TABLE payment_request_document (
    document_id INTEGER PRIMARY KEY,
    payment_id INTEGER NOT NULL,
    award_name TEXT,
    award_reference_code INTEGER,
    receipt TEXT NOT NULL,
    reviewer_id INTEGER REFERENCES university_financial_services_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    pbs_form INTEGER REFERENCES pbs (pbs_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: pbs
CREATE TABLE pbs (
    pbs_id INTEGER PRIMARY KEY,
    amount INTEGER NOT NULL CHECK(amount >= 0),
    student_name TEXT NOT NULL,
    student_id INTEGER NOT NULL REFERENCES student (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    reviewer_id  INTEGER REFERENCES student_financial_aid_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: reconciliation_worksheet
CREATE TABLE reconciliation_worksheet (
    worksheet_id INTEGER PRIMARY KEY,
    transactions TEXT NOT NULL,
    maintainer_id INTEGER REFERENCES student_payment_procurement_cardholder (holder_id) ON DELETE CASCADE ON UPDATE CASCADE,
    reviewer_id   INTEGER REFERENCES student_financial_aid_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: request_for_approval
CREATE TABLE request_for_approval (
    request_id INTEGER PRIMARY KEY,
    fund_source TEXT NOT NULL,
    award_value INTEGER NOT NULL,
    award_type TEXT NOT NULL,
    criteria_for_selection TEXT NOT NULL,
    program_description TEXT NOT NULL,
    purpose TEXT NOT NULL,
    request_officer_id INTEGER REFERENCES university_financial_services_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    approve_officer_id INTEGER REFERENCES approve_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: student
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    course TEXT NOT NULL);
    
-- Table: student_financial_aid_office
CREATE TABLE student_financial_aid_office (
    officer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

-- Table: student_financial_aid_record
CREATE TABLE student_financial_aid_record (
    record_id INTEGER PRIMARY KEY,
    student_id INTEGER REFERENCES student (student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    aid_amount INTEGER NOT NULL,
    officer_id INTEGER REFERENCES student_financial_aid_office (officer_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: student_payment_procurement_cardholder
CREATE TABLE student_payment_procurement_cardholder (
    holder_id INTEGER PRIMARY KEY,
    money_amount INTEGER
);

-- Table: transaction_documentation
CREATE TABLE transaction_documentation (
    transaction_id INTEGER PRIMARY KEY,
    award_name TEXT,
    award_reference_code TEXT NOT NULL,
    receipt TEXT NOT NULL,
    maintainer_id INTEGER REFERENCES student_payment_procurement_cardholder (holder_id) ON DELETE CASCADE ON UPDATE CASCADE,
    payment_id INTEGER REFERENCES payment (payment_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: university_financial_services_office
CREATE TABLE university_financial_services_office (
    officer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL
);

---------------------------------------------------------------------------------------------------------------------------------
-- INSTANCE LEVEL DATA
---------------------------------------------------------------------------------------------------------------------------------

-- Insert: student
INSERT INTO student (student_id,name, course) VALUES (147,'Leo', 'science');
INSERT INTO student (student_id,name, course) VALUES (225,'Alex', 'economics');
INSERT INTO student (student_id,name, course) VALUES (115,'Jay', 'art');

-- Insert: application
INSERT INTO application (application_id,content,student_id,reviewer_id) VALUES (1,'game prize',2,1);
INSERT INTO application (application_id,content,student_id,reviewer_id) VALUES (2,'scholarship',1,1);
INSERT INTO application (application_id,content,student_id,reviewer_id) VALUES (3,'salary',3,1);

-- Insert: approve_award_report
INSERT INTO approve_award_report (report_id, approve_award_list, maintainer_id,reviewer_id) 
VALUES (1,'game prize for Alex(student_id: 2)',2,2);

INSERT INTO approve_award_report (report_id, approve_award_list, maintainer_id,reviewer_id) 
VALUES (2,'scholarship for Leo(student_id: 1)',2,2);

-- Insert: approve_office
INSERT INTO approve_office (officer_id,email,name,type,branch,pre_approve_permission) 
VALUES (1,'jimmy@gamil.com','Jimmy','dean',NULL,1);

INSERT INTO approve_office (officer_id,email,name,type,branch,pre_approve_permission) 
VALUES (2,'zoey@gmail.com','Zoey','provost_officers',NULL,1);

-- Insert: award
INSERT INTO award (award_id,name,award_value,category,approve_officer, pre_approve_by,payment_id,request_id)
VALUES (1, 'game prize',100,'2', 1, NULL, 1, 1);

INSERT INTO award (award_id,name,award_value,category,approve_officer, pre_approve_by,payment_id,request_id)
VALUES (2, 'scholarship', 600,'3', 2, NULL, 2,2);

INSERT INTO award (award_id,name,award_value,category,approve_officer, pre_approve_by,payment_id,request_id)
VALUES (3, 'salary', 200, '2', 1, NULL, 3, 3);

-- Insert: payment
INSERT INTO payment (payment_id, type,paid_by_prd,paid_by_card) VALUES (1,'Card',NULL,1);
INSERT INTO payment (payment_id, type,paid_by_prd,paid_by_card) VALUES (2,'PRD',1,NULL);
INSERT INTO payment (payment_id, type,paid_by_prd,paid_by_card) VALUES (3,'Card',NULL,2);

-- Insert: payment_request_document
INSERT INTO payment_request_document (document_id,payment_id,award_name,award_reference_code,receipt,reviewer_id,pbs_form)
VALUES (1,2,'scholarship','002','from school', 2,1);

-- Insert: pbs
INSERT INTO pbs ( pbs_id,amount,student_name,student_id,reviewer_id)
VALUES (1,600,'Leo',1,2);

-- Insert: reconciliation_worksheet
INSERT INTO reconciliation_worksheet (worksheet_id,transactions,maintainer_id,reviewer_id)
VALUES (1,'for game prize', 1,2);

INSERT INTO reconciliation_worksheet (worksheet_id,transactions,maintainer_id,reviewer_id)
VALUES ( 2,'for salary', 2, 2);

-- Insert:request_for_approval
INSERT INTO request_for_approval (request_id,fund_source,award_value, award_type,criteria_for_selection,program_description, purpose, request_officer_id,approve_officer_id)
VALUES (1,'unrestricted general funds - self supporting',100,'2','check the game winner information','last week''s football game','game prize',1,1);

INSERT INTO request_for_approval (request_id,fund_source,award_value, award_type,criteria_for_selection,program_description, purpose, request_officer_id,approve_officer_id)
VALUES (2,'restricted gifts',600,'3','check this student''s grade and behaviours','national scholarship','scholarship',1,2);

INSERT INTO request_for_approval (request_id,fund_source,award_value, award_type,criteria_for_selection,program_description, purpose, request_officer_id,approve_officer_id)
VALUES (3,'unrestricted general funds - self supporting',200,'2','check the student''s work condition','bookstore salary','salary',1,1);

-- Insert: student_financial_aid_office
INSERT INTO student_financial_aid_office (officer_id,name) VALUES (1,'Kate');
INSERT INTO student_financial_aid_office (officer_id,name) VALUES (2,'Kevin');
                   
-- Insert: student_financial_aid_record
INSERT INTO student_financial_aid_record (record_id,student_id, aid_amount,officer_id) VALUES (1,1,600,2);
INSERT INTO student_financial_aid_record (record_id,student_id, aid_amount,officer_id) VALUES(2,3,200,2);

-- Insert: student_payment_procurement_cardholder
INSERT INTO student_payment_procurement_cardholder (holder_id,money_amount) VALUES (1,300);
INSERT INTO student_payment_procurement_cardholder (holder_id,money_amount) VALUES (2,400);

-- Insert: transaction_documentation
INSERT INTO transaction_documentation (transaction_id,award_name,award_reference_code,receipt,maintainer_id,payment_id)
VALUES (1,'game','001','from store',1,1);

INSERT INTO transaction_documentation (transaction_id,award_name,award_reference_code,receipt,maintainer_id,payment_id)
VALUES (2, 'salary','003','from bookstore', 2,3);

-- Insert: transaction_documentation
INSERT INTO university_financial_services_office (officer_id,name,email)
VALUES (1,'David','david@gmail.com');

INSERT INTO university_financial_services_office (officer_id,name,email)
VALUES (2, 'Sam','sam@gmail.com');

---------------------------------------------------------------------------------------------------------------------------------
-- CLIENT QUESTIONS
---------------------------------------------------------------------------------------------------------------------------------

-- 1
SELECT SUM(award.award_value)
FROM transaction_documentation
JOIN award ON transaction_documentation.payment_id = award.payment_id;

-- 2
SELECT COUNT(*)
FROM (
  SELECT award.award_id
  FROM award
  INNER JOIN approve_office ON award.approve_officer = approve_office.officer_id
  WHERE approve_office.pre_approve_permission = 1
) a;

-- 3
SELECT ufso.name, ufso.email
FROM university_financial_services_office ufso
JOIN application a ON ufso.officer_id = a.reviewer_id
JOIN award aw ON a.application_id = aw.request_id
GROUP BY ufso.name, ufso.email
ORDER BY COUNT(*) DESC
LIMIT 1;

