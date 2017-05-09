<%--
  Created by IntelliJ IDEA.
  User: Saath_Ashish
  Date: 5/7/2017
  Time: 1:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>

    <title>$Title$</title>
  </head>
  <body>
  <table border="1">
      <tr>
          <td valign="top">
          </td>
          <td>

              <%-- Set the scripting language to Java and --%>
              <%-- Import the java.sql package --%>
              <%@ page language="java" import="java.sql.*" %>
              <%@ page import="static java.sql.DriverManager.*" %>

              <%-- -------- Open Connection Code -------- --%>
              <%
                  try {
                      // Load Oracle Driver class file
                      registerDriver
                              (new com.microsoft.sqlserver.jdbc.SQLServerDriver());

                      Connection conn = getConnection
                              ("jdbc:sqlserver://localhost:1433;databaseName=cse132bTritonWebReg", "sa", "logme");

              %>

              <%-- -------- INSERT Code -------- --%>
              <%
                  String action = request.getParameter("action");
                  if (action != null && action.equals("Insert")) {

                      // Begin transaction
                      conn.setAutoCommit(false);

                      // Create the prepared statement and use it to
                      // INSERT the student attributes INTO the Student table.
                      PreparedStatement pstmt = conn.prepareStatement(
                              "INSERT INTO STUDENT VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

                      pstmt.setInt(1, Integer.parseInt(request.getParameter("SSN")));
                      pstmt.setString(2, request.getParameter("ID"));
                      pstmt.setString(3, request.getParameter("FIRSTNAME"));
                      pstmt.setString(4, request.getParameter("MIDDLENAME"));
                      pstmt.setString(5, request.getParameter("LASTNAME"));
                      pstmt.setString(6, request.getParameter("RESIDENCY"));
                      pstmt.setString(7, request.getParameter("STATUS"));
                      pstmt.setString(8, request.getParameter("ENROLL"));
                      int rowCount = pstmt.executeUpdate();

                      // Commit transaction
                      conn.commit();
                      conn.setAutoCommit(true);
                  }
              %>

              <%-- -------- UPDATE Code -------- --%>


              <%-- -------- DELETE Code -------- --%>


              <!-- Add an HTML table header row to format the results -->
              <table border="1">
                  <tr>
                      <th>SSN</th>
                      <th>ID</th>
                      <th>First</th>
                      <th>Middle</th>
                      <th>Last</th>
                      <th>Residency</th>
                      <th>Action</th>
                  </tr>
                  <tr>
                      <form action="index.jsp" method="get">
                          <input type="hidden" value="insert" name="action">
                          <th><input value="" name="SSN" size="10" title="enterssn"></th>
                          <th><input value="" name="ID" size="10" title="enterstuid"></th>
                          <th><input value="" name="FIRSTNAME" size="15" title="enterFname"></th>
                          <th><input value="" name="MIDDLENAME" size="15" title="enterMname" ></th>
                          <th><input value="" name="LASTNAME" size="15" title="enterLname"></th>
                          <th><input value="" name="RESIDENCY" size="15" title="enterresidency"></th>
                          <th><input type="submit" value="Insert"></th>
                      </form>
                  </tr>

                  <%

                          // Close the Connection
                          conn.close();
                      } catch (SQLException sqle) {
                          out.println(sqle.getMessage());
                      } catch (Exception e) {
                          out.println(e.getMessage());
                      }
                  %>
              </table>
          </td>
      </tr>
  </table>
  </body>
</html>
