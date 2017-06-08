<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/10/2017
  Time: 1:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MS-Undergraduate</title>
</head>
<body>
<table border="1">
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>MS Undergraduate List</h3>
            <p>Note:Insert new MS/BS student.</p>
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
                            "INSERT INTO CURRENTLYTEACHING(SECTION_ID, FACULTY)" +
                                    " VALUES(?, ?)");
                    pstmt.setInt(1, Integer.parseInt(request.getParameter("SECTION_ID")));
                    pstmt.setString(2, request.getParameter("FACULTY"));


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
                        ("SELECT * FROM SECTIONENROLLMENT");

            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>SECTION_ID</th>
                    <th>FACULTY</th>
                </tr>
                <tr>
                    <form action="facultysectionentry.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <th>
                            <%
                                rs = statement.executeQuery("SELECT id AS SECTION_ID, SECTION_NUM FROM SECTION");
                            %>
                            <SELECT name = "SECTION_ID">
                                <%
                                    while (rs.next()){
                                %>
                                <option value="<%=rs.getInt("SECTION_ID")%>"><%=rs.getInt("SECTION_ID")%> </option>
                                <%
                                    }
                                %>
                            </SELECT>
                        </th>
                        <th>
                            <%
                                rs = statement.executeQuery("SELECT FACULTY FROM FACULTY");
                            %>
                            <SELECT name = "FACULTY">
                                <%
                                    while (rs.next()){
                                %>
                                <option value="<%=rs.getString("FACULTY")%>"><%=rs.getString("FACULTY")%> </option>
                                <%
                                    }
                                %>
                            </SELECT>
                        </th>
                        <%--<th><input value="" name="FACULTY" size="40" ></th>--%>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>
                <%
                    // Iterate over the ResultSet

                    while ( rs.next() ) {

                %>

                <tr>
                    <form action="facultysectionentry.jsp" method="get">
                        <input type="hidden" value="update" name="action">


                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getString("SECTION_ID") %>"
                                   name="SECTION_ID" readonly>
                        </td>

                        <%-- Get the SSN, which is a number --%>
                        <td>
                            <input value="<%= rs.getString("FACULTY") %>"
                                   name="FACULTY" size="40" readonly>
                        </td>


                        <%-- Button --%>
                        <td>
                            <input type="submit" value="Update">
                        </td>
                    </form>
                    <form action="msundergraduate.jsp" method="get">
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
