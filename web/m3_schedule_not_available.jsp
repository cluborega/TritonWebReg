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

                    //Drop temporary tables if they exists
                    try {
                        stmt.executeUpdate("IF OBJECT_ID('#tempClassEnrolled', 'U') IS NOT NULL DROP TABLE #tempClassEnrolled;");
                        stmt.executeUpdate("IF OBJECT_ID('#tempUnenrolled', 'U') IS NOT NULL DROP TABLE #tempUnenrolled;");
                        stmt.executeUpdate("IF OBJECT_ID('#tempOverlapping', 'U') IS NOT NULL DROP TABLE #tempOverlapping;");

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

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
                        // getting all the enrolled meetings of SP 2017
                        stmt.executeUpdate("SELECT co.COURSENUMBER AS courseEnrolled, cl.CLASS_TITLE AS classEnrolled, s.SECTION_NUM AS secEnrolled, m.start_time AS enrolledStartTime,\n" +
                                "m.end_time AS enrolledEndTime INTO #tempClassEnrolled\n" +
                                "FROM COURSE co\n" +
                                "JOIN COURSE_WITHCLASS cwc ON co.id = cwc.COURSE_ID\n" +
                                "JOIN CLASS cl ON cwc.CLASS_ID = cl.id\n" +
                                "JOIN SECTION s ON cl.id = s.CLASS_ID\n" +
                                "JOIN SECTIONENROLLMENT se ON s.id = se.SECTION_ID\n" +
                                "JOIN STUDENT stu ON se.STUDENT_ID = stu.STUDENT_ID\n" +
                                "JOIN MEETINGS m ON s.id = m.section_id\n" +
                                "AND cl.QUARTER = 'SP' AND cl.CLASS_YEAR = '2017'\n" +
                                "WHERE stu.SSN ="+ student_ssn);

                        //finally executing query to get all the conflicting courses and their times
                        rs = statement.executeQuery("SELECT M.section_id, COR.COURSENUMBER AS COURSENUMBER, CL.CLASS_TITLE as CLASS_TITLE FROM #tempClassEnrolled TC\n" +
                                "JOIN MEETINGS M ON TC.enrolledStartTime = M.start_time AND\n" +
                                "    TC.enrolledEndTime = M.end_time AND\n" +
                                "    TC.secEnrolled <> M.section_id\n" +
                                "JOIN SECTIONENROLLMENT SE ON SE.SECTION_ID = M.section_id\n" +
                                "JOIN SECTION SC ON SE.SECTION_ID = SC.id\n" +
                                "JOIN CLASS CL ON CL.id = SC.CLASS_ID\n" +
                                "JOIN COURSE_WITHCLASS CWC ON CWC.CLASS_ID = CL.id\n" +
                                "JOIN COURSE COR ON CWC.COURSE_ID = COR.id\n" +
                                "GROUP BY M.section_id, CL.CLASS_TITLE, COR.COURSENUMBER");

                    //Drop temporary tables if they exists
                    try {
                        stmt.executeUpdate("IF OBJECT_ID('#tempClassEnrolled', 'U') IS NOT NULL DROP TABLE #tempClassEnrolled;");
                        stmt.executeUpdate("IF OBJECT_ID('#tempUnenrolled', 'U') IS NOT NULL DROP TABLE #tempUnenrolled;");
                        stmt.executeUpdate("IF OBJECT_ID('#tempOverlapping', 'U') IS NOT NULL DROP TABLE #tempOverlapping;");
                        stmt.close();

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
            %>
            <table border="1">
                <tr>
                    <th>Conflicting_Course</th>
                    <th>Conflicting_Class</th>
                </tr>
                <%
                    while(rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("COURSENUMBER")%></td>
                    <td><%=rs.getString("CLASS_TITLE")%></td>
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
