<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/10/2017
  Time: 10:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Faculty Entry Form</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Faculty Entry</h3>
            <p>Note:</p>
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
                                "INSERT INTO Faculty (FACULTY, TITLE, DEPARTMENT) " +
                                        "VALUES (?, ?, ?)");
                        pstmtInsert.setString(1, request.getParameter("FACULTY")); //faculty name is PK in the db
                        pstmtInsert.setString(2, request.getParameter("TITLE"));
                        pstmtInsert.setString(3, request.getParameter("DEPARTMENT"));

                        int rowCount = pstmtInsert.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                }
                else if (action != null && action.equals("update")) {
                    try {
                        conn.setAutoCommit(false);
                        PreparedStatement pstmtUpdate = conn.prepareStatement(
                            "UPDATE FACULTY SET FACULTY = ?, TITLE = ?, " +
                            "DEPARTMENT = ? WHERE id = ?");

                        pstmtUpdate.setString(1, request.getParameter("FACULTY"));
                        pstmtUpdate.setString(2, request.getParameter("TITLE"));
                        pstmtUpdate.setString(3, request.getParameter("DEPARTMENT"));
                        pstmtUpdate.setInt(4, Integer.parseInt(request.getParameter("id")));
                        int rowCount = pstmtUpdate.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                }
            %>

                <table border="1">
                    <tr>
                        <th>Faculty_Name</th>
                        <th>Title</th>
                        <th>Department</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="faculty-entry.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><input value="" name="FACULTY" size="20" required></td>
                            <td><input value="" name="TITLE" size="20" required></td>
                            <td><input value="" name="DEPARTMENT" size="20" required></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>
                    <%
                        // VIEWING DATA INSIDE FACULTY TABLE
                        PreparedStatement selectStmt = conn.prepareStatement("SELECT * FROM FACULTY ORDER BY FACULTY ASC");
                        ResultSet rs  = null;
                        try {
                            rs = selectStmt.executeQuery();
                        }
                        catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>

                    <%
                        while ( rs.next() ) {
                    %>

                    <tr>
                        <form action="faculty-entry.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td><input name="FACULTY" value="<%= rs.getString("FACULTY")%>" size="20" required></td>
                            <td><input name="TITLE" value="<%= rs.getString("TITLE")%>" size="20" required></td>
                            <td><input name="DEPARTMENT" value="<%= rs.getString("DEPARTMENT")%>" size="20" required></td>
                            <td><input type="submit" value="Update"></td>
                        </form>

                        <form action="faculty-entry.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td><input type="submit" value="Delete"></td>
                        </form>
                    </tr>
                    <%
                        } //END WHILE LOOP FOR VIEW
                        rs.close();
                        conn.close();
                    %>
                </table>
        </td>
</table>



</body>
</html>
