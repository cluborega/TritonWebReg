<%--
  Created by IntelliJ IDEA.
  User: Bibek Kshetri
  Date: 5/9/2017
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student</title>
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
            <h3>Students List</h3>
            <p>Note: Please select from the Student Entry Menu on the left for Entry forms</p>
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


            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                ResultSet rs = statement.executeQuery
                        ("SELECT * FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>SSN</th>
                    <th>ID</th>
                    <th>First</th>
                    <th>Middle</th>
                    <th>Last</th>
                    <th>Residency</th>
                    <th>Status</th>
                </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

                %>

                <tr>
                    <form action="main_student.jsp" method="get">
                        <input type="hidden" value="update" name="action">

                        <%-- Get the SSN, which is a number --%>
                        <td>
                            <input value="<%= rs.getInt("SSN") %>"
                                   name="SSN" size="10">
                        </td>

                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getString("STUDENT_ID") %>"
                                   name="ID" size="10">
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
                                   name="STATUS" size="15">
                        </td>


                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Update">
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
