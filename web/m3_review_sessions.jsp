<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 6/1/2017
  Time: 1:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedule a Review Session</title>
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
                if (request.getParameter("secNum") == null){
                try{
                    rs = statement != null ? statement.executeQuery(
                            "SELECT co.COURSENUMBER AS courseNum, cl.CLASS_TITLE AS className, sec.SECTION_NUM AS SecNum\n" +
                                    "FROM SECTION sec\n" +
                                    "JOIN CLASS cl ON sec.CLASS_ID = cl.id\n" +
                                    "JOIN COURSE_WITHCLASS cwc ON cl.id = cwc.CLASS_ID\n" +
                                    "JOIN COURSE co ON cwc.COURSE_ID = co.id\n" +
                                    "WHERE cl.QUARTER = 'SP'\n" +
                                    "AND cl.CLASS_YEAR = '2017'\n" +
                                    "ORDER BY courseNum, className, SecNum") : null;
                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>
                <form action="m3_review_sessions.jsp" method="POST">
                    <select name="section_num" required>
                        <option selected disabled>Select Section</option>
                        <%
                            while (rs.next()) {
                                String displayClass = rs.getString("courseNum") + " > " + rs.getString("className") + " > Section " +
                                        rs.getString("secNum");
                        %>
                        <option value="<%=rs.getString("secNum")%>"><%=displayClass%></option>
                        <%
                            }
                        %>
                    </select>
                    Start:<input type="text" name="start_date" placeholder="yyyy-mm-dd" required>
                    End:<input type="text" name="end_date" placeholder="yyyy-mm-dd" required>
                    <input type="submit" value="Submit">
                </form>

                <%
                    } //end of if secNum == null
                    else {
                        Statement stmt = null;
                        if (conn != null) {
                            stmt = conn.createStatement();
                        }
                        try {
                            if (stmt != null) {
                                stmt.executeUpdate("IF OBJECT_ID('#enrolled_section_times', 'U') IS NOT NULL DROP TABLE #enrolled_section_times;");
                                stmt.executeUpdate("IF OBJECT_ID('#review_session_intervals', 'U') IS NOT NULL DROP TABLE #review_session_intervals;");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        try {
                            //create temporary table to store enrolled times
                            stmt.executeUpdate("SELECT DISTINCT LECT_START_TIME AS enrolled_start_time, DATEADD(HH,1,LECT_START_TIME) AS enrolled_end_time\n" +
                                    "INTO #enrolled_section_times\n" +
                                    "FROM SECTION s\n" +
                                    "WHERE s.id IN (SELECT se.id FROM SECTIONENROLLMENT se) ");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                    }
                %>
            </td>
        </tr>
</table>


</body>
</html>
