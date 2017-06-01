<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 6/1/2017
  Time: 6:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Courses Unavailable to enroll</title>
</head>
<body>

<table border = '1'>
    <tr>
        <td valign="top">
            <jsp:include page="menu.html"></jsp:include>
        </td>
        <td valign = 'top'>
            <h3>Select a student to view Unavailable courses </h3>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.net.URLEncoder" %>

            <%-- Open connection with DB --%>
                <%
                    String student_ssn = request.getParameter("student_ssn");
                    Connection conn = null;
                    try {
                        DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                        conn = DriverManager.getConnection
                                ("jdbc:sqlserver://localhost:1433;databaseName=CSE132B",
                                        "sa", "Firewall1");
                    } catch (SQLException e){
                        e.printStackTrace();
                    }
                %>

                <%
                    if(conn == null){
                        System.out.println("Connection with db not eastablished.");
                    }
                    Statement statement = null;
                    if (conn != null) {
                        try {
                            statement = conn.createStatement();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    Statement stmt = conn.createStatement();

                    stmt.executeUpdate("IF OBJECT_ID('#tempClassEnrolled', 'U') IS NOT NULL DROP TABLE #tempClassEnrolled;");

                    ResultSet rs = null;
                    if (student_ssn==null) {
                        rs = statement.executeQuery("SELECT DISTINCT st.SSN AS student_ssn, st.STUDENT_ID AS st_num, FIRSTNAME, MIDDLENAME, LASTNAME\n" +
                                " FROM Student st\n" +
                                " JOIN SECTIONENROLLMENT se ON st.STUDENT_ID = se.STUDENT_ID\n" +
                                " JOIN SECTION s ON se.SECTION_ID = s.id\n" +
                                " JOIN CLASS c ON s.CLASS_ID = c.id\n" +
                                " WHERE c.quarter = 'SP'\n" +
                                " AND c.class_year = '2017'\n" +
                                " ORDER BY st.STUDENT_ID ASC;");
                %>

            <form action="m3_schedule_not_available.jsp" method="POST">
                <select name="student_ssn" required>
                    <option selected disabled>Select Student</option>
                    <%
                        while (rs.next()) {
                            String studentDetails = rs.getString("student_ssn") + " - " + rs.getString("FIRSTNAME") + " " +
                                    rs.getString("MIDDLENAME") + " " + rs.getString("LASTNAME");
                    %>
                    <option value="<%=rs.getString("student_ssn")%>"><%=studentDetails%></option>
                    <%
                        }
                    %>
                </select>
                <input type="submit" value="Submit">
            </form>

            <%
                }
                else {

                        stmt.executeUpdate("create table #tempClassEnrolled  -- create temporry table to insert required data\n" +
                                "(\n" +
                                " stu_ssn int not null,\n" +
                                " class_id int not null,\n" +
                                " course_id int not null,\n" +
                                "  section_num int not null,\n" +
                                "  lec_day VARCHAR(10) not null,\n" +
                                "  lec_time VARCHAR(10) not null,\n" +
                                "  di_day VARCHAR(10),\n" +
                                "  di_time VARCHAR(10)\n" +
                                ") -- temp table helps compare the conflicting time with that of current classes\n" +
                                "INSERT INTO #tempClassEnrolled (stu_ssn, class_id, course_id, section_num, lec_day, lec_time, di_day, di_time)\n" +
                                "SELECT N.ssn AS ssn, C.id class_id, CU.id course_id, S.SECTION_NUM, S.LECT_DAYS, S.LECT_START_TIME, S.DI_DAYS, S.DI_STARTTIME\n" +
                                "FROM CLASS C, SECTION S, COURSE_WITHCLASS CWC, COURSE CU, SECTIONENROLLMENT E, STUDENT N\n" +
                                "WHERE N.SSN=16 AND N.STUDENT_ID = E.STUDENT_ID AND E.SECTION_ID = S.SECTION_NUM\n" +
                                "      AND S.CLASS_ID = C.id AND C.id = CWC.CLASS_ID AND CU.id = CWC.COURSE_ID;");

                        rs = statement.executeQuery("SELECT C.CLASS_TITLE, CU.COURSENUMBER, S.SECTION_NUM, S.LECT_DAYS, S.LECT_START_TIME FROM CLASS C, COURSE_WITHCLASS CWC, COURSE CU, SECTION S, #tempClassEnrolled #tce\n" +
                                "WHERE C.id = S.CLASS_ID AND S.CLASS_ID = CWC.CLASS_ID AND CWC.COURSE_ID = CU.id AND\n" +
                                "      (#tce.lec_day = S.LECT_DAYS OR #tce.di_day = S.DI_DAYS OR #tce.lec_day = S.DI_DAYS OR #tce.di_day = S.LECT_DAYS) AND\n" +
                                "      (#tce.lec_time = S.LECT_START_TIME OR #tce.di_time = S.DI_STARTTIME OR #tce.lec_time = S.DI_STARTTIME OR #tce.di_time = S.LECT_START_TIME)\n" +
                                "GROUP BY S.SECTION_NUM,C.CLASS_TITLE,CU.COURSENUMBER, S.LECT_DAYS, S.LECT_START_TIME;");

                        stmt.close();
            %>
            <table border="1">
                <tr>
                    <%--<th>Enrolled_Course</th>--%>
                    <%--<th>Enrolled_Class</th>--%>
                    <%--<th>Enrolled_SectionNum</th>--%>
                    <th>Conflicting_Course</th>
                    <th>Conflicting_Class</th>
                    <th>Conflicting_Section</th>
                </tr>
                <%
                    while(rs.next()) {
                %>
                <tr>
                    <%--<td><input type="text" name="enrolled_course" value="<%=rs.getString("enrolled_course")%>" readonly></td>--%>
                    <%--<td><input type="text" name="enrolled_class" value="<%=rs.getString("enrolled_class")%>" readonly></td>--%>
                    <%--<td><input type="text" name="enrolled_section" value="<%=rs.getString("enrolled_section")%>" readonly></td>--%>
                    <td><input type="text" name="conflicting_course" value="<%=rs.getString("COURSENUMBER")%>" readonly></td>
                    <td><input type="text" name="conflicting_class" value="<%=rs.getString("CLASS_TITLE")%>" readonly></td>
                    <td><input type="text" name="conflicting_section" value="<%=rs.getString("SECTION_NUM")%>" readonly></td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>
        </td>
    </tr>
</table>

</body>
</html>
