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
<%!
Connection conn, con1;
%>
<form name="failtostartafterreprov" method="get" action="" onSubmit="return validate();">
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement(), stmt2=conn.createStatement(), stmt3=conn.createStatement(), stmt4=conn.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null, rs4=null;
	String sql1="", sql2="", sql3="", sql4="";
	
	String today="", sevdaybfre="", msg="";

	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	today = formatter.format(tdydte);

	java.util.Date tdydte1 = new java.util.Date();
	long ms=tdydte.getTime();
	ms=ms-1000 * 60 * 60 *24*1;
	tdydte1.setTime(ms);

	sevdaybfre = formatter.format(tdydte1);
	
	String firstdate=request.getParameter("thedate");
		
	if(firstdate==null)
	{
		msg="Data Status after Re-provision (since 2 days)";
	}
	else
	{
		String thedate1=request.getParameter("thedate1");
		sevdaybfre=firstdate;
		today=thedate1;

		msg="Data Status after Re-provision " + new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sevdaybfre)) + " till " +new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
	} 
%>

<table border="0" width="90%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> <%=msg%> </font> </b> </td>
    <td bgcolor="#f5f5f5" align="right"> <a href="excelreprovfailstart.jsp?thedate=<%=sevdaybfre%>&thedate1=<%=today%>"> <img src="../images/excel.jpg" width="15px" height="15px" border="0"/> </a> </td>
</tr>
<tr>
   <td align="right"> <div align="right"> 
	<table border="0" width="100%" align="right">
	    <tr>
		<td align="right" > <input type="text" id="thedate" name="thedate" size="13" class="formElement" value="<%=sevdaybfre%>" readonly/>
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
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Mobile No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Reprovision Date </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Status </font> </td>
</tr>	
<%
	int j=1;
	double yes=0, no=0, i=0;
	sql1="select * from t_reprovisiondailynum where ondate between '"+sevdaybfre+"' and '"+today+"' and VehCode not in('','0','-') ";
	//out.print(sql1);
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ 
		String mobno=rs1.getString("MobileNo");
		String repdate=rs1.getString("ondate");
		String vehcode=rs1.getString("VehCode");
		
		try{
			sql3="select * from t_veh"+vehcode+" where TheFieldDataDate ='"+repdate+"' and TheFiledTextFileName='SI'";
			//out.print(sql3);
			rs3=stmt3.executeQuery(sql3);
			if(rs3.next())
			{ 
				yes++;
%>
				<tr>
					<td bgcolor="#f5f5f5"> <%=j%> </td>
					<td bgcolor="#f5f5f5"> <%=mobno%> </td>
					<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(repdate))%> </td>
					<td bgcolor="#f5f5f5"> Yes </td>
				</tr>
<%
			}
			else
			{ 
				no++;
%>
				<tr>
					<td bgcolor="#f5f5f5"> <%=j%> </td>
					<td bgcolor="#f5f5f5"> <%=mobno%> </td>
					<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(repdate))%> </td>
					<td bgcolor="#f5f5f5"> No </td>
				</tr>
<%			
				
			}
		j++;
		i++;
		} catch(Exception e)
		{ %> 
			<tr>
				<td bgcolor="#f5f5f5" colspan="3"> NO RECORD FOUND</td>
			</tr>	
<%	 	}
				
	} //close of while

	double yesper=(yes/i)*100;
	double noper=(no/i)*100;

	NumberFormat nf1 = DecimalFormat.getNumberInstance();
	nf1.setMaximumFractionDigits(0);
	nf1.setMinimumFractionDigits(0);	
	nf1.setGroupingUsed(false);

	String totsntrepr=nf1.format(i);
	String totyes=nf1.format(yes);
	String totno=nf1.format(no);

	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);

	String yesperstr=nf.format(yesper);
	String noperstr=nf.format(noper);
%>
	<table border="10" width="100%" align="center">
		<tr>		
			<td align="center" bgcolor="#2696B8"> <B> Total Sent for Re-Provision </B> </td>
			<td align="center" bgcolor="#2696B8" > <B> Count which sent data <br> on same date (Yes) </B> </td>
			<td align="center" bgcolor="#2696B8"> <B> Count which did not send <br> data on same date (No) </B></td>
			<td align="center" bgcolor="#2696B8"> <B> %age (Yes) </B> </td>
			<td align="center" bgcolor="#2696B8"> <B> %age (No) </B> </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <%=totsntrepr%> </td>
			<td bgcolor="#f5f5f5"> <%=totyes%> </td>
			<td bgcolor="#f5f5f5"> <%=totno%> </td>
			<td bgcolor="#f5f5f5"> <%=yesperstr%> </td>
			<td bgcolor="#f5f5f5"> <%=noperstr%> </td>
		</tr>
	</table>	
		
<%
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
finally{
	conn.close();
	con1.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
</html>
