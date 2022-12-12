<%@ include file="headerhtml.jsp" %>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#2696E8">
<%!
Connection conn;
%>
<% 

try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	Statement stmt1 = conn.createStatement();
ResultSet rs2=null;
String sql1="", sql2="", sql3="", sql4=""; 

String fn="", un="", pass="", add="", totinst="", typuser="",  mnthlyrent="", sla="";
int maxid=0;
fn=request.getParameter("fn");
un=request.getParameter("un");
pass=request.getParameter("pass");
add=request.getParameter("add");
totinst=request.getParameter("totinst"); 
typuser=request.getParameter("typeuser");
mnthlyrent=request.getParameter("monthlyrent");
sla=request.getParameter("sla");

java.util.Date d = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String s=formatter.format(d);

String year = new SimpleDateFormat("yyyy").format(d);
String expdate = year+"-12-31";

sql2="select max(UserId) as maxid from t_security";
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	maxid=rs2.getInt("maxid");
}
	maxid=maxid+1;	

sql1="insert into t_security (UserId,  UserName, FullName, Password, TypeofUser, TypeValue, Address, CreationDate,ExpiryDate) values ('"+maxid+"','"+un+"', '"+fn+"', '"+pass+"', '"+typuser+"', '"+fn+"', '"+add+"', '"+s+"','"+expdate+"') ";
System.out.print(sql1);
stmt1.executeUpdate(sql1);

sql3="insert into t_noofinstallations (UserId, Transporter, TotalInst, LeftInst) values ('"+maxid+"', '"+fn+"', '"+totinst+"', '"+totinst+"')";
System.out.print(sql3);
stmt1.executeUpdate(sql3);

sql4="insert into t_transporterbilldetails (OwnerName, SLA, Amount) values ('"+fn+"', '"+sla+"', '"+mnthlyrent+"')";
System.out.print(sql4);
stmt1.executeUpdate(sql4);

response.sendRedirect("adduser.jsp?inserted=successfull");
return;

} catch(Exception e) { out.println("Exception----->"+e); }

finally
{
conn.close();
}
%>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>