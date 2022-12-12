<%@ include file="headerhtml.jsp" %>
<!-- <META HTTP-EQUIV=Refresh CONTENT='60; URL=onlineusers.jsp'>  -->
<html>
<head>
<script language="javascript">

function validate()
{ 
	var date1=document.getElementById("thedate").value;
	var date2=document.getElementById("thedate1").value;

	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);

	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	if(dy1>year || dy2>year)
	{
		alert("Selected date should not be greater than Todays date (Year)");
		//document.getElementById("calender").value="";
		//document.getElementById("calender1").value="";
		//document.getElementById("calender").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2) 
	{
		if(dm1>month || dm2>month)
		{
			alert("Selected date should not be greater than Todays date (Month)");
			//document.getElementById("calender").value="";
			//document.getElementById("calender1").value="";
			//document.getElementById("calender").focus;

			return false;
		}
	}

	if(dm1==month)
	{
		if(dd1>day || dd2>day)
		{
			alert("Selected date should not be greater than Todays date (Day)");
			//document.getElementById("calender").value="";
			//document.getElementById("calender1").value="";
			//document.getElementById("calender").focus;
	
			return false;
	
		}
	}

	if(dy1>dy2)
	{
		alert("From date year should not be greater than To date year");
		//document.getElementById("data").value="";
		//document.getElementById("data1").value="";
		//document.getElementById("data").focus;

		return false;
	}
	
	else if(year==dy1 && year==dy2) 
	{
		if(dm1>dm2)
		{
			alert("From date month should not be greater than To date month");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			//document.getElementById("data").focus;

			return false;
		}
	}
	
	if(dm1==dm2)
	 {
		if(dd1 > dd2)
		{
			alert("From date should not be greater than To date");
			//document.getElementById("data").value="";
			//document.getElementById("data1").value="";
			//document.getElementById("data").focus;

			return false;
		}
	}
	return true;	
	
}


</script>

</head>
<%!Connection con1; %>
<form name="lagreport" method="get" action="" onSubmit="return validate();">
<%

try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement();
	ResultSet rs1=null;
	String sql1="";
	
	String today="", onedaybfre="", msg="";

	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	today = formatter.format(tdydte);

	java.util.Date tdydte1 = new java.util.Date();
	long ms=tdydte.getTime();
	ms=ms-1000 * 60 * 60 *24*1;
	tdydte1.setTime(ms);

	onedaybfre = formatter.format(tdydte1);
	
	String firstdate=request.getParameter("thedate");
		
	if(firstdate==null)
	{
		msg="Lag Report (for Yesterday)";
	}
	else
	{
		String thedate1=request.getParameter("thedate1");
		onedaybfre=firstdate;
		today=thedate1;

		msg="Lag Report from " + new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(onedaybfre)) + " till " +new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
	} 
%>

<table border="0" width="90%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> <%=msg%> </font> </b> </td>
    
</tr>
<tr>
   <td align="right"> <div align="right"> 
	<table border="0" width="100%" align="right">
	    <tr>
		<td align="right" > <input type="text" id="thedate" name="thedate" size="13" class="formElement" value="<%=onedaybfre%>" readonly/>
		<img src="../images/calendar.png" id="trigger" border="0">
		<!-- <input type="button" name="trigger" id="trigger" value="From Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "thedate",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script>
             &nbsp;&nbsp;&nbsp;
             <input type="text" id="thedate1" name="thedate1" size="13" class="formElement" value="<%=today%>" readonly/>
		<img src="../images/calendar.png" id="trigger1" border="0">
		<!-- <input type="button" name="trigger1" id="trigger1" value="To Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "thedate1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script>
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="Submit" name="Submit" Value="Submit" class="formElement">
	</td> </tr> </table>
   </td>	
</tr>
<tr>
    <td align="center">
    	<table border="0" width="100%" align="center">
	    <tr>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Sr No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Date </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Lag Vehicle Count </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Max. Lag (Hrs)</font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Avg. Lag </font> </td>
</tr>	
<%
	int i=1;
	
	sql1="select TheDate, count(VehicleCode) as countveh, max(Lag) as maxlag, avg(Lag) as avglag  from t_vehiclelagdata where TheDate between '"+onedaybfre+"' and '"+today+"' group by TheDate";
	//out.print(sql1);
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ 
		double maxlaghrs=rs1.getDouble("maxlag");
		maxlaghrs=maxlaghrs/60;

		double avglaghrs=rs1.getDouble("avglag");
		avglaghrs=avglaghrs/60;

		NumberFormat nf = DecimalFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);	
		nf.setGroupingUsed(false);
	
		String maxlaghrsfrmtd=nf.format(maxlaghrs);
		String avglaghrsfrmtd=nf.format(avglaghrs);	
%>
		<tr>
			<td bgcolor="#f5f5f5"> <%=i%> </td>
			<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs1.getString("TheDate")))%> </td>
			<td bgcolor="#f5f5f5"> <a href="lagvehs.jsp?date1=<%=rs1.getString("TheDate")%>"> <%=rs1.getString("countveh")%> </a> </td>
			<td bgcolor="#f5f5f5"> <%=maxlaghrsfrmtd%> </td>
			<td bgcolor="#f5f5f5"> <%=avglaghrsfrmtd%> </td>
		</tr>
<%
		i++;
	}
%>
<%
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
finally{
	con1.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
</html>
