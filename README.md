# Student_Award_System_University-of-Kentucky

Establishing student recognition awards and prizes is an important aspect of promoting academic excellence and motivating students to achieve their full potential. However, managing and keeping track of student achievements can be a daunting task for educational institutions. Creating a database management system for the Establishment of Student Recognition Awards and Prizes can help streamline this process and provide a centralized repository for storing and managing student recognition data. The system is designed to efficiently store and manage data related to student achievements, including academic awards, scholarships, and prizes. It captures key information such as student details, award type, award amount, awarding organization, and date of recognition. Furthermore, the database management provides insights into student achievements over time, which can be useful for decision-making and program evaluation. Security measures should also be put in place to ensure the confidentiality and integrity of the data. 



The database schema includes multiple tables such as application, approve_award_report,
approve_office, award, payment, payment_request_document, pbs, reconciliation_worksheet,
request_for_approval, student, student_financial_aid_office, student_financial_aid_record,
student_payment_procurement_cardholder, transaction_documentation, and
university_financial_services_office. 

#### The schema includes various constraints and references to ensure data integrity and establish relationships between different tables.

a. PRIMARY KEY constraint: This ensures that each record in the table has a unique
identifier, which is essential for tracking individual records and avoiding duplicate
entries. It also allows other tables to reference that unique identifier as a foreign key.

* PRIMARY KEY constraint on the "award_id" field of the “award” table ensures that
each record in the "award" table has a unique identifier.


b. NOT NULL constraint: This ensures that a column cannot contain a NULL value, and
therefore enforces data integrity by preventing missing or incomplete data.
* NOT NULL constraint on the "amount" and "student_name" fields of the "pbs" table
ensures that every record in the "pbs" table contains amount and student name data,
and prevents the creation of records without content.

c. DEFAULT NULL constraint on "pre_approve_permission" field of “approve office” table
allows for the creation of records without a pre-approve permission value, as not all
approve officers may have permission.

d. ON DELETE CASCADE and ON UPDATE CASCADE constraints: This ensures that
when a record is deleted or updated in the source table, the corresponding foreign key
in the child table is also deleted or updated. This helps to maintain data consistency
and prevent orphaned records in the child tables.
* ON DELETE CASCADE & ON UPDATE CASCADE constraints ensure that if an
“officer_id” is deleted or updated in the “student_financial_aid_office” table, the
corresponding records in the “reconciliation_worksheet” table are also updated or
deleted, maintaining referential integrity.

e. REFERENCES constraint: This ensures that the value in that field must exist in the
referenced field of another table, providing referential integrity between the two tables.
This constraint helps to maintain data accuracy & consistency by preventing the
creation of invalid records that reference non-existent values in other tables.
* REFERENCES constraint on “maintainer_id” ensures that any value entered into this
field must already exist in the “holder_id” of
“student_payment_procurement_cardholder” table, preventing the creation of orphaned
records.

f. CHECK constraint on a specific field in a table ensures that the values in a column
meet a specific condition.
* CHECK constraint is added to the “amount” field of the “award” table. This ensures that
the “amount” field can only have values that are greater than or equal to zero.
