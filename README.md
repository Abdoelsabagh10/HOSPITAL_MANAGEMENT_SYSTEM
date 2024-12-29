# Hospital Management System

## Overview
This project is a comprehensive **Hospital Management System** designed to streamline the management of hospital data, including departments, doctors, patients, nurses, appointments, and shifts. The system is built using modern web development technologies and follows best practices for secure and efficient data handling.

## Features
- **CRUD Operations**: Create, Read, Update, and Delete functionality for:
  - Departments
  - Doctors
  - Patients
  - Nurses
  - Appointments
  - Shifts
- **Database Management**: Secure and optimized interactions with the database using **Stored Procedures**.
- **User-Friendly Interface**: Intuitive design using HTML/CSS for easy navigation and interaction.

## Technologies Used
- **Flask**: A lightweight and powerful web framework for Python.
- **SQL Server**: A robust relational database management system for data storage and querying.
- **Stored Procedures**: Precompiled SQL statements for secure and efficient database operations.
- **HTML/CSS**: For building a clean and responsive user interface.

## Installation and Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Abdoelsabagh10/HOSPITAL_MANAGEMENT_SYSTEM.git
   cd HOSPITAL_MANAGEMENT_SYSTEM
   ```

2. **Set Up a Virtual Environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install Dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure the Database:**
   - Set up an SQL Server database.
   - Run the provided SQL scripts (`H.sql` and `SQL_PROCEDURES.sql`) to create the necessary tables and stored procedures.

5. **Set Environment Variables:**
   Create a `.env` file in the root directory and add the following:
   ```env
   FLASK_APP=app.py
   FLASK_ENV=development
   DATABASE_URI=mssql+pymssql://username:password@server/database_name
   ```

6. **Run the Application:**
   ```bash
   flask run
   ```
   The application will be available at `http://127.0.0.1:5000/`.

## Project Structure
```
|-- app.py             # Main application file
|-- static/            # Static files (CSS, images, etc.)
|-- templates/         # HTML templates
|-- models/            # Database models
|-- routes/            # Application routes and logic
|-- migrations/        # Database migration files
|-- requirements.txt   # Python dependencies
|-- README.md          # Project documentation
```



## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with detailed information about the changes.

## License
This project is licensed under the [MIT License](LICENSE).

---

Feel free to reach out if you have any questions or suggestions!
