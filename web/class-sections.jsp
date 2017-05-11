<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/11/2017
  Time: 12:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Class Section Entry</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">
            <jsp:include page="studentmenu.html"/>
            <jsp:include page="menu.html" />

        </td>
        <td>

            <%@ page language="java" import="java.sql.*" %>

            <%-- -------- Open Connection Code -------- --%>
            <%
                Connection conn = null;
                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                    // Make a connection to the Oracle datasource "cse132b"

                    conn = DriverManager.getConnection
                            ("jdbc:sqlserver://localhost:1433;databaseName=CSE132B",
                                    "sa", "Firewall1");
                }catch( SQLException e){
                    System.err.println("Error in establishing connection with the database.");
                    e.printStackTrace();
                }

                Statement statement = conn.createStatement();
                ResultSet rs = null;
                try {
                    rs = statement.executeQuery(
                            "SELECT c.id AS CLASS_ID, c.CLASS_TITLE AS CLASS_TITLE, c.QUARTER AS CLASS_QUARTER, " +
                                    "c.CLASS_YEAR AS CLASS_YEAR, COUNT(s.id) AS NUM_SECTIONS " +
                                    "FROM CLASS c LEFT OUTER JOIN SECTION s ON c.id = s.CLASS_ID " +
                                    "GROUP BY c.id, c.CLASS_TITLE, c.QUARTER, c.CLASS_YEAR ORDER BY c.CLASS_YEAR, c.QUARTER ASC");
                } catch (SQLException e) {
                    System.err.println("Exception during executing query and getting result in result set.");
                    e.printStackTrace();
                }

            %>

            <table border="1">
                <tr>
                    <th>Class</th>
                    <th>Quarter</th>
                    <th>Year</th>
                    <th>Number of Sections</th>
                    <th colspan="2">Action</th>
                </tr>
                <%
                    if (rs != null){
                        while ( rs.next() ) {
                %>
                    <tr>
                        <td><input type="text" value="<%= rs.getString("CLASS_TITLE")%>" size="10"></td>
                        <td><input type="text" value="<%= rs.getString("CLASS_QUARTER")%>" size="10"></td>
                        <td><input type="text" value="<%= rs.getString("CLASS_YEAR")%>" size="10"></td>
                        <td><input type="text" value="<%= rs.getInt("NUM_SECTIONS")%>" size="10"></td>

                        <!-- Updating current sections shown here TODO -->
                        <td><input type="submit" value="Update Section"></td>
                    </tr>
                <%
                        }
                    }
                %>
                <%
                    //TODO update and delete code
                %>
                <tr>

                </tr>
                <%
                    try {
                        rs.close();
                        conn.close();
                    }
                    catch (SQLException e){
                        System.err.println("Exception in course_enrollment.jsp, failed to close conn.");
                        e.printStackTrace();
                    }
                %>


            </table>
        </td>
</table>

</body>
</html>
