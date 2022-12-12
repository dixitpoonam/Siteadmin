<%@ include file="headerhtml.jsp" %>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn.createStatement();
Statement stmt = conn.createStatement();
ResultSet rs2=null;
String sql1="", sql2=""; 
String flag = "2";
String trans="", fn="", pass="", un="",typeofuser="",admin="";
int maxid=0;
trans=request.getParameter("trans");
fn=request.getParameter("fn");
un=request.getParameter("un");
pass=request.getParameter("pass");
admin=request.getParameter("admin");
System.out.println("admin777777777777777777"+un);
			java.util.Date d = new java.util.Date();
			System.out.println("admin777777^^^^^^^^^^^777777777777");
			Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			System.out.println("admin7777777*****************77777777777"+un);
			String s=formatter.format(d);
			System.out.println("admin777777@@@@@@@@@@@@@@@777777777777"+un);
			
			String year = new SimpleDateFormat("yyyy").format(d);
			System.out.println("admin777777((((((((((((((((((((((((((((((((((777777777777"+admin);
			String expdate = year+"-12-31";
			System.out.println("admin777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!777777777777"+admin);
			
sql2="select max(UserId) as maxid from t_security";
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	maxid=rs2.getInt("maxid");
}
	maxid=maxid+1;	
	//System.out.println("admin777777777777777777"+admin);	
	if(null==request.getParameter("admin")){
	//	System.out.println("admin======>"+admin);	

		
		sql1="select * from t_security where TypeValue='"+trans+"' and typeofuser<>'EndUser'";
ResultSet rsttype=stmt1.executeQuery(sql1);
if(rsttype.next())
{
	typeofuser=rsttype.getString("typeofuser");
}
else
{
	String sql11="select * from t_group where GPName='"+trans+"'";
	ResultSet rsttype1=stmt1.executeQuery(sql11);
	if(rsttype1.next())
	{
		typeofuser="GROUP";
	}
	else
	{
		typeofuser="Transporter";
	}
}
	
	}
	else if(admin.equalsIgnoreCase("admin")){
		typeofuser="Admin";
	}
	//System.out.println("typeofuser777777777777777"+typeofuser);
	String sql = "select * from db_gps.t_security where username = '"+un+"'";
	ResultSet rs = stmt.executeQuery(sql);
	if(rs.next())
	{
		flag = "1";
	}
	else
	{
        sql1="insert into t_security (UserId,  UserName, FullName, Password, TypeofUser, TypeValue, CreationDate,TransporterName,ExpiryDate) values ('"+maxid+"','"+un+"', '"+fn+"', '"+pass+"', '"+typeofuser+"', '"+trans+"', '"+s+"','"+trans+"','"+expdate+"') ";
		System.out.print(sql1);
		//out.print(typeofuser);
            stmt1.executeUpdate(sql1);
            flag = "2";
	}
		//System.out.print(sql1);
		if(flag == "1")
		{
			response.sendRedirect("createnewid.jsp?inserted="+flag);
		}
		else
		{
			response.sendRedirect("createnewid.jsp?inserted="+flag);
		}
return;

} catch(Exception e) { out.println("Exception----->"+e);e.printStackTrace(); }
finally{
	conn.close();
}
%>
<%@ include file="footerhtml.jsp" %>
