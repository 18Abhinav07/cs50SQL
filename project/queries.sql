-- Query 1: Retrieve all patients along with their appointments
SELECT p.*, a.*
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id;

-- Query 2: List all doctors and their respective departments
SELECT d.*, dept.name AS department_name
FROM Doctors d
JOIN Departments dept ON d.department_id = dept.department_id;

-- Query 3: Get all appointments scheduled for a specific doctor
SELECT a.*, p.*
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.doctor_id = 1; -- Specify doctor_id here

-- Query 4: Retrieve prescription details for a particular patient
SELECT p.*, d.*
FROM Prescriptions p
JOIN Doctors d ON p.doctor_id = d.doctor_id
WHERE p.patient_id = 1; -- Specify patient_id here

-- Query 5: List all medical records for a specific patient
SELECT m.*, d.*
FROM MedicalRecords m
JOIN Doctors d ON m.doctor_id = d.doctor_id
WHERE m.patient_id = 1; -- Specify patient_id here

-- Query 6: Fetch all rooms in a particular department
SELECT r.*
FROM Rooms r
WHERE r.department_id = 1; -- Specify department_id here

-- Query 7: Get details of all staff members in a specific department
SELECT s.*, dept.name AS department_name
FROM Staff s
JOIN Departments dept ON s.department_id = dept.department_id
WHERE s.department_id = 1; -- Specify department_id here

-- Query 8: Retrieve all tests conducted for a specific patient
SELECT tr.*, t.*
FROM TestResults tr
JOIN Tests t ON tr.test_id = t.test_id
WHERE tr.patient_id = 1; -- Specify patient_id here

-- Query 9: List all appointments scheduled for a particular date
SELECT a.*, p.*
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE DATE(a.appointment_date) = '2024-05-20'; -- Specify date here

-- Query 10: Fetch all patients admitted to a particular room
SELECT p.*
FROM Patients p
JOIN MedicalRecords m ON p.patient_id = m.patient_id
WHERE m.room_id = 1; -- Specify room_id here

-- Query 11: Get the total number of appointments for each doctor
SELECT d.*, COUNT(a.appointment_id) AS appointment_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

-- Query 12: Retrieve the latest prescription for each patient
SELECT p.*
FROM Prescriptions p
JOIN (
    SELECT patient_id, MAX(prescription_date) AS latest_date
    FROM Prescriptions
    GROUP BY patient_id
) AS latest ON p.patient_id = latest.patient_id AND p.prescription_date = latest.latest_date;

-- Query 13: List all doctors who have appointments on a specific date
SELECT DISTINCT d.*
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
WHERE DATE(a.appointment_date) = '2024-05-20'; -- Specify date here

-- Query 14: Get the average cost of tests conducted by each doctor
SELECT d.*, AVG(t.cost) AS avg_test_cost
FROM Doctors d
JOIN TestResults tr ON d.doctor_id = tr.doctor_id
JOIN Tests t ON tr.test_id = t.test_id
GROUP BY d.doctor_id;

-- Query 15: Retrieve all appointments along with the corresponding doctor and patient details
SELECT a.*, d.*, p.*
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id;

-- Query 16: List all available rooms in a specific department
SELECT r.*
FROM Rooms r
LEFT JOIN MedicalRecords m ON r.room_id = m.room_id
WHERE m.room_id IS NULL AND r.department_id = 1; -- Specify department_id here

-- Query 17: Fetch the count of appointments scheduled for each day
SELECT DATE(appointment_date) AS appointment_day, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY DATE(appointment_date);

-- Query 18: Retrieve all appointments along with the patient's age at the time of appointment
SELECT a.*, p.*, YEAR(CURRENT_DATE) - YEAR(p.date_of_birth) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(p.date_of_birth, '%m%d')) AS age_at_appointment
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id;

-- Query 19: Get the total number of patients admitted to each room type
SELECT r.type, COUNT(*) AS patient_count
FROM MedicalRecords m
JOIN Rooms r ON m.room_id = r.room_id
GROUP BY r.type;

-- Query 20: Retrieve the top 5 doctors with the highest number of appointments
SELECT d.*, COUNT(a.appointment_id) AS appointment_count
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id
ORDER BY appointment_count DESC
LIMIT 5;

