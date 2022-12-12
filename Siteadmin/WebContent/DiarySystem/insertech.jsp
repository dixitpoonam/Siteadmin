<%@ include file="headerhtml.jsp" %>
<%!
Connection conn1;
%>
<% 	
try {

	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn1.createStatement();
Statement stmt2 = conn1.createStatement();

ResultSet rs2=null,rs3=null;
String sql1="", sql2="",sql3="", sql4=""; 

int maxid=0,maxid1=0;
String name=request.getParameter("techname");
String tuname=request.getParameter("techuname");
String mobno=request.getParameter("mobno");
String location=request.getParameter("location");

		java.util.Date d = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s=formatter.format(d);
			
sql2="select max(TID) as maxid from t_techlist";
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	maxid=rs2.getInt("maxid");
}
	maxid=maxid+1;
	
sql3="select max(ID) as maxid1 from t_admin";
rs3=stmt2.executeQuery(sql3);
if(rs3.next())
{
	maxid1=rs3.getInt("maxid1");
}
	maxid1=maxid1+1;
	
String sqltech="select TechName from t_techlist where TechName='"+name+"'";	
ResultSet rsuser=stmt1.executeQuery(sqltech);
if(rsuser.next())
{
	
	response.sendRedirect("addtechnician.jsp?inserted=Already Exist");
}
else
{
sql1="insert into t_techlist (TID,TechName,techuname,pass,Available,Location,MobNo) values ('"+maxid+"','"+name+"', '"+tuname+"', 'transworld', 'Yes', '"+location+"','"+mobno+"') ";
stmt1.executeUpdate(sql1);
sql4="insert into t_admin (id,Name,UName,pass,URole,UserType) values ('"+maxid1+"','"+name+"', '"+tuname+"', 'transworld', 'tech', 'tech') ";
stmt2.executeUpdate(sql4);
}

response.sendRedirect("addtechnician.jsp?inserted=successfull");
return;

} catch(Exception e) { out.println("Exception----->"+e); }finally{conn1.close();}

%>
<%@ include file="footerhtml.jsp" %>