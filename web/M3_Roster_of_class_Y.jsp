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
                            "SELECT CLASS_TITLE, COURSENUMBER, QUARTER, CLASS_YEAR FROM COURSE C, CLASS CL, COURSE_WITHCLASS CWC WHERE\n" +
                                    "CL.QUARTER='SP' AND CL.CLASS_YEAR='2017' AND CL.ID = CWC.CLASS_ID AND CWC.COURSE_ID = C.ID");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }
            %>

            <table border = '1'>
                <form action="M3_display_roster_of_class_y.jsp" method="post">
                    <tr>
                        <td>Select</td>
                        <td>TITLE</td>
                        <td>COURSE NUMBER</td>
                        <td>QUARTER</td>
                        <td>CLASS_YEAR</td>
                    </tr>

                    <%
                        while(rs.next() && rs!=null){
                            String title=null;
                            String coursenumber=null;
                            String quarter=null;
                            String classyr=null;
                            String urltitle=null;


                            try{
                                title = rs.getString("CLASS_TITLE");
                                coursenumber = rs.getString("COURSENUMBER");
                                quarter = rs.getString("QUARTER");
                                classyr=rs.getString("CLASS_YEAR");

                            } catch (SQLException e){
                                e.printStackTrace();
                            }
                    %>

                    <tr>
                        <td>
                            <input type="radio" value=<%= URLEncoder.encode(title, "UTF-8")%> name="action">
                        </td>
                        <td>
                            <%= title%>
                        </td>
                        <td>
                            <%=coursenumber%>
                        </td>
                        <td>
                            <%=quarter%>
                        </td>
                        <td>
                            <%=classyr%>
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
