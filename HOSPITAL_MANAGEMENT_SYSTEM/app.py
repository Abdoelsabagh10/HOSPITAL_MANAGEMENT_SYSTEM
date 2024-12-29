from flask import Flask, render_template, request, redirect, url_for
import pyodbc
import logging

logging.basicConfig(level=logging.DEBUG)

# Flask app initialization
app = Flask(__name__)

# Database connection setup
conn = pyodbc.connect(
    'Driver={ODBC Driver 18 for SQL Server};'
    'Server=3BDOELSABAGH;'
    'Database=Hospital_1;'
    'Trusted_Connection=yes;'
    'TrustServerCertificate=yes;'
)
cursor = conn.cursor()

# Database functions using stored procedures

#    Department

def add_department(department_id, name):
    query = "{CALL AddDepartment(?, ?)}"
    cursor.execute(query, (department_id, name))
    conn.commit()

def update_department(department_id, name):
    query = "{CALL UpdateDepartment(?, ?)}"
    cursor.execute(query, (department_id, name))
    conn.commit()

def delete_department(department_id):
    query = "{CALL DeleteDepartment(?)}"
    cursor.execute(query, (department_id,))
    conn.commit()

def get_all_departments():
    query = "{CALL GetAllDepartments()}"
    cursor.execute(query)
    return cursor.fetchall()

#   Shift 
def add_shift(staff_name, start_time, end_time, role):
    query = "{CALL AddShift(?, ?, ?, ?)}"
    cursor.execute(query, (staff_name, start_time, end_time, role))
    conn.commit()

def update_shift(shift_id, staff_name, start_time, end_time, role):
    query = "{CALL UpdateShift(?, ?, ?, ?, ?)}"
    cursor.execute(query, (shift_id, staff_name, start_time, end_time, role))
    conn.commit()

def delete_shift(shift_id):
    query = "{CALL DeleteShift(?)}"
    cursor.execute(query, (shift_id,))
    conn.commit()

def get_all_shifts():
    query = "{CALL GetAllShifts()}"
    cursor.execute(query)
    return cursor.fetchall()

# Patient
def add_patient(name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id):
    query = "{CALL AddPatient(?, ?, ?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id))
    conn.commit()

def update_patient(patient_id, name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id):
    query = "{CALL UpdatePatient(?, ?, ?, ?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (patient_id, name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id))
    conn.commit()

def delete_patient(patient_id):
    query = "{CALL DeletePatient(?)}"
    cursor.execute(query, (patient_id,))
    conn.commit()

def get_all_patients():
    query = "{CALL GetAllPatients()}"
    cursor.execute(query)
    return cursor.fetchall()

# Nurse
def add_nurse(name, department_id, phone_number, shift_id, supervisor_id):
    query = "{CALL AddNurse(?, ?, ?, ?, ?)}"
    cursor.execute(query, (name, department_id, phone_number, shift_id, supervisor_id))
    conn.commit()

def update_nurse(nurse_id, name, department_id, phone_number, shift_id, supervisor_id):
    query = "{CALL UpdateNurse(?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (nurse_id, name, department_id, phone_number, shift_id, supervisor_id))
    conn.commit()

def delete_nurse(nurse_id):
    query = "{CALL DeleteNurse(?)}"
    cursor.execute(query, (nurse_id,))
    conn.commit()

def get_all_nurses():
    query = "{CALL GetAllNurses()}"
    cursor.execute(query)
    return cursor.fetchall()

# Appointment

def get_all_appointments_with_names():
    query = "{CALL GetAllAppointmentsWithNames()}"
    cursor.execute(query)
    return cursor.fetchall()

def add_appointment(doctor_id, patient_id, appointment_date, diagnosis, co):
    query = "{CALL AddAppointment(?, ?, ?, ?, ?)}"
    cursor.execute(query, (doctor_id, patient_id, appointment_date, diagnosis, co))
    conn.commit()

def update_appointment(appointment_id, doctor_id, patient_id, appointment_date, diagnosis, co):
    query = "{CALL UpdateAppointment(?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (appointment_id, doctor_id, patient_id, appointment_date, diagnosis, co))
    conn.commit()

def delete_appointment(appointment_id):
    query = "{CALL DeleteAppointment(?)}"
    cursor.execute(query, (appointment_id,))
    conn.commit()

# Doctor
def add_doctor(name, specialization, department_id, phone_number, email, salary, manager_id, shift_id):
    query = "{CALL AddDoctor(?, ?, ?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (name, specialization, department_id, phone_number, email, salary, manager_id, shift_id))
    conn.commit()

def update_doctor(doctor_id, name, specialization, department_id, phone_number, email, salary, manager_id, shift_id):
    query = "{CALL UpdateDoctor(?, ?, ?, ?, ?, ?, ?, ?, ?)}"
    cursor.execute(query, (doctor_id, name, specialization, department_id, phone_number, email, salary, manager_id, shift_id))
    conn.commit()

def delete_doctor(doctor_id):
    query = "{CALL DeleteDoctor(?)}"
    cursor.execute(query, (doctor_id,))
    conn.commit()

def get_all_doctors():
    query = "{CALL GetAllDoctors()}"
    cursor.execute(query)
    return cursor.fetchall()


# Routes
@app.route('/')
def home():
    return render_template('index.html')

@app.route('/departments')
def view_departments():
    departments = get_all_departments()
    return render_template('view_departments.html', departments=departments)

@app.route('/add-department', methods=['GET', 'POST'])
def add_department_route():
    if request.method == 'POST':
        department_id = request.form['id'] 
        name = request.form['name']        
        add_department(department_id, name) 
        return redirect(url_for('view_departments'))
    return render_template('add_department.html')


@app.route('/edit-department/<int:id>', methods=['GET', 'POST'])
def edit_department_route(id):
    if request.method == 'POST':
        name = request.form['name']
        update_department(id, name)
        return redirect(url_for('view_departments'))
    cursor.execute("SELECT * FROM Department WHERE id = ?", (id,))
    department = cursor.fetchone()
    return render_template('edit_department.html', department=department)

@app.route('/delete-department/<int:id>', methods=['GET', 'POST'])
def delete_department_route(id):
    if request.method == 'POST':
        delete_department(id)
        return redirect(url_for('view_departments'))
    
    
    cursor.execute("SELECT * FROM Department WHERE id = ?", (id,))
    department = cursor.fetchone()

    if not department:
        return "Department not found", 404
    
    return render_template('delete_department.html', department=department)

##########################################################################################################
@app.route('/doctors')
def view_doctors():
    doctors = get_all_doctors()
    return render_template('view_doctors.html', doctors=doctors)

@app.route('/add-doctor', methods=['GET', 'POST'])
def add_doctor_route():
    if request.method == 'POST':
        name = request.form['name']
        specialization = request.form['specialization']
        department_id = request.form['department_id']
        phone_number = request.form['phone_number']
        email = request.form['email']
        salary = request.form['salary']
        manager_id = request.form['manager_id']
        shift_id = request.form['shift_id']
        add_doctor(name, specialization, department_id, phone_number, email, salary, manager_id, shift_id)
        return redirect(url_for('view_doctors'))
    cursor.execute("SELECT * FROM Department")
    departments = cursor.fetchall()
    return render_template('add_doctor.html', departments=departments)

@app.route('/edit-doctor/<int:id>', methods=['GET', 'POST'])
def edit_doctor_route(id):
    if request.method == 'POST':
        name = request.form['name']
        specialization = request.form['specialization']
        department_id = request.form['department_id']
        phone_number = request.form['phone_number']
        email = request.form['email']
        salary = request.form['salary']
        manager_id = request.form['manager_id']
        shift_id = request.form['shift_id']
        update_doctor(id, name, specialization, department_id, phone_number, email, salary, manager_id, shift_id)
        return redirect(url_for('view_doctors'))
    cursor.execute("SELECT * FROM Doctor WHERE id = ?", (id,))
    doctor = cursor.fetchone()
    cursor.execute("SELECT * FROM Department")
    departments = cursor.fetchall()
    return render_template('edit_doctor.html', doctor=doctor, departments=departments)


@app.route('/delete-doctor/<int:id>', methods=['GET', 'POST'])
def delete_doctor_route(id):
    if request.method == 'POST':
        delete_doctor(id)
        return redirect(url_for('view_doctors'))
    cursor.execute("SELECT * FROM Doctor WHERE id = ?", (id,))
    doctor = cursor.fetchone()
    return render_template('delete_doctor.html', doctor=doctor)
##########################################################################################################
@app.route('/patients')
def view_patients():
    patients = get_all_patients()
    return render_template('view_patients.html', patients=patients)

@app.route('/add-patient', methods=['GET', 'POST'])
def add_patient_route():
    if request.method == 'POST':
        name = request.form['name']
        age = request.form['age']
        gender = request.form['gender']
        phone_number = request.form['phone_number']
        address = request.form['address']
        medical_history = request.form['medical_history']
        doctor_id = request.form['doctor_id']
        nurse_id = request.form['nurse_id']
        add_patient(name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id)
        return redirect(url_for('view_patients'))
    cursor.execute("SELECT * FROM Doctor")
    doctors = cursor.fetchall()
    cursor.execute("SELECT * FROM Nurse")
    nurses = cursor.fetchall()
    return render_template('add_patient.html', doctors=doctors, nurses=nurses)

@app.route('/edit-patient/<int:id>', methods=['GET', 'POST'])
def edit_patient_route(id):
    if request.method == 'POST':
        name = request.form['name']
        age = request.form['age']
        gender = request.form['gender']
        phone_number = request.form['phone_number']
        address = request.form['address']
        medical_history = request.form['medical_history']
        doctor_id = request.form['doctor_id']
        nurse_id = request.form['nurse_id']
        update_patient(id, name, age, gender, phone_number, address, medical_history, doctor_id, nurse_id)
        return redirect(url_for('view_patients'))
    cursor.execute("SELECT * FROM Patient WHERE id = ?", (id,))
    patient = cursor.fetchone()
    cursor.execute("SELECT * FROM Doctor")
    doctors = cursor.fetchall()
    cursor.execute("SELECT * FROM Nurse")
    nurses = cursor.fetchall()
    return render_template('edit_patient.html', patient=patient, doctors=doctors, nurses=nurses)

@app.route('/delete-patient/<int:id>', methods=['GET', 'POST'])
def delete_patient_route(id):
    if request.method == 'POST':
        delete_patient(id)
        return redirect(url_for('view_patients'))
    cursor.execute("SELECT * FROM Patient WHERE id = ?", (id,))
    patient = cursor.fetchone()
    return render_template('delete_patient.html', patient=patient)
##########################################################################################################
@app.route('/nurses')
def view_nurses():
    nurses = get_all_nurses()
    return render_template('view_nurses.html', nurses=nurses)

@app.route('/add-nurse', methods=['GET', 'POST'])
def add_nurse_route():
    if request.method == 'POST':
        name = request.form['name']
        department_id = request.form['department_id']
        phone_number = request.form['phone_number']
        shift_id = request.form['shift_id']
        supervisor_id = request.form['supervisor_id']
        add_nurse(name, department_id, phone_number, shift_id, supervisor_id)
        return redirect(url_for('view_nurses'))
    cursor.execute("SELECT * FROM Department")
    departments = cursor.fetchall()
    return render_template('add_nurse.html', departments=departments)

@app.route('/edit-nurse/<int:id>', methods=['GET', 'POST'])
def edit_nurse_route(id):
    if request.method == 'POST':
        name = request.form['name']
        department_id = request.form['department_id']
        phone_number = request.form['phone_number']
        shift_id = request.form['shift_id']
        supervisor_id = request.form['supervisor_id']
        update_nurse(id, name, department_id, phone_number, shift_id, supervisor_id)
        return redirect(url_for('view_nurses'))
    cursor.execute("SELECT * FROM Nurse WHERE id = ?", (id,))
    nurse = cursor.fetchone()
    cursor.execute("SELECT * FROM Department")
    departments = cursor.fetchall()
    return render_template('edit_nurse.html', nurse=nurse, departments=departments)

@app.route('/delete-nurse/<int:id>', methods=['GET', 'POST'])
def delete_nurse_route(id):
    if request.method == 'POST':
        delete_nurse(id)
        return redirect(url_for('view_nurses'))
    cursor.execute("SELECT * FROM Nurse WHERE id = ?", (id,))
    nurse = cursor.fetchone()
    return render_template('delete_nurse.html', nurse=nurse)
##########################################################################################################
@app.route('/appointments')
def view_appointments():
    appointments = get_all_appointments_with_names()
    return render_template('view_appointments.html', appointments=appointments)

@app.route('/add-appointment', methods=['GET', 'POST'])
def add_appointment_route():
    if request.method == 'POST':
        doctor_id = request.form['doctor_id']
        patient_id = request.form['patient_id']
        appointment_date = request.form['appointment_date']
        diagnosis = request.form['diagnosis']
        co = request.form['co']
        add_appointment(doctor_id, patient_id, appointment_date, diagnosis, co)
        return redirect(url_for('view_appointments'))
    cursor.execute("SELECT * FROM Doctor")
    doctors = cursor.fetchall()
    cursor.execute("SELECT * FROM Patient")
    patients = cursor.fetchall()
    return render_template('add_appointment.html', doctors=doctors, patients=patients)

@app.route('/edit-appointment/<int:id>', methods=['GET', 'POST'])
def edit_appointment_route(id):
    if request.method == 'POST':
        doctor_id = request.form['doctor_id']
        patient_id = request.form['patient_id']
        appointment_date = request.form['appointment_date']
        diagnosis = request.form['diagnosis']
        co = request.form['co']
        update_appointment(id, doctor_id, patient_id, appointment_date, diagnosis, co)
        return redirect(url_for('view_appointments'))
    cursor.execute("SELECT * FROM Appointment WHERE id = ?", (id,))
    appointment = cursor.fetchone()
    cursor.execute("SELECT * FROM Doctor")
    doctors = cursor.fetchall()
    cursor.execute("SELECT * FROM Patient")
    patients = cursor.fetchall()
    return render_template('edit_appointment.html', appointment=appointment, doctors=doctors, patients=patients)

@app.route('/delete-appointment/<int:id>', methods=['GET', 'POST'])
def delete_appointment_route(id):
    if request.method == 'POST':
        delete_appointment(id)
        return redirect(url_for('view_appointments'))
    cursor.execute("SELECT * FROM Appointment WHERE id = ?", (id,))
    appointment = cursor.fetchone()
    return render_template('delete_appointment.html', appointment=appointment)

##########################################################################################################
@app.route('/shifts')
def view_shifts():
    shifts = get_all_shifts()
    return render_template('view_shifts.html', shifts=shifts)

@app.route('/add-shift', methods=['GET', 'POST'], endpoint='add_shift')
def add_shift_route():
    if request.method == 'POST':
        staff_name = request.form['staff_name']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        role = request.form['role']
        add_shift(staff_name, start_time, end_time, role)
        return redirect(url_for('view_shifts'))
    cursor.execute("SELECT name FROM Doctor UNION SELECT name FROM Nurse")
    staff_members = cursor.fetchall()
    return render_template('add_shift.html', staff_members=staff_members)

@app.route('/edit-shift/<int:id>', methods=['GET', 'POST'])
def edit_shift_route(id):
    if request.method == 'POST':
        staff_name = request.form['staff_name']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        role = request.form['role']
        update_shift(id, staff_name, start_time, end_time, role)
        return redirect(url_for('view_shifts'))
    cursor.execute("SELECT * FROM Shift WHERE id = ?", (id,))
    shift = cursor.fetchone()
    return render_template('edit_shift.html', shift=shift)

@app.route('/delete-shift/<int:id>', methods=['GET', 'POST'])
def delete_shift_route(id):
    if request.method == 'POST':
        delete_shift(id)
        return redirect(url_for('view_shifts'))
    cursor.execute("SELECT * FROM Shift WHERE id = ?", (id,))
    shift = cursor.fetchone()
    return render_template('delete_shift.html', shift=shift)
##########################################################################################################

if __name__ == '__main__':
    app.run(debug=True)
