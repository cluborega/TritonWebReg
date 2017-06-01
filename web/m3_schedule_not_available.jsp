<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 6/1/2017
  Time: 6:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Courses Unavailable to enroll</title>
</head>
<body>

<table border = '1'>
    <tr>
        <td valign="top">
            <jsp:include page="menu.html"></jsp:include>
        </td>
        <td valign = 'top'>
            <h3>Grade Distribution </h3>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.net.URLEncoder" %>

            <%-- Open connection with DB --%>
                <%
                    String student_ssn = request.getParameter("student_ssn");
                    Connection conn = null;
                    try {
                        DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                        conn = DriverManager.getConnection
                                ("jdbc:sqlserver://localhost:1433;databaseName=CSE132B",
                                        "sa", "Firewall1");
                    } catch (SQLException e){
                        e.printStackTrace();
                    }
                %>

                <%
                    if(conn == null){
                        System.out.println("Connection with db not eastablished.");
                    }
                    Statement statement = null;
                    if (conn != null) {
                        try {
                            statement = conn.createStatement();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }

                    ResultSet rs = null;
                    if (student_ssn==null) {
                        rs = statement.executeQuery("SELECT DISTINCT st.SSN AS student_ssn, st.STUDENT_ID AS st_num, FIRSTNAME, MIDDLENAME, LASTNAME\n" +
                                " FROM Student st\n" +
                                " JOIN SECTIONENROLLMENT se ON st.STUDENT_ID = se.STUDENT_ID\n" +
                                " JOIN SECTION s ON se.SECTION_ID = s.id\n" +
                                " JOIN CLASS c ON s.CLASS_ID = c.id\n" +
                                " WHERE c.quarter = 'SP'\n" +
                                " AND c.class_year = '2017'\n" +
                                " ORDER BY st.STUDENT_ID ASC;");
                %>

            <form action="m3_schedule_not_available.jsp" method="POST">
                <select name="student_ssn" required>
                    <option selected disabled>Select Student</option>
                    <%
                        while (rs.next()) {
                            String studentDetails = rs.getString("student_ssn") + " - " + rs.getString("FIRSTNAME") + " " +
                                    rs.getString("MIDDLENAME") + " " + rs.getString("LASTNAME");
                    %>
                    <option value="<%=rs.getString("student_ssn")%>"><%=studentDetails%></option>
                    <%
                        }
                    %>
                </select>
                <input type="submit" value="Submit">
            </form>

            <%
                }
            %>
        </td>
    </tr>
</table>

</body>
</html>
