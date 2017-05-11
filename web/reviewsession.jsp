<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/9/2017
  Time: 11:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Review Session</title>
</head>
<body>


<table border="1">
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Review Session Entry</h3>
            <p>Note:</p>
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.text.DateFormat" %>
            <%@ page import="java.text.SimpleDateFormat" %>

            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    // Load Oracle Driver class file
                    DriverManager.registerDriver
                            (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection
                            ("jdbc:sqlserver://localhost:1433;databaseName=CSE132B",
                                    "sa", "Firewall1");
                    if (conn == null){
                        System.out.println("Not connected");
                    }

            %>


            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT the student attributes INTO the Student table.
                    PreparedStatement pstmt  = conn.prepareStatement(
                            "INSERT INTO REVIEWSESSION (CLASS_ID,SECTION_NUM,LOCATION"+
                                    " ,REVIEW_DATE, START_TIME, END_TIME)" +
                                    " VALUES(?,?,?,?,?,?)");

                    String start = request.getParameter("START_TIME");
                    String end = request.getParameter("END_TIME");
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                    pstmt.setString(2, request.getParameter("SECTION_NUM"));
                    pstmt.setString(3, request.getParameter("LOCATION"));
                    pstmt.setDate(4, java.sql.Date.valueOf(request.getParameter("REVIEW_DATE")));
                    pstmt.setString(5, start);
                    pstmt.setString(6, end);
                    int rowCount = pstmt.executeUpdate();



                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>



            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                ResultSet rs = statement.executeQuery
                        ("SELECT * FROM REVIEWSESSION");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>CLASS</th>
                    <th>SECTION</th>
                    <th>LOCATION</th>
                    <th>DATE</th>
                    <th>Time Start</th>
                    <th>Time End</th>
                </tr>
                <tr>
                    <form action="reviewsession.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <th><input value="" name="CLASS_ID" size="10"></th>
                        <th><input value="" name="SECTION_NUM" size="10"></th>
                        <th><input value="" name="LOCATION" size="10"></th>
                        <th><input type="date" value="" name="REVIEW_DATE" size="10"></th>
                        <th><input type="time" value="" name="START_TIME" size="10"></th>
                        <th><input type="time" value="" name="END_TIME" size="10"></th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {
                %>

                <tr>
                    <form action="reviewsession.jsp" method="get">
                        <input type="hidden" value="update" name="action">


                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getInt("CLASS_ID") %>"
                                   name="CLASS_ID" size="10">
                        </td>

                        <%-- Get the SSN, which is a number --%>
                        <td>
                            <input value="<%= rs.getString("SECTION_NUM") %>"
                                   name="SECTION_NUM" size="10">
                        </td>

                        <td>
                            <input value="<%= rs.getString("LOCATION") %>"
                                   name="LOCATION" size="10">
                        </td>

                        <%-- Get the ID --%>
                        <td>
                            <input type="date" value="<%= rs.getDate("REVIEW_DATE") %>"
                                   placeholder="yyyy-mm-dd" name="REVIEW_DATE" size="10">
                        </td>

                        <%-- Get the SSN, which is a number --%>
                        <td>
                            <input type="time" value="<%= rs.getString("START_TIME") %>"
                                   name="START_TIME" size="10">
                        </td>

                        <td>
                            <input type="time" value="<%= rs.getString("END_TIME") %>"
                                   name="END_TIME" size="10">
                        </td>

                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Update">
                        </td>
                    </form>
                    <form action="reviewsession.jsp" method="get">
                        <input type="hidden" value="delete" name="action">
                        <input type="hidden"
                               value="<%= rs.getString("id") %>" name="ID">
                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Delete">
                        </td>
                    </form>
                </tr>
                <%
                    }
                %>

                <%-- -------- Close Connection Code -------- --%>
                <%
                        // Close the ResultSet
                        rs.close();

                        // Close the Statement
                        statement.close();

                        // Close the Connection
                        conn.close();
                    } catch (SQLException sqle) {
                        out.println(sqle.getMessage());
                    } catch (Exception e) {
                        out.println(e.getMessage());
                    }
                %>
            </table>
        </td>
    </tr>
</table>


</body>
</html>

