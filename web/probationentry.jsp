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
    <title>Probation Entry</title>
</head>
<body>


<table border="1">
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Probation Entry</h3>
            <p>Note:</p>
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>

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
                            "INSERT INTO PROBATION(STUDENT_ID,START_DATE,END_DATE,REASON)" +
                                    " VALUES(?,?,?,?)");

                    pstmt.setString(1, request.getParameter("ID"));
                    pstmt.setDate(2, java.sql.Date.valueOf(request.getParameter("START_DATE")));
                    pstmt.setDate(3, java.sql.Date.valueOf(request.getParameter("END_DATE")));
                    pstmt.setString(4,request.getParameter("REASON"));
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
                        ("SELECT * FROM PROBATION");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>START DATE</th>
                    <th>END DATE</th>
                    <th>REASON</th>
                </tr>
                <tr>
                    <form action="probationentry.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <th><input value="" name="ID" size="10"></th>
                        <th><input type="date" value="" name="START_DATE" size="10" placeholder="yyyy-mm-dd"></th>
                        <th><input type="date" value="" name="END_DATE" size="10" placeholder="yyyy-mm-dd"></th>
                        <th><input value="" name="REASON" size="20"></th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

                %>

                <tr>
                    <form action="probationentry.jsp" method="get">
                        <input type="hidden" value="update" name="action">


                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getString("STUDENT_ID") %>"
                                   name="ID" size="10">
                        </td>

                        <%-- Get the Start date --%>
                        <td>
                            <input type="date" placeholder="yyyy-mm-dd" value="<%= rs.getString("START_DATE")%>"
                                   name="START_DATE" size="10">
                        </td>

                        <td>
                            <input type="date" placeholder="yyyy-mm-dd" value="<%= rs.getString("END_DATE")%>"
                                   name="END_DATE" size="10">
                        </td>

                        <td>
                            <input value="<%= rs.getString("REASON")%>"
                                name="REASON" size="20">
                        </td>


                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Update">
                        </td>
                    </form>
                    <form action="probationentry.jsp" method="get">
                        <input type="hidden" value="delete" name="action">
                        <input type="hidden"
                               value="<%= rs.getString("STUDENT_ID") %>" name="STUDENT_ID">
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
