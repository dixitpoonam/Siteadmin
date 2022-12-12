<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp" %>


<script language="javascript">
function validate()
{
	var comment=document.getElementById("comment").value;
	var othercomment=document.getElementById("othercomment").value;
	othercomment=othercomment.replace(/^\s+|\s+$/g,"");//trim
	if(comment=="select" && (othercomment=="" || othercomment.lenght==0))
	{
		alert("Please enter a comment");
		return false;
	}
	return true;
}





</script>
<html>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<head>





</head>

<head>
<title>Transworld Trip Admin Module</title>
<STYLE>A:link {
	TEXT-DECORATION: none
}
A:visited {
	TEXT-DECORATION: none
}
</STYLE>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<!--<script src="../elabel.js" type="text/javascript"></script>
--><style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">

<form name="tripend" action="insertComment.jsp" method="post" onSubmit="return validate();">
<%!
Connection conn,conn1;
%>
<% 
String vehcode="", vehreg="", stplace="", endplace="", stdate="", sttime="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";
double stlat=0, stlong=0, endlat=0, endlong=0;
int oscount=0,account=0,dccount=0,distance=0,stopcount=0, stkm=0, endkm=0, totkm=0;

try {
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=conn.createStatement(), stmt2=conn.createStatement(), stmt3=conn.createStatement(),stmt4=conn.createStatement(),dbCustCompStmt4=conn1.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="";

String location="", latitu="", longi="";
String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");
String inserted=request.getParameter("inserted");
java.util.Date d=new java.util.Date();
String rfname="";//,rlname="";
String dte=new SimpleDateFormat("yyyy-MM-dd").format(d);
String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d);
int hours=(d.getHours());
int minutes=(d.getMinutes());

	String loginuser=session.getAttribute("username").toString();
	String tripid=request.getParameter("tripid");
	//String enddate=request.getParameter("calender1");
	//String endhrs=request.getParameter("endtime1");
	//String endmin=request.getParameter("endtime2");
	String comment=request.getParameter("comment");
	String othercomment=request.getParameter("othercomment");
	
	comment=comment+","+othercomment;
	//String endtime=endhrs+":"+endmin+":00";	
	rfname=session.getAttribute("username").toString(); 

	
	
 	java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   	Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   	String nwfrmtdte=formatter.format(datefrmdb);

	java.util.Date datefrmdb1=new java.util.Date();
	Format formatter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   	String nwfrmtdte1=formatter1.format(datefrmdb1);
   	
   	if(inserted!=null && inserted.equalsIgnoreCase("yes"))
   	{
   		%>
   		<table border="0" width="100%"  class="stats">
   		<tr><td>Inserted Sucessfully</td></tr>
   		</table>
   		<%
   	}
%>
		<table border="0" width="100%"  class="stats">
			<tr>
			<td class="hed" align="center" ><b>Sr.No.</b></td>
			<td class="hed" align="center" ><b>Ent Date Time</b></td>
			<td class="hed" align="center" > <b>TripID</b></td>
			<td class="hed" align="center"> <b> Vehicle</b></td>
			<td class="hed" align="center" > <b>Comment</b> </td>
			<td class="hed" align="center" ><b>Ent By.</b></td>
			</tr>

<%
int i=1;
	String sql12="select * from t_tripcomments where TripId='"+tripid+"' and vehid="+vehiclecode;
	ResultSet rs12=stmt1.executeQuery(sql12);
	while(rs12.next())
	{ %>
	<tr>
				<td><%=i%></td>
				<td><%=rs12.getString("tripid") %></td>
				<td><%=rs12.getString("vehregno")%></td>
				<td><%=rs12.getString("comment") %></td>
				<td><%= rs12.getString("datetime")%></td>
				<td><%= rs12.getString("entby")%></td>	
			</tr>
		
<%
i++;
}
	
%>
				
			</table>

<table border="1" width="100%" class="stats">
     <tr>
			<td colspan="2" align="center"> <font size="3" color="maroon"> <B>Enter Comment for <%=vehno%> </B> </font> </td>
     </tr>		
     <tr>
     <td>Comments</td>
     <td>
     <select id="comment" name="comment">
     <option value="select">Select</option>
     <%
     String commentsSql="Select Comment from t_commentlist where Listname='endtrip'";
     ResultSet commRst=dbCustCompStmt4.executeQuery(commentsSql);
     while(commRst.next())
     {
     %>
     <option value="<%=commRst.getString("Comment") %>"><%=commRst.getString("Comment") %></option>
     <%} %>
     </select> 
     
     </td>
     </tr>
     <tr>
     <td>Other Comments
      		 <input type="hidden" id="tripid" name="tripid" value="<%=tripid%>"/>
             <input type="hidden" id="vehregno" name="vehregno" value="<%=vehno%>"/>
              <input type="hidden" id="vehcode" name="vehcode" value="<%=vehiclecode%>"/>
     </td>
     <td><textarea rows="2" cols="20" name="othercomment" id="othercomment"></textarea> </td>
     </tr>
     <tr>
     	
     <td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" /> </td> 
     </tr>
</table>


<table border="0" width="100%">
     <tr>
	<td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td>
     </tr>		
</table>
		<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="maroon"> <B>Successfully Done </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh the Open Trip Report page to reflect the changes. </font> </td>
			</tr>	
			</table>

<%
		
	//} //close of outer else
 //close of MAIN ELSE


} catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try{
conn.close();
conn1.close();
	}
	catch(Exception ex)
	{}
} 
  
%>

</form>
</body>
</html>

	
