<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/11/2017
  Time: 12:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Class Section Entry</title>
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
                            "INSERT INTO SECTION(CLASS_ID,SECTION_NUM,SECTION_MAX)" +
                                    " VALUES(?,?,?)");

                    pstmt.setInt(1, Integer.parseInt(request.getParameter("CLASS_ID")));
                    pstmt.setString(2, request.getParameter("SECTION_NUM"));
                    pstmt.setInt(3, (Integer.parseInt(request.getParameter("SECTION_MAX"))));
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

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                ResultSet classSet = getClassStmt.executeQuery("SELECT id, CLASS_TITLE AS nameOfClass FROM CLASS");
//                ResultSet rs = statement.executeQuery
//                        ("SELECT * FROM SECTION");
            %>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
                <tr>
                    <th>CLASS ID</th>
                    <th>SECTION ID</th>
                    <th>SECTION MAX</th>
                </tr>
                <tr>
                    <form action="class-sections.jsp" method="get">
                        <input type="hidden" value="insert" name="action">
                        <td><select name="CLASS_ID">
                            <%
                                while(classSet.next())
                                {
                                    System.out.println(classSet.getString("nameOfClass"));
                            %>
                            <option value="<%=classSet.getString("id")%>">
                                <%=classSet.getString("nameOfClass") + "-"+classSet.getString("id")%>
                            </option>
                            <%
                                }
                            %>
                        </select></td>
                        <th><input value="" name="SECTION_NUM" size="10"></th>
                        <th><input value="" name="SECTION_MAX" size="10"></th>
                        <th><input type="submit" value="Insert"></th>
                    </form>
                </tr>

                <%-- -------- Iteration Code -------- --%>

                <%--<tr>--%>
                    <%--<form action="class-sections.jsp" method="get">--%>
                        <%--<input type="hidden" value="update" name="action">--%>


                        <%--&lt;%&ndash; Get the ID &ndash;%&gt;--%>
                        <%--<td>--%>
                            <%--<input value="<%=classSet.getString("nameOfClass")%>"--%>
                                   <%--name="CLASS_ID" size="10" readonly>--%>
                        <%--</td>--%>

                        <%--&lt;%&ndash; Get the SSN, which is a number &ndash;%&gt;--%>
                        <%--<td>--%>
                            <%--<input value="<%= rs.getString("SECTION_NUM") %>"--%>
                                   <%--name="SECTION_ID" size="10">--%>
                        <%--</td>--%>

                        <%--<td>--%>
                            <%--<input value="<%= rs.getInt("SECTION_MAX") %>"--%>
                                   <%--name="SECTION_MAX" size="10">--%>
                        <%--</td>--%>


                        <%--&lt;%&ndash; Button &ndash;%&gt;--%>
                        <%--<td>--%>
                            <%--<input type="submit" value="Update">--%>
                        <%--</td>--%>
                    <%--</form>--%>
                <%--</tr>--%>


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



