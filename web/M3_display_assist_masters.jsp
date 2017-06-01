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
            <h3>Masters Degree Assist </h3>
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




                if(SSN != null && degree_name!= null ){
                    if(conn == null){
                        System.out.println("Connection with db not established.");
                    }

                    try{
                        statement.executeUpdate("IF OBJECT_ID ('#VIEW_UNITS','U') IS NOT NULL DROP TABLE #VIEW_UNITS");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        statement.executeUpdate("IF OBJECT_ID ('#VIEW_GPA','U') IS NOT NULL DROP TABLE #VIEW_GPA");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        statement.executeUpdate("CREATE TABLE #VIEW_UNITS (\n" +
                                "\tDEGREE_NAME VARCHAR(20),\n" +
                                "\tCONCERNTRATION_NAME VARCHAR(20),\n" +
                                "\tREQ_UNITS INTEGER,\n" +
                                "\tMINGPA   NUMERIC (3,2),\n" +
                                "\tTAKEN_UNITS INTEGER\n" +
                                ")");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        statement.executeUpdate("INSERT INTO #VIEW_UNITS(\n" +
                                "\tDEGREE_NAME ,\n" +
                                "\tCONCERNTRATION_NAME,\n" +
                                "\tREQ_UNITS ,\n" +
                                "\tMINGPA ,\n" +
                                "\tTAKEN_UNITS \n" +
                                ") \n" +
                                "SELECT DEGREE_NAME,CONCERNTRATION_NAME,CC.REQ_UNITS AS REQ_UNITS,MINGPA,SUM(UNITS_TAKEN) AS TAKEN_UNITS\n" +
                                "FROM DEGREE D \n" +
                                "JOIN COURSECONCERNTRATION CC ON D.id = CC.DEGREE_ID\n" +
                                "JOIN COURSE CR ON CR.id = CC.COURSE_ID\n" +
                                "JOIN COURSE_WITHCLASS CWC ON CWC.COURSE_ID = CR.id\n" +
                                "JOIN CLASS CL ON CL.id = CWC.CLASS_ID\n" +
                                "LEFT OUTER JOIN CLASSESTAKEN CT ON CT.CLASS_ID = CL.id\n" +
                                "JOIN STUDENT S ON CT.STUDENT_ID = S.STUDENT_ID\n" +
                                "WHERE\n" +
                                "DEGREE_NAME='"+degree_name+"' AND DEGREE_TYPE = 'MS' AND S.SSN="+ SSN +" AND\n" +
                                "(GRADE_RECEIVED NOT IN ('IN'))\n" +
                                "GROUP BY DEGREE_NAME, DEGREE_TYPE,CONCERNTRATION_NAME,CC.REQ_UNITS,MINGPA");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        statement.executeUpdate("CREATE TABLE #VIEW_GPA (\n" +
                                "\tDEGREE_TYPE VARCHAR (5),\n" +
                                "\tDEGREE_NAME VARCHAR(20),\n" +
                                "\tCONCERNTRATION_NAME VARCHAR(20),\n" +
                                "\tREQ_UNITS INTEGER,\n" +
                                "\tMINGPA NUMERIC(3,2),AVGGPA NUMERIC(3,2)\n" +
                                ")");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        statement.executeUpdate("INSERT INTO #VIEW_GPA(\n" +
                                "\tDEGREE_TYPE,\n" +
                                "\tDEGREE_NAME ,\n" +
                                "\tCONCERNTRATION_NAME,\n" +
                                "\tREQ_UNITS ,\n" +
                                "\tMINGPA ,\n" +
                                "\tAVGGPA\n" +
                                ") \n" +
                                "SELECT DEGREE_TYPE,DEGREE_NAME,CONCERNTRATION_NAME,CC.REQ_UNITS AS REQ_UNITS,MINGPA,SUM(NUMBER_GRADE)/COUNT(CT.id) AS AVGGPA\n" +
                                "FROM DEGREE D \n" +
                                "JOIN COURSECONCERNTRATION CC ON D.id = CC.DEGREE_ID\n" +
                                "JOIN COURSE CR ON CR.id = CC.COURSE_ID\n" +
                                "JOIN COURSE_WITHCLASS CWC ON CWC.COURSE_ID = CR.id\n" +
                                "JOIN CLASS CL ON CL.id = CWC.CLASS_ID\n" +
                                "LEFT OUTER JOIN CLASSESTAKEN CT ON CT.CLASS_ID = CL.id\n" +
                                "JOIN STUDENT S ON CT.STUDENT_ID = S.STUDENT_ID\n" +
                                "LEFT OUTER JOIN GRADE_CONVERSION G ON CT.GRADE_RECEIVED = G.LETTER_GRADE\n" +
                                "WHERE\n" +
                                "DEGREE_NAME='"+degree_name+"'AND DEGREE_TYPE = 'MS' AND S.SSN="+SSN+" AND\n" +
                                "(GRADE_RECEIVED NOT IN ('IN','U','S'))\n" +
                                "GROUP BY DEGREE_NAME, DEGREE_TYPE,CONCERNTRATION_NAME,CC.REQ_UNITS,MINGPA");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }

                    try{
                        rs = statement.executeQuery("SELECT TEMP1.DEGREE_NAME,TEMP1.CONCERNTRATION_NAME,TEMP1.REQ_UNITS,TEMP1.MINGPA,\n" +
                                "TEMP1.TAKEN_UNITS,TEMP2.AVGGPA  FROM #VIEW_UNITS TEMP1 , #VIEW_GPA TEMP2 WHERE\n" +
                                "TEMP1.DEGREE_NAME = TEMP2.DEGREE_NAME AND TEMP1.CONCERNTRATION_NAME=TEMP2.CONCERNTRATION_NAME AND\n" +
                                "TEMP1.MINGPA = TEMP2.MINGPA AND TEMP1.REQ_UNITS = TEMP2.REQ_UNITS");

                    }
                    catch (SQLException e){
                        e.printStackTrace();
                    }
            %>



                <table border = '1'>
                    <tr>

                        <td>Degree Name</td>
                        <td>Concerntration Name</td>
                        <td>Required Units</td>
                        <td>Min Gpa</td>
                        <td>Taken Units</td>
                        <td>Average Gpa</td>
                        <td>Status</td>
                     </tr>
            <%


                    while(rs.next()){
                        String degreename = rs.getString("DEGREE_NAME");
                        String conc_name = rs.getString("CONCERNTRATION_NAME");
                        int req_units = rs.getInt("REQ_UNITS");
                        double mingpa = rs.getDouble("MINGPA");
                        int taken_units = rs.getInt("TAKEN_UNITS");
                        double avggpa = rs.getDouble("AVGGPA");
                        String check=null;
                        if(avggpa >= mingpa && taken_units>=req_units){
                            check="Complete";
                        } else {
                            check = "Not Complete";
                        }

            %>
                 <tr>
                     <td><%=degreename%></td>
                     <td><%=conc_name%></td>
                     <td><%=req_units%></td>
                     <td><%=mingpa%></td>
                     <td><%=taken_units%></td>
                     <td><%=avggpa%></td>
                     <td><%=check%></td>
                </tr>
            <%


                    }

                try{
                    statement.executeUpdate("IF OBJECT_ID ('#VIEW_DONE','U') IS NOT NULL DROP TABLE #VIEW_DONE");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("CREATE TABLE #VIEW_DONE (\n" +
                            "\tDEPARTMENT VARCHAR(40),\n" +
                            "\tCONCERNTRATION_NAME VARCHAR(40),\n" +
                            "\tCOURSENUMBER VARCHAR(40),\n" +
                            "\tCLASS_TITLE VARCHAR(40),\n" +
                            ")");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("IF OBJECT_ID ('#VIEW_NOTDONE','U') IS NOT NULL DROP TABLE #VIEW_NOTDONE");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("CREATE TABLE #VIEW_NOTDONE (\n" +
                            "\tDEPARTMENT VARCHAR(40),\n" +
                            "\tCONCERNTRATION_NAME VARCHAR(40),\n" +
                            "\tCOURSENUMBER VARCHAR(40),\n" +
                            "\tCLASS_TITLE VARCHAR(40)\n" +
                            ")");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }



                try{
                    statement.executeUpdate("IF OBJECT_ID ('#VIEW_OFFER','U') IS NOT NULL DROP TABLE #VIEW_OFFER");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("CREATE TABLE #VIEW_OFFER (\n" +
                            "\tDEPARTMENT VARCHAR(40),\n" +
                            "\tCONCERNTRATION_NAME VARCHAR(40),\n" +
                            "\tCOURSENUMBER VARCHAR(40),\n" +
                            "\tCLASS_TITLE VARCHAR(40),\n" +
                            "\tQUARTER VARCHAR(20),\n" +
                            "\tYEAR CHAR(4)\n" +
                            ")");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }


                try{
                    statement.executeUpdate("\n" +
                            "INSERT INTO #VIEW_DONE(\n" +
                            "\tDEPARTMENT ,\n" +
                            "\tCONCERNTRATION_NAME,\n" +
                            "\tCOURSENUMBER ,\n" +
                            "\tCLASS_TITLE \n" +
                            ") \n" +
                            "SELECT DEPARTMENT,CONCERNTRATION_NAME,COURSENUMBER,CLASS_TITLE\n" +
                            "FROM DEGREE D \n" +
                            "JOIN COURSECONCERNTRATION CC ON D.id = CC.DEGREE_ID\n" +
                            "JOIN COURSE CR ON CR.id = CC.COURSE_ID\n" +
                            "JOIN COURSE_WITHCLASS CWC ON CWC.COURSE_ID = CR.id\n" +
                            "JOIN CLASS CL ON CL.id = CWC.CLASS_ID\n" +
                            "LEFT OUTER JOIN CLASSESTAKEN CT ON CT.CLASS_ID = CL.id\n" +
                            "JOIN STUDENT S ON CT.STUDENT_ID = S.STUDENT_ID\n" +
                            "WHERE\n" +
                            "DEGREE_NAME='"+degree_name+"' AND DEGREE_TYPE = 'MS' AND S.SSN="+SSN+" AND\n" +
                            "(GRADE_RECEIVED NOT IN ('IN','F'))\n" +
                            "ORDER BY DEPARTMENT,CONCERNTRATION_NAME,COURSENUMBER,CLASS_TITLE\n");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("INSERT INTO #VIEW_NOTDONE(\n" +
                            "\tDEPARTMENT ,\n" +
                            "\tCONCERNTRATION_NAME,\n" +
                            "\tCOURSENUMBER ,\n" +
                            "\tCLASS_TITLE \n" +
                            ") \n" +
                            "SELECT DISTINCT DEPARTMENT,CONCERNTRATION_NAME,COURSENUMBER,CLASS_TITLE\n" +
                            "FROM DEGREE D  \n" +
                            "JOIN COURSECONCERNTRATION CC ON D.id = CC.DEGREE_ID\n" +
                            "JOIN COURSE CR ON CR.id = CC.COURSE_ID\n" +
                            "JOIN COURSE_WITHCLASS CWC ON CWC.COURSE_ID = CR.id\n" +
                            "JOIN CLASS CL ON CL.id = CWC.CLASS_ID\n" +
                            "WHERE\n" +
                            "DEGREE_NAME='"+degree_name+"' AND DEGREE_TYPE = 'MS' AND NOT EXISTS(\n" +
                            "\tSELECT * FROM #VIEW_DONE VD WHERE\n" +
                            "\tVD.CLASS_TITLE = CL.CLASS_TITLE AND\n" +
                            "\tVD.CONCERNTRATION_NAME = CC.CONCERNTRATION_NAME AND\n" +
                            "\tVD.COURSENUMBER = CR.COURSENUMBER AND\n" +
                            "\tVD.DEPARTMENT = CR.DEPARTMENT \n" +
                            ")\n" +
                            "ORDER BY DEPARTMENT,CONCERNTRATION_NAME,COURSENUMBER,CLASS_TITLE");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }

                try{
                    statement.executeUpdate("INSERT INTO #VIEW_OFFER(\n" +
                            "\tDEPARTMENT ,\n" +
                            "\tCONCERNTRATION_NAME,\n" +
                            "\tCOURSENUMBER ,\n" +
                            "\tCLASS_TITLE,\n" +
                            "\tQUARTER,\n" +
                            "\tYEAR \n" +
                            ") \n" +
                            "SELECT \n" +
                            "VND.DEPARTMENT,VND.CONCERNTRATION_NAME,VND.COURSENUMBER,VND.CLASS_TITLE,\n" +
                            "CL.QUARTER,CL.CLASS_YEAR\n" +
                            "FROM #VIEW_NOTDONE VND \n" +
                            "JOIN COURSE CR ON CR.DEPARTMENT = VND.DEPARTMENT AND CR.COURSENUMBER = VND.COURSENUMBER\n" +
                            "JOIN CLASS CL ON CL.CLASS_TITLE = VND.CLASS_TITLE \n" +
                            "JOIN QUARTER QT ON CL.QUARTER = QT.QUARTER AND CL.CLASS_YEAR = QT.YEAR\n" +
                            "GROUP BY VND.CONCERNTRATION_NAME,VND.DEPARTMENT,VND.COURSENUMBER,VND.CLASS_TITLE,\n" +
                            "CL.QUARTER,CL.CLASS_YEAR,QT.ID HAVING MIN(QT.ID) > (SELECT ID FROM QUARTER WHERE QUARTER='SP' AND YEAR='2017')\n" +
                            "ORDER BY VND.CONCERNTRATION_NAME,VND.DEPARTMENT,VND.COURSENUMBER,VND.CLASS_TITLE,QT.ID\n");

                }
                catch (SQLException e){
                    e.printStackTrace();
                }


                try{

                    rs = statement.executeQuery("SELECT VND.DEPARTMENT,VND.CONCERNTRATION_NAME,VND.CLASS_TITLE,VO.QUARTER,VO.YEAR FROM #VIEW_NOTDONE VND, #VIEW_OFFER VO WHERE\n" +
                            "VND.CLASS_TITLE = VO.CLASS_TITLE AND\n" +
                            "VND.CONCERNTRATION_NAME = VO.CONCERNTRATION_NAME AND\n" +
                            "VND.COURSENUMBER = VO.COURSENUMBER AND \n" +
                            "VND.DEPARTMENT = VO.DEPARTMENT\n" +
                            "ORDER BY VND.CONCERNTRATION_NAME,VND.DEPARTMENT,VND.COURSENUMBER,VND.CLASS_TITLE");

                } catch (SQLException e){
                    e.printStackTrace();
                }


            %>      </table>

                    <h4>Future Class offerings</h4>
                    <table border="1">
                    <tr>
                        <th>Department</th>
                        <th>Concerntration Name</th>
                        <th>Class Title</th>
                        <th>Quarter</th>
                        <th>Year</th>
                    </tr>

                    <%

                    while(rs.next()){
                        %>
                        <tr>
                            <td><%=rs.getString("DEPARTMENT")%></td>
                            <td><%=rs.getString("CONCERNTRATION_NAME")%></td>
                            <td><%=rs.getString("CLASS_TITLE")%></td>
                            <td><%=rs.getString("QUARTER")%></td>
                            <td><%=rs.getString("YEAR")%></td>
                        </tr>

                    <%
                    }
                    %>
                    </table>
            <%



                }

            %>
        </td>
    </tr>

</table>
</body>
</html>
