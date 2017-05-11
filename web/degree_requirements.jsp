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
    <title>Degree Requirement</title>
</head>
<body>


<table border="1">
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>

            <jsp:include page="menu.html" />

        </td>
        <td>

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
                            "INSERT INTO DEGREE (DEGREE_TYPE,DEGREE_NAME,REQ_UNITS)" +
                                    " VALUES(?,?,?)");

                    pstmt.setString(1, request.getParameter("DEGREE_TYPE"));
                    pstmt.setString(2, request.getParameter("DEGREE_NAME"));
                    pstmt.setInt(3, Integer.parseInt(request.getParameter("REQ_UNITS")));
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
                        ("SELECT * FROM DEGREE");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>DEGREE TYPE</th>
                    <th>DEGREE NAME</th>
                    <th>REQUIRED UNITS</th>
                </tr>
                <tr>
                    <form action="degree_requirements.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <th><input value="" name="DEGREE_TYPE" size="10"></th>
                        <th><input value="" name="DEGREE_NAME" size="10"></th>
                        <th><input value="" name="REQ_UNITS" size="10"</th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {
                %>

                <tr>
                    <form action="degree_requirements.jsp" method="get">
                        <input type="hidden" value="update" name="action">


                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getString("DEGREE_TYPE") %>"
                                   name="DEGREE_TYPE" size="10">
                        </td>

                        <%-- Get the SSN, which is a number --%>
                        <td>
                            <input value="<%= rs.getString("DEGREE_NAME") %>"
                                   name="DEGREE_NAME" size="10">
                        </td>

                        <td>
                            <input value="<%= rs.getString("REQ_UNITS") %>"
                                   name="REQ_UNITS" size="10">
                        </td>


                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Update">
                        </td>
                    </form>
                    <form action="degree_requirements.jsp" method="get">
                        <input type="hidden" value="delete" name="action">
                        <input type="hidden"
                               value="<%= rs.getString("DEGREE_NAME") %>" name="DEGREE_NAME">
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
