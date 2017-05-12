<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/11/2017
  Time: 2:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student's Classes Taken in past</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Past Classes</h3>
            <p>Note:insert past classes</p>
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
                                "INSERT INTO CLASSESTAKEN (STUDENT_ID, SECTIONENROLLMENT_ID, grade_received) " +
                                        "VALUES (?, ?, ?)");
                        pstmtInsert.setString(1, request.getParameter("STUDENT_ID"));
                        pstmtInsert.setInt(2, Integer.parseInt(request.getParameter("SECTIONENROLLMENT_ID")));
                        pstmtInsert.setString(3, request.getParameter("GRADE_RECEIVED"));

                        int rowCount = pstmtInsert.executeUpdate();
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


            <table border="1">
                <tr>
                    <th>Student ID</th>
                    <th>Section Num</th>
                    <th>Grade Received</th>
                    <th colspan="2">Action</th>
                </tr>
                <tr>
                    <form action="classes-in-past.jsp" method="post">
                        <input type="hidden" value="insert" name="action">
                        <td><input value="" name="STUDENT_ID" size="10" required></td>
                        <td><input value="" name="SECTIONENROLLMENT_ID" size="10" required></td>
                        <td><select name="GRADE_RECEIVED" required>
                                <option disabled selected >Select Grade</option>
                                <option value="GRADEA+">A+</option>
                                <option value="GRADEA">A</option>
                                <option value="GRADEA-">A-</option>
                                <option value="GRADEB+">B+</option>
                                <option value="GRADEB">B</option>
                                <option value="GRADEB-">B-</option>
                                <option value="GRADEC+">C+</option>
                                <option value="GRADEC">C</option>
                                <option value="GRADEC-">C-</option>
                                <option value="GRADED">D</option>
                                <option value="GRADEF">F</option>
                            </select>
                        </td>
                        <td><input type="submit" value="Insert"></td>
                    </form>
                </tr>

                <%
                    Statement statement = conn.createStatement();
                    ResultSet rs = null;
                    try {
                        rs = statement.executeQuery("SELECT * FROM CLASSESTAKEN ");  //TODO write query to retrieve enrollment info
                    } catch (SQLException e) {
                        System.err.println("Result set exception classes-in-past jsp");
                        e.printStackTrace();
                    }
                %>


                <%
                    while (rs.next()){
                %>

                <tr>
                    <form action="classes-in-past.jsp" method="post">
                        <input type="hidden" value="update" name="action">
                        <%-- Get the ID --%>
                        <td>
                            <input value="<%= rs.getString("STUDENT_ID") %>"
                                   name="STUDENT_ID" size="10">
                        </td>

                        <%-- Get the FIRSTNAME --%>
                        <td>
                            <input value="<%= rs.getInt("SECTIONENROLLMENT_ID") %>"
                                   name="SECTIONENROLLMENT_ID" size="10">
                        </td>

                        <%-- Get the LASTNAME --%>
                        <td>
                            <input value="<%= rs.getString("GRADE_RECEIVED") %>"
                                   name="GRADE_RECEIVED" size="10">
                        </td>
                        <td><input type="submit" value="Update"></td>
                    </form>
                </tr>
                <%}%>
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
