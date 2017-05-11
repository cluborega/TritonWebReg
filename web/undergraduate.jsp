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
    <title>Undergraduate</title>
</head>
<body>


<table border="1">
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="studentmenu.html"/>
            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Undergraduate and BS/MS List</h3>
            <p>Note:Insert new undergraduate </p>
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
                                "INSERT INTO Student(STUDENT_ID,SSN,FIRSTNAME,MIDDLENAME,LASTNAME,RESIDENCY,STAT)" +
                                        " VALUES(?, ?, ?, ?, ?, ?,?)");

                        pstmt.setString(1, request.getParameter("ID"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("SSN")));
                        pstmt.setString(3, request.getParameter("FIRSTNAME"));
                        pstmt.setString(4, request.getParameter("MIDDLENAME"));
                        pstmt.setString(5, request.getParameter("LASTNAME"));
                        pstmt.setString(6, request.getParameter("RESIDENCY"));
                        pstmt.setString(7, request.getParameter("STATUS"));
                        int rowCount = pstmt.executeUpdate();


                        //add into undergraduate table
                        pstmt = conn.prepareStatement("INSERT INTO UNDERGRADUATE "+
                                "(UNDERGRADUATE_ID, COLLEGE, MAJOR, MINOR)"+
                                " VALUES(?,?,?,?)");
                        System.out.println(request.getParameter("ID"));
                        pstmt.setString(1, (request.getParameter("ID")));
                        pstmt.setString(2, (request.getParameter("COLLEGE")));
                        pstmt.setString(3, (request.getParameter("MAJOR")));
                        pstmt.setString(4, (request.getParameter("MINOR")));
                        rowCount = pstmt.executeUpdate();

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
                            ("SELECT SSN,STUDENT_ID ,FIRSTNAME,MIDDLENAME,LASTNAME,"+
                                    "RESIDENCY,STAT, COLLEGE, MAJOR,MINOR FROM"+
                                    " Student, UNDERGRADUATE  WHERE STUDENT_ID = UNDERGRADUATE_ID");
                %>

                <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>Residency</th>
                        <th>Status</th>
                        <th>College</th>
                        <th>Major</th>
                        <th>Minor</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="undergraduate.jsp" method="get">
                            <input type="hidden" value="insert" name="action">
                            <th><input value="" name="ID" size="10"></th>
                            <th><input value="" name="SSN" size="10"></th>
                            <th><input value="" name="FIRSTNAME" size="15"></th>
                            <th><input value="" name="MIDDLENAME" size="15"></th>
                            <th><input value="" name="LASTNAME" size="15"></th>
                            <th><input value="" name="RESIDENCY" size="15"></th>
                            <th><input value="Undergrad" name="STATUS" size="15" readonly></th>
                            <th><input value="" name="COLLEGE" size="15"></th>
                            <th><input value="" name="MAJOR" size="15"></th>
                            <th><input value="" name="MINOR" size="15"></th>
                            <th><input type="submit" value="Insert"></th>
                        </form>
                    </tr>

                    <%-- -------- Iteration Code -------- --%>
                    <%
                        // Iterate over the ResultSet

                        while ( rs.next() ) {

                    %>

                    <tr>
                        <form action="undergraduate.jsp" method="get">
                            <input type="hidden" value="update" name="action">


                            <%-- Get the ID --%>
                            <td>
                                <input value="<%= rs.getString("STUDENT_ID") %>"
                                       name="ID" size="10">
                            </td>

                            <%-- Get the SSN, which is a number --%>
                            <td>
                                <input value="<%= rs.getString("SSN") %>"
                                       name="SSN" size="10">
                            </td>


                            <%-- Get the FIRSTNAME --%>
                            <td>
                                <input value="<%= rs.getString("FIRSTNAME") %>"
                                       name="FIRSTNAME" size="15">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("MIDDLENAME") %>"
                                       name="MIDDLENAME" size="15">
                            </td>

                            <%-- Get the LASTNAME --%>
                            <td>
                                <input value="<%= rs.getString("LASTNAME") %>"
                                       name="LASTNAME" size="15">
                            </td>

                            <%-- Get the COLLEGE --%>
                            <td>
                                <input value="<%= rs.getString("RESIDENCY") %>"
                                       name="RESIDENCY" size="15">
                            </td>

                            <%-- Get the STATUS --%>
                            <td>
                                <input value="<%= rs.getString("STAT") %>"
                                       name="STATUS" size="15" readonly>
                            </td>

                            <%-- Get the College --%>
                            <td>
                                <input value="<%= rs.getString("COLLEGE") %>"
                                       name="COLLEGE" size="15">
                            </td>

                            <%-- Get the Major --%>
                            <td>
                                <input value="<%= rs.getString("MAJOR") %>"
                                       name="MAJOR" size="15">
                            </td>


                            <%-- Get the Minor --%>
                            <td>
                                <input value="<%= rs.getString("MINOR") %>"
                                       name="MINOR" size="15">
                            </td>

                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="undergraduate.jsp" method="get">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden"
                                   value="<%= rs.getInt("SSN") %>" name="SSN">
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
