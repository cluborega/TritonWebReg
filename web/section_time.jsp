<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 6/8/2017
  Time: 1:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter Section Times</title>
</head>
<body>

<table border="1">
    <tr>
        <td valign="top">

            <jsp:include page="menu.html" />

        </td>
        <td valign="top">
            <h3>Class-Sections</h3>
            <p>Note:</p>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="javax.swing.plaf.nimbus.State" %>

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
                            "INSERT INTO WEEKLYMEETING(meeting_type, sec_id, days, start_time)" +
                                    " VALUES(?,?,?,?)");

                    pstmt.setString(1, request.getParameter("meeting_type"));
                    pstmt.setInt(2, (Integer.parseInt(request.getParameter("sec_id"))));
                    pstmt.setString(3, request.getParameter("days"));
                    pstmt.setString(4, request.getParameter("start_time"));
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
                Statement getClassStmt = conn.createStatement();

                ResultSet classSet = getClassStmt.executeQuery("SELECT s.id AS sid, s.SECTION_NUM AS sec_num FROM SECTION s");
//                ResultSet rs = statement.executeQuery
//                        ("SELECT * FROM SECTION");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>Meeting Type</th>
                    <th>Section Id</th>
                    <th>Meeting Days</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                </tr>
                <tr>
                    <form action="section_time.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <td><SELECT name = "meeting_type">
                            <option value ="LE">LE</option>
                            <option value ="DI">DI</option>
                            <option value ="LAB">LAB</option>
                        </SELECT>

                        </td>
                        <td><select name="sec_id">
                            <%
                                while(classSet.next())
                                {
                            %>
                            <option value="<%=classSet.getInt("sid")%>"><%=classSet.getInt("sec_num")%>
                            </option>
                            <%
                                }
                            %>
                        </select></td>
                        <th><input value="" name="days" size="10"></th>
                        <th><input value="" name="start_time" size="10" placeholder="HH:MM:SS"></th>
                        <%--<th><input value="" name="end_time" size="10" placeholder="HH:MM:SS"></th>--%>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>


                <%-- -------- Close Connection Code -------- --%>
                <%
                        // Close the ResultSet
//                    rs.close();

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
