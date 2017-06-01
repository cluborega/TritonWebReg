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
                            ("jdbc:sqlserver://localhost:1433;databaseName=CSE132B",
                                    "sa", "Firewall1");
                } catch (SQLException e){
                    e.printStackTrace();
                }
            %>


            <%
                String ssn = URLDecoder.decode(request.getParameter("action"), "UTF-8");
                Statement statement = conn.createStatement();
                ResultSet rs = null;
                if(ssn != null){

                    if(conn == null){
                        System.out.println("Connection with db not established.");
                    }

                    try{
                        System.out.println(ssn);
                        rs = statement.executeQuery(
                                "SELECT DEPARTMENT, COURSENUMBER, CLASS_TITLE,QUARTER, CLASS_YEAR, CT.UNITS_TAKEN, CT.GRADE_RECEIVED,GC.NUMBER_GRADE FROM CLASSESTAKEN CT\n" +
                                        "JOIN CLASS CL ON CT.CLASS_ID = CL.ID\n" +
                                        "JOIN COURSE_WITHCLASS CWC ON CWC.CLASS_ID = CL.ID\n" +
                                        "JOIN COURSE CR ON CWC.COURSE_ID = CR.ID\n" +
                                        "JOIN STUDENT S ON S.STUDENT_ID=CT.STUDENT_ID\n" +
                                        "LEFT OUTER JOIN GRADE_CONVERSION GC ON CT.GRADE_RECEIVED = GC.LETTER_GRADE\n" +
                                        "WHERE\n" +
                                        "S.SSN ="+ssn +
                                        "ORDER BY CLASS_YEAR, QUARTER, CLASS_TITLE");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }


                }
            %>



            <table border = '1'>
                <tr>
                    <td>DEPARTMENT</td>
                    <td>COURSENUMBER</td>
                    <td>CLASS TITLE</td>
                    <td>QUARTER</td>
                    <td>CLASS YEAR</td>
                    <td>UNITS</td>
                    <td>GRADE_RECEIVED</td>
                </tr>

                <%
                    String curr_quarter=null;
                    String curr_year=null;
                    double quarter_gpa = 0;
                    double quarter_unit=0;
                    double total_unit=0.0;
                    double total_gpa=0;
                    double gpa=0;
                    double q_gpa=0;
                %>

                <%
                    while(rs.next() && rs != null){
                        String  department=null;
                        String coursenumber=null;
                        String class_title=null;
                        String quarter=null;
                        String class_yr=null;
                        int units = 0;
                        String grade=null;
                        double num_grade = 0.0;


                        try{
                            department= rs.getString("DEPARTMENT");
                            coursenumber= rs.getString("COURSENUMBER");
                            class_title = rs.getString("CLASS_TITLE");
                            quarter=rs.getString("QUARTER");
                            class_yr=rs.getString("CLASS_YEAR");
                            units=Integer.parseInt(rs.getString("UNITS_TAKEN"));
                            grade=rs.getString("GRADE_RECEIVED");
                            num_grade = Double.parseDouble(rs.getString("NUMBER_GRADE"));
                        } catch (SQLException e){
                            e.printStackTrace();
                        }

                        if(curr_quarter == null && curr_year==null){
                            curr_quarter = quarter;
                            curr_year = class_yr;
                            quarter_unit=quarter_unit + units;
                            quarter_gpa = quarter_gpa + (units * num_grade);
                            total_unit =total_unit + units;
                            total_gpa = total_gpa + (units * num_grade);
                %>

                <tr>
                    <td>
                        <%= department%>
                    </td>
                    <td>
                        <%=coursenumber%>
                    </td>
                    <td>
                        <%=class_title%>
                    </td>
                    <td>
                        <%=quarter%>
                    </td>
                    <td>
                        <%=class_yr%>
                    </td>
                    <td>
                        <%=units%>
                    </td>
                    <td>
                        <%=grade%>
                    </td>

                </tr>

                <%

                        } else if (curr_quarter.equals(quarter) && curr_year.equals(class_yr)){

                %>
                            <tr>
                              <td>
                                   <%= department%>
                              </td>
                              <td>
                                 <%=coursenumber%>
                              </td>
                              <td>
                                 <%=class_title%>
                              </td>
                              <td>
                                 <%=quarter%>
                              </td>
                              <td>
                                  <%=class_yr%>
                              </td>
                                <td>
                                  <%=units%>
                                 </td>
                                <td>
                                   <%=grade%>
                                 </td>

                             </tr>

                <%

                            quarter_unit=quarter_unit + units;
                            quarter_gpa = quarter_gpa + (units * num_grade);
                             total_unit =total_unit + units;
                            total_gpa = total_gpa + (units * num_grade);

                        } else if (curr_quarter != quarter || curr_year != class_yr) { %>

                            <tr>
                                <td>
                                    <p>Total units in <%=curr_quarter%> <%=curr_year%> = <%=quarter_unit%></p>
                                    <%
                                        q_gpa = quarter_gpa/quarter_unit;
                                    %>
                                    <p>Quarter GPA: <%=q_gpa%></p>
                                </td>
                            </tr>


                <%
                                curr_quarter = quarter;
                                curr_year = class_yr;
                                quarter_gpa = (units * num_grade);
                                quarter_unit = units;
                                total_unit =total_unit + units;
                                total_gpa = total_gpa + (units * num_grade);
                                System.out.println(quarter_unit);

                %>

                <tr>
                    <td>
                        <%= department%>
                    </td>
                    <td>
                        <%=coursenumber%>
                    </td>
                    <td>
                        <%=class_title%>
                    </td>
                    <td>
                        <%=quarter%>
                    </td>
                    <td>
                        <%=class_yr%>
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


                <%
                    }
                %>
                <tr>
                    <td>
                        <p>Total units in <%=curr_quarter%> <%=curr_year%> = <%=quarter_unit%></p>
                        <%
                            q_gpa = quarter_gpa/quarter_unit;
                        %>
                        <p>Quarter GPA: <%=q_gpa%></p>

                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Cumulative GPA Table</p>
                        <p>Total units taken: <%=total_unit%></p>
                        <%
                            gpa = total_gpa/total_unit;
                        %>
                        <p>Cumulative GPA: <%=gpa%></p>
                    </td>
                </tr>

            </table>


        </td>
    </tr>

</table>
</body>
</html>
