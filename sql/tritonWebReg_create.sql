CREATE TABLE STUDENT(
  SSN INT NOT NULL,
  ID VARCHAR(10) NOT NULL,
  FIRSTNAME VARCHAR(20) NOT NULL,
  MIDDLENAME VARCHAR(20),
  LASTNAME VARCHAR(20) NOT NULL,
  RESIDENCY VARCHAR(20) NOT NULL,
  STATUS VARCHAR(20) NOT NULL,
  ENROLL VARCHAR(5) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE TABLE PREV_DEGREE(
  STUDENT_ID VARCHAR(10) NOT NULL,
  YEAR_ INT NOT NULL,
  TITLE VARCHAR(40) NOT NULL,
  UNIVERSITY VARCHAR(40),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
  CONSTRAINT PAST_DEGREE_ID PRIMARY KEY (STUDENT_ID,YEAR_,TITLE, UNIVERSITY)
);

CREATE TABLE PROBATION(
  STUDENT_ID VARCHAR(10) NOT NULL,
  START_QUARTER VARCHAR(20),
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(20),
  END_YEAR INT,
  REASON VARCHAR(140) NOT NULL,
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
  CONSTRAINT PB_ID PRIMARY KEY (STUDENT_ID,START_QUARTER,START_YEAR)
);

CREATE TABLE ATTENDANCE(
  STUDENT_ID VARCHAR(10) NOT NULL,
  START_QUARTER VARCHAR(20),
  START_YEAR INT NOT NULL,
  END_QUARTER VARCHAR(20),
  END_YEAR INT,
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
  CONSTRAINT ATTEND_ID PRIMARY KEY (STUDENT_ID,START_QUARTER,START_YEAR)
);

CREATE TABLE UNDERGRAD(
  UNDERGRAD_ID VARCHAR(10) NOT NULL,
  COLLEGE_NAME VARCHAR(50),
  MAJOR VARCHAR(10),
  MINOR VARCHAR(10),
  FIVEYEAR VARCHAR(5),
  PRIMARY KEY (UNDERGRAD_ID),
  FOREIGN KEY (UNDERGRAD_ID) REFERENCES STUDENT(ID)
);


CREATE TABLE DEPARTMENT(
  DEPT_NAME VARCHAR(40) NOT NULL,
  MIN_GPA DECIMAL(4,3),
  MAJOR_UNITS_UD INT NOT NULL,
  MAJOR_UNITS_LD INT NOT NULL,
  MINOR_UNITS_UD INT NOT NULL,
  MINOR_UNITS_LD INT NOT NULL,
  PRIMARY KEY(DEPT_NAME)
);

CREATE TABLE COURSE(
  COURSE_NUM INT NOT NULL,
  TITLE VARCHAR(50) NOT NULL,
  UNITS VARCHAR(15) NOT NULL,
  GRADE_TYPE VARCHAR(20) NOT NULL,
  LEVEL VARCHAR(10) NOT NULL,
  LAB_WORK VARCHAR(5) NOT NULL,
  PRIMARY KEY(COURSE_NUM)
);


CREATE TABLE GRADUATE(
  GRAD_ID VARCHAR(10) NOT NULL,
  STATUS VARCHAR(20) NOT NULL,
  DEPT_NAME VARCHAR(40),
  CONCENTRATION VARCHAR(25),
  PRIMARY KEY (GRAD_ID),
  FOREIGN KEY (GRAD_ID) REFERENCES STUDENT(ID),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME)
);

CREATE TABLE PHD (
  GRAD_ID VARCHAR(10) NOT NULL,
  PHD_CANDIDATE INT,
  PRIMARY KEY (GRAD_ID),
  FOREIGN KEY (GRAD_ID) REFERENCES GRADUATE (GRAD_ID)
);


CREATE TABLE FACULTY(
  FACULTY_NAME VARCHAR(20) NOT NULL,
  TITLE VARCHAR(50),
  PRIMARY KEY(FACULTY_NAME)
);

CREATE TABLE CLASS(
  COURSE_NUM INT NOT NULL,
  QUARTER VARCHAR(20),
  YEAR_ INT NOT NULL,
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE (COURSE_NUM),
  CONSTRAINT CLASS_ID PRIMARY KEY(COURSE_NUM, QUARTER, YEAR_)
);

CREATE TABLE SECTION(
  SECTION_ID INT NOT NULL,
  CLASS_SIZE INT NOT NULL,
  COURSE_NUM INT NOT NULL,
  FACULTY_NAME VARCHAR(20) NOT NULL,
  QUARTER VARCHAR(20),
  YEAR_ INT NOT NULL,
  PRIMARY KEY (SECTION_ID),
  FOREIGN KEY (COURSE_NUM, QUARTER, YEAR_) REFERENCES CLASS(COURSE_NUM, QUARTER, YEAR_),
  FOREIGN KEY (FACULTY_NAME) REFERENCES FACULTY(FACULTY_NAME)
);


CREATE TABLE WORKS_FOR(
  FACULTY_NAME VARCHAR(20) NOT NULL,
  DEPT_NAME VARCHAR(40) NOT NULL,
  FOREIGN KEY (FACULTY_NAME) REFERENCES FACULTY(FACULTY_NAME),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  CONSTRAINT WORKS_FOR_ID PRIMARY KEY(FACULTY_NAME, DEPT_NAME)
);

CREATE TABLE CATEGORIES(
  DEPT_NAME VARCHAR(40) NOT NULL,
  COURSE_NUM INT NOT NULL,
  NAME VARCHAR(30) NOT NULL,
  MIN_UNITS INT,
  MIN_GPA DECIMAL(4,3),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM),
  CONSTRAINT CAT_ID PRIMARY KEY(DEPT_NAME, COURSE_NUM, NAME)
);

CREATE TABLE CONCENTRATION(
  DEPT_NAME VARCHAR(40) NOT NULL,
  COURSE_NUM INT NOT NULL,
  NAME VARCHAR(30) NOT NULL,
  MIN_UNITS INT,
  MIN_GPA DECIMAL(4,3),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM),
  CONSTRAINT CONC_ID PRIMARY KEY(DEPT_NAME, COURSE_NUM, NAME)
);


CREATE TABLE PREREQUISITE(
  PREREQ_NUM INT NOT NULL,
  COURSE_NUM INT NOT NULL,
  INSTRUCTOR_CONSENT VARCHAR(5) NOT NULL,
  FOREIGN KEY (PREREQ_NUM) REFERENCES COURSE(COURSE_NUM),
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM),
  CONSTRAINT PREREQ_ID PRIMARY KEY (PREREQ_NUM, COURSE_NUM)
);

CREATE TABLE COURSE_UNITS(
  COURSE_NUM INT NOT NULL,
  UNITS INT NOT NULL,
  CONSTRAINT C_ID PRIMARY KEY (COURSE_NUM, UNITS),
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM)
);


CREATE TABLE TAKES(
  STUDENT_ID VARCHAR(10) NOT NULL,
  SECTION_ID INT NOT NULL,
  GRADE VARCHAR(5),
  UNITS INT NOT NULL,
  STATUS VARCHAR(20) NOT NULL,
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
  FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
  CONSTRAINT TAKES_ID PRIMARY KEY (STUDENT_ID, SECTION_ID)
);

/**
CREATE TABLE ALREADY_TAKEN(
    STUDENT_ID INT NOT NULL,
    SECTION_ID INT NOT NULL,
    GRADE VARCHAR(5),
    UNITS INT NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
    FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
    CONSTRAINT TAKEN_ID PRIMARY KEY (STUDENT_ID, SECTION_ID)
);

CREATE TABLE WAITLISTED_FOR(
    STUDENT_ID INT NOT NULL,
    SECTION_ID INT NOT NULL,
    GRADE VARCHAR(5),
    UNITS INT NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(ID),
    FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
    CONSTRAINT WAITLISTED_ID PRIMARY KEY (STUDENT_ID, SECTION_ID)
);
 **/

CREATE TABLE MEETING(
  SECTION_ID INT NOT NULL,
  BUILDING VARCHAR(15) NOT NULL,
  ROOM VARCHAR(10) NOT NULL,
  TIME VARCHAR(20) NOT NULL,
  DAY_ VARCHAR(15) NOT NULL,
  MANDATORY VARCHAR(5),
  TYPE VARCHAR(20),
  FOREIGN KEY (SECTION_ID) REFERENCES SECTION(SECTION_ID),
  CONSTRAINT MEETING_ID PRIMARY KEY (SECTION_ID,BUILDING,ROOM,TIME,DAY_)
);

CREATE TABLE ONE_TIME(
  SECTION_ID INT NOT NULL,
  COURSE_NUM INT NOT NULL,
  TYPE VARCHAR(40),
  BUILDING INT NOT NULL,
  ROOM VARCHAR(20) NOT NULL,
  TIME VARCHAR(50) NOT NULL,
  DAY_ VARCHAR(20) NOT NULL,
  CONSTRAINT OT_ID PRIMARY KEY (SECTION_ID, BUILDING, ROOM, TIME, DAY_),
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM)
);

CREATE TABLE MAJOR_IN(
  UNDERGRAD_ID VARCHAR(10) NOT NULL,
  DEPT_NAME VARCHAR(40) NOT NULL,
  FOREIGN KEY (UNDERGRAD_ID) REFERENCES UNDERGRAD(UNDERGRAD_ID),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  CONSTRAINT MIN_ID PRIMARY KEY (UNDERGRAD_ID, DEPT_NAME)
);

CREATE TABLE MINOR_IN(
  UNDERGRAD_ID VARCHAR(10) NOT NULL,
  DEPT_NAME VARCHAR(40) NOT NULL,
  FOREIGN KEY (UNDERGRAD_ID) REFERENCES UNDERGRAD(UNDERGRAD_ID),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  CONSTRAINT MAJ_ID PRIMARY KEY (UNDERGRAD_ID, DEPT_NAME)
);

CREATE TABLE BELONGS_TO(
  GRAD_ID VARCHAR(10) NOT NULL,
  DEPT_NAME VARCHAR(40) NOT NULL,
  FOREIGN KEY (GRAD_ID) REFERENCES GRADUATE(GRAD_ID),
  FOREIGN KEY (DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME),
  PRIMARY KEY (GRAD_ID)
);

CREATE TABLE THESIS_COMMITTEE(
  GRAD_ID VARCHAR(10) NOT NULL,
  FACULTY_NAME VARCHAR(20) NOT NULL,
  FOREIGN KEY (GRAD_ID) REFERENCES GRADUATE(GRAD_ID),
  FOREIGN KEY (FACULTY_NAME) REFERENCES FACULTY(FACULTY_NAME),
  CONSTRAINT TC_ID PRIMARY KEY (GRAD_ID, FACULTY_NAME)
);

CREATE TABLE ADVISOR(
  GRAD_ID VARCHAR(10) NOT NULL,
  FACULTY_NAME VARCHAR(20) NOT NULL,
  FOREIGN KEY (GRAD_ID) REFERENCES PHD(GRAD_ID),
  FOREIGN KEY (FACULTY_NAME) REFERENCES FACULTY(FACULTY_NAME),
  CONSTRAINT ADVISOR_ID PRIMARY KEY (GRAD_ID, FACULTY_NAME)
);

CREATE TABLE OFFERED_BY(
  COURSE_NUM INT NOT NULL,
  DEPT_NAME VARCHAR(40) NOT NULL,
  FOREIGN KEY (COURSE_NUM) REFERENCES COURSE(COURSE_NUM),
  FOREIGN KEY (DEPT_NAME ) REFERENCES DEPARTMENT(DEPT_NAME ),
  CONSTRAINT OFFER_ID PRIMARY KEY (COURSE_NUM , DEPT_NAME)
);