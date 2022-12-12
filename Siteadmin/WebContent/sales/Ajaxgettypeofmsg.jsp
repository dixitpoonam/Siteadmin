<%@ include file="conn.jsp" %>
<%!
Connection conn;
%>
<%
try {
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=conn.createStatement();
ResultSet rs1=null;
String sql1="";
String trans=request.getParameter("trans");

sql1="select * from t_usermessage where UserTypeValue='"+trans+"' ";
//out.println(sql1);
rs1=stmt1.executeQuery(sql1);

if(rs1.next())
{
  out.print(rs1.getString("MessageId"));
}
else
{
	out.print("Not Available");
}


} catch(Exception e) {out.println(e);}

finally
{
conn.close();
}

%>





