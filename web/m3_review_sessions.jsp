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
                String start_date = request.getParameter("start_date");
                String end_date = request.getParameter("end_date");

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
                    Start:<input type="text" name="start_date" placeholder="mm/dd/yyyy" required>
                    End:<input type="text" name="end_date" placeholder="mm/dd/yyyy" required>
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
                            stmt.executeUpdate("SELECT DISTINCT LECT_DAYS AS enrolled_days,\n" +
                                    "  STUFF(REPLACE(RIGHT(CONVERT(VARCHAR(19), LECT_START_TIME, 0), 7), ' ', '0'), 6, 0, ' ') AS enrolled_start_time,\n" +
                                    "  STUFF(REPLACE(RIGHT(CONVERT(VARCHAR(19), DATEADD(HH,1,LECT_START_TIME), 0), 7), ' ', '0'), 6, 0, ' ') AS enrolled_end_time\n" +
                                    "INTO #enrolled_section_times\n" +
                                    "FROM SECTION s\n" +
                                    "WHERE s.id IN (SELECT se.id FROM SECTIONENROLLMENT se) ");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        stmt.executeUpdate("IF OBJECT_ID('#tempDate','U') IS NOT NULL DROP TABLE #tempDate;\n" +
                                "IF OBJECT_ID('#available_times','U') IS NOT NULL DROP TABLE #available_times;\n" +
                                "DECLARE @date_from DATETIME2, @date_to DATETIME2\n" +
                                "SET @date_from = '"+start_date+"'\n" +
                                "SET @date_to = '"+end_date+"';\n" +
                                "WITH #tempDate AS(\n" +
                                "    SELECT @date_from AS dt\n" +
                                "    UNION ALL\n" +
                                "    SELECT DATEADD(HH,1,dt) FROM #tempDate WHERE dt<@date_to)\n" +
                                "SELECT DATENAME(MONTH,dt) AS month, DATEPART(DAY,dt) AS DayNum, DATENAME(DW,dt) AS Day, STUFF(REPLACE(RIGHT(CONVERT(VARCHAR(19), dt, 0), 7), ' ', '0'), 6, 0, ' ') AS Time\n" +
                                "INTO #available_times\n" +
                                "FROM #tempDate;");

//                        rs= statement.executeQuery(" ");

                    }
                %>
            </td>
        </tr>
</table>


</body>
</html>
