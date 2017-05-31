<%--
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
                String SSN = request.getParameter("action");
                Statement statement = conn.createStatement();
                ResultSet rs = null;

                if(SSN != null){
                    if(conn == null){
                        System.out.println("Connection with db not established.");
                    }

                    try{


                        rs = statement.executeQuery(
                                "SELECT C.CLASS_TITLE,COR.COURSENUMBER,C.QUARTER,C.CLASS_YEAR,E.UNITS_TAKING,S.SECTION_NUM FROM\n" +
                                        "CLASS C, SECTION S, SECTIONENROLLMENT E, STUDENT N,COURSE COR, COURSE_WITHCLASS CWC WHERE N.SSN ="+ SSN +"AND N.STUDENT_ID = E.STUDENT_ID AND S.CLASS_ID = C.id AND\n" +
                                        "E.SECTION_ID = S.SECTION_NUM AND C.ID=CWC.CLASS_ID AND COR.ID = CWC.COURSE_ID\n" +
                                        "ORDER BY COURSENUMBER" );

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }


                }

            %>

            <table border = '1'>
                <tr>
                    <td>Class_Title</td>
                    <td>Course Number</td>
                    <td>Quarter</td>
                    <td>Class_Year</td>
                    <td>Section</td>
                    <td>Units</td>
                </tr>

                <%
                    while(rs.next() && rs != null){
                        String ct=null;
                        String cn=null;
                        String quarter=null;
                        String cye=null;
                        String section=null;
                        String units=null;

                        try{
                            ct = rs.getString("CLASS_TITLE");
                            cn = rs.getString("COURSENUMBER");
                            quarter = rs.getString("QUARTER");
                            cye=rs.getString("CLASS_YEAR");
                            section=rs.getString("SECTION_NUM");
                            units=rs.getString("UNITS_TAKING");
                        } catch (SQLException e){
                            e.printStackTrace();
                        }
                %>

                <tr>
                    <td>
                        <%=ct%>
                    </td>
                    <td>
                        <%=cn%>
                    </td>
                    <td>
                        <%=quarter%>
                    </td>
                    <td>
                        <%=cye%>
                    </td>
                    <td>
                        <%=section%>
                    </td>
                    <td>
                        <%=units%>
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
