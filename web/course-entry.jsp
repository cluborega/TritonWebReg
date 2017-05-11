<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/10/2017
  Time: 1:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Enrollment</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Course Entry</h3>
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
                                "INSERT INTO COURSE(DEPARTMENT, COURSENUMBER, MINUNITS, MAXUNITS, " +
                                        "GRADE_OPTION, REQUIRESLAB, REQUIRESCONSENT) VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmtInsert.setString(1, request.getParameter("DEPARTMENT"));
                        pstmtInsert.setString(2, request.getParameter("COURSENUMBER"));
                        pstmtInsert.setInt(3, Integer.parseInt(request.getParameter("MINUNITS")));
                        pstmtInsert.setInt(4, Integer.parseInt(request.getParameter("MAXUNITS")));
                        pstmtInsert.setString(5, request.getParameter("GRADE_OPTION"));
                        pstmtInsert.setInt(6, Integer.parseInt(request.getParameter("REQUIRESLAB")));
                        pstmtInsert.setInt(7, Integer.parseInt(request.getParameter("REQUIRESCONSENT")));

                        int rowCount = pstmtInsert.executeUpdate();
                        conn.commit();
                        String[] getPreReqs = request.getParameterValues("PREREQUISITE_ID");
                        if(getPreReqs != null) {
                            pstmtInsert = conn.prepareStatement(
                                    "INSERT INTO PREREQUISITE (TARGET_ID, PREREQUISITE_ID) VALUES " +
                                            "((SELECT COURSE.id FROM COURSE WHERE DEPARTMENT=? AND COURSENUMBER=?), ?)");

                            for(String p : getPreReqs) {
                                pstmtInsert.setString(1, request.getParameter("DEPARTMENT"));
                                pstmtInsert.setString(2, request.getParameter("COURSENUMBER"));
                                pstmtInsert.setInt(3, Integer.parseInt(p));

                                rowCount = pstmtInsert.executeUpdate();
                            }

                            conn.commit();
                        } //END IF PREREQ != null
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
                                "UPDATE COURSE SET COURSENUMBER = ?, DEPARTMENT = ?, " +
                                        "MINUNITS = ?, MAXUNITS = ?, GRADE_OPTION = ?, " +
                                        "REQUIRESLAB = ?, REQUIRESCONSENT = ? WHERE id = ?");

                        pstmtUpdate.setString(1, request.getParameter("COURSENUMBER"));
                        pstmtUpdate.setString(2, request.getParameter("DEPARTMENT"));
                        pstmtUpdate.setInt(3, Integer.parseInt(request.getParameter("MINUNITS")));
                        pstmtUpdate.setInt(4, Integer.parseInt(request.getParameter("MAXUNITS")));
                        pstmtUpdate.setString(5, request.getParameter("GRADE_OPTION"));
                        pstmtUpdate.setInt(6, Integer.parseInt(request.getParameter("REQUIRESLAB")));
                        pstmtUpdate.setInt(7, Integer.parseInt(request.getParameter("REQUIRESCONSENT")));
                        pstmtUpdate.setInt(8, Integer.parseInt(request.getParameter("id")));
                        int rowCount = pstmtUpdate.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                }
            %>
            <%
                Statement statement = conn.createStatement();
                ResultSet rs = statement.executeQuery(
                        "SELECT * FROM COURSE");
            %>
            <table border="1">
                <tr>
                    <th>Department</th>
                    <th>Course Number</th>
                    <th>Min Units</th>
                    <th>Max Units</th>
                    <th>Grade Option</th>
                    <th>Lab Required</th>
                    <th>Consent Required</th>
                    <th>Prereqsite</th>
                    <th colspan="2">Action</th>
                </tr>
                <tr>
                    <form action="course-entry.jsp" method="post">
                        <input type="hidden" value="insert" name="action">
                        <td><input value="" name="DEPARTMENT" size="10" required></td>
                        <td><input value="" name="COURSENUMBER" size="10" required></td>
                        <td><input value="" name="MINUNITS" size="10" required></td>
                        <td><input value="" name="MAXUNITS" size="10" required></td>
                        <td><select name="GRADE_OPTION" required>
                            <option disabled selected>Grade Option</option>
                            <option value="Letter">Letter Grade</option>
                            <option value="S/U">S/U</option>
                            <option value="Both">Both</option>
                        </select></td>
                        <td width="5"><select name="REQUIRESLAB">
                            <option value="0" selected>No</option>
                            <option value="1">Yes</option>
                        </select></td>
                        <td><select name="REQUIRESCONSENT">
                            <option value="0" selected>No</option>
                            <option value="1">Yes</option>
                        </select></td>
                        <td><select multiple name="PREREQUISITE_ID">
                            <option disabled>Select course(s)</option>
                            <%
                                while (rs.next()) {
                                    String dept = rs.getString("DEPARTMENT");
                                    String course_num = rs.getString("COURSENUMBER");
                            %>
                            <option value="<%=rs.getInt("id")%>"><%=dept + " " + course_num%></option>
                            <%
                                }
                            %>
                        </select></td>
                        <td colspan="2"><input type="submit" value="Insert"></td>
                    </form>
                </tr>
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
