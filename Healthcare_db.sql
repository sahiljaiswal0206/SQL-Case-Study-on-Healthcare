DROP DATABASE IF EXISTS healthcare_db;
CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

CREATE TABLE Patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  phone VARCHAR(20)
);
INSERT INTO Patients (first_name, last_name, date_of_birth, phone) VALUES
('Alice',  'Johnson', '1985-02-14', '555-111-1001'),
('Bob',    'Smith',   '1990-07-22', '555-111-1002'),
('Carol',  'Nguyen',  '1978-11-05', '555-111-1003'),
('David',  'Patel',   '2001-03-30', '555-111-1004'),
('Emily',  'Garcia',  '1995-12-09', '555-111-1005'),
('Frank',  'Lee',     '1982-05-18', '555-111-1006');


CREATE TABLE Doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
  specialty  VARCHAR(100) NOT NULL,
  phone VARCHAR(20)
);
INSERT INTO Doctors (first_name, last_name, specialty, phone) VALUES
('Grace', 'Kim',     'Cardiology',     '555-222-2001'),
('Henry', 'Brown',   'Dermatology',    '555-222-2002'),
('Irene', 'Lopez',   'Pediatrics',     '555-222-2003'),
('James', 'Wilson',  'Orthopedics',    '555-222-2004'),
('Karen', 'Singh',   'Internal Med',   '555-222-2005'),
('Liam',  'O\'Neil', 'Neurology',      '555-222-2006');


CREATE TABLE Rooms (
  room_id INT AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(10) NOT NULL UNIQUE,
  room_type VARCHAR(50) NOT NULL,
  capacity INT NOT NULL
);
INSERT INTO Rooms (room_number, room_type, capacity) VALUES
('101', 'Exam', 1),
('102', 'Exam', 1),
('201', 'Ward', 2),
('202', 'Ward', 2),
('301', 'ICU',  1);


CREATE TABLE InsurancePolicies (
  policy_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  provider VARCHAR(100) NOT NULL,
  policy_number VARCHAR(50) NOT NULL UNIQUE,
  coverage_start DATE NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO InsurancePolicies (patient_id, provider, policy_number, coverage_start) VALUES
(1, 'BlueShield', 'BS-10001', '2023-01-01'),
(2, 'UnitedCare', 'UC-20001', '2023-03-15'),
(3, 'MediPlus',   'MP-30001', '2022-06-01'),
(4, 'BlueShield', 'BS-10002', '2024-02-01'),
(5, 'LifeSecure', 'LS-50001', '2023-11-20');


CREATE TABLE Appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_datetime DATETIME NOT NULL,
  room_id INT,
  status ENUM('scheduled','completed','cancelled') NOT NULL DEFAULT 'scheduled',
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
    ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO Appointments (patient_id, doctor_id, appointment_datetime, room_id, status) VALUES
(1, 1, '2025-08-20 09:00:00', 1, 'completed'),
(2, 2, '2025-08-21 10:30:00', 2, 'completed'),
(3, 5, '2025-08-22 11:00:00', 3, 'scheduled'),
(4, 4, '2025-08-22 14:00:00', 4, 'scheduled'),
(5, 3, '2025-08-23 09:15:00', 1, 'scheduled'),
(6, 6, '2025-08-23 15:45:00', 5, 'scheduled');


CREATE TABLE MedicalRecords (
  record_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  visit_date DATE NOT NULL,
  diagnosis VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
INSERT INTO MedicalRecords (patient_id, doctor_id, visit_date, diagnosis) VALUES
(1, 1, '2025-08-20', 'Hypertension, stable'),
(2, 2, '2025-08-21', 'Eczema flare-up'),
(3, 5, '2025-08-22', 'Type 2 Diabetes, new dx'),
(4, 4, '2025-08-22', 'Knee sprain'),
(5, 3, '2025-08-23', 'Routine pediatric check');


CREATE TABLE Prescriptions (
  prescription_id INT AUTO_INCREMENT PRIMARY KEY,
  record_id INT NOT NULL,
  medication_name VARCHAR(100) NOT NULL,
  dosage VARCHAR(50) NOT NULL,
  instructions VARCHAR(255),
  FOREIGN KEY (record_id) REFERENCES MedicalRecords(record_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO Prescriptions (record_id, medication_name, dosage, instructions) VALUES
(1, 'Lisinopril', '10 mg daily', 'Take once daily in the morning'),
(2, 'Hydrocortisone cream', 'Apply BID', 'Thin layer to affected area'),
(3, 'Metformin', '500 mg BID', 'With meals'),
(4, 'Ibuprofen', '400 mg TID prn', 'Take with food, as needed'),
(5, 'Multivitamin', '1 tab daily', 'Morning with water'),
(5, 'Acetaminophen', '500 mg q6h prn', 'Max 3g/day');


CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  appointment_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  method ENUM('cash','card','insurance') NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO Payments (patient_id, appointment_id, amount, method) VALUES
(1, 1, 120.00, 'card'),
(2, 2, 85.00,  'insurance'),
(3, 3, 40.00,  'cash'),
(4, 4, 60.00,  'card'),
(5, 5, 30.00,  'insurance'),
(6, 6, 50.00,  'cash');



 -- 1. Show doctor full names and specialty, ordered by specialty then name.

SELECT CONCAT(first_name, ' ', last_name) AS doctor_name,
       specialty
FROM Doctors
ORDER BY specialty, doctor_name;

-- 2. Return room_number and capacity for rooms that can hold 2 or more.

SELECT room_number, capacity
FROM Rooms
WHERE capacity >= 2
ORDER BY room_number;

-- 3.  List patient names who do not have any insurance.

SELECT CONCAT(p.first_name, ' ', p.last_name) AS patient_name
FROM Patients p
LEFT JOIN InsurancePolicies ip 
ON ip.patient_id = p.patient_id
WHERE ip.policy_id IS NULL
ORDER BY patient_name;

-- 4. Show the next 10 scheduled appointments with patient and doctor names.

SELECT a.appointment_id,
a.appointment_datetime,
CONCAT(p.first_name, ' ', p.last_name) AS patient,
CONCAT(d.first_name, ' ', d.last_name) AS doctor
FROM Appointments a
JOIN Patients p ON p.patient_id = a.patient_id
JOIN Doctors d ON d.doctor_id = a.doctor_id
WHERE a.status = 'scheduled'
ORDER BY a.appointment_datetime
LIMIT 10;

-- 5. List each patient and their total payments (0 if none).

SELECT p.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       SUM(pay.amount) AS total_paid
FROM Patients p
LEFT JOIN Payments pay ON pay.patient_id = p.patient_id
GROUP BY p.patient_id
ORDER BY total_paid DESC, patient;

-- 6. Find patients whose diagnosis contains the word 'Diabetes'.

SELECT DISTINCT p.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       mr.diagnosis
FROM MedicalRecords mr
JOIN Patients p ON p.patient_id = mr.patient_id
WHERE mr.diagnosis LIKE '%Diabetes%';

-- 7.  Label appointments as 'Active' for scheduled, else 'Inactive'.

select appointment_id, status,
case
when status = 'scheduled' then 'Active' Else 'Inactive'
END AS status_label
from appointments
order by appointment_id;

-- 8. Show each payment with patient name and appointment datetime.

SELECT pay.payment_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       a.appointment_datetime,
       pay.amount,
       pay.method
FROM Payments pay
LEFT JOIN Patients p ON p.patient_id = pay.patient_id
LEFT JOIN Appointments a ON a.appointment_id = pay.appointment_id
ORDER BY pay.payment_id;

-- 9. List patient names with zero completed appointments.

SELECT CONCAT(first_name, ' ', last_name) AS patient
FROM Patients
WHERE patient_id NOT IN (
  SELECT DISTINCT patient_id
  FROM Appointments
  WHERE status = 'completed'
)
ORDER BY patient;

-- 10. Return appointment_id scheduled in rooms with capacity greater than the average capacity

SELECT appointment_id
FROM Appointments
WHERE room_id IN (
  SELECT room_id
  FROM Rooms
  WHERE capacity > (SELECT AVG(capacity) FROM Rooms)
);

-- 11 Return room_number for rooms that are referenced by any scheduled appointment.

SELECT room_number
FROM Rooms
WHERE room_id IN (
  SELECT DISTINCT room_id
  FROM Appointments
  WHERE status = 'scheduled' AND room_id IS NOT NULL
);

-- 12 Return first 15 characters of diagnosis as preview.

SELECT record_id,
       diagnosis,
       SUBSTRING(diagnosis, 1, 15) AS diagnosis_preview
FROM MedicalRecords
ORDER BY record_id;

-- 13. Remove dashes from patient phones.

SELECT patient_id,
       phone AS original_phone,
       REPLACE(phone, '-', '') AS normalized_phone
FROM Patients
ORDER BY patient_id;

-- 14.  List patient names who have at least one appointment with a Neurology specialist.

SELECT CONCAT(p.first_name, ' ', p.last_name) AS patient
FROM Patients p
WHERE p.patient_id IN (
  SELECT a.patient_id
  FROM Appointments a
  JOIN Doctors d ON d.doctor_id = a.doctor_id
  WHERE d.specialty = 'Neurology'
);

-- 15. Flag payments >= 100 as 'High', else 'Normal'.

SELECT payment_id, amount,
       IF(amount >= 100, 'High', 'Normal') AS payment_size
FROM Payments
ORDER BY amount DESC, payment_id;

-- 16. Map statuses to 'Active', 'Done', 'Cancelled', 'Other'.

SELECT appointment_id, status,
       CASE status
         WHEN 'scheduled' THEN 'Active'
         WHEN 'completed' THEN 'Done'
         WHEN 'cancelled' THEN 'Cancelled'
         ELSE 'Other'
       END AS status_label
FROM Appointments
ORDER BY appointment_id;

