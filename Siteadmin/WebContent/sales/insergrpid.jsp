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
String transp=request.getParameter("trans");
String veh=request.getParameter("veh");
int vehcode=0;
String sql3="select * from t_vehicledetails where vehicleregnumber = '"+veh.trim()+"'";
ResultSet rs3=stmt1.executeQuery(sql3);
if(rs3.next())
{
	vehcode=rs3.getInt("vehiclecode");
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
sql1="insert into t_security (UserId,UserName,FullName,Password,TypeofUser,TypeValue,CreationDate,TransporterName,ExpiryDate) values ('"+maxid+"','"+user+"', '"+transp+"', 'transworld', 'GROUP', '"+typevalue+"', '"+s+"','"+transp+"','"+expdate+"') ";
stmt1.executeUpdate(sql1);
}
String sql4="insert into t_group(GPName,VehRegNo,Transporter,Vehcode)values('"+typevalue+"','"+transp+"','"+veh+"','"+vehcode+"')";

String sql5="insert into t_targetpage(`typevalue`,`targetpage`)values('"+typevalue+"','castrolempmain.jsp')";
//out.print(sql1);
//out.print(typeofuser);

stmt1.executeUpdate(sql4);
out.print("sql 4--->"+sql4);
stmt1.executeUpdate(sql5);
response.sendRedirect("creategrpid.jsp?inserted=successfull");
return;

} catch(Exception e) { out.println("Exception----->"+e); }
finally
{
conn.close();
}
%>
<%@ include file="footerhtml.jsp" %>