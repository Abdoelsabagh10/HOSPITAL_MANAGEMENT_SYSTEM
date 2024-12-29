use Hospital_1

-- Department Procedures
CREATE PROCEDURE AddDepartment
    @id INT,
    @name NVARCHAR(50)
AS
BEGIN
    INSERT INTO Department (id, name) VALUES (@id, @name)
END
GO

CREATE PROCEDURE UpdateDepartment
    @id INT,
    @name NVARCHAR(50)
AS
BEGIN
    UPDATE Department SET name = @name WHERE id = @id
END
GO

CREATE PROCEDURE DeleteDepartment
    @id INT
AS
BEGIN
    DELETE FROM Department WHERE id = @id
END
GO

CREATE PROCEDURE GetAllDepartments
AS
BEGIN
    SELECT * FROM Department
END
GO

-- Shift Procedures
CREATE PROCEDURE AddShift
    @staff_name NVARCHAR(50),
    @start_time DATETIME,
    @end_time DATETIME,
    @role NVARCHAR(50)
AS
BEGIN
    INSERT INTO Shift (staff_name, start_time, end_time, role) VALUES (@staff_name, @start_time, @end_time, @role)
END
GO

CREATE PROCEDURE UpdateShift
    @id INT,
    @staff_name NVARCHAR(50),
    @start_time DATETIME,
    @end_time DATETIME,
    @role NVARCHAR(50)
AS
BEGIN
    UPDATE Shift SET staff_name = @staff_name, start_time = @start_time, end_time = @end_time, role = @role WHERE id = @id
END
GO

CREATE PROCEDURE DeleteShift
    @id INT
AS
BEGIN
    DELETE FROM Shift WHERE id = @id
END
GO

CREATE PROCEDURE GetAllShifts
AS
BEGIN
    SELECT * FROM Shift
END
GO

-- Patient Procedures
CREATE PROCEDURE AddPatient
    @name NVARCHAR(50),
    @age INT,
    @gender NVARCHAR(10),
    @phone_number NVARCHAR(15),
    @address NVARCHAR(100),
    @medical_history NVARCHAR(MAX),
    @doctor_id INT,
    @nurse_id INT
AS
BEGIN
    INSERT INTO Patient (name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id) VALUES (@name, @age, @gender, @phone_number, @address, @medical_history, @doctor_id, @nurse_id)
END
GO

CREATE PROCEDURE UpdatePatient
    @id INT,
    @name NVARCHAR(50),
    @age INT,
    @gender NVARCHAR(10),
    @phone_number NVARCHAR(15),
    @address NVARCHAR(100),
    @medical_history NVARCHAR(MAX),
    @doctor_id INT,
    @nurse_id INT
AS
BEGIN
    UPDATE Patient SET name = @name, age = @age, gender = @gender, phone_number = @phone_number, address = @address, medical_history = @medical_history, doctor_id = @doctor_id, nurse_id = @nurse_id WHERE id = @id
END
GO

CREATE PROCEDURE DeletePatient
    @id INT
AS
BEGIN
    DELETE FROM Patient WHERE id = @id
END
GO

CREATE PROCEDURE GetAllPatients
AS
BEGIN
    SELECT * FROM Patient
END
GO

-- Nurse Procedures
CREATE PROCEDURE AddNurse
    @name NVARCHAR(50),
    @department_id INT,
    @phone_number NVARCHAR(15),
    @shift_id INT,
    @supervisor_id INT
AS
BEGIN
    INSERT INTO Nurse (name, department_id, phone_number, shift_id, supervisor_id) VALUES (@name, @department_id, @phone_number, @shift_id, @supervisor_id)
END
GO

CREATE PROCEDURE UpdateNurse
    @id INT,
    @name NVARCHAR(50),
    @department_id INT,
    @phone_number NVARCHAR(15),
    @shift_id INT,
    @supervisor_id INT
AS
BEGIN
    UPDATE Nurse SET name = @name, department_id = @department_id, phone_number = @phone_number, shift_id = @shift_id, supervisor_id = @supervisor_id WHERE id = @id
END
GO

CREATE PROCEDURE DeleteNurse
    @id INT
AS
BEGIN
    DELETE FROM Nurse WHERE id = @id
END
GO

CREATE PROCEDURE GetAllNurses
AS
BEGIN
    SELECT 
        Nurse.id, 
        Nurse.name, 
        Nurse.phone_number, 
        Nurse.shift_id, 
        Nurse.supervisor_id, 
        Department.name AS department_name
    FROM Nurse
    LEFT JOIN Department ON Nurse.department_id = Department.id
END
GO

-- Appointment Procedures
CREATE PROCEDURE GetAllAppointmentsWithNames
AS
BEGIN
    SELECT 
        Appointment.id, 
        Doctor.name AS doctor_name, 
        Patient.name AS patient_name, 
        Appointment.appointment_date, 
        Appointment.diagnosis, 
        Appointment.co
    FROM Appointment
    JOIN Doctor ON Appointment.doctor_id = Doctor.id
    JOIN Patient ON Appointment.patient_id = Patient.id
END
GO

CREATE PROCEDURE AddAppointment
    @doctor_id INT,
    @patient_id INT,
    @appointment_date DATETIME,
    @diagnosis NVARCHAR(MAX),
    @co NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Appointment (doctor_id, patient_id, appointment_date, diagnosis, co) VALUES (@doctor_id, @patient_id, @appointment_date, @diagnosis, @co)
END
GO

CREATE PROCEDURE UpdateAppointment
    @id INT,
    @doctor_id INT,
    @patient_id INT,
    @appointment_date DATETIME,
    @diagnosis NVARCHAR(MAX),
    @co NVARCHAR(MAX)
AS
BEGIN
    UPDATE Appointment SET doctor_id = @doctor_id, patient_id = @patient_id, appointment_date = @appointment_date, diagnosis = @diagnosis, co = @co WHERE id = @id
END
GO

CREATE PROCEDURE DeleteAppointment
    @id INT
AS
BEGIN
    DELETE FROM Appointment WHERE id = @id
END
GO

-- Doctor Procedures
CREATE PROCEDURE AddDoctor
    @name NVARCHAR(50),
    @specialization NVARCHAR(50),
    @department_id INT,
    @phone_number NVARCHAR(15),
    @email NVARCHAR(50),
    @salary DECIMAL(18, 2),
    @manager_id INT,
    @shift_id INT
AS
BEGIN
    INSERT INTO Doctor (name, specialization, department_id, phone_number, email, salary, manager_id, shift_id) VALUES (@name, @specialization, @department_id, @phone_number, @email, @salary, @manager_id, @shift_id)
END
GO

CREATE PROCEDURE UpdateDoctor
    @id INT,
    @name NVARCHAR(50),
    @specialization NVARCHAR(50),
    @department_id INT,
    @phone_number NVARCHAR(15),
    @email NVARCHAR(50),
    @salary DECIMAL(18, 2),
    @manager_id INT,
    @shift_id INT
AS
BEGIN
    UPDATE Doctor SET name = @name, specialization = @specialization, department_id = @department_id, phone_number = @phone_number, email = @email, salary = @salary, manager_id = @manager_id, shift_id = @shift_id WHERE id = @id
END
GO

CREATE PROCEDURE DeleteDoctor
    @id INT
AS
BEGIN
    DELETE FROM Doctor WHERE id = @id
END
GO

CREATE PROCEDURE GetAllDoctors
AS
BEGIN
    SELECT Doctor.id, Doctor.name, Doctor.specialization, Doctor.phone_number,
        Doctor.email, Doctor.salary, Doctor.manager_id, Doctor.shift_id,
        Department.name AS department_name
    FROM Doctor
    LEFT JOIN Department ON Doctor.department_id = Department.id
END
GO


