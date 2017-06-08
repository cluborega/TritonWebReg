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
                Statement stmt = conn.createStatement();
                ResultSet rs_utility = stmt.executeQuery("SELECT STUDENT_ID FROM STUDENT");
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    if (conn == null) {
                        System.out.println("Connection with db not established.");
                    }

                    try {
                        conn.setAutoCommit(false);
                        PreparedStatement pstmtInsert = conn.prepareStatement(
                                "INSERT INTO CLASSESTAKEN (STUDENT_ID, CLASS_ID, grade_received) " +
                                        "VALUES (?, ?, ?)");
                        pstmtInsert.setString(1, request.getParameter("STUDENT_ID"));
                        pstmtInsert.setInt(2, Integer.parseInt(request.getParameter("CLASS_ID")));
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
                    if (conn == null) {
                        System.out.println("Connection with db not established.");
                    }

                    try {
                        conn.setAutoCommit(false);
                        PreparedStatement pstmtUpdate = conn.prepareStatement(
                                "UPDATE CLASSESTAKEN SET GRADE_RECEIVED =? WHERE id = ?"); //AND CLASS_ID = ?");
                        pstmtUpdate.setString(1, request.getParameter("GRADE_RECEIVED"));
                        pstmtUpdate.setString(2, request.getParameter("ct_id"));
//                        pstmtUpdate.setString(3, request.getParameter("CLASS_ID"));
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
                <th>
                    <th>Student ID</th>
                    <th>Class</th>
                    <th>Grade Received</th>
                    <th colspan="2">Action</th>
                </tr>
                <tr>
                    <form action="classes-in-past.jsp" method="post">
                        <input type="hidden" value="insert" name="action">
                        <td> <SELECT name = "STUDENT_ID" required>
                            <% while (rs_utility.next()){
                            %>
                            <option value=""> <%= rs_utility.getString("STUDENT_ID")%></option>
                            <%
                                }
                            %>
                        </SELECT>
                        </td>
                        <%
                            rs_utility.close();
                            rs_utility = stmt.executeQuery("SELECT * FROM CLASS");
                        %>
                        <td><SELECT name = "STUDENT_ID" required>
                            <% while (rs_utility.next()){
                            %>
                            <option value="<%= rs_utility.getString("id")%>"> <%= rs_utility.getString("CLASS_TITLE")+" "+rs_utility.getString("QUARTER")+" "+rs_utility.getString("CLASS_YEAR")%></option>
                            <%
                                }
                            %>
                        </SELECT></td>
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
                        rs = statement.executeQuery("SELECT ct.id AS ct_id, ct.STUDENT_ID AS STUDENT_ID, cl.CLASS_TITLE AS CLASS_TITLE, cl.QUARTER AS QUARTER, cl.CLASS_YEAR AS CLASS_YEAR, ct.GRADE_RECEIVED AS GRADE_RECEIVED FROM CLASSESTAKEN ct\n" +
                                "JOIN CLASS cl ON ct.CLASS_ID= cl.id;");  //TODO write query to retrieve enrollment info
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
                            <input name="<%= rs.getString("STUDENT_ID") %>" hidden><%= rs.getString("STUDENT_ID") %> </input>
                        </td>

                        <%-- Get the FIRSTNAME --%>
                        <td><input value="<%= rs.getInt("ct_id") %>" hidden>
                            <%= rs.getString("CLASS_TITLE") +" "+rs.getString("QUARTER")+ " "+rs.getString("CLASS_YEAR") %>
                            </input>
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
