CREATE TABLE STUDENT(
  STUDENT_ID VARCHAR(40),
  SSN INT NOT NULL UNIQUE,
  FIRSTNAME VARCHAR(40) NOT NULL,
  MIDDLENAME VARCHAR(40),
  LASTNAME VARCHAR(40) NOT NULL,
  RESIDENCY VARCHAR(40) NOT NULL,
  STAT VARCHAR(40) NOT NULL,
  PRIMARY KEY (STUDENT_ID)
);

CREATE TABLE DEPARTMENT (
  DEPT_NAME VARCHAR(40),
  REQUIRED_UNITS INTEGER NOT NULL,
  PRIMARY KEY (DEPT_NAME)
);
CREATE TABLE FACULTY(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  FACULTY VARCHAR(40),
  TITLE VARCHAR(40) NOT NULL,
  DEPARTMENT VARCHAR(40) NOT NULL,
  PRIMARY KEY (FACULTY),
  FOREIGN KEY (DEPARTMENT) REFERENCES DEPARTMENT (DEPT_NAME)
);

CREATE TABLE COURSE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  DEPARTMENT VARCHAR(40),
  COURSENUMBER VARCHAR(40),
  MINUNITS INTEGER NOT NULL,-- CHECK (MINUNITS > 0),
  MAXUNITS INTEGER NOT NULL,-- CHECK (MAXUNITS >= MINUNITS),
  COURSETYPE VARCHAR(2),
  GRADE_OPTION VARCHAR(40) NOT NULL,
  REQUIRESLAB BIT,
  REQUIRESCONSENT BIT,
  PRIMARY KEY (DEPARTMENT, COURSENUMBER),
  FOREIGN KEY (DEPARTMENT) REFERENCES DEPARTMENT (DEPT_NAME)
);

CREATE TABLE CLASS(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  CLASS_TITLE VARCHAR(40),
  QUARTER VARCHAR(40),
  CLASS_YEAR CHAR(4),
  PRIMARY KEY (CLASS_TITLE, QUARTER, CLASS_YEAR)
);


CREATE TABLE COURSE_WITHCLASS(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  COURSE_ID INTEGER,
  CLASS_ID INTEGER,
  PRIMARY KEY (COURSE_ID, CLASS_ID),
  FOREIGN KEY (COURSE_ID) REFERENCES COURSE (id),
  FOREIGN KEY (CLASS_ID) REFERENCES CLASS (id)
);


CREATE TABLE SECTION(
  id INT UNIQUE NOT NULL IDENTITY (1,1),
  SECTION_NUM VARCHAR(40),
  CLASS_ID INTEGER,
  LECT_DAYS VARCHAR (10),
  LECT_START_TIME DATETIME2,
  DI_DAYS VARCHAR(10),
  DI_STARTTIME DATETIME2,
  SECTION_MAX INTEGER, --MAX NUMBER OF PEOPLE
  PRIMARY KEY (SECTION_NUM, CLASS_ID),
  FOREIGN KEY (CLASS_ID) REFERENCES CLASS (id)
);

CREATE TABLE DEGREE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  DEGREE_TYPE VARCHAR(40),
  DEGREE_NAME VARCHAR(40),
  REQ_UNITS_TOTAL INTEGER,
  REQ_UNITS_LD INTEGER,
  REQ_UNITS_UP INTEGER,
  REQ_UNITS_TE INTEGER,
  REQ_UNITS_GRAD INTEGER,
  PRIMARY KEY (DEGREE_TYPE, DEGREE_NAME)
);

CREATE TABLE REVIEWSESSION(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  CLASS_ID INT NOT NULL,
  SECTION_NUM VARCHAR(40),
  LOCATION VARCHAR(40) NOT NULL,
  REVIEW_DATE DATE NOT NULL,
  START_TIME VARCHAR(10) NOT NULL,
  END_TIME VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (SECTION_NUM,CLASS_ID) REFERENCES SECTION (SECTION_NUM,CLASS_ID)
);

CREATE TABLE MEETINGS(
  id INT UNIQUE IDENTITY (1,1),
  section_id INTEGER,
  meeting_type VARCHAR(10),
  start_time DATETIME2,
  end_time DATETIME2,
  location VARCHAR(10) NOT NULL,
  required BIT NOT NULL,
  PRIMARY KEY (section_id, meeting_type, start_time, end_time),
  FOREIGN KEY (section_id) REFERENCES Section (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE QUARTER(
  id INTEGER IDENTITY (1,1) PRIMARY KEY,
  QUARTER VARCHAR(40) NOT NULL,
  YEAR CHAR(4) NOT NULL
);

CREATE TABLE ATTENDANCE(
  id INT UNIQUE,
  STUDENT_ID VARCHAR(40),
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  PRIMARY KEY (STUDENT_ID),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID)
);

CREATE TABLE PROBATION(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  STUDENT_ID VARCHAR(40),
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  REASON VARCHAR(300) NOT NULL,
  PRIMARY KEY (STUDENT_ID),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID)
);

CREATE TABLE PREVIOUSDEGREE(
  id INT UNIQUE,
  STUDENT_ID VARCHAR(40),
  TYPE VARCHAR(40),
  MAJOR VARCHAR(40),
  SCHOOL_NAME VARCHAR(40),
  PRIMARY KEY (STUDENT_ID, TYPE, MAJOR, SCHOOL_NAME),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID)
);


CREATE TABLE UNDERGRADUATE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  UNDERGRADUATE_ID VARCHAR(40),
  COLLEGE VARCHAR(40) NOT NULL,
  MAJOR VARCHAR(40) NOT NULL,
  MINOR VARCHAR(40),
  PRIMARY KEY (UNDERGRADUATE_ID),
  FOREIGN KEY (UNDERGRADUATE_ID) REFERENCES STUDENT (STUDENT_ID)
);

CREATE TABLE MSUNDERGRADUATE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  MSUNDERGRADUATE_ID VARCHAR(40),
  DEPARTMENT VARCHAR(40) NOT NULL,
  PRIMARY KEY (MSUNDERGRADUATE_ID),
  FOREIGN KEY (MSUNDERGRADUATE_ID) REFERENCES UNDERGRADUATE (UNDERGRADUATE_ID),
  FOREIGN KEY (DEPARTMENT) REFERENCES DEPARTMENT (DEPT_NAME)
);

CREATE TABLE GRADUATE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  GRADUATE_ID VARCHAR(40),
  GRADUATE_TYPE VARCHAR(40) NOT NULL,
  MAJOR VARCHAR(40) NOT NULL,
  DEPARTMENT VARCHAR(40) NOT NULL,
  PRIMARY KEY (GRADUATE_ID),
  FOREIGN KEY (GRADUATE_ID) REFERENCES STUDENT (STUDENT_ID),
  FOREIGN KEY (DEPARTMENT) REFERENCES DEPARTMENT (DEPT_NAME)
);

CREATE TABLE MASTERSTUDENT(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  MASTERSTUDENT_ID VARCHAR(40),
  ADVISOR VARCHAR(40),
  PRIMARY KEY (MASTERSTUDENT_ID),
  FOREIGN KEY (MASTERSTUDENT_ID) REFERENCES GRADUATE (GRADUATE_ID),
  FOREIGN KEY (ADVISOR) REFERENCES FACULTY (FACULTY)
);

CREATE TABLE PHDSTUDENT(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  PHDSTUDENT_ID VARCHAR(40),
  CANDIDATE_TYPE VARCHAR(40) NOT NULL,
  PRIMARY KEY (PHDSTUDENT_ID),
  FOREIGN KEY (PHDSTUDENT_ID) REFERENCES GRADUATE (GRADUATE_ID)
);

CREATE TABLE PRECANDIDATE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  PRECANDIDATE_ID VARCHAR(40),
  ADVISOR VARCHAR(40),
  PRIMARY KEY (PRECANDIDATE_ID),
  FOREIGN KEY (PRECANDIDATE_ID) REFERENCES PHDSTUDENT (PHDSTUDENT_ID),
  FOREIGN KEY (ADVISOR) REFERENCES FACULTY (FACULTY)
);

CREATE TABLE CANDIDATE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  CANDIDATE_ID VARCHAR(40),
  ADVISOR VARCHAR(40) NOT NULL,
  PRIMARY KEY (CANDIDATE_ID),
  FOREIGN KEY (CANDIDATE_ID) REFERENCES PHDSTUDENT (PHDSTUDENT_ID),
  FOREIGN KEY (ADVISOR) REFERENCES FACULTY (FACULTY)
);

CREATE TABLE THESISCOMMITTEE(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  GRADUATE_ID VARCHAR(40),
  FACULTY VARCHAR(40),
  PRIMARY KEY (GRADUATE_ID, FACULTY),
  FOREIGN KEY (GRADUATE_ID) REFERENCES GRADUATE (GRADUATE_ID),
  FOREIGN KEY (FACULTY) REFERENCES FACULTY (FACULTY)
);

CREATE TABLE SECTIONENROLLMENT(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  STUDENT_ID VARCHAR(40),
  SECTION_ID INTEGER,
  UNITS_TAKING INTEGER NOT NULL,
  GRADE_OPTION VARCHAR(40) NOT NULL,
  PRIMARY KEY (STUDENT_ID, SECTION_ID),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID),
  FOREIGN KEY (SECTION_ID) REFERENCES SECTION (id)
);

CREATE TABLE CLASSESTAKEN(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  STUDENT_ID VARCHAR(40),
  CLASS_ID INTEGER,
  GRADE_OPT VARCHAR(10),
  UNITS_TAKEN INTEGER,
  GRADE_RECEIVED VARCHAR(40) NOT NULL,
  PRIMARY KEY (STUDENT_ID, CLASS_ID),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT (STUDENT_ID),
  FOREIGN KEY (CLASS_ID) REFERENCES CLASS (id)
);

CREATE TABLE TEACHINGHISTORY(
   id INT UNIQUE NOT NULL IDENTITY(1,1),
  FACULTY VARCHAR(40),
  CLASS_ID INTEGER,
  PRIMARY KEY (FACULTY, CLASS_ID),
  FOREIGN KEY (FACULTY) REFERENCES FACULTY (FACULTY),
  FOREIGN KEY (CLASS_ID) REFERENCES CLASS (id)
);

CREATE TABLE CURRENTLYTEACHING(
   id INT UNIQUE NOT NULL IDENTITY(1,1),
  SECTION_ID INTEGER,
  FACULTY VARCHAR(40),
  PRIMARY KEY (SECTION_ID,FACULTY),
  FOREIGN KEY (FACULTY) REFERENCES FACULTY (FACULTY),
  FOREIGN KEY (SECTION_ID) REFERENCES SECTION (id)
);

CREATE TABLE PREREQUISITE(
  id INT UNIQUE,
  TARGET_ID INTEGER,
  PREREQUISITE_ID INTEGER,
  PRIMARY KEY (TARGET_ID, PREREQUISITE_ID),
  FOREIGN KEY (TARGET_ID) REFERENCES COURSE (id),
  FOREIGN KEY (PREREQUISITE_ID) REFERENCES COURSE (id),
);

CREATE TABLE COURSECONCERNTRATION(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  COURSE_ID INTEGER,
  DEGREE_ID INTEGER,
  CONCERNTRATION_NAME VARCHAR(40),
  REQ_UNITS INTEGER NOT NULL,
  MINGPA NUMERIC(3, 2),
  PRIMARY KEY (COURSE_ID, DEGREE_ID, CONCERNTRATION_NAME),
  FOREIGN KEY (COURSE_ID) REFERENCES COURSE (id),
  FOREIGN KEY (DEGREE_ID) REFERENCES DEGREE (id)
);

CREATE TABLE COURSECATEGORY(
  id INT UNIQUE NOT NULL IDENTITY(1,1),
  COURSE_ID INTEGER,
  DEGREE_ID INTEGER,
  REQ_UNITS INTEGER,
  CATEGORY_NAME VARCHAR(40),
  PRIMARY KEY (COURSE_ID, DEGREE_ID, CATEGORY_NAME),
  FOREIGN KEY (COURSE_ID) REFERENCES COURSE (id),
  FOREIGN KEY (DEGREE_ID) REFERENCES DEGREE (id)
);

CREATE TABLE GRADE_CONVERSION(
 LETTER_GRADE CHAR(2) NOT NULL,
 NUMBER_GRADE DECIMAL(2,1)
);


