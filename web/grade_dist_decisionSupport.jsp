<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/31/2017
  Time: 5:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grade Distribution</title>
</head>
<body>

<table border = '1'>
    <tr>
        <td valign="top">
            <jsp:include page="menu.html"></jsp:include>
        </td>
        <td valign = 'top'>
            <h3>Grade Distribution </h3>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.net.URLEncoder" %>

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

                ResultSet rs = null;
//                if(request.getParameter("course_id") == null && request.getParameter("faculty_name") == null &&
//                        request.getParameter("quarter_id") == null) {
                try{


                    rs = statement != null ? statement.executeQuery(
                            "SELECT * FROM COURSE ORDER BY DEPARTMENT, COURSENUMBER ASC") : null;

                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>

            <table border = '1'>
                <form action="grade_dist_result.jsp" method="post">
                    <tr>
                        <td><select name="course_id" required>
                            <option selected disabled>Select Course</option>
                            <%
                                while (rs.next()) {
                                String courseInfo = rs.getString("COURSENUMBER");
                            %>
                            <option value="<%=rs.getInt("id")%>"><%=courseInfo%></option>
                            <%
                                }
                            %>
                            </select>
                        </td>
                        <td>
                            <%
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            try {
                                rs = statement != null ? statement.executeQuery("SELECT * FROM FACULTY ORDER BY FACULTY ASC") : null;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>

                            <select name="faculty_name">

                                <option value = "default" selected >Select Instructor/Faculty</option>
                                <%
                                    while (rs.next()) {
                                        String facultyInfo = rs.getString("FACULTY");
                                %>
                                <option value="<%= URLEncoder.encode(facultyInfo, "UTF-8")%>">  <%=facultyInfo%></option>
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            <%
                                try {
                                    rs.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                try {
                                    rs = statement != null ? statement.executeQuery("SELECT * FROM QUARTER ORDER BY YEAR ASC") : null;
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>

                            <select name="quarter_id">

                                <option selected disabled>Select Quarter</option>
                                <%
                                    while (rs.next()) {
                                        String quarterInfo = null;
                                        try {
                                            quarterInfo = rs.getString("QUARTER") + " " +rs.getString("YEAR");
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                %>
                                <option value="<%=rs.getInt("id")%>"><%=quarterInfo%></option>
                                <%
                                    } //end while loop
                                %>
                            </select>
                        </td>
                        <td>
                            <input type="submit" name="submit" value="Display">
                        </td>
                    </tr>
                </form>
            </table>
        </td>
    </tr>

</table>
</body>
</html>


<%--<%--%>
    <%--}--%>
    <%--else if (request.getParameter("course_id") != null && request.getParameter("faculty_name") != null &&--%>
            <%--request.getParameter("quarter_id") != null) {--%>
        <%--rs = statement.executeQuery(--%>
                <%--"SELECT COURSE.COURSENUMBER AS course_info FROM COURSE WHERE id = " + course_id);--%>
    <%--}--%>
    <%--rs.next();--%>
<%--%>--%>
<%--<p>Course: <b><%=rs.getString("course_info")%></b></p>--%>
<%--<p>Faculty_name: <b><%=faculty_name%></b></p>--%>
<%--<%--%>
    <%--rs.close();--%>
    <%--rs = statement.executeQuery(--%>
            <%--"SELECT QUARTER.QUARTER, QUARTER.YEAR FROM QUARTER WHERE id = " + quarter_id);--%>
    <%--rs.next();--%>
<%--%>--%>
<%--<p>Quarter: <b><%=rs.getString("QUARTER")+" "+rs.getString("YEAR")%></b></p>--%>
<%--<%--%>
    <%--rs.close();--%>
    <%--rs = statement.executeQuery(--%>
            <%--"SELECT COUNT(CASE WHEN grade_received = 'A+' THEN 1 END) AS \"A+\", " +--%>
                    <%--"COUNT(CASE WHEN grade_received = 'A' THEN 1 END) AS \"[A]\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'A-' THEN 1 END) AS \"A-\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'B+' THEN 1 END) AS \"B+\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'B' THEN 1 END) AS \"[B]\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'B-' THEN 1 END) AS \"B-\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'C+' THEN 1 END) AS \"C+\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'C' THEN 1 END) AS \"[C]\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'C-' THEN 1 END) AS \"C-\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'D' THEN 1 END) AS \"[D]\","+--%>
                    <%--"COUNT(CASE WHEN grade_received = 'F' THEN 1 END) AS \"[F]\""+--%>
                    <%--"FROM Course co "+--%>
                    <%--"JOIN COURSE_WITHCLASS ci ON co.id = ci.course_id "+--%>
                    <%--"JOIN Class cl ON ci.class_id = cl.id "+--%>
                    <%--"JOIN TeachingHistory th ON cl.id = th.class_id "+--%>
                    <%--"JOIN Quarter q ON cl.quarter = q.quarter AND cl.class_year = q.year "+--%>
                    <%--"JOIN ClassesTaken ct ON cl.id = ct.CLASS_ID "+--%>
                    <%--"WHERE co.id = " + course_id + " " +--%>
                    <%--"AND faculty_name = '" + faculty_name + "' " +--%>
                    <%--"AND q.id = " + quarter_id);--%>
    <%--rs.next();--%>
<%--%>--%>