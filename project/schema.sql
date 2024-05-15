-- Patients table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    emergency_contact VARCHAR(100)
);

-- Doctors table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- Appointments table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status ENUM('Scheduled', 'Canceled', 'Completed'),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Prescriptions table
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_id INT,
    prescription_date DATE,
    medication TEXT,
    dosage VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Medical Records table
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Departments table
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Rooms table
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    room_number VARCHAR(20),
    type ENUM('General', 'ICU', 'Emergency'),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Staff table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(100),
    department_id INT,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Tests table
CREATE TABLE Tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10, 2)
);

-- Test Results table
CREATE TABLE TestResults (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    test_id INT,
    test_date DATE,
    doctor_id INT,
    result TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (test_id) REFERENCES Tests(test_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

