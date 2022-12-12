<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
    <%@ include file="header.jsp" %>
   
    <%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>




<%
String action=request.getParameter("action");
System.out.print("action======"+action);

///*********************** Add employee code ********************
if(action.contains("addemp"))
{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";
String confirm=request.getParameter("confirm");
out.println("confirm"+confirm);

String name=request.getParameter("name");
String cName=request.getParameter("cName");
System.out.println("name"+name+ "cname"+cName);
String username=request.getParameter("username");
String email=request.getParameter("email");
out.println("username"+username);
String pass=request.getParameter("pass");
out.println("pass"+pass);
String typeOfUser=request.getParameter("typeOfUser");
out.println("typeOfUser"+typeOfUser);
String deptCode=request.getParameter("deptName");
System.out.println("Department_selected---->"+deptCode);
String empid=request.getParameter("empid");
//out.println("Department Name---->"+deptCode);
//String reportingto=request.getParameter("reportingto");
//out.println("reportingPerson"+reportingto);







String typeofleave="",inserted="";
String weekoff=request.getParameter("weekoff");
System.out.println("weekoff======"+weekoff);
Boolean innerflag=false;

Statement st,st1,st2,st3,st4,st5,st6,st7,st8,st9,st10,st11,st12,st14,st15;


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

st=conn.createStatement();
st1=conn.createStatement();
st2=conn.createStatement();
st3=conn.createStatement();
st4=conn.createStatement();
st5=conn.createStatement();
st6=conn.createStatement();
st7=conn.createStatement();
st8=conn.createStatement();
st9=conn.createStatement();
st10=conn.createStatement();
st11=conn.createStatement();
st12=conn.createStatement();
st14=conn.createStatement();
st15=conn.createStatement();

///////////
int reportigHodId=0;
String deptName="",underdeptcode="";
 int respectivehodId=0;
String sqldeptName="select deptName from t_department where DeptCode='"+deptCode+"'  and status='Active'";

ResultSet rs7=st7.executeQuery(sqldeptName);
System.out.println("sql query-- for dept name-> "+sqldeptName);
if(rs7.next())
{
	deptName=rs7.getString("deptName");
}
System.out.println("deptName--->"+deptName);


////////////

if(typeOfUser.equalsIgnoreCase("contractor"))
{
	System.out.println("Inside contractor");
	String sqlreportingHodId="SELECT HODId FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st6.executeQuery(sqlreportingHodId);
	System.out.println("Inside contractor"+sqlreportingHodId);
	if(rs6.next())
	{
		reportigHodId=rs6.getInt("HODId");
	}
	System.out.println("Inside contractor"+reportigHodId);

}
else
{
	System.out.println("Inside HOD");
	String sqlreportingHodId="SELECT UnderDeptCode FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st6.executeQuery(sqlreportingHodId);

	if(rs6.next())
	{
		underdeptcode=rs6.getString("UnderDeptCode");
	}

	System.out.println("Inside UnderDeptCode"+underdeptcode);
	
	String sqlrespectiveHodID="SELECT HODId from t_department where DeptCode='"+underdeptcode+"'";
	
	ResultSet rs8=st8.executeQuery(sqlrespectiveHodID);
	
	if(rs8.next())
	{
		reportigHodId=rs8.getInt("HODId");
	}
	System.out.println("Inside UnderDeptCode1"+reportigHodId);
	//updating hod  for department and leaverequest
	
	String getdepthodsql="SELECT HODId from t_department where DeptCode='"+deptCode+"'";
	ResultSet rs9=st9.executeQuery(getdepthodsql);
	System.out.println("current hod id query-->"+getdepthodsql);
	if(rs9.next())
	{
		currentHodId=rs9.getInt("HODId");
	}
	System.out.println(" current Hod Id -->"+currentHodId);
	String getdepthodemailsql="SELECT email from t_leaveadmin where empid='"+currentHodId+"' and status='Yes'";
	ResultSet rs10=st10.executeQuery(getdepthodemailsql);
	System.out.println("current hod email id query-->"+getdepthodemailsql);
	if(rs10.next())
	{
		currentHodEmailId=rs10.getString("email");
	}
	String updateleavereqhodemailsql="update t_leaverequest set hod='"+email+"' where hod='"+currentHodEmailId+"'";
	int suc=st11.executeUpdate(updateleavereqhodemailsql);
	System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"---flag--"+suc);
	
	String updatedepthodemailsql="update t_department set hodid='"+empid+"' where DeptCode='"+deptCode+"'";
	int suc1=st11.executeUpdate(updatedepthodemailsql);
	System.out.println("department update query ---->"+updatedepthodemailsql+"---flag--"+suc1);
	
	/*  Assigining previous Hod as contractor  */
	String updateleaveadminHodsql="update t_leaveadmin set urole=' contractor' where email='"+currentHodEmailId+"'";
	int suc2=st14.executeUpdate(updateleaveadminHodsql);
	System.out.println("previous Hod updation update query ---->"+updateleaveadminHodsql+"---flag--"+suc2);
	
/*  code for updating reporting to hod for all User in that Department */
	
	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+empid+"' where  typevalue='"+deptName+"'";
	System.out.println("Reporting to hod  updation query------>"+sqlupdateReportingtoHoduser);
	int flgforreport=st15.executeUpdate(sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod query--->"+sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod count"+flgforreport);

	
	
}//end of Hod else


////////////////////////



java.util.Date d= new java.util.Date();
out.println(d);
String datetoday=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
out.println(datetoday);
Boolean flag=false;
String sql1="select * from t_leaveadmin where empid='"+empid+"'";
ResultSet rs=st1.executeQuery(sql1);
if(rs.next()){
	response.sendRedirect("addEmployee.jsp?already=yes");
	
}
else
{
	System.out.println("Inside insertquery");
String sql="insert into t_leaveadmin(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser,reportingtohod) values ('"+empid+"','"+cName+"','"+username+"','"+pass+"','"+email+"','"+typeOfUser+"','"+deptName+"','"+weekoff+"','"+session.getAttribute("empname")+"','"+reportigHodId+"')  ";
String sqlInsertHistory="insert into t_leaveadminhistory(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser) values ('"+empid+"','"+cName+"','"+username+"','"+pass+"','"+email+"','"+typeOfUser+"','"+deptName+"','"+weekoff+"','"+session.getAttribute("empname")+"')";

out.println("sql--->"+sql);
int i=0;
i=st.executeUpdate(sql);
st4.executeUpdate(sqlInsertHistory);
System.out.println("Inside contractor-->Insert query"+sql);
System.out.println("Inside contractor"+sqlInsertHistory);
response.sendRedirect("alertGoTo.jsp?msg=Contractor Added successfully &goto=employeeReport.jsp");

}
}//end of add employee


///*********************** Edit employee code ********************
if(action.contains("editemp"))
{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";
	//String currentHodId="",currentHodEmailId="",newHodId="",newHodEmailId="";
	System.out.print("edit");

	Statement st4=conn.createStatement();
	Statement st5=conn.createStatement();
	Statement st6=conn.createStatement();
	Statement st7=conn.createStatement();
	Statement st8=conn.createStatement();
	Statement st9=conn.createStatement();
	Statement st10=conn.createStatement();
	Statement st11=conn.createStatement();
	Statement st12=conn.createStatement();
	Statement st13=conn.createStatement();
	Statement st14=conn.createStatement();
	Statement st15=conn.createStatement();

	String EmpID=request.getParameter("EmpID");
	String Name=request.getParameter("Name");
	String UName=request.getParameter("UName");
	String URole=request.getParameter("URole");
	String Email=request.getParameter("Email");
	String TypeValue=request.getParameter("TypeValue");
	String weekOff=request.getParameter("weekOff");
	String reportingto=request.getParameter("reportingto");
	String deptCode=request.getParameter("deptName");
	System.out.println("Department_selected---->"+deptCode);
	String empid=request.getParameter("empid");
	String user_status=request.getParameter("status");
	out.println("User Status--->"+user_status);
////////////


int reportigHodId=0;
String deptName="",underdeptcode="";

String sqldeptName="select deptName from t_department where DeptCode='"+deptCode+"'  and status='Active'";

ResultSet rs7=st7.executeQuery(sqldeptName);
if(rs7.next())
{
	deptName=rs7.getString("deptName");
}
System.out.println("deptName--->"+deptName);



if(URole.equalsIgnoreCase("contractor"))
{
	System.out.println("Inside contractor");
	String sqlreportingHodId="SELECT HODId FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st6.executeQuery(sqlreportingHodId);
	System.out.println("Inside contractor"+sqlreportingHodId);
	if(rs6.next())
	{
		reportigHodId=rs6.getInt("HODId");
	}
	System.out.println("Inside contractor"+reportigHodId);

}
else
{
	System.out.println("Inside HOD");
	String sqlreportingHodId="SELECT UnderDeptCode FROM t_department where DeptName='"+deptName+"'  and status='Active'";
	
	ResultSet rs6=st6.executeQuery(sqlreportingHodId);

	if(rs6.next())
	{
		underdeptcode=rs6.getString("UnderDeptCode");
	}

	System.out.println("Inside UnderDeptCode"+underdeptcode);
	
	String sqlrespectiveHodID="SELECT HODId from t_department where DeptCode='"+underdeptcode+"'";
	
	ResultSet rs8=st8.executeQuery(sqlrespectiveHodID);
	
	if(rs8.next())
	{
		reportigHodId=rs8.getInt("HODId");
	}
	System.out.println("Inside UnderDeptCode1"+reportigHodId);
	
//updating hod  for department and leaverequest
	
	String getdepthodsql="SELECT HODId from t_department where DeptCode='"+deptCode+"'";
	ResultSet rs9=st9.executeQuery(getdepthodsql);
	System.out.println("current hod id query-->"+getdepthodsql);
	if(rs9.next())
	{
		currentHodId=rs9.getInt("HODId");
	}
	System.out.println(" current Hod Id -->"+currentHodId);
	String getdepthodemailsql="SELECT email from t_leaveadmin where empid='"+currentHodId+"'  and status='Yes'";
	ResultSet rs10=st10.executeQuery(getdepthodemailsql);
	System.out.println("current hod email id query-->"+getdepthodemailsql);
	if(rs10.next())
	{
		currentHodEmailId=rs10.getString("email");
	}
	String updateleavereqhodemailsql="update t_leaverequest set hod='"+Email+"' where hod='"+currentHodEmailId+"'";
	int suc=st11.executeUpdate(updateleavereqhodemailsql);
	System.out.println("leave request update query ---->"+updateleavereqhodemailsql+"---flag--"+suc);
	
	String updateDepthodemailsql="update t_department set hodid='"+EmpID+"' where DeptCode='"+deptCode+"'";
	int suc1=st11.executeUpdate(updateDepthodemailsql);
	System.out.println("leave request update query ---->"+updateDepthodemailsql+"---flag--"+suc1);
	/*  Assigining previous Hod as contractor  */
	String updateleaveadminHodsql="update t_leaveadmin set urole=' contractor' where email='"+currentHodEmailId+"'";
	int suc2=st14.executeUpdate(updateleaveadminHodsql);
	System.out.println("previous Hod updation update query ---->"+updateleaveadminHodsql+"---flag--"+suc2);
	/*  */
/*  code for updating reporting to hod for all User in that Department */
	
	String sqlupdateReportingtoHoduser="update t_leaveadmin set  ReportingtoHod='"+EmpID+"' where  typevalue='"+deptName+"'";
	System.out.println("Reporting to hod  updation query------>"+sqlupdateReportingtoHoduser);
	int flgforreport=st15.executeUpdate(sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod query--->"+sqlupdateReportingtoHoduser);
	System.out.println("updated reporting to hod count"+flgforreport);
	
	
	
	
}//end of HOD else


	////////////////////////

	//System.out.println("========="+EmpID+"========"+UName+"==============="+Email+"==========="+URole+"======="+TypeValue+"======="+weekOff+"");
	try
	{
		String pass="";
		String sql="select * from t_leaveadmin where empid='"+EmpID+"'";
		
		ResultSet rs=st6.executeQuery(sql);
		while(rs.next())
		{
			pass=rs.getString("pass");
		}
		String sqledit="update t_leaveadmin set Name='"+Name+"',UName='"+UName+"',Email='"+Email+"',URole='"+URole+"',TypeValue='"+deptName+"',weekOff='"+weekOff+"',ERPUser='"+session.getAttribute("empname")+"',reportingtohod='"+reportigHodId+"',status='"+user_status+"' where EmpID="+EmpID+"";
		System.out.println("sqledit======"+sqledit);
		String sqlInsertHistory="insert into t_leaveadminhistory(empid,Name,UName,pass,Email,URole,TypeValue,weekOff,ERPUser,status) values ('"+EmpID+"','"+Name+"','"+UName+"','"+pass+"','"+Email+"','"+URole+"','"+deptName+"','"+weekOff+"','"+session.getAttribute("empname")+"','"+user_status+"')";
		
		st4.executeUpdate(sqledit);
		st5.executeUpdate(sqlInsertHistory);
		
	//	String leavreqhodupdatesql="update t_leaverequest set hod='"++"' where hod='"++"'";
		
		
		
		
	}
	catch(Exception e)
	{
		System.out.println("Exception-------->>"+e);
	}
	finally
	{
		conn.close();
		response.sendRedirect("alertGoTo.jsp?msg=Contractor successfully updated&goto=employeeReport.jsp");
	}
	
}

%>
</body>
</html>