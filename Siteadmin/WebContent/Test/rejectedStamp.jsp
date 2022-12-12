<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>
<script>
function validate()
{ 
	try
	{
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		
	
	return datevalidate();
	return true;
	}
	catch(e)
	{
		alert(e);
	}
}

function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
	dd11=date1.substring(0,2);
	dd22=date2.substring(0,2);
	mm1=date1.substring(3,6);
	mm2=date2.substring(3,6);
	mm11=dateformat(mm1);
	mm22=dateformat(mm2);
	yy11=date1.substring(7,11);
	yy22=date2.substring(7,11);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();

	var year=date.getFullYear();
	if(yy11>year  || yy22>year) 
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
			if(mm11>month || mm22>month)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}
	if(mm11==month && mm22==month)
	{
		if(dd11>day || dd22>day)
		{
			alert("selected date should not be greater than todays date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
	}

	if(yy11 > yy22)
	{
		alert("From date year should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	else if(year==yy11 && year==yy22)
	{
		 if(mm11>mm22)
	{
		alert("From date month should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	if(mm11==month && mm22==month) 
	{
		if(yy11==yy22)
		{
		if(dd11 > dd22)
		{
			alert("From date should not be greater than to date");
			document.getElementById("data").value="";
			document.getElementById("data1").value="";
			document.getElementById("data").focus;
			return false;
		}
		}
	}
	else
		if(yy11<yy22)
		{
			return true;
		}
	else
		if(dd11 > dd22)
	{
			if(mm11<mm22)
			{
				return true;
			}
			
		alert("From date should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}

	return true;
}

function dateformat(days)
{
	 if(days=='Jan')
		return(1);
	 else
		if(days=='Feb')
			return(2);
		else
			if(days=='Mar')
				return(3);
			else
				if(days=='Apr')
					return(4);
				else
					if(days=='May') //timeformat: "%M:%S"
						
						return(5);
					else
						if(days=='Jun')
							return(6);
						else
							if(days=='Jul')
								return(7);
							else
								if(days=='Aug')
									return(8);
								else
									if(days=='Sep')
										return(9);
									else
										if(days=='Oct')
											return(10);
										else
											if(days=='Nov')
												return(11);
											else
												if(days=='Dec')
													return(12);
 }

</script>

<%!

Statement st, st1;
int limit;
Connection conn;
%>

<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="", vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",defaultDate1="",calstatus="";

int count=0;

try{
	st=conn.createStatement();
	st1=conn.createStatement();
	defaultDate= new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	defaultDate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	
	%>
	<form name="unitform" action="" method="get" onsubmit="return validate();">
	<table border="0" width="80%" align="center" >
	<tr><td colspan="5" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5" align="center">
	<input type="text" id="data" name="data" value="<%=defaultDate %>"  size="10" readonly/>
	&nbsp;
  	<input type="button" name="The Date" value="From Date" id="trigger">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5" align="center">
	<input type="text" id="data1" name="data1" value="<%=defaultDate1 %>"  size="10" readonly/>
	&nbsp;
  	<input type="button" name="The Date1" value="To Date" id="trigger1">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5" align="center">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</table>
	</form>
	
	<%
	if(!(null==request.getQueryString()))
	{
		
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2 = request.getParameter("data1");
		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate2));
		
		%>
		<form name="unitform" action="" method="get" >
		<table border="0" width="100%" align="center">
			<tr bgcolor="#2696B8">
			<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>MIS Summary Report of Rejected Data From <%=thedate %> To <%=thedate2 %></b></font>
			</th>
			</tr>
			<tr>
		<td  class="hed" align="center">
		<div align="right" style="width: 650px;">
		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %>
		<a href="excelrejectstamps.jsp?data=<%=thedate %>&data1=<%=thedate2 %>"  title="Export to Excel">
		<img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></a>
		
		</div> 
		
		<table  border="0"  class="sortable" align="center" style="width: 650px;">
		<tr>
		<td class="hed" align="center" style="width: 10px;">Sr.No.</td>
		<td class="hed" align="center" style="width: 100px;">Date</td>
		<td class="hed" align="center" style="width: 80px;">AC</td>
		<td class="hed" align="center" style="width: 80px;">DC </td>
		<td class="hed" align="center" style="width: 80px;">OS</td>
		<td class="hed" align="center" style="width: 80px;">SI</td>
		<td class="hed" align="center" style="width: 80px;">Rejected Stamps</td>
		</tr>
		<%
		int days = 0;
		String date = thedate1,date3 = "";
		sql = "select datediff('"+thedate3+"','"+thedate1+"') as datediff";
		ResultSet rs = st.executeQuery(sql);
		if(rs.next())
		{
			days= rs.getInt("datediff") + 1;
		}
		for(int i = 1;i<=days;i++)
		{
			int oscount = 0,ACcount = 0,DCcount = 0,SIcount = 0,stampcount = 0;
			sql = "select count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+date+" 00:00:00'  and  TheDatetime <='"+date+" 23:59:59'  and stamp in ('OS3','OS3D','OSDuplicate','OSIgnore') ";
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				oscount = rs.getInt("cnt");
			}
			
			sql = "select count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+date+" 00:00:00'  and  TheDatetime <='"+date+" 23:59:59'  and stamp in ('AC1','AC1D','ACDuplicate') ";
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				ACcount = rs.getInt("cnt");
			}
			
			sql = "select count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+date+" 00:00:00'  and  TheDatetime <='"+date+" 23:59:59'  and stamp in ('DC1','DC1D','DCDuplicate') ";
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				DCcount = rs.getInt("cnt");
			}
			
			sql = "select count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+date+" 00:00:00'  and  TheDatetime <='"+date+" 23:59:59'  and stamp = 'SI1' ";
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				SIcount = rs.getInt("cnt");
			}
		
			sql = "select count(*) as cnt from db_gps.t_invaliddata where storeddate = '"+date+"'  ";
			rs = st.executeQuery(sql);
			if(rs.next())
			{
				stampcount = rs.getInt("cnt");
			}
			%>
			<tr>
			<td class="bodyText" align="right" ><div align="right"><%=i %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date))  %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%if(ACcount > 0){%><a href="MISLevel1.jsp?stamp=AC&data=<%=date %>" target="_blank"><%=ACcount%></a><%}else{%><%=ACcount%><%} %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%if(DCcount > 0){%><a href="MISLevel1.jsp?stamp=DC&data=<%=date %>" target="_blank"><%=DCcount%></a><%}else{%><%=DCcount%><%} %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%if(oscount > 0){%><a href="MISLevel1.jsp?stamp=OS&data=<%=date %>" target="_blank"><%=oscount%></a><%}else{%><%=oscount%><%} %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%if(SIcount > 0){%><a href="MISLevel1.jsp?stamp=SI&data=<%=date %>" target="_blank"><%=SIcount%></a><%}else{%><%=SIcount%><%} %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%if(stampcount > 0){%><a href="MISLevel1.jsp?stamp=stamp&data=<%=date %>" target="_blank"><%=stampcount%></a><%}else{%><%=stampcount%><%} %></div></td>
			</tr>
			<%
			
			Calendar cal = Calendar.getInstance();
			java.util.Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(date);
			//System.out.println("Date 1  "+date1);
			cal.setTime(date1);
			cal.add(Calendar.DAY_OF_MONTH,1);
		
			Date yesterday = cal.getTime();
			date3 =new SimpleDateFormat("yyyy-MM-dd").format(yesterday);
			
			date = date3;
			
		}
		
		%>
		</table>
		
		
		</td>
		</tr>
		</table>
		</form>
			<%
		
	}
		%>
	<%

}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();

	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>
	<%@ include file="footerhtml.jsp" %>
	
