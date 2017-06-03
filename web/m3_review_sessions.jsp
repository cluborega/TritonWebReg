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
                Statement stmt = null;
                String sectionNumber = request.getParameter("section_num");
                if (conn != null) {
                    try {
                        statement = conn.createStatement();
                        stmt = conn.createStatement();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

                ResultSet rs = null;
                if (sectionNumber == null){
                try{
                    rs = statement != null ? statement.executeQuery(
                            "SELECT co.COURSENUMBER AS courseNum, cl.CLASS_TITLE AS className, sec.SECTION_NUM AS SecNum\n" +
                                    "FROM SECTION sec\n" +
                                    "JOIN CLASS cl ON sec.CLASS_ID = cl.id\n" +
                                    "JOIN COURSE_WITHCLASS cwc ON cl.id = cwc.CLASS_ID\n" +
                                    "JOIN COURSE co ON cwc.COURSE_ID = co.id\n" +
                                    "WHERE cl.QUARTER = 'SP'\n" +
                                    "AND cl.CLASS_YEAR = '2017'\n" +
                                    "ORDER BY courseNum, className, SecNum;") : null;
                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>
                <h3>Fill out below to see times for review session </h3>

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
                    Start:<input type="text" name="start_date" placeholder="mm/dd/yyyy" required>
                    End:<input type="text" name="end_date" placeholder="mm/dd/yyyy" required>
                    <input type="submit" value="Submit">
                </form>

                <%
                    } //end of if secNum != null
                    else {

                            //create temporary table to store enrolled times
                            if (stmt != null) {
                                stmt.executeUpdate("SELECT st.STUDENT_ID INTO ##enrolledStudentsInY FROM SECTION s\n" +
                                        "JOIN SECTIONENROLLMENT se ON s.id = se.SECTION_ID\n" +
                                        "JOIN STUDENT st ON se.STUDENT_ID = st.STUDENT_ID\n" +
                                        "WHERE s.id = '" + sectionNumber + "';");

                                System.out.println(sectionNumber);
                                stmt.executeUpdate("DECLARE @date_from DATETIME2, @date_to DATETIME2\n" +
                                        "SET @date_from = '"+start_date+"'\n" +
                                        "SET @date_to = '"+end_date+"';\n" +
                                        "WITH ##tempDate AS(\n" +
                                        "    SELECT @date_from AS dt\n" +
                                        "    UNION ALL\n" +
                                        "    SELECT DATEADD(HH,1,dt) FROM ##tempDate  WHERE dt<@date_to)\n" +
                                        "SELECT * INTO ##available_times FROM ##tempDate ;");

                                stmt.executeUpdate("SELECT m.start_time\n" +
                                        "INTO ##busyTime FROM SECTION s\n" +
                                        "JOIN SECTIONENROLLMENT se ON se.SECTION_ID = s.id\n" +
                                        "JOIN ##enrolledStudentsInY ##ey ON se.STUDENT_ID = ##ey.STUDENT_ID\n" +
                                        "JOIN MEETINGS m ON m.section_id = s.id;");

                                rs = statement != null ? statement.executeQuery("SELECT DATENAME(MONTH,##att.dt) AS Month, DATEPART(DAY,##att.dt) AS DayNum, DATENAME(DW,##att.dt) AS DayName,\n" +
                                        "STUFF(REPLACE(RIGHT(CONVERT(VARCHAR(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS startTime,\n" +
                                        "  STUFF(REPLACE(RIGHT(CONVERT(VARCHAR(19), DATEADD(HH,1,dt), 0), 7), ' ', '0'), 6, 0, ' ') AS endTime\n" +
                                        "FROM ##available_times ##att\n" +
                                        "WHERE ##att.dt NOT IN (SELECT * FROM ##busyTime) AND DATEPART(HH,##att.dt) > 08 AND DATEPART(HH, ##att.dt) < 21;") : null;
                            }

                        stmt.executeUpdate("IF OBJECT_ID('##enrolledStudentsInY', 'U') IS NULL DROP TABLE ##enrolledStudentsInY");
                        stmt.executeUpdate("IF OBJECT_ID('##tempDate','U') IS NOT NULL DROP TABLE ##tempDate;");
                        stmt.executeUpdate("IF OBJECT_ID('##available_times','U') IS NOT NULL DROP  TABLE ##available_times;");
                        stmt.executeUpdate("IF OBJECT_ID('##busyTime','U') IS NOT NULL DROP TABLE ##busyTime;");
                %>
                <h3>Available Time for review sessions:</h3>
                <%
                        while(rs.next()){
                            System.out.println( "Ashish");
                %>
                <table>
                    <tr><%= rs.getString("Month")+" "+rs.getString("DayNum")+" "+rs.getString("DayName")+" "+rs.getString("startTime")+" - "+rs.getString("endTime")%></tr>
                </table>
                <%
                    }
                    }
                %>
            </td>
        </tr>
</table>
</body>
</html>
