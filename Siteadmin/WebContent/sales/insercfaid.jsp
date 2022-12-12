<%@ include file="headerhtml.jsp" %>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
Statement stmt1 = conn.createStatement();
ResultSet rs2=null;
String sql1="", sql2=""; 

String trans="", fn="", pass="", un="",typeofuser="";
int maxid=0;
//String targetpage=request.getParameter("targetpage");
//String grpname=request.getParameter("grpname");
String loc=request.getParameter("loc");
//String veh=request.getParameter("veh");
String zonecode="";
String sql3="select ZoneCode from t_castrolzones where Zonedesc='"+loc+"'";
ResultSet rs3=stmt1.executeQuery(sql3);
if(rs3.next())
{
	zonecode=rs3.getString("ZoneCode");
}
String user=request.getParameter("user");
String typevalue=request.getParameter("typevalue");
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
	
String sqluser="select Username from t_security where Username='"+user+"'";	
ResultSet rsuser=stmt1.executeQuery(sqluser);
if(rsuser.next())
{
	
	
}
else
{
sql1="insert into t_security (UserId,UserName,FullName,Password,TypeofUser,TypeValue,CreationDate,ExpiryDate) values ('"+maxid+"','"+user+"', 'Castrol', 'transworld', 'SUBUSER', 'Castrol', '"+s+"','"+expdate+"') ";
stmt1.executeUpdate(sql1);
}
String sql4="insert into t_subuser(UserId,Password,Location,LocationCode,Transporter,UserRole)values('"+user+"','transworld','"+loc+"','"+zonecode+"','Castrol','Normal')";
//String sql5="insert into t_targetpage(`typevalue`,`targetpage`)values('"+typevalue+"','castrolempmain.jsp')";
//out.print(sql1);
//out.print(typeofuser);

stmt1.executeUpdate (sql4);
//stmt1.executeUpdate(sql5);
response.sendRedirect("createcfaid.jsp?inserted=successfull");
return;

} catch(Exception e) { out.println("Exception----->"+e); }
finally
{
conn.close();
}
%>
<%@ include file="footerhtml.jsp" %>