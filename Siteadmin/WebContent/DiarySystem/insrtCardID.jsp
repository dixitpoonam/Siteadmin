<%@ include file="headerhtml.jsp" %>
<%!
Connection conn1;
%>
<% 

try {
	
	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = conn1.createStatement();
	Statement stmt2 = conn1.createStatement();

//ResultSet rs2=null;
ResultSet rs1=null;
ResultSet rs2=null;
String sql1="";

String username=session.getAttribute("username").toString();
String cardid=request.getParameter("id");
String cardref=request.getParameter("ref");


String sql2 = "Select CardID from t_cardid where CardID ='"+cardid+"'";
rs1 = stmt1.executeQuery(sql2);

String sql3 = "Select CardRefNo from t_cardid where CardRefNo ='"+cardref+"'";
rs2 = stmt2.executeQuery(sql3);

if(rs1.next())
{
	response.sendRedirect("cardidEntry.jsp?inserted="+cardid+" is Duplicate CardID");

}
else if(rs2.next())
{
		response.sendRedirect("cardidEntry.jsp?inserted="+cardref+" is Duplicate CardRefNo");
		
}
else
{
    sql1="insert into t_cardid (CardID,CardRefNo,EntBy) values ('"+cardid+"','"+cardref+"','"+username+"')";
    stmt1.executeUpdate(sql1);
}
response.sendRedirect("cardidEntry.jsp?inserted=successfull");
return; 

}catch(Exception e) { out.println("Exception----->"+e);e.printStackTrace(); }finally{conn1.close();}
%>
<%@ include file="footerhtml.jsp" %>