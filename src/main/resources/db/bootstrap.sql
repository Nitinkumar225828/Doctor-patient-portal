CREATE TABLE IF NOT EXISTS user_details (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS specialist (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  specialist_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS doctor (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fullName VARCHAR(100) NOT NULL,
  dateOfBirth VARCHAR(30) NOT NULL,
  qualification VARCHAR(100) NOT NULL,
  specialist VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS appointment (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL,
  fullName VARCHAR(100) NOT NULL,
  gender VARCHAR(20) NOT NULL,
  age VARCHAR(10) NOT NULL,
  appointmentDate VARCHAR(30) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  diseases VARCHAR(255) NOT NULL,
  doctorId INT NOT NULL,
  address VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL
);

INSERT INTO specialist (specialist_name)
SELECT 'Cardiologist'
WHERE NOT EXISTS (SELECT 1 FROM specialist WHERE specialist_name = 'Cardiologist');

INSERT INTO specialist (specialist_name)
SELECT 'Dermatologist'
WHERE NOT EXISTS (SELECT 1 FROM specialist WHERE specialist_name = 'Dermatologist');

INSERT INTO specialist (specialist_name)
SELECT 'Neurologist'
WHERE NOT EXISTS (SELECT 1 FROM specialist WHERE specialist_name = 'Neurologist');

INSERT INTO specialist (specialist_name)
SELECT 'Orthopedic'
WHERE NOT EXISTS (SELECT 1 FROM specialist WHERE specialist_name = 'Orthopedic');

INSERT INTO specialist (specialist_name)
SELECT 'Pediatrician'
WHERE NOT EXISTS (SELECT 1 FROM specialist WHERE specialist_name = 'Pediatrician');

INSERT INTO doctor (id, fullName, dateOfBirth, qualification, specialist, email, phone, password)
SELECT 1, 'Dr. Ayesha Khan', '1988-04-12', 'MBBS, MD', 'Cardiologist', 'ayesha@hospital.com', '9876543210', 'doctor123'
WHERE NOT EXISTS (SELECT 1 FROM doctor WHERE email = 'ayesha@hospital.com');

INSERT INTO doctor (id, fullName, dateOfBirth, qualification, specialist, email, phone, password)
SELECT 2, 'Dr. Rahul Sharma', '1985-09-01', 'MBBS, MS', 'Orthopedic', 'rahul@hospital.com', '9876501234', 'doctor123'
WHERE NOT EXISTS (SELECT 1 FROM doctor WHERE email = 'rahul@hospital.com');

INSERT INTO user_details (id, full_name, email, password)
SELECT 1, 'Demo Patient', 'patient@example.com', 'patient123'
WHERE NOT EXISTS (SELECT 1 FROM user_details WHERE email = 'patient@example.com');

INSERT INTO appointment (id, userId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address, status)
SELECT 1, 1, 'Demo Patient', 'Male', '28', '2026-03-30', 'patient@example.com', '9999999999', 'Fever', 1, 'Kolkata', 'Pending'
WHERE NOT EXISTS (SELECT 1 FROM appointment WHERE id = 1);
