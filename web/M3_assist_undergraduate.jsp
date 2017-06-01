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
            <h3> Select Student and Degree Type </h3>
            <%@ page language="java" import="java.sql.*" %>
            <%@ page import="java.net.URLEncoder" %>

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
                            "SELECT DISTINCT SSN, S.FIRSTNAME,S.MIDDLENAME,S.LASTNAME FROM STUDENT S,DEGREE D, UNDERGRADUATE U,SECTIONENROLLMENT SE WHERE\n" +
                                    "U.UNDERGRADUATE_ID = S.STUDENT_ID AND S.STUDENT_ID = SE.STUDENT_ID AND U.MAJOR = D.DEGREE_NAME");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>

            <table border = '1'>
                <form action="M3_display_assist_undergraduate.jsp" method="post">
                    <tr>
                        <td>Select</td>
                        <td>SSN</td>
                        <td>First Name</td>
                        <td>Middle Name</td>
                        <td>Last Name</td>

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

                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                    %>

                    <tr>
                        <td>
                            <input type="radio" value=<%=ssn%> name="student">
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


                    </tr>
                    <%
                        }

                    %>
                    <tr><td></td></tr><tr><td></td></tr>

                    <tr>
                        <th>Select Degree</th>
                        <th>Degree Type</th>
                        <th>Degree Name</th>
                    </tr>
                    <%
                        rs.close();
                        try{
                            rs = statement.executeQuery("SELECT DEGREE_TYPE, DEGREE_NAME FROM DEGREE WHERE DEGREE_TYPE ='BS'");
                        } catch (SQLException e){
                            e.printStackTrace();
                        }

                        while(rs.next() && rs!=null){
                            String degree_type=null;
                            String degree_name = null;

                            try{
                                degree_type = rs.getString("DEGREE_TYPE");
                                degree_name = rs.getString("DEGREE_NAME");
                            }catch (SQLException e) {
                                e.printStackTrace();
                            }

                    %>

                        <tr>
                            <td>
                                <input type="radio" value=<%=URLEncoder.encode(degree_name, "UTF-8")%> name="degree">
                            </td>
                            <td>
                                <%=degree_type%>
                            </td>
                            <td>
                                <%=degree_name%>
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
