<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
    <%@ include file="headerhtml.jsp" %>
   
    <%@ page language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<%!
Connection c;
Statement st, st1,st2;
String  unitid,thedate,thedate1,thedate2;
int limit;
Connection conn,conn1;
%>

<%
String action=request.getParameter("action");
System.out.print("action======"+action);

///*********************** Add employee code ********************

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);


if(action.contains("addemp"))
{
	
	try
	{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";


String unitid=request.getParameter("unitid");
String imei=request.getParameter("imei");
System.out.println("UnitID==>"+unitid+ "IMEI==>"+imei);



//out.println("Department Name---->"+deptCode);
//String reportingto=request.getParameter("reportingto");
//out.println("reportingPerson"+reportingto);







Statement st,st1,st2,st3,st4,st5,st6,st7,st8,st9,st10,st11,st12,st14,st15;
st=conn.createStatement();
st1=conn.createStatement();


///////////
int reportigHodId=0;
String deptName="",underdeptcode="";
 int respectivehodId=0;
 int i=0;
String sqldeptName="select imei from db_gps.t_imeidetails where imei='"+imei+"' ";

ResultSet rs7=st.executeQuery(sqldeptName);
System.out.println("sql query-- for dept name-> "+sqldeptName);
if(rs7.next())
{
	


}else{
	
	
	java.util.Date d= new java.util.Date();
	out.println(d);
	String datetoday=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
	out.println(datetoday);


		System.out.println("Inside insertquery");
	String sql="insert into db_gps.t_imeidetails(imei,unitid,EnteredDate,EnteredBy,status) values ('"+imei+"','"+unitid+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"','"+session.getAttribute("username")+"' ,'Active')  ";
	String sqlInsertHistory="insert into db_gps.t_imeidetailsHistory(imei,unitid,EnteredDate,EnteredBy,status) values ('"+imei+"','"+unitid+"','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"','"+session.getAttribute("username")+"','Active')";

	
	
	
	out.println("sql--->"+sql);
	
	i=st1.executeUpdate(sql);
	st1.executeUpdate(sqlInsertHistory);
	System.out.println("Inside imei-->Insert query"+sql);
	System.out.println("Inside imei"+sqlInsertHistory);
	
	
}
String chk="-";

if(i!=0)
{
	chk="yes";	
	
}

System.out.println("RowCount==>"+i);


try{
	if(chk.equalsIgnoreCase("yes"))
	{
	response.sendRedirect("alertGoTo.jsp?msg=IMEI Added successfully &goto=ConfigureIMEIUnit.jsp");
	}else{
		response.sendRedirect("alertGoTo.jsp?msg= Exception Occured IMEI &goto=ConfigureIMEIUnit.jsp");
		
	}
}catch(Exception e33){
	
}

System.out.println("deptName--->"+deptName);


////////////





	}
	catch(Exception e)
	{
		System.out.println("Exception-------->>"+e);
		
		
	}
	finally
	{
		
		
		conn.close();
		//response.sendRedirect("alertGoTo.jsp?msg=IMEI Added successfully &goto=ConfigureIMEIUnit.jsp");
	}

}//end of add employee


///*********************** Edit employee code ********************
if(action.contains("editemp"))
{
	
	try{
	int currentHodId=0;
	String currentHodEmailId="",newHodId="",newHodEmailId="";
	//String currentHodId="",currentHodEmailId="",newHodId="",newHodEmailId="";
	System.out.print("edit");

	Statement st4=conn.createStatement();
	Statement st5=conn.createStatement();
	

	String imei=request.getParameter("imei");
	String unitid=request.getParameter("unitid");
	
	System.out.println("imei--->"+imei);
	System.out.println("unitid--->"+unitid);
	
	
	
////////////


int reportigHodId=0;
String deptName="",underdeptcode="";

String sqldeptName="select imei from db_gps.t_imeidetails where imei='"+imei+"' ";

ResultSet rs7=st4.executeQuery(sqldeptName);
if(rs7.next())
{
	
	
	
	String updateleavereqhodemailsql="update db_gps.t_imeidetails set unitid='"+unitid+"' where imei='"+imei+"'  ";
	int suc=st5.executeUpdate(updateleavereqhodemailsql);
	System.out.println("IMEI EDITED ---->"+suc);
	
	
	String sqlInsertHistory="insert into db_gps.t_imeidetailsHistory(imei,unitid,EnteredDate,EnteredBy) values ('"+imei+"','"+unitid+"','"+new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())+"','"+session.getAttribute("username")+"')";
	int suc1=st5.executeUpdate(sqlInsertHistory);
	System.out.println("IMEI EDITED - HISTORy--->"+suc1);
	
	
}
System.out.println("deptName--->"+deptName);


	}
	catch(Exception e)
	{
		System.out.println("Exception-------->>"+e);
	}
	finally
	{
		conn.close();
		response.sendRedirect("alertGoTo.jsp?msg=IMEI successfully updated&goto=ConfigureIMEIUnit.jsp");
	}

	
	
}

%>
</body>
</html>