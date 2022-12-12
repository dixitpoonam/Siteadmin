<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>
<%!

Statement st, st1;
int limit;
Connection conn;
%>

<%@page import="org.apache.naming.java.javaURLContextFactory"%><script type="text/javascript">
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

	if(document.getElementById("unitid").value=="") 
	{
		alert("Please Enter the Unit ID.");
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
	String lim1=request.getParameter("limit");
	String limit = "";
	if(!(null==request.getQueryString()))
	{
		defaultDate=request.getParameter("data");
		defaultDate1=request.getParameter("data1");
		if(lim1.equals("xx"))
		{
			limit=" limit "+request.getParameter("lim");
		}
		else
		{
			limit="";
		}
		System.out.println("limit 1   "+limit );
		unitid=request.getParameter("unitid");
	}
	
	
	
	%>
	<form name="unitform" action="" method="get" onsubmit="return validate();">
	<table border="0" width="100%" align="center" >
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
	<td bgcolor="#F5F5F5" align="center"><b>Unit ID :</b>&nbsp;
	<input type="text" name="unitid" id="unitid"  size="10" value="<%=unitid %>"></input> 
	</td>
	<td bgcolor="#F5F5F5" align="center"><b>Limit :</b>&nbsp;&nbsp;
	<%
	if(lim1!=null && lim1.equals("xx"))
	{
		%>
		<input type="radio" name="limit" value="xx" checked="checked"> <input type="text" name="lim" value="10" size="5" class="stats" />
		<%
	}
	else
	{
		%>
		<input type="radio" name="limit" value="xx" checked="checked"> <input type="text" name="lim" value="10" size="5" class="stats" />
		<%
	}
	if(lim1!=null && lim1.equals("All"))
	{
		%>
		<br>
		 <input type="radio" name="limit" value="All" checked="checked"> ALL
		<%
	}
	else
	{
		%>
		<br>
		 <input type="radio" name="limit" value="All" > ALL
		<%
	}
	%>
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
		<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>Rejected Stamps of Unit <%=unitid %> From <%=thedate %> To <%=thedate2 %></b></font>
		</th>
		</tr>
		<%
		boolean flag=false;
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			flag=true;
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
			
			%>
			<tr>
			<td  class="hed" align="center">
			<table width="100%" class="stats" style="width: 600px;">
			<tr>
			<td class="hed" align="center">Vehicle No</td>
			<td class="hed" align="center">Vehicle Code</td>
			<td class="hed"  align="center">Transporter</td>
			</tr>
			<tr>
			<td align="left"><div align="left"><%=VehicleRegNumber %></div></td>
			<td align="right"><div align="right"><%=vehcode %></div></td>
			<td align="left"><div align="left"><%=OwnerName %></div></td>
			</tr>
			</table>
			</td>
			</tr>
		<%}
		else
		{%>
		<tr>
			<td  class="hed" align="center">
			<table width="100%" class="stats" style="width: 600px;">
			<tr>
			<td class="hed"  align="center">Vehicle No</td>
			<td class="hed"  align="center">Vehicle Code</td>
			<td class="hed"  align="center">Transporter</td>
			</tr>
			<tr>
			<td align="left"><div align="left">NA</div></td>
			<td align="left"><div align="left">NA</div></td>
			<td align="left"><div align="left">NA</div></td>
			</tr>
			</table>
			</td>
			</tr>
		<%	
		}
		%>
		<tr>
		<td  class="hed" align="center">
		<div align="right">
		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %>
		<a href="excelignoredstamps.jsp?data=<%=thedate %>&data1=<%=thedate2 %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel">
		<img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></a>
		
		</div> 
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.No.</td>
		<td class="hed" align="center">TheDateTime</td>
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Reason </td>
		<td class="hed" align="center">Speed</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Latitude</td>
		<td class="hed" align="center">Longitude</td>
		<td class="hed" align="center">Route ID</td>
		<td class="hed" align="center">Zone</td>
		<td class="hed" align="center">Program</td>
		</tr>
		<%
		sql="select * from db_gps.t_osrejected where TheDateTime >='"+thedate1+" 00:00:00' and TheDateTime <= '"+thedate3+" 23:59:59'   and unitid='"+unitid+"' order by TheDateTime  "+limit;
		System.out.println("sql    "+sql);
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
			%>
			<tr>
			<td class="bodyText" align="right" style="width: 5px;"><div align="right"><%=i %></div></td>
			<td class="bodyText" align="right" style="width: 30px;"><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDateTime")))  %></div></td>
			<td class="bodyText" align="left" style="width: 30px;"><div align="left"><%=rst.getString("Stamp") %></div></td>
			<td class="bodyText" align="left" style="width: 100px;"><div align="left"><%=rst.getString("Reason") %></div></td>
			<td class="bodyText" align="right" style="width: 20px;"><div align="right"><%=rst.getString("Speed") %></div></td>
			<td class="bodyText" align="right" style="width: 20px;"><div align="right"><%=rst.getString("Duration") %></div></td>
			<td class="bodyText" align="right" style="width: 30px;"><div align="right"><%=rst.getString("Latitude") %></div></td>
			<td class="bodyText" align="right" style="width: 30px;"><div align="right"><%=rst.getString("Longitude") %></div></td>
			<td class="bodyText" align="right" style="width: 20px;"><div align="right"><%=rst.getString("RouteID") %></div></td>
			<td class="bodyText" align="left" style="width: 50px;"><div align="left"><%=rst.getString("Zone") %></div></td>
			<td class="bodyText" align="left" style="width: 50px;"><div align="left"><%=rst.getString("ProgramName") %></div></td>
			</tr>
		<%
		i++;
		}
			
		%>
		</table>
		</td>	
		</tr>
		
		</table>
	</form>
	
		<%
	}
	
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