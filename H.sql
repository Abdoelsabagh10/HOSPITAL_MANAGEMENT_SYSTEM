create database Hospital_1
go

use Hospital_1
go


CREATE TABLE Department (
    id INT PRIMARY KEY ,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE shift (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing ID
    staff_name VARCHAR(255) NOT NULL,         -- Name of the shift
    start_time TIME NOT NULL,          -- Start time of the shift
    end_time TIME NOT NULL             -- End time of the shift
);



CREATE TABLE doctor (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing ID
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    department_id INT,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    manager_id INT NOT NULL,
    shift_id INT,  -- Shift reference (can be NULL if not assigned)
    FOREIGN KEY (department_id) REFERENCES Department(id),
    FOREIGN KEY (shift_id) REFERENCES shift(id),
    FOREIGN KEY (manager_id) REFERENCES doctor(id)  -- Self-referencing foreign key
);

CREATE TABLE Doctors_Management (
    doctor_id INT,
    manager_id INT,
    PRIMARY KEY (doctor_id, manager_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(id),
    FOREIGN KEY (manager_id) REFERENCES doctor(id)
);

CREATE TABLE nurse (
    id INT IDENTITY(1,1) PRIMARY KEY,  
    name VARCHAR(255) NOT NULL,         
    department_id INT,                  
    phone_number VARCHAR(20) NOT NULL,  
    shift_id INT,                       
    supervisor_id INT,                  -- Supervisor reference (doctor)
    FOREIGN KEY (department_id) REFERENCES Department(id),   -- Foreign key to Department
    FOREIGN KEY (shift_id) REFERENCES shift(id),             -- Foreign key to Shifts
    FOREIGN KEY (supervisor_id) REFERENCES doctor(id)        -- Foreign key to Doctors (supervisor)
);

CREATE TABLE patient (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing ID
    name VARCHAR(255) NOT NULL,         -- Patient's name
    age INT NOT NULL,                   -- Patient's age
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('Male', 'Female')),  -- Gender with CHECK constraint
    phone_number VARCHAR(20) NOT NULL,  -- Patient's phone number
    address VARCHAR(255) NOT NULL,      -- Patient's address
    medical_history TEXT,               -- Medical history (optional)
    doctor_id INT NOT NULL,             -- Doctor assigned to the patient
    nurse_id INT NOT NULL,              -- Nurse assigned to the patient
    FOREIGN KEY (doctor_id) REFERENCES doctor(id),  -- Foreign key to Doctors table
    FOREIGN KEY (nurse_id) REFERENCES nurse(id)     -- Foreign key to Nurses table
);

CREATE TABLE appointment (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    doctor_id INT NOT NULL,
	patient_id INT NOT NULL,
	appointment_date DATETIME NOT NULL,
	
    diagnosis TEXT,
    co TEXT,
	FOREIGN KEY (patient_id ) REFERENCES patient(id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(id)
);

-- Insert data into Department table

INSERT INTO Department (id, name) VALUES
    (1, 'Cardiology'),
    (2, 'Neurology'),
    (3, 'Pediatrics'),
    (4, 'Orthopedics');
	(5, 'Oncology'),
    (6, 'Radiology'),
    (7, 'Orthopedics'),
    (8, 'Gynecology'),
    (9, 'Dermatology'),
    (10, 'Urology');

-- Insert data into Shifts table
INSERT INTO shift ( staff_name, start_time, end_time) VALUES
    ( 'Morning', '08:00:00', '14:00:00'),
    ( 'Afternoon', '14:00:00', '20:00:00'),
    ( 'Night', '20:00:00', '08:00:00');
ALTER TABLE shift
ADD role VARCHAR(20);

-- Insert data into Doctors table

INSERT INTO doctor ( name, specialization, department_id, phone_number, email, salary, manager_id, shift_id)
VALUES
    ( 'Dr. Alice Smith', 'Cardiologist', 2, '555-123-0001', 'alice.smith@hospital.com', 150000.00, 1, 1),
    ( 'Dr. John Doe', 'Neurologist', 3, '555-123-0002', 'john.doe@hospital.com', 145000.00, 1, 2),
    ( 'Dr. Emma Brown', 'Pediatrician', 4, '555-123-0003', 'emma.brown@hospital.com', 140000.00, 1, 1),
    ( 'Dr. Michael Wilson', 'Oncologist', 5, '555-123-0004', 'michael.wilson@hospital.com', 155000.00, 2, 2),
    ( 'Dr. Olivia Taylor', 'Radiologist', 6, '555-123-0005', 'olivia.taylor@hospital.com', 148000.00, 2, 1),
    ( 'Dr. Liam Anderson', 'Orthopedic Surgeon', 7, '555-123-0006', 'liam.anderson@hospital.com', 160000.00, 2, 3),
    ( 'Dr. Sophia Martinez', 'Gynecologist', 8, '555-123-0007', 'sophia.martinez@hospital.com', 142000.00, 3, 2),
    ( 'Dr. William Moore', 'Dermatologist', 9, '555-123-0008', 'william.moore@hospital.com', 138000.00, 3, 3),
    ( 'Dr. Mia Davis', 'Urologist', 10, '555-123-0009', 'mia.davis@hospital.com', 135000.00, 3, 1),
    ( 'Dr. Ethan White', 'Emergency Physician', 1, '555-123-0010', 'ethan.white@hospital.com', 158000.00, 1, 2),
    ( 'Dr. Ava Johnson', 'Cardiologist', 2, '555-123-0011', 'ava.johnson@hospital.com', 150000.00, 1, 3),
    ( 'Dr. James Lee', 'Neurologist', 3, '555-123-0012', 'james.lee@hospital.com', 145000.00, 4, 2),
    ( 'Dr. Isabella Hall', 'Pediatrician', 4, '555-123-0013', 'isabella.hall@hospital.com', 140000.00, 5, 1),
    ( 'Dr. Lucas King', 'Oncologist', 5, '555-123-0014', 'lucas.king@hospital.com', 155000.00, 6, 2),
     ('Dr. Amelia Wright', 'Radiologist', 6, '555-123-0015', 'amelia.wright@hospital.com', 148000.00, 7, 1),
    ( 'Dr. Mason Scott', 'Orthopedic Surgeon', 7, '555-123-0016', 'mason.scott@hospital.com', 160000.00, 8, 3),
    ( 'Dr. Charlotte Allen', 'Gynecologist', 8, '555-123-0017', 'charlotte.allen@hospital.com', 142000.00, 9, 2),
    ( 'Dr. Elijah Young', 'Dermatologist', 9, '555-123-0018', 'elijah.young@hospital.com', 138000.00, 10, 3),
    ( 'Dr. Harper Hernandez', 'Urologist', 10, '555-123-0019', 'harper.hernandez@hospital.com', 135000.00, 11, 1),
    ( 'Dr. Benjamin Lopez', 'Emergency Physician', 1, '555-123-0020', 'benjamin.lopez@hospital.com', 158000.00, 12, 2),
    ( 'Dr. Evelyn Evans', 'Cardiologist', 2, '555-123-0021', 'evelyn.evans@hospital.com', 150000.00, 13, 3),
    ( 'Dr. Henry Adams', 'Neurologist', 3, '555-123-0022', 'henry.adams@hospital.com', 145000.00, 14, 2),
    ( 'Dr. Lily Clark', 'Pediatrician', 4, '555-123-0023', 'lily.clark@hospital.com', 140000.00, 15, 1),
    ( 'Dr. Sebastian Baker', 'Oncologist', 5, '555-123-0024', 'sebastian.baker@hospital.com', 155000.00, 16, 2),
    ( 'Dr. Zoey Turner', 'Radiologist', 6, '555-123-0025', 'zoey.turner@hospital.com', 148000.00, 17, 1),
    ( 'Dr. David Gonzalez', 'Orthopedic Surgeon', 7, '555-123-0026', 'david.gonzalez@hospital.com', 160000.00, 18, 3),
    ( 'Dr. Penelope Carter', 'Gynecologist', 8, '555-123-0027', 'penelope.carter@hospital.com', 142000.00, 19, 2),
    ( 'Dr. Wyatt Green', 'Dermatologist', 9, '555-123-0028', 'wyatt.green@hospital.com', 138000.00, 20, 3),
    ( 'Dr. Layla Nelson', 'Urologist', 10, '555-123-0029', 'layla.nelson@hospital.com', 135000.00, 21, 1),
    ('Dr. Jack Walker', 'Emergency Physician', 1, '555-123-0030', 'jack.walker@hospital.com', 158000.00, 22, 2);

-- Insert data into Doctors_Management table

 INSERT INTO Doctors_Management (doctor_id, manager_id)
VALUES
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 2),
    (6, 2),
    (7, 2),
    (8, 3),
    (9, 3),
    (10, 4),
    (11, 4);
-- Insert data into Nurses table
INSERT INTO nurse (name, department_id, phone_number, shift_id, supervisor_id)
VALUES
    ('Nurse Olivia Smith', 2, '555-200-0001', 1, 1),
    ('Nurse Liam Johnson', 3, '555-200-0002', 2, 2),
    ('Nurse Emma Williams', 4, '555-200-0003', 3, 3),
    ('Nurse Noah Brown', 5, '555-200-0004', 1, 4),
    ('Nurse Ava Jones', 6, '555-200-0005', 2, 5),
    ('Nurse William Garcia', 7, '555-200-0006', 3, 6),
    ('Nurse Sophia Miller', 8, '555-200-0007', 1, 7),
    ('Nurse James Davis', 9, '555-200-0008', 2, 8),
    ('Nurse Mia Rodriguez', 10, '555-200-0009', 3, 9),
    ('Nurse Benjamin Martinez', 1, '555-200-0010', 1, 10),
    ('Nurse Charlotte Lopez', 2, '555-200-0011', 2, 11),
    ('Nurse Elijah Gonzalez', 3, '555-200-0012', 3, 2),
    ('Nurse Amelia Wilson', 4, '555-200-0013', 1, 3),
    ('Nurse Lucas Anderson', 5, '555-200-0014', 2, 4),
    ('Nurse Harper Thomas', 6, '555-200-0015', 3, 5),
    ('Nurse Evelyn White', 7, '555-200-0016', 1, 6),
    ('Nurse Henry Harris', 8, '555-200-0017', 2, 7),
    ('Nurse Scarlett Clark', 9, '555-200-0018', 3, 8),
    ('Nurse Daniel Lewis', 10, '555-200-0019', 1, 9),
    ('Nurse Madison Walker', 1, '555-200-0020', 2, 10),
    ('Nurse Jackson Hall', 2, '555-200-0021', 3, 1),
    ('Nurse Aria Allen', 3, '555-200-0022', 1, 2),
    ('Nurse Lucas Young', 4, '555-200-0023', 2, 3),
    ('Nurse Grace King', 5, '555-200-0024', 3, 4),
    ('Nurse David Wright', 6, '555-200-0025', 1, 5),
    ('Nurse Victoria Green', 7, '555-200-0026', 2, 6),
    ('Nurse Jack Adams', 8, '555-200-0027', 3, 7),
    ('Nurse Zoey Nelson', 9, '555-200-0028', 1, 8),
    ('Nurse Ryan Baker', 10, '555-200-0029', 2, 9),
    ('Nurse Lily Perez', 1, '555-200-0030', 3, 10),
    ('Nurse Nathan Scott', 2, '555-200-0031', 1, 1),
    ('Nurse Hannah Collins', 3, '555-200-0032', 2, 2),
    ('Nurse Leo Murphy', 4, '555-200-0033', 3, 3),
    ('Nurse Abigail Rivera', 5, '555-200-0034', 1, 4),
    ('Nurse Carter Reed', 6, '555-200-0035', 2, 5),
    ('Nurse Ellie Torres', 7, '555-200-0036', 3, 6),
    ('Nurse Wyatt Brooks', 8, '555-200-0037', 1, 7),
    ('Nurse Penelope Sanders', 9, '555-200-0038', 2, 8),
    ('Nurse Owen Price', 10, '555-200-0039', 3, 9),
    ('Nurse Layla Foster', 1, '555-200-0040', 1, 10),
    ('Nurse Chloe Hughes', 2, '555-200-0041', 2, 1),
    ('Nurse Lucas Rivera', 3, '555-200-0042', 3, 2),
    ('Nurse Isabella Butler', 4, '555-200-0043', 1, 3),
    ('Nurse Mason Ramirez', 5, '555-200-0044', 2, 4),
    ('Nurse Zoe Cooper', 6, '555-200-0045', 3, 5),
    ('Nurse Elijah Cox', 7, '555-200-0046', 1, 6),
    ('Nurse Mila Ward', 8, '555-200-0047', 2, 7),
    ('Nurse Jack Mitchell', 9, '555-200-0048', 3, 8),
    ('Nurse Aria Carter', 10, '555-200-0049', 1, 9),
    ('Nurse Henry Bennett', 1, '555-200-0050', 2, 10);


-- Insert data into Patients table

INSERT INTO patient (name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id) 
VALUES
    ('John Smith', 45, 'Male', '555-300-0001', '123 Main St, New York, NY', 'Diabetes', 1, 1),
    ('Emily Johnson', 30, 'Female', '555-300-0002', '456 Elm St, Los Angeles, CA', 'Asthma', 2, 2),
    ('Michael Brown', 52, 'Male', '555-300-0003', '789 Oak St, Chicago, IL', 'Hypertension', 3, 3),
    ('Sarah Davis', 28, 'Female', '555-300-0004', '321 Pine St, Houston, TX', 'No significant history', 4, 4),
    ('David Miller', 60, 'Male', '555-300-0005', '654 Maple St, Phoenix, AZ', 'Heart Disease', 5, 5),
    ('Sophia Wilson', 35, 'Female', '555-300-0006', '987 Cedar St, Philadelphia, PA', 'Allergies', 6, 6),
    ('James Martinez', 40, 'Male', '555-300-0007', '111 Birch St, San Antonio, TX', 'Migraine', 7, 7),
    ('Olivia Garcia', 25, 'Female', '555-300-0008', '222 Ash St, San Diego, CA', 'No significant history', 8, 8),
    ('William Lopez', 55, 'Male', '555-300-0009', '333 Spruce St, Dallas, TX', 'Cholesterol', 9, 9),
    ('Ava Gonzalez', 23, 'Female', '555-300-0010', '444 Palm St, San Jose, CA', 'No significant history', 10, 10),
    ('Benjamin Clark', 65, 'Male', '555-300-0011', '555 Redwood St, Austin, TX', 'Arthritis', 11, 11),
    ('Mia Lewis', 27, 'Female', '555-300-0012', '666 Willow St, Jacksonville, FL', 'Anemia', 12, 12),
    ('Lucas Walker', 38, 'Male', '555-300-0013', '777 Fir St, Columbus, OH', 'Hypertension', 13, 13),
    ('Charlotte Allen', 33, 'Female', '555-300-0014', '888 Pineapple St, Indianapolis, IN', 'Pregnancy', 14, 14),
    ('Henry Young', 48, 'Male', '555-300-0015', '999 Mango St, Fort Worth, TX', 'Obesity', 15, 15),
    ('Amelia King', 29, 'Female', '555-300-0016', '1000 Banana St, Charlotte, NC', 'No significant history', 16, 16),
    ('Daniel Hernandez', 53, 'Male', '555-300-0017', '1100 Peach St, Detroit, MI', 'Kidney Disease', 17, 17),
    ('Ella Scott', 31, 'Female', '555-300-0018', '1200 Plum St, El Paso, TX', 'Migraines', 18, 18),
    ('Jack Green', 41, 'Male', '555-300-0019', '1300 Grape St, Memphis, TN', 'No significant history', 19, 19),
    ('Grace Baker', 26, 'Female', '555-300-0020', '1400 Cherry St, Boston, MA', 'Anxiety', 20, 20),
    ('Matthew Rivera', 47, 'Male', '555-300-0021', '1500 Apple St, Seattle, WA', 'Hypertension', 1, 1),
    ('Chloe Mitchell', 34, 'Female', '555-300-0022', '1600 Lime St, Nashville, TN', 'Asthma', 2, 2),
    ('Alexander Perez', 56, 'Male', '555-300-0023', '1700 Coconut St, Denver, CO', 'Diabetes', 3, 3),
    ('Harper Edwards', 32, 'Female', '555-300-0024', '1800 Avocado St, Baltimore, MD', 'No significant history', 4, 4),
    ('Ethan Morris', 39, 'Male', '555-300-0025', '1900 Lemon St, Louisville, KY', 'Back Pain', 5, 5),
    ('Scarlett Rogers', 24, 'Female', '555-300-0026', '2000 Orange St, Portland, OR', 'No significant history', 6, 6),
    ('Andrew Reed', 50, 'Male', '555-300-0027', '2100 Kiwi St, Oklahoma City, OK', 'Heart Disease', 7, 7),
    ('Lily Cooper', 28, 'Female', '555-300-0028', '2200 Papaya St, Milwaukee, WI', 'Allergies', 8, 8),
    ('Nathan Bell', 44, 'Male', '555-300-0029', '2300 Watermelon St, Albuquerque, NM', 'Hypertension', 9, 9),
    ('Hannah Ramirez', 36, 'Female', '555-300-0030', '2400 Blueberry St, Tucson, AZ', 'Migraines', 10, 10),
    ('Liam Sanders', 37, 'Male', '555-300-0031', '2500 Plum St, Atlanta, GA', 'Diabetes', 11, 11),
    ('Emma Morgan', 29, 'Female', '555-300-0032', '2600 Cherry St, Miami, FL', 'No significant history', 12, 12),
    ('Mason Ward', 42, 'Male', '555-300-0033', '2700 Peach St, Raleigh, NC', 'Hypertension', 13, 13),
    ('Sophia Hughes', 25, 'Female', '555-300-0034', '2800 Lime St, Orlando, FL', 'Allergies', 14, 14),
    ('Logan Bryant', 51, 'Male', '555-300-0035', '2900 Lemon St, Richmond, VA', 'Heart Disease', 15, 15),
    ('Mia Cruz', 30, 'Female', '555-300-0036', '3000 Apple St, New Orleans, LA', 'Asthma', 16, 16),
    ('Lucas Rivera', 39, 'Male', '555-300-0037', '3100 Grape St, Minneapolis, MN', 'Back Pain', 17, 17),
    ('Ava Ramirez', 26, 'Female', '555-300-0038', '3200 Orange St, Tulsa, OK', 'No significant history', 18, 18);

-- Insert data into Appointments table

INSERT INTO appointment (doctor_id, patient_id, appointment_date, Diagnosis, Co)
    VALUES
    (6, 1, '2024-12-21 09:00:00', 'Hypertension Checkup', 'None'),
    (7, 2, '2024-12-21 09:30:00', 'Asthma Management', 'None'),
    (8, 3, '2024-12-21 10:00:00', 'Heart Disease Consultation', 'No complications'),
    (9, 4, '2024-12-21 10:30:00', 'Routine Checkup', 'None'),
    (10, 5, '2024-12-21 11:00:00', 'Heart Disease Follow-Up', 'Blood Pressure Medication'),
    (11, 6, '2024-12-21 11:30:00', 'Allergy Treatment', 'None'),
    (12, 7, '2024-12-21 12:00:00', 'Migraine Follow-Up', 'Some headache episodes'),
    (13, 8, '2024-12-21 12:30:00', 'Pregnancy Care', 'No complications'),
    (14, 9, '2024-12-21 13:00:00', 'Cholesterol Check', 'Medication adjusted'),
    (15, 10, '2024-12-21 13:30:00', 'Anxiety Therapy', 'No major issues reported'),
    (16, 11, '2024-12-21 14:00:00', 'Arthritis Management', 'Medication prescribed'),
    (17, 12, '2024-12-21 14:30:00', 'Anemia Checkup', 'Iron supplements recommended'),
    (18, 13, '2024-12-21 15:00:00', 'Back Pain Evaluation', 'Physical therapy prescribed'),
    (19, 14, '2024-12-21 15:30:00', 'Pregnancy Ultrasound', 'No complications'),
    (20, 15, '2024-12-21 16:00:00', 'Obesity Counseling', 'Diet and exercise plan'),
    (21, 16, '2024-12-21 16:30:00', 'Asthma Control', 'Inhaler prescribed'),
    (22, 17, '2024-12-21 17:00:00', 'Kidney Disease Management', 'Diuretics prescribed'),
    (23, 18, '2024-12-21 17:30:00', 'Migraine Follow-Up', 'No new symptoms'),
    (24, 19, '2024-12-21 18:00:00', 'Cholesterol Checkup', 'Dietary changes suggested'),
    (25, 20, '2024-12-21 18:30:00', 'Mental Health Therapy', 'No major concerns'),
    (26, 21, '2024-12-22 09:00:00', 'Hypertension Monitoring', 'Blood pressure stable'),
    (27, 22, '2024-12-22 09:30:00', 'Allergy Test', 'Mild allergic reaction'),
    (28, 23, '2024-12-22 10:00:00', 'Heart Disease Review', 'Medication adjusted'),
    (29, 24, '2024-12-22 10:30:00', 'Routine Health Check', 'No issues found'),
    (30, 25, '2024-12-22 11:00:00', 'Heart Disease Follow-Up', 'Cholesterol control'),
    (7, 26, '2024-12-22 11:30:00', 'Asthma Follow-Up', 'Inhaler adjusted'),
    (8, 27, '2024-12-22 12:00:00', 'Back Pain Consultation', 'No major changes'),
    (6, 28, '2024-12-22 12:30:00', 'Mental Health Review', 'No major concerns'),
    (3, 29, '2024-12-22 13:00:00', 'Cholesterol and Heart Health', 'Medication adjusted'),
    (12, 30, '2024-12-22 13:30:00', 'Anxiety Management', 'Therapy sessions continued'),
    (6, 1, '2024-12-22 14:00:00', 'Diabetes Management', 'Sugar levels controlled'),
    (7, 2, '2024-12-22 14:30:00', 'Asthma Control', 'Medication increased'),
    (8, 3, '2024-12-22 15:00:00', 'Routine Health Check', 'No major issues'),
    (9, 4, '2024-12-22 15:30:00', 'Pregnancy Checkup', 'No complications'),
    (10, 5, '2024-12-22 16:00:00', 'Hypertension Review', 'BP slightly elevated'),
    (11, 6, '2024-12-22 16:30:00', 'Asthma Follow-Up', 'Breathing exercises suggested'),
    (12, 7, '2024-12-22 17:00:00', 'Heart Disease Care', 'Stress test recommended'),
    (13, 8, '2024-12-22 17:30:00', 'Routine Checkup', 'No concerns'),
    (14, 9, '2024-12-22 18:00:00', 'Cholesterol Follow-Up', 'Dietary changes implemented'),
    (15, 10, '2024-12-22 18:30:00', 'Mental Health Evaluation', 'Continued therapy recommended');




--test
select * from Department
select * from doctor
select * from patient
select * from nurse
select * from appointment
select * from shift