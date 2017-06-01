<<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 5/31/2017
  Time: 10:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
            <%@ page import="java.net.URLDecoder" %>

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
                String title = URLDecoder.decode(request.getParameter("action"), "UTF-8");
                Statement statement = conn.createStatement();
                ResultSet rs = null;
                if(title != null){

                    if(conn == null){
                        System.out.println("Connection with db not established.");
                    }

                    try{
                        System.out.println(title);
                        rs = statement.executeQuery(
                                "SELECT S.SSN,S.STUDENT_ID, S.FIRSTNAME,S.MIDDLENAME,S.LASTNAME, E.UNITS_TAKING,E.GRADE_OPTION\n" +
                                        "FROM STUDENT S, CLASS C, SECTIONENROLLMENT E, SECTION SC WHERE\n" +
                                        "E.SECTION_ID = SC.SECTION_NUM AND SC.CLASS_ID = C.id AND C.CLASS_TITLE = '"+ title+"'" +" AND \n" +
                                        "C.QUARTER = 'SP' AND C.CLASS_YEAR = '2017' AND E.STUDENT_ID = S.STUDENT_ID");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }


                }
                %>

            <h1><%=title%></h1>

            <table border = '1'>
                <tr>
                    <td>SSN</td>
                    <td>STUDENT ID</td>
                    <td>FIRST NAME</td>
                    <td>MIDDLE NAME</td>
                    <td>LAST NAME</td>
                    <td>UNITS</td>
                    <td>GRADE_OPTION</td>
                </tr>

                <%
                    while(rs.next() && rs != null){
                        String ssn=null;
                        String pid=null;
                        String fname=null;
                        String mname=null;
                        String lname=null;
                        String units=null;
                        String grade=null;

                        try{
                            ssn = rs.getString("SSN");
                            pid = rs.getString("STUDENT_ID");
                            fname = rs.getString("FIRSTNAME");
                            mname=rs.getString("MIDDLENAME");
                            lname=rs.getString("LASTNAME");
                            units=rs.getString("UNITS_TAKING");
                            grade=rs.getString("GRADE_OPTION");
                        } catch (SQLException e){
                            e.printStackTrace();
                        }
                %>

                <tr>
                    <td>
                        <%= ssn%>
                    </td>
                    <td>
                        <%=pid%>
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
                        <%=units%>
                    </td>
                    <td>
                        <%=grade%>
                    </td>

                </tr>
                <%
                    }
                %>
            </table>


        </td>
    </tr>

</table>
</body>
</html>
