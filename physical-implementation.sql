-- FINAL DATABASE PROJECT PHYSICAL IMPLEMENTATION

-- Creating the Database
CREATE DATABASE IF NOT EXISTS ElectronicMedicalRecords;

-- Use the Database
USE ElectronicMedicalRecords;

-- Creating the Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    BirthDate DATE,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100)
);

-- Creating the Medications Table
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY,
    PatientID INT,
    DrugName VARCHAR(100),
    Dosage VARCHAR(50),
    AdminInstructions TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Creating the Lab Results Table
CREATE TABLE LabResults (
    ResultID INT PRIMARY KEY,
    PatientID INT,
    Test VARCHAR(100),
    TestValue VARCHAR(50),
    TestDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Creating an Index on Medications Table
CREATE INDEX MedNameDoseAdminIndex ON Medications(DrugName, Dosage, AdminInstructions);

-- Creating an Index on LabResults Table
CREATE INDEX TestNameValueDateIndex ON LabResults(Test, TestValue, TestDate);

-- Inserting Sample Data into Patients Table
INSERT INTO Patients (Name, Birthdate, Address, PhoneNumber, Email)
VALUES
    ('John Doe', '1980-04-15', '231 Main St', '999-123-687', 'john_doe@outlook.com'),
    ('Jane Smith', '1985-09-20', '546 Oak St', '555-567-908', 'jane.mith@gmail.com'),
    ('Mary Poppins', '1974-08-26', '17 Cherry Tree Ln', '414-312-8298', 'mpoppins@yahoo.com');

-- Inserting Sample Data into Medications Table
INSERT INTO Medications (MedicationID, PatientID, DrugName, Dosage, AdminInstructions)
VALUES
    (101, 1, 'Aspirin', '100mg', 'Once daily'),
    (201, 3, 'Ibuprofen', '200mg', 'Twice daily'),
    (301, 2, 'Antibiotic', '500mg', 'With meals');

-- Inserting Sample Data into Lab Results Table
INSERT INTO LabResults (ResultID, PatientID, Test, TestValue, TestDate)
VALUES
    (110, 1, 'Blood Pressure', '120/80', '2023-01-10'),
    (220, 1, 'Cholesterol', '200', '2023-07-15'),
    (330, 3, 'Blood Sugar', '110', '2023-11-20'),
    (331, 2, 'Streptococcal Screen', 'Positve', '2023-10-15');

-- Creating a Database User
CREATE USER 'EMRUser'@'localhost' IDENTIFIED BY 'EMR_Password87';

-- Grant Permissions to the User
GRANT SELECT, INSERT, UPDATE, DELETE ON ElectronicMedicalRecords.* TO 'EMRUser'@'localhost';
