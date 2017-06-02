<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/31/2017
  Time: 9:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>students currently enrolled</title>
</head>
<body>
<table border = '1'>
    <tr>
        <td valign="top">
            <jsp:include page="menu.html"></jsp:include>
        </td>
        <td valign = 'top'>
            <h3>List of Students currently enrolled </h3>
             <%@ page language="java" import="java.sql.*" %>

            <%-- Open connection with DB --%>
            <%
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
                Statement statement = conn.createStatement();
                ResultSet rs = null;
                try{


                    rs = statement.executeQuery(
                            "SELECT DISTINCT SSN,FIRSTNAME,MIDDLENAME, LASTNAME, S.STUDENT_ID from STUDENT S, SECTIONENROLLMENT SE WHERE\n" +
                                    "SE.STUDENT_ID = S.STUDENT_ID\n" +
                                    "ORDER BY SSN");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>

            <table border = '1'>
                <form action="M3_display_current_classes_by_X.jsp" method="post">
                    <tr>
                        <td>Select</td>
                        <td>SSN</td>
                        <td>First Name</td>
                        <td>Middle Name</td>
                        <td>Last Name</td>
                        <td>Student ID</td>
                    </tr>

                    <%
                        while(rs.next() && rs!=null){
                            String ssn=null;
                            String fname=null;
                            String mname=null;
                            String lname=null;
                            String sid=null;

                            try{
                               ssn = rs.getString("SSN");
                               fname = rs.getString("FIRSTNAME");
                               mname = rs.getString("MIDDLENAME");
                               lname=rs.getString("LASTNAME");
                               sid=rs.getString("STUDENT_ID");
                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                    %>

                    <tr>
                        <td>
                            <input type="radio" value=<%=ssn%> name="action">
                        </td>
                        <td>
                            <%=ssn%>
                        </td>
                        <td>
                            <%=fname%>
                        </td>
                        <td>
                            <%=mname%>
                        </td>
                        <td>
                            <%=lname%>
                        </td>
                        <td>
                            <%=sid%>
                        </td>

                    </tr>
                    <%
                        }
                    %>

                    <tr>
                        <td>
                            <input type="submit", name="submit" value="Display">
                        </td>

                    </tr>

                </form>

            </table>


        </td>
    </tr>

</table>
</body>
</html>
