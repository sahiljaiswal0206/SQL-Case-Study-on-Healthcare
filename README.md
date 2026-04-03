
# SQL Case Study on Healthcare

### Project Overview
This project is a Healthcare Management System database built using SQL. It simulates real-world healthcare operations such as managing patients, doctors, appointments, medical records, and payments.

The goal of this project is to demonstrate strong SQL skills, including database design, data manipulation, and query writing for analytical purposes.

### Tools Used
MySQL Workbench

### Database Structure

The database consists of the following tables:

Patients – Stores patient details.

Doctors – Stores doctor information and specialties.

Rooms – Contains hospital room details.

InsurancePolicies – Tracks patient insurance data.

Appointments – Manages scheduling between patients and doctors.

MedicalRecords – Stores diagnosis and visit history.

Prescriptions – Contains prescribed medications.

Payments – Records billing and payment methods.

### Relationships (Conceptual ER Description)

**.** Each patient can have multiple appointments, medical records, and payments.

**.** Each doctor can handle multiple appointments and medical records.

**.** Appointments connect patients, doctors, and rooms.

**.** Medical records are linked to both patients and doctors.

**.** Prescriptions are linked to medical records.

**.** Payments are linked to patients and appointments.

### Key Features
**.** Fully normalized relational database.

**.** Use of primary keys and foreign keys for data integrity.

**.** Realistic healthcare workflow simulation.

**.** Sample dataset included for testing.

### SQL Concepts Demonstrated
This project covers a wide range of SQL concepts:

**.** Joins (INNER JOIN, LEFT JOIN).

**.** Subqueries.

**.** Aggregate Functions (SUM, AVG).

**.** Grouping & Sorting (GROUP BY, ORDER BY).

**.** Conditional Logic (CASE, IF).

**.** String Functions (CONCAT, REPLACE, SUBSTRING).

**.** Filtering (WHERE, LIKE).

**.** Constraints & Relationships.

### Sample Queries Included
**.** Some example analyses performed in this project:

**.** Retrieve doctor names with specialties.

**.** Find patients without insurance.

**.** List upcoming scheduled appointments.

**.** Calculate total payments per patient.

**.** Identify patients with specific diagnoses (e.g., Diabetes).

**.** Classify appointment and payment statuses.

**.** Filter records using subqueries.

### How to Run the Project
1. Open MySQL Workbench.
2. Create a new SQL file
3. Copy and paste the provided SQL script
4. Run the script to:

**.** Create the database

**.** Create all tables

**.** Insert sample data

5. Execute the queries to view results.

### Future Improvements
**.** Add more advanced analytics queries

**.** Create views for reporting

**.** Add stored procedures and triggers

**.** Build a dashboard using Power BI or Tableau

### Conclusion
This project demonstrates the ability to design a structured database and write efficient SQL queries for real-world scenarios. It reflects practical knowledge useful for roles such as Data Analyst and SQL Developer.