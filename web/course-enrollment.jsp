<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/11/2017
  Time: 2:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Enrollment Entry Form</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Course Enrollment</h3>
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
                        if (conn != null) {
                            conn.setAutoCommit(false);
                        }
                        System.out.println(request.getParameter("SECTION_ID"));
                        PreparedStatement pstmtInsert = conn != null ? conn.prepareStatement(
                                "INSERT INTO SECTIONENROLLMENT (STUDENT_ID, SECTION_ID, UNITS_TAKING, GRADE_OPTION) " +
                                        "VALUES (?, ?, ?, ?)") : null;

                        pstmtInsert.setString(1, request.getParameter("STUDENT_ID"));
                        pstmtInsert.setInt(2, Integer.parseInt(request.getParameter("SECTION_ID")));
                        pstmtInsert.setInt(3, Integer.parseInt(request.getParameter("UNITS_TAKING")));
                        pstmtInsert.setString(4, request.getParameter("GRADE_OPTION"));

                        int rowCount = pstmtInsert.executeUpdate();

                        if (conn != null) {
                            conn.commit();
                            conn.setAutoCommit(true);
                        }

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
                Statement statement = null;
                if (conn != null) {
                    try {
                        statement = conn.createStatement();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
//                Statement getStudentsStmt = conn.createStatement();
                ResultSet rs = null;
                ResultSet studentRset = null;
                try {
//                    studentRset = getStudentsStmt.executeQuery("SELECT STUDENT_ID FROM STUDENT");
                    rs = statement != null ? statement.executeQuery("SELECT * FROM STUDENT") : null;  //TODO write query to retrieve enrollment info
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
            <table border="1">
                <tr>
                    <th>Student Id</th>
                    <th>Section Id</th>
                    <th>Units Taking</th>
                    <th>Grade Option</th>
                </tr>
                <tr>
                    <form action="course-enrollment.jsp" method="POST">
                        <input type="hidden" value="insert" name="action">
                        <th><select name="STUDENT_ID">
                            <%
                                if (rs != null){
//                                    System.out.println("student rset is not null "+ rs.getString("STUDENT_ID"));
                                while (rs.next()) {
                            %>
                            <option value ="<%=rs.getString("STUDENT_ID")%>"><%=rs.getString("STUDENT_ID")%></option>
                            <%
                                }
                                }
                            %>
                        </select>
                        </th>
                        <th>
                            <%
//                                rs.close();
                                rs = statement.executeQuery("SELECT id AS SECTION_ID, SECTION_NUM FROM SECTION");
                            %>
                            <select name = "SECTION_ID">
                                <%
                                    while (rs.next()) {
                                %>

                                <option value="<%=rs.getInt("SECTION_ID")%>" ><%= rs.getInt("SECTION_NUM")%> </option>
                                <%
                                    }
                                %>
                            </select>
                        </th>
                        <th><input value="" name="UNITS_TAKING" size="10"></th>
                        <td><select name="GRADE_OPTION" required>
                            <option disabled selected>Grade Option</option>
                            <option value="Letter">Letter Grade</option>
                            <option value="S/U">S/U</option>
                            <option value="Both">Both</option>
                        </select></td>
                        <td><input type="submit" value="Insert"></td>
                    </form>
                </tr>
                <%
                    //TODO update and delete code
                %>
                <tr>

                </tr>
                <%
                    try {
//                        studentRset.close();
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
