<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/31/2017
  Time: 9:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grade Distrubition Result</title>
</head>
<body>
<table border = '1'>
    <tr>
        <td valign="top">
            <jsp:include page="menu.html"></jsp:include>
        </td>

<%@ page language="java" import="java.sql.*" %>
        <%@ page import="java.net.URLDecoder" %>
        <%@ page import="java.util.Objects" %>

        <%-- Open connection with DB --%>
<%
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

    int course_id = 0;
    if(request.getParameter("course_id") != null) {
        course_id = Integer.parseInt(request.getParameter("course_id"));
    }


    String faculty_name = URLDecoder.decode(request.getParameter("faculty_name"), "UTF-8");

//                faculty_name = URLDecoder.decode(request.getParameter("faculty_name"), "UTF-8");

            System.out.println(faculty_name);
//            request.getParameter("faculty_name");

    int quarter_id = 0;
    if(request.getParameter("quarter_id") != null) {
        quarter_id = Integer.parseInt(request.getParameter("quarter_id"));
    }

    ResultSet rs = null;
%>
    <td>
                    <%
                        if (request.getParameter("course_id") != null && !Objects.equals(request.getParameter("faculty_name"), "default") &&
                                request.getParameter("quarter_id") != null) {
                            rs = statement.executeQuery(
                                    "SELECT COURSE.COURSENUMBER AS course_info FROM COURSE WHERE id = " + course_id);

                        rs.next();
                    %>
                    <p>Course: <b><%=rs.getString("course_info")%></b></p>
                    <p>Instructor: <b><%=faculty_name%></b></p>
                    <%
                        rs.close();
                        rs = statement.executeQuery(
                                "SELECT QUARTER.QUARTER, QUARTER.YEAR FROM QUARTER WHERE id = " + quarter_id);
                        rs.next();
                    %>
                    <p>Quarter: <b><%=rs.getString("QUARTER")+" "+rs.getString("YEAR")%></b></p>
                    <%
                        rs.close();
                        rs = statement.executeQuery(
                                "SELECT COUNT(CASE WHEN grade_received = 'A+' THEN 1 END) AS 'A+'," +
                                        "COUNT(CASE WHEN grade_received = 'A' THEN 1 END) AS 'A',"+
                                        "COUNT(CASE WHEN grade_received = 'A-' THEN 1 END) AS 'A-',"+
                                        "COUNT(CASE WHEN grade_received = 'B+' THEN 1 END) AS 'B+',"+
                                        "COUNT(CASE WHEN grade_received = 'B' THEN 1 END) AS 'B',"+
                                        "COUNT(CASE WHEN grade_received = 'B-' THEN 1 END) AS 'B-',"+
                                        "COUNT(CASE WHEN grade_received = 'C+' THEN 1 END) AS 'C+',"+
                                        "COUNT(CASE WHEN grade_received = 'C' THEN 1 END) AS 'C',"+
                                        "COUNT(CASE WHEN grade_received = 'C-' THEN 1 END) AS 'C-',"+
                                        "COUNT(CASE WHEN grade_received = 'D' THEN 1 END) AS 'D',"+
                                        "COUNT(CASE WHEN grade_received = 'F' THEN 1 END) AS 'F' "+
                                        "FROM COURSE co "+
                                        "JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id "+
                                        "JOIN CLASS cl ON ci.class_id = cl.id "+
                                        "JOIN TEACHINGHISTORY th ON cl.id = th.class_id "+
                                        "JOIN QUARTER q ON cl.quarter = q.quarter AND cl.class_year = q.year "+
                                        "JOIN CLASSESTAKEN ct ON cl.id = ct.CLASS_ID "+
                                        "WHERE co.id = " + course_id + " " +
                                        "AND FACULTY = '" + faculty_name + "' " +
                                        "AND q.id = " + quarter_id);
                        rs.next();
                    %>
            <table border="1">
                <tr>
                    <th>Grade</th>
                    <th>Count</th>
                </tr>
                <tr>
                    <td><input type="text" value="A+" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("A+")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="A" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("A")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="A-" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("A-")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="B+" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("B+")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="B" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("B")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="B-" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("B-")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="C+" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("C+")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="C" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("C")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="C-" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("C-")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="D" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("D")%>"></td>
                </tr>
                <tr>
                    <td><input type="text" value="F" readonly></td>
                    <td><input type="text" value="<%=rs.getInt("F")%>"></td>
                </tr>
            </table>
        <%
            }
            else if (request.getParameter("course_id") != null && !Objects.equals(request.getParameter("faculty_name"), "default") &&
                    request.getParameter("quarter_id") == null) {
                rs = statement.executeQuery(
                        "SELECT COURSE.COURSENUMBER AS course_info FROM COURSE WHERE id = " + course_id);

                rs.next();
        %>
        <p>Course: <b><%=rs.getString("course_info")%></b></p>
        <p>Instructor: <b><%=faculty_name%></b></p>

        <%
            rs.close();
            rs = statement.executeQuery(
                    "SELECT COUNT(CASE WHEN grade_received = 'A+' THEN 1 END) AS 'A+'," +
                            "COUNT(CASE WHEN grade_received = 'A' THEN 1 END) AS 'A',"+
                            "COUNT(CASE WHEN grade_received = 'A-' THEN 1 END) AS 'A-',"+
                            "COUNT(CASE WHEN grade_received = 'B+' THEN 1 END) AS 'B+',"+
                            "COUNT(CASE WHEN grade_received = 'B' THEN 1 END) AS 'B',"+
                            "COUNT(CASE WHEN grade_received = 'B-' THEN 1 END) AS 'B-',"+
                            "COUNT(CASE WHEN grade_received = 'C+' THEN 1 END) AS 'C+',"+
                            "COUNT(CASE WHEN grade_received = 'C' THEN 1 END) AS 'C',"+
                            "COUNT(CASE WHEN grade_received = 'C-' THEN 1 END) AS 'C-',"+
                            "COUNT(CASE WHEN grade_received = 'D' THEN 1 END) AS 'D',"+
                            "COUNT(CASE WHEN grade_received = 'F' THEN 1 END) AS 'F' "+
                            "FROM COURSE co "+
                            "JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id "+
                            "JOIN CLASS cl ON ci.class_id = cl.id "+
                            "JOIN TEACHINGHISTORY th ON cl.id = th.class_id "+
                            "JOIN QUARTER q ON cl.quarter = q.quarter AND cl.class_year = q.year "+
                            "JOIN CLASSESTAKEN ct ON cl.id = ct.CLASS_ID "+
                            "WHERE co.id = " + course_id + " " +
                            "AND FACULTY = '" + faculty_name + "' ");
            rs.next();
        %>
        <table border="1">
            <tr>
                <th>Grade</th>
                <th>Count</th>
            </tr>
            <tr>
                <td><input type="text" value="A+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="A" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="A-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A-")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B-")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C-")%>"></td>
            </tr>
            <tr>
                <td><input type="text" value="D" readonly></td>
                <td><input type="text" value="<%=rs.getInt("D")%>"></td>
            </tr>
            <tr>
                <td><input type="text" value="F" readonly></td>
                <td><input type="text" value="<%=rs.getInt("F")%>"></td>
            </tr>
        </table>

        <%
            rs.close();
            rs = statement.executeQuery(
                    "SELECT SUM(number_grade)/COUNT(ct.id) AS avg_gpa " +
                    "FROM COURSE co " +
                    "JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id " +
                    "JOIN CLASS cl ON ci.class_id = cl.id " +
                    "JOIN TEACHINGHISTORY th ON cl.id = th.class_id " +
                    "JOIN CLASSESTAKEN ct ON cl.id = ct.CLASS_ID " +
                    "JOIN GRADE_CONVERSION gc ON ct.grade_received = gc.letter_grade " +
                    "WHERE (grade_received NOT IN ('IN', 'S', 'U') OR grade_received IS NULL) " +
                    "AND co.id = " + course_id + " " +
                            "AND FACULTY = '" + faculty_name + "' ");
            rs.next();
        %>
        <p>Average GPA: <b><%=rs.getDouble("avg_gpa")%></b></p>


        <%
         } else if (request.getParameter("course_id") != null && request.getParameter("faculty_name").equals("default") &&
                request.getParameter("quarter_id") == null) {

             rs = statement.executeQuery( "SELECT COURSE.COURSENUMBER AS course_info FROM COURSE WHERE id = " + course_id);
             rs.next();
        %>
        <p>Course: <b><%=rs.getString("course_info")%></b></p>
        <%
            rs.close();
            rs = statement.executeQuery(
                    "SELECT COUNT(CASE WHEN grade_received = 'A+' THEN 1 END) AS 'A+'," +
                            "COUNT(CASE WHEN grade_received = 'A' THEN 1 END) AS 'A',"+
                            "COUNT(CASE WHEN grade_received = 'A-' THEN 1 END) AS 'A-',"+
                            "COUNT(CASE WHEN grade_received = 'B+' THEN 1 END) AS 'B+',"+
                            "COUNT(CASE WHEN grade_received = 'B' THEN 1 END) AS 'B',"+
                            "COUNT(CASE WHEN grade_received = 'B-' THEN 1 END) AS 'B-',"+
                            "COUNT(CASE WHEN grade_received = 'C+' THEN 1 END) AS 'C+',"+
                            "COUNT(CASE WHEN grade_received = 'C' THEN 1 END) AS 'C',"+
                            "COUNT(CASE WHEN grade_received = 'C-' THEN 1 END) AS 'C-',"+
                            "COUNT(CASE WHEN grade_received = 'D' THEN 1 END) AS 'D',"+
                            "COUNT(CASE WHEN grade_received = 'F' THEN 1 END) AS 'F' "+
                            "FROM COURSE co "+
                            "JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id "+
                            "JOIN CLASS cl ON ci.class_id = cl.id "+
                            "JOIN TEACHINGHISTORY th ON cl.id = th.class_id "+
                            "JOIN QUARTER q ON cl.quarter = q.quarter AND cl.class_year = q.year "+
                            "JOIN CLASSESTAKEN ct ON cl.id = ct.CLASS_ID "+
                            "WHERE co.id = " + course_id);
            rs.next();
        %>
        <table border="1">
            <tr>
                <th>Grade</th>
                <th>Count</th>
            </tr>
            <tr>
                <td><input type="text" value="A+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="A" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="A-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("A-")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="B-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("B-")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C+" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C+")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="C-" readonly></td>
                <td><input type="text" value="<%=rs.getInt("C-")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="D" readonly></td>
                <td><input type="text" value="<%=rs.getInt("D")%>" readonly></td>
            </tr>
            <tr>
                <td><input type="text" value="F" readonly></td>
                <td><input type="text" value="<%=rs.getInt("F")%>" readonly></td>
            </tr>
        </table>

        <%}%>

        </td>
    </tr>
</table>
</body>
</html>