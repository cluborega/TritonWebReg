<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/10/2017
  Time: 9:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Class Entry</title>
</head>
<body>
<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Class Entry</h3>
            <p>Note:Insert new class info</p>
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
                    e.printStackTrace();
                }

            %>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    if (conn == null) {
                        System.out.println("Connection with db not established.");
                    }

                    try {
                        conn.setAutoCommit(false);
                        PreparedStatement pstmtInsert = conn.prepareStatement(
                                "INSERT INTO CLASS(CLASS_TITLE, QUARTER, CLASS_YEAR) VALUES (?, ?, ?)");

                        pstmtInsert.setString(1, request.getParameter("CLASS_TITLE"));
                        pstmtInsert.setString(2, request.getParameter("QUARTER"));
                        pstmtInsert.setInt(3, Integer.parseInt(request.getParameter("CLASS_YEAR")));

                        int rowCount = pstmtInsert.executeUpdate();
                        conn.commit();

                        pstmtInsert = conn.prepareStatement(
                                "INSERT INTO CLASSINSTANCE (COURSE_ID, CLASS_ID) VALUES " +
                                        "(?, (SELECT CLASS.id FROM CLASS WHERE CLASS_TITLE = ? AND QUARTER = ? AND CLASS_YEAR = ?))");

                        pstmtInsert.setInt(1, Integer.parseInt(request.getParameter("CLASS_COURSE_ID")));
                        pstmtInsert.setString(2, request.getParameter("CLASS_TITLE"));
                        pstmtInsert.setString(3, request.getParameter("QUARTER"));
                        pstmtInsert.setString(4, request.getParameter("CLASS_YEAR"));

                        rowCount = pstmtInsert.executeUpdate();

                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                }
                else if (action != null && action.equals("update")) {

                    //TODO Update and delete Milestone 3
                }
            %>

            <%
                Statement statement = conn.createStatement();
                ResultSet rs = null;
                try {
                    rs = statement.executeQuery(
                            "SELECT id AS COURSE_ID, DEPARTMENT, COURSENUMBER FROM COURSE " +
                                    "ORDER BY DEPARTMENT, COURSENUMBER ASC");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
            <table border="1">
                <tr>
                    <th>Class</th>
                    <th>Quarter</th>
                    <th>Year</th>
                    <th>Course</th>
                    <th colspan="2">Action</th>
                </tr>
                <tr>
                    <form action="class-entry.jsp" method="post">
                        <input type="hidden" value="insert" name="action">
                        <td><input value="" name="CLASS_TITLE" size="10" required></td>
                        <td><select name="QUARTER" required>
                            <option disabled selected>Quarter</option>
                            <option value="Fall">Fall</option>
                            <option value="Winter">Winter</option>
                            <option value="Spring">Spring</option>
                            <option value="Summer">Summer-I</option>
                            <option value="Summer">Summer-II</option>
                        </select></td>
                        <td><input value = "" type="text" name="CLASS_YEAR" size="10" required></td>
                        <td><select name="CLASS_COURSE_ID" required>
                            <option disabled selected>Select a course</option>
                            <%
                                while (rs.next()) {
                                    String dept = null;
                                    String classNum = null;
                                    try {
                                        dept = rs.getString("DEPARTMENT");
                                        classNum = rs.getString("COURSENUMBER");
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                            %>
                            <option value="<%=rs.getInt("COURSE_ID")%>"><%=dept + " " + classNum%></option>
                            <%
                                }
                            %>
                        </select></td>
                        <td colspan="2"><input type="submit" value="Insert"></td>
                    </form>
                </tr>
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
