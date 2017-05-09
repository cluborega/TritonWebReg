CREATE TABLE Student(
  id INT UNIQUE,
  student_num VARCHAR(20),
  ssn VARCHAR(20) NOT NULL UNIQUE,
  first_name VARCHAR(20) NOT NULL,
  middle_name VARCHAR(20),
  last_name VARCHAR(20) NOT NULL,
  residency VARCHAR(20) NOT NULL,
  student_type VARCHAR(20) NOT NULL,
  PRIMARY KEY (student_num)
);

CREATE TABLE Faculty(
  id INT UNIQUE,
  faculty_name VARCHAR(20),
  title VARCHAR(20) NOT NULL,
  department VARCHAR(20) NOT NULL,
  PRIMARY KEY (faculty_name)
);

CREATE TABLE Class(
  id INT UNIQUE,
  class_title VARCHAR(20),
  quarter VARCHAR(20),
  class_year CHAR(4),
  PRIMARY KEY (class_title, quarter, class_year)
);

CREATE TABLE Section(
  id INT UNIQUE,
  section_num VARCHAR(20),
  class_id INTEGER,
  section_limit INTEGER,
  PRIMARY KEY (section_num, class_id),
  FOREIGN KEY (class_id) REFERENCES Class (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Degree(
  id INT UNIQUE,
  degree_type VARCHAR(20),
  degree_name VARCHAR(20),
  required_units INTEGER,
  PRIMARY KEY (degree_type, degree_name)
);

CREATE TABLE AttendancePeriod(
  id INT UNIQUE,
  student_num VARCHAR(20),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (student_num),
  FOREIGN KEY (student_num) REFERENCES Student (student_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ProbationPeriod(
  id INT UNIQUE,
  student_num VARCHAR(20),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  reason VARCHAR(20) NOT NULL,
  PRIMARY KEY (student_num),
  FOREIGN KEY (student_num) REFERENCES Student (student_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PreviousDegree(
  id INT UNIQUE,
  student_num VARCHAR(20),
  type VARCHAR(20),
  major VARCHAR(20),
  school_name VARCHAR(20),
  PRIMARY KEY (student_num, type, major, school_name),
  FOREIGN KEY (student_num) REFERENCES Student (student_num)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE StudentAccount(
  id INT UNIQUE,
  account_num VARCHAR(20),
  balance MONEY NOT NULL,
  PRIMARY KEY (account_num),
  FOREIGN KEY (account_num) REFERENCES Student (student_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AccountStatement(
  id INT UNIQUE,
  account_num VARCHAR(20),
  statement_number INTEGER UNIQUE NOT NULL,
  bill_amount MONEY NOT NULL,
  due_date DATE NOT NULL,
  PRIMARY KEY (account_num, statement_number),
  FOREIGN KEY (account_num) REFERENCES StudentAccount (account_num)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Undergraduate(
  id INT UNIQUE,
  undergraduate_num VARCHAR(20),
  college VARCHAR(20) NOT NULL,
  major VARCHAR(20) NOT NULL,
  minor VARCHAR(20),
  PRIMARY KEY (undergraduate_num),
  FOREIGN KEY (undergraduate_num) REFERENCES Student (student_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MSUndergraduate(
  id INT UNIQUE,
  msundergraduate_num VARCHAR(20),
  department VARCHAR(20) NOT NULL,
  PRIMARY KEY (msundergraduate_num),
  FOREIGN KEY (msundergraduate_num) REFERENCES Undergraduate (undergraduate_num)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Graduate(
  id INT UNIQUE,
  graduate_num VARCHAR(20),
  graduate_type VARCHAR(20) NOT NULL,
  major VARCHAR(20) NOT NULL,
  department VARCHAR(20) NOT NULL,
  PRIMARY KEY (graduate_num),
  FOREIGN KEY (graduate_num) REFERENCES Student (student_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MSStudent(
  id INT UNIQUE,
  msstudent_num VARCHAR(20),
  advisor VARCHAR(20),
  PRIMARY KEY (msstudent_num),
  FOREIGN KEY (msstudent_num) REFERENCES Graduate (graduate_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PhDStudent(
  id INT UNIQUE,
  phdstudent_num VARCHAR(20),
  candidate_type VARCHAR(20) NOT NULL,
  PRIMARY KEY (phdstudent_num),
  FOREIGN KEY (phdstudent_num) REFERENCES Graduate (graduate_num) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Precandidate(
  id INT UNIQUE,
  precandidate_num VARCHAR(20),
  advisor VARCHAR(20),
  PRIMARY KEY (precandidate_num),
  FOREIGN KEY (precandidate_num) REFERENCES PhDStudent (phdstudent_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Candidate(
  id INT UNIQUE,
  candidate_num VARCHAR(20),
  advisor VARCHAR(20) NOT NULL,
  PRIMARY KEY (candidate_num),
  FOREIGN KEY (candidate_num) REFERENCES PhDStudent (phdstudent_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (advisor) REFERENCES Faculty (faculty_name) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ThesisCommittee(
  id INT UNIQUE,
  graduate_num VARCHAR(20),
  faculty_name VARCHAR(20),
  PRIMARY KEY (graduate_num, faculty_name),
  FOREIGN KEY (graduate_num) REFERENCES Graduate (graduate_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SectionEnrollment(
  id INT UNIQUE,
  student_num VARCHAR(20),
  section_id INTEGER,
  units_taking INTEGER NOT NULL,
  grade_option VARCHAR(20) NOT NULL,
  PRIMARY KEY (student_num, section_id),
  FOREIGN KEY (student_num) REFERENCES Student (student_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (section_id) REFERENCES Section (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ClassesTaken(
  id INT UNIQUE,
  student_num VARCHAR(20),
  sectionenrollment_id INTEGER,
  grade_received VARCHAR(20) NOT NULL,
  PRIMARY KEY (student_num, sectionenrollment_id),
  FOREIGN KEY (student_num) REFERENCES Student (student_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (sectionenrollment_id) REFERENCES SectionEnrollment (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TeachingHistory(
  id INT UNIQUE,
  faculty_name VARCHAR(20),
  class_id INTEGER,
  PRIMARY KEY (faculty_name, class_id),
  FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (class_id) REFERENCES Class (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CurrentlyTeaching(
  id INT UNIQUE,
  section_id INTEGER,
  faculty_name VARCHAR(20),
  PRIMARY KEY (section_id),
  FOREIGN KEY (faculty_name) REFERENCES Faculty (faculty_name),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (section_id) REFERENCES Section (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Course(
  id INT UNIQUE,
  department VARCHAR(20),
  course_num VARCHAR(20),
  min_units INTEGER NOT NULL,-- CHECK (min_units > 0),
  max_units INTEGER NOT NULL,-- CHECK (max_units >= min_units),
  grade_option VARCHAR(20) NOT NULL,
  requires_lab BIT,
  requires_consent BIT,
  PRIMARY KEY (department, course_num)
);

CREATE TABLE Prerequisite(
  id INT UNIQUE,
  target_id INTEGER,
  prerequisite_id INTEGER,
  PRIMARY KEY (target_id, prerequisite_id),
  FOREIGN KEY (target_id) REFERENCES Course (id),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (prerequisite_id) REFERENCES Course (id),-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CourseConcentration(
  id INT UNIQUE,
  course_id INTEGER,
  degree_id INTEGER,
  concentration_name VARCHAR(20),
  required_units INTEGER NOT NULL,
  min_gpa NUMERIC(3, 2),
  PRIMARY KEY (course_id, degree_id, concentration_name),
  FOREIGN KEY (course_id) REFERENCES Course (id),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (degree_id) REFERENCES Degree (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CourseCategory(
  id INT UNIQUE,
  course_id INTEGER,
  degree_id INTEGER,
  category_name VARCHAR(20),
  required_units INTEGER NOT NULL,
  min_gpa NUMERIC(3, 2),
  PRIMARY KEY (course_id, degree_id, category_name),
  FOREIGN KEY (course_id) REFERENCES Course (id),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (degree_id) REFERENCES Degree (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ClassInstance(
  id INT UNIQUE,
  course_id INTEGER,
  class_id INTEGER,
  PRIMARY KEY (course_id, class_id),
  FOREIGN KEY (course_id) REFERENCES Course (id),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (class_id) REFERENCES Class (id) --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SectionWaitlist(
  id INT UNIQUE,
  student_num VARCHAR(20),
  section_id INTEGER,
  position INTEGER,
  PRIMARY KEY (student_num, section_id),
  FOREIGN KEY (student_num) REFERENCES Student (student_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (section_id) REFERENCES Section (id)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE NonweeklyMeeting(
  id INT UNIQUE,
  section_id INTEGER,
  meeting_type VARCHAR(20),
  start_datetime DATETIME2,
  end_datetime DATETIME2,
  location VARCHAR(20) NOT NULL,
  required BIT NOT NULL,
  PRIMARY KEY (section_id, meeting_type, start_datetime, end_datetime),
  FOREIGN KEY (section_id) REFERENCES Section (id)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE WeeklyMeeting(
  id INT UNIQUE,
  section_id INTEGER,
  meeting_type VARCHAR(20),
  start_datetime DATETIME2,
  end_datetime DATETIME2,
  location VARCHAR(20) NOT NULL,
  required BIT NOT NULL,
  PRIMARY KEY (section_id, meeting_type, start_datetime, end_datetime),
  FOREIGN KEY (section_id) REFERENCES Section (id)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DegreesEarned(
  id INT UNIQUE,
  student_num VARCHAR(20),
  degree_id INTEGER,
  PRIMARY KEY (student_num, degree_id),
  FOREIGN KEY (student_num) REFERENCES Student (student_num),-- ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (degree_id) REFERENCES Degree (id)-- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Quarter(
  id INT PRIMARY KEY,
  quarter VARCHAR(20) NOT NULL,
  year CHAR(4) NOT NULL
);

CREATE TABLE GRADE_CONVERSION(
  LETTER_GRADE CHAR(2) NOT NULL,
  NUMBER_GRADE DECIMAL(2,1)
);