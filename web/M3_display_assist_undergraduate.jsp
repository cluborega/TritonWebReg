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
            <h3>Undergraduate Degree Assist </h3>
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
                String SSN = request.getParameter("student");
                String degree_name = URLDecoder.decode(request.getParameter("degree"),"UTF-8");
                Statement statement = conn.createStatement();
                ResultSet rs = null;

                int total_unit = 0;
                int ldunit=0;
                int udunit=0;
                int teunit=0;
                int totalremaining=0;
                int totaltaken=0;
                int lowerdiv=0;
                int upperdiv=0;
                int techelec=0;


                if(SSN != null && degree_name!= null ){
                    if(conn == null){
                        System.out.println("Connection with db not established.");
                    }

                    try {

                        rs = statement.executeQuery("SELECT DEGREE_NAME,REQ_UNITS_TOTAL,REQ_UNITS_UP,REQ_UNITS_LD,REQ_UNITS_TE FROM DEGREE WHERE DEGREE_NAME='"+degree_name+"' AND DEGREE_TYPE='BS'");
                    } catch (SQLException e){
                        e.printStackTrace();
                    }



                    while(rs.next()){
                        try {
                            total_unit = rs.getInt("REQ_UNITS_TOTAL");
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        ldunit = rs.getInt("REQ_UNITS_LD");
                        udunit= rs.getInt("REQ_UNITS_UP");
                        teunit = rs.getInt("REQ_UNITS_TE");
                    }


                    rs.close();

                    try{


                        rs = statement.executeQuery(
                                "SELECT DEGREE_NAME, CATEGORY.CATEGORY_NAME, CATEGORY.REQ_UNITS ,SUM(UNITS_TAKEN)AS UNITS_TAKEN FROM DEGREE D\n" +
                                        "JOIN COURSECATEGORY CATEGORY ON CATEGORY.DEGREE_ID = D.ID\n" +
                                        "JOIN COURSE COR ON COR.ID = CATEGORY.COURSE_ID\n" +
                                        "JOIN COURSE_WITHCLASS CWC ON CWC.COURSE_ID = COR.ID\n" +
                                        "JOIN CLASS CL ON CWC.CLASS_ID = CL.ID\n" +
                                        "LEFT OUTER JOIN CLASSESTAKEN CT ON CT.CLASS_ID = CL.ID\n" +
                                        "JOIN STUDENT S ON S.STUDENT_ID = CT.STUDENT_ID\n" +
                                        "WHERE DEGREE_NAME ='"+degree_name +"' AND DEGREE_TYPE='BS' AND (GRADE_RECEIVED NOT IN('D','F','IN','U') OR GRADE_RECEIVED IS NULL) AND S.SSN = "+ SSN +
                                        "GROUP BY DEGREE_NAME,CATEGORY_NAME, DEGREE_TYPE, CATEGORY.REQ_UNITS" );

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
                }

            %>



            <table border = '1'>
                <tr>
                    <td>DEGREE NAME</td>
                    <td>CATEGORY</td>
                    <td>REQUIRED UNITS</td>
                    <td>TAKEN UNITS</td>
                    <td>REMAINING UNITS</td>

                </tr>

                <%
                    while(rs.next() && rs != null){
                        String dname=null;
                        String cat=null;
                        int requnit = 0;
                        int takenunit=0;


                        try{
                            dname = rs.getString("DEGREE_NAME");
                            cat = rs.getString("CATEGORY_NAME");
                            requnit = rs.getInt("REQ_UNITS");

                            takenunit = rs.getInt("UNITS_TAKEN");
                            if (cat.equals("LD")){
                                lowerdiv = takenunit;
                            } else if(cat.equals("UD")){
                                upperdiv = takenunit;
                            } else if(cat.equals("TE")){
                                techelec = takenunit;
                            }
                            totaltaken = totaltaken + takenunit;


                        } catch (SQLException e){
                            e.printStackTrace();
                        }
                %>

                <tr>
                    <td>
                        <%=dname%>
                    </td>
                    <td>
                        <%=cat%>
                    </td>
                    <td>
                        <%=requnit%>
                    </td>
                    <td>
                        <%=takenunit%>
                    </td>
                    <td>
                        <%=(requnit-takenunit)%>
                    </td>
                 </tr>
                <%
                    }
                %>

                <tr>
                    <td>
                        <p>Total req. unit: <%=total_unit%></p>
                        <p>Total Completed unit: <%=totaltaken%></p>
                        <p>Total Remaining unit: <%=(total_unit - totaltaken)%></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Total req. Lower Division unit: <%=ldunit%></p>
                        <p>Total completed LD unit: <%=lowerdiv%></p>
                        <p>Total remaining unit: <%=ldunit-lowerdiv%></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Total req. Upper Div unit: <%=udunit%></p>
                        <p>Total completed UD unit: <%=upperdiv%></p>
                        <p>Total Remaining unit: <%=udunit-upperdiv%></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Total req. Tech Elective unit: <%=teunit%></p>
                        <p>Total completed TE unit: <%=techelec%></p>
                        <p>Total Remaining Unit: <%=teunit-techelec%></p>
                    </td>
                </tr>
            </table>


        </td>
    </tr>

</table>
</body>
</html>
