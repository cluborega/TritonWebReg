<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/31/2017
  Time: 12:37 PM
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
            <%@ page import="java.net.URLEncoder" %>

            <%-- Open connection with DB --%>
            <%
                Connection conn = null;
                try {
                    DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                    conn = DriverManager.getConnection
                            ("jdbc:sqlserver://localhost:1433;databaseName=TEST",
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
                            "SELECT DISTINCT SSN,S.STUDENT_ID,FIRSTNAME,MIDDLENAME,LASTNAME FROM STUDENT S, CLASSESTAKEN CT \n" +
                                    "WHERE CT.STUDENT_ID=S.STUDENT_ID\n" +
                                    "ORDER BY SSN");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>

            <table border = '1'>
                <form action="M3_display_grade_report_of_x.jsp" method="post">
                    <tr>
                        <td>Select</td>
                        <td>SSN</td>
                        <td>STUDENT_ID</td>
                        <td>FIRSTNAME</td>
                        <td>LASTNAME</td>
                    </tr>

                    <%
                        while(rs.next() && rs!=null){
                            String ssn=null;
                            String student_id=null;
                            String fname=null;
                            String lname=null;



                            try{
                                ssn = rs.getString("SSN");
                                student_id = rs.getString("STUDENT_ID");
                                fname= rs.getString("FIRSTNAME");
                                lname=rs.getString("LASTNAME");

                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                    %>

                    <tr>
                        <td>
                            <input type="radio" value=<%= ssn%> name="action">
                        </td>
                        <td>
                            <%= ssn%>
                        </td>
                        <td>
                            <%=student_id%>
                        </td>
                        <td>
                            <%=fname%>
                        </td>
                        <td>
                            <%=lname%>
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
