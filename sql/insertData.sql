
/*DEPARTNMENT*/

INSERT INTO DEPARTMENT (DEPT_NAME, REQUIRED_UNITS) VALUES ('CSE',60)
INSERT INTO DEPARTMENT (DEPT_NAME, REQUIRED_UNITS) VALUES ('PHIL',40)
INSERT INTO DEPARTMENT (DEPT_NAME, REQUIRED_UNITS) VALUES ('MAE',60)

/*FACULTY*/


INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('JUSTIN BIEBER','ASSOCIATE PROFESSOR','CSE')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('FLO RIDA','PROFESSOR','CSE')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('SELENA GOMEZ','PROFESSOR','MAE')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('ADELE','PROFESSOR','PHIL')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('TAYLOR SWIFT','PROFESSOR','CSE')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('KELLY CLARKSON','PROFESSOR','CSE')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('ADAM LEVINE','PROFESSOR','PHIL')
INSERT INTO FACULTY (FACULTY, TITLE, DEPARTMENT) VALUES ('BJORK','PROFESSOR','MAE')

/*STUDENT*/

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A1',1,'BENJAMIN','','B','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A1','MARSHALL','COMPUTER SCIENCE','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A2','2','KRISTEN','','W','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A2','REVELLE','COMPUTER SCIENCE','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A3','3','DANIEL','','F','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A3','WARREN','COMPUTER SCIENCE','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A4','4','CLAIRE','','J','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A4','WARREN','COMPUTER SCIENCE','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A5','5','JULIE','','C','OUT OF STATE','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A5','SIXTH','COMPUTER SCIENCE','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A6','6','KEVIN','','L','FOREIGN','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A6','SIXTH','MECHANICAL ENGINEERING','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A7','7','MICHAEL','','B','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A7','','MECHANICAL ENGINEERING','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A8','8','JOSEPH','','J','OUT OF STATE','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A8','SIXTH','MECHANICAL ENGINEERING','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A9','9','DEVIN','','P','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A9','MUIR','MECHANICAL ENGINEERING','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A10','10','LOGAN','','F','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A10','MUIR','MECHANICAL ENGINEERING','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A11','11','VIKRAM','','N','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A11','REVELLE','PHILPSOPHY','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A12','12','RACHEL','','Z','OUT OF STATE','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A12','MARSHALL','PHILPSOPHY','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A13','13','ZACH','','M','FOREIGN','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A13','REVELLE','PHILPSOPHY','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A14','14','JUSTIN','','H','CA','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A14','ROOSEVELT','PHILPSOPHY','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('A15','15','RAHUL','','R','OUT OF STATE','UNDERGRAD')
INSERT INTO uNDERGRADUATE(UNDERGRADUATE_ID,COLLEGE,MAJOR,MINOR) VALUES ('A15','ROOSEVELT','PHILPSOPHY','')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M16','16','DAVE','','C','FOREIGN','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M16','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M16','FLO RIDA')

INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M17','17','NELSON','','H','OUT OF STATE','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M17','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M17','TAYLOR SWIFT')


INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M18','18','ANDREW','','P','FOREIGN','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M18','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M18','JUSTIN BIEBER')


INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M19','19','NATHAN','','S','OUT OF STATE','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M19','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M19','FLO RIDA')


INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M20','20','JOHN','','H','CA','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M20','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M20','BJORK')


INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M21','21','ANWELL','','W','FOREIGN','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M21','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M21','BJORK')


INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)VALUES('M22','22','TIM','','K','FOREIGN','MASTERS')
INSERT INTO GRADUATE(GRADUATE_ID, GRADUATE_TYPE,MAJOR,DEPARTMENT)VALUES('M22','MASTERS','COMPUTER SCIENCE','CSE')
INSERT INTO MASTERSTUDENT(MASTERSTUDENT_ID,ADVISOR) VALUES ('M22','FLO RIDA')




/*DEGREE*/


INSERT INTO DEGREE(DEGREE_TYPE, DEGREE_NAME,REQ_UNITS_TOTAL, REQ_UNITS_LD, REQ_UNITS_UP,REQ_UNITS_TE,REQ_UNITS_GRAD)VALUES ('BS','COMPUTER SCIENCE','40','10','15','15','0')
INSERT INTO DEGREE(DEGREE_TYPE, DEGREE_NAME,REQ_UNITS_TOTAL, REQ_UNITS_LD, REQ_UNITS_UP,REQ_UNITS_TE,REQ_UNITS_GRAD)VALUES ('BA','PHILOSOPHY','35','15','20','0','0')
INSERT INTO DEGREE(DEGREE_TYPE, DEGREE_NAME,REQ_UNITS_TOTAL, REQ_UNITS_LD, REQ_UNITS_UP,REQ_UNITS_TE,REQ_UNITS_GRAD)VALUES ('BS','MECHANICAL ENGINEERING','50','20','20','10','0')
INSERT INTO DEGREE(DEGREE_TYPE, DEGREE_NAME,REQ_UNITS_TOTAL, REQ_UNITS_LD, REQ_UNITS_UP,REQ_UNITS_TE,REQ_UNITS_GRAD)VALUES ('MS','COMPUTER SCIENCE','45','0','0','0','45')



/*CLASSES*/
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','FA','2014')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','SP','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','FA','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','WI','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','SP','2018')


INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO THEORY','WI','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO THEORY','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO THEORY','FA','2017')



INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILISTIC REASONING','FA','2014')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILISTIC REASONING','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILISTIC REASONING','FA','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILISTIC REASONING','WI','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILISTIC REASONING','SP','2018')

INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('MACHINE LEARNING','WI','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('MACHINE LEARNING','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('MACHINE LEARNING','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('MACHINE LEARNING','FA','2018')

INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATA MINING AND PREDICTIVE ANALYTICS','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATA MINING AND PREDICTIVE ANALYTICS','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATA MINING AND PREDICTIVE ANALYTICS','WI','2018')


INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATABASES','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATABASES','SP','2018')

INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('OPERATING SYSTEM','SP','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('OPERATING SYSTEM','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('OPERATING SYSTEM','FA','2017')



INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('COMPUTATIONAL METHODS','SP','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('COMPUTATIONAL METHODS','SP','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('COMPUTATIONAL METHODS','SP','2018')

INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','FA','2014')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','WI','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','WI','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','FA','2018')



INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO LOGIC','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO LOGIC','FA','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO LOGIC','WI','2018')

INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('SCIENTIFIC REASONING','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('SCIENTIFIC REASONING','SP','2018')


INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','SP','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','FA','2015')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','SP','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','WI','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','FA','2016')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','SP','2018')


INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRODUCTION TO COMPUTER SCIENCE-JAVA','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('INTRO TO THEORY','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('DATA MINING AND PREDICTIVE ANALYTICS','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('OPERATING SYSTEM','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('PROBABILITY AND STATISTICS','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('SCIENTIFIC REASONING','SP','2017')
INSERT INTO CLASS (CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES ('FREEDOM, EQUALITY AND THE LAW','SP','2017')


/*COURSES*/


INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE8A','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE105','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE123','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE250A','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE250B','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE255','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE232A','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('CSE','CSE221','2','4','LETTER',0,0)



INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('MAE','MAE3','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('MAE','MAE107','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('MAE','MAE108','2','4','LETTER',0,0)

INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('PHIL','PHIL10','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('PHIL','PHIL12','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('PHIL','PHIL165','2','4','LETTER',0,0)
INSERT INTO COURSE(DEPARTMENT,COURSENUMBER,MINUNITS,MAXUNITS,GRADE_OPTION,REQUIRESLAB,REQUIRESCONSENT)VALUES('PHIL','PHIL167','2','4','LETTER',0,0)



/*COURSE AND CLASS LINKER*/
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,1)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,2)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,3)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,4)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,5)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,6)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,7)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(2,8)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(2,9)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(2,10)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(4,11)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(4,12)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(4,13)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(4,14)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(4,15)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(5,16)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(5,17)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(5,18)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(5,19)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(6,20)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(6,21)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(6,22)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(7,23)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(7,24)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(8,25)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(8,26)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(8,27)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(10,28)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(10,29)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(10,30)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,31)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,32)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,33)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,34)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,35)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(12,36)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(12,37)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(12,38)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(13,39)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(13,40)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(13,41)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,42)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,43)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,44)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,45)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,46)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(1,47)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(2,48)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(6,49)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(8,50)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(11,51)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(13,52)
INSERT INTO COURSE_WITHCLASS(COURSE_ID,CLASS_ID)VALUES(14,53)


/*Sections of current quarter	*/



INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('1','51','MWF','10:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('2','50','MWF','10:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('3','49','MWF','12:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('4','52','MWF','12:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('5','50','MWF','12:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('6','48','TUETHU','2:00AM','40','F','6:00PM')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('7','53','TUETHU','3:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('8','51','TUETHU','3:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('9','50','TUETHU','5:00AM','40','','')
INSERT INTO SECTION(SECTION_NUM, CLASS_ID, LECT_DAYS,LECT_START_TIME,SECTION_MAX,DI_DAYS,DI_STARTTIME) VALUES ('10','47','TUETHU','5:00AM','40','W','7:00PM')



/*CURRENT ENROLLMENT*/


INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M16','2','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M17','9','4','S/U')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M18','5','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M19','2','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M20','9','4','LETTER')

INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M21','5','4','S/U')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M22','3','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M16','3','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('M17','3','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A1','10','4','S/U')

INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A5','10','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A3','10','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A7','1','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A8','1','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A9','8','4','LETTER')

INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A4','6','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A12','4','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A13','7','4','S/U')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A13','4','4','LETTER')
INSERT INTO SECTIONENROLLMENT(STUDENT_ID,SECTION_ID,UNITS_TAKING,GRADE_OPTION)VALUES('A15','7','4','LETTER')



/*CLASS TAKEN HISTORY*/

INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A1','1','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A3','1','LETTER','4','B+')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A2','2','LETTER','4','C-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A4','3','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A5','3','LETTER','4','B')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A1','8','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A5','8','LETTER','4','B+')

INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A4','8','LETTER','4','C')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M16','11','LETTER','4','C')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M22','12','LETTER','4','B+')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M18','12','LETTER','4','D')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','12','LETTER','4','F')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M17','16','LETTER','4','A')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','16','LETTER','4','A')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M20','20','LETTER','4','B-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M18','20','LETTER','4','B')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M21','20','LETTER','4','F')

INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M17','23','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M22','25','LETTER','4','A')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M20','25','LETTER','4','A')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A10','28','LETTER','4','B+')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A8','31','LETTER','2','B-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A7','31','LETTER','2','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A6','32','LETTER','2','B')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A10','32','LETTER','2','B+')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A11','36','LETTER','4','A')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A12','36','LETTER','4','A')

INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A13','36','LETTER','4','C-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A14','36','LETTER','4','C+')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A15','41','LETTER','2','F')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A12','41','LETTER','2','D')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('A11','42','LETTER','2','A-')

/*EXTRA
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','12','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','18','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','20','LETTER','4','A-')
INSERT INTO CLASSESTAKEN (STUDENT_ID,CLASS_ID,GRADE_OPT,UNITS_TAKEN,GRADE_RECEIVED) VALUES ('M19','23','LETTER','4','A-')
*/



/*TEACHING CURRENTLY*/ 

INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('1','ADELE')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('3','FLO RIDA')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('8','FLO RIDA')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('10','ADELE')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('6','TAYLOR SWIFT')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('9','JUSTIN BIEBER')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('4','ADAM LEVINE')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('7','TAYLOR SWIFT')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('2','KELLY CLARKSON')
INSERT INTO CURRENTLYTEACHING(SECTION_ID,FACULTY)VALUES('5','KELLY CLARKSON')



INSERT INTO COURSECONCERNTRATION (COURSE_ID,DEGREE_ID,CONCERNTRATION_NAME,REQ_UNITS,MINGPA) VALUES ('7','4','DATABASES','4','3')
INSERT INTO COURSECONCERNTRATION (COURSE_ID,DEGREE_ID,CONCERNTRATION_NAME,REQ_UNITS,MINGPA) VALUES ('4','4','AI','8','3.1')
INSERT INTO COURSECONCERNTRATION (COURSE_ID,DEGREE_ID,CONCERNTRATION_NAME,REQ_UNITS,MINGPA) VALUES ('6','4','AI','8','3.1')
INSERT INTO COURSECONCERNTRATION (COURSE_ID,DEGREE_ID,CONCERNTRATION_NAME,REQ_UNITS,MINGPA) VALUES ('8','4','SYSTEMS','4','3.3')

                                                                                                               
 /* LD - LOWER DIVISION,UD - UPPER DIVISION,GC - GRADUATE COURSE,TE - TECHNICAL ELECTIVE*/
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('1','1','10','LD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('2','1','15','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('3','1','15','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('4','4','45','GC')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('5','4','45','GC')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('6','4','45','GC')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('7','4','45','GC')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('8','4','45','GC')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('9','3','20','LD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('10','3','20','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('11','3','20','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('12','2','15','LD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('13','2','15','LD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('14','2','20','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('15','2','20','UD')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('4','1','15','TE')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('8','1','15','TE')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('2','1','15','TE')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('10','3','10','TE')
INSERT INTO COURSECATEGORY(COURSE_ID,DEGREE_ID,REQ_UNITS,CATEGORY_NAME) VALUES ('9','3','10','TE')

INSERT INTO grade_conversion values('A+', 4.0);
INSERT INTO grade_conversion values('A', 4.0);
INSERT INTO grade_conversion values('A-', 3.7);
INSERT INTO grade_conversion values('B+', 3.3);
INSERT INTO grade_conversion values('B', 3.0);
INSERT INTO grade_conversion values('B-', 2.7);
INSERT INTO grade_conversion values('C+', 2.3);
INSERT INTO grade_conversion values('C', 2.0);
INSERT INTO grade_conversion values('C-', 1.7);
INSERT INTO grade_conversion values('D', 1.0);
INSERT INTO grade_conversion values('F', 0.0);
