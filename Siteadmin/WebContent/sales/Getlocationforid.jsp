<%@ include file="conn.jsp" %>
<%!
Connection conn;
%>
<% 

try {
String ID=request.getParameter("UserID");

//Class.forName(MM_dbConn_DRIVER);
//Connection con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
String sql4="";
Statement stmt3 = conn.createStatement();
ResultSet rs4 = null;
sql4="SELECT * FROM t_subuser where UserId  ='"+ID+"'";
//System.out.println(sql4);
rs4 = stmt3.executeQuery(sql4);
out.println("<table>");

  while(rs4.next())
  {
	  out.println("<tr>");
	  out.println("<td>");
	  out.println(rs4.getString("Location"));
	  out.println("</td>");
	  out.println("</tr>");
  }
  out.println("</table>");
} catch(Exception e) {out.println(e);}

finally
{
conn.close();
}
%>

