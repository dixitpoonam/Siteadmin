<%@ include file="headerhtml.jsp" %>

<%@page import="java.util.Date"%>

<script type="text/javascript">

function validate()
  {
	if(document.getElementById("data").value=="")
	 {
	  	alert("Please select the from date");
		return false;
	 }
	if(document.getElementById("data1").value=="")
	 {
	  	alert("Please select the to date");
		return false;
	 }
	 return datevalidate();
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
					if(days=='May')
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
	if(yy11>year || yy22>year)
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

 function allSelected(allVal)
 {
 	if(document.unitform.extAll.checked) 
 	{
 		document.getElementById("data").style.display='none';
     	document.getElementById("data1").style.display='none';
     }
 	else 
 	{
 		document.getElementById("data").style.display="";
     	document.getElementById("data1").style.display="";
 	}
 }
</script>

<%
	Connection conn=null;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;

String todate="",fromdate="";
int limit=0;

try{
	st1=conn.createStatement();
		todate=fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	
%>
	<form name="unitform" action="" method="get" onsubmit="return validate();">
	<table border="0" width="100%" align="center" class="sortable">
	
	<tr><td colspan="10" align="center" class="sorttable_nosort"><b>Check Report Numbers In FleetView</b> 
	</td></tr>
	
	<tr>
	
	<td bgcolor="#F5F5F5" width="65%">
	<font size="2" face="Arial">
	All <input type="checkbox" name="extAll" id="extAll" value="yes"  onclick="allSelected(this.value);"></input></font>
	
	&nbsp;&nbsp;
	<input type="text" id="data" name="data" value="<%=fromdate%>"  size="12"  style="display: " readonly>
		<script type="text/javascript">
	
  	Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data"       // ID of the button
    }
  );
	
</script>

 &nbsp;&nbsp;
	<input type="text" id="data1" name="data1" value="<%=todate%>"  size="12" style="display: " readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "data1"       // ID of the button
    }
  );
</script>
	&nbsp;&nbsp;
	<input type="submit" name="sumbit" value="submit" class="stats">
	<div align="right"><font size="2"><a href="NMCReportTrack.jsp">Add Report</a></font></div>
	</td>
	</tr>
	
	<tr>
	<td colspan="13">
	<%
	String sql="";
	String chbxAll=request.getParameter("extAll");
	System.out.println(chbxAll);
		if(null != request.getParameter("data1") && null!=request.getParameter("data"))
		{
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		}
		else
			todate=fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
		if(!(null==request.getQueryString()))
		{
			if(request.getParameter("Error")!=null){
		 		if(request.getParameter("Error").equalsIgnoreCase("true")){
	%>
			<div> <b>!!! Data <u>NOT</u> saved due to some problem !!!</b> </div>
			<%
				} else  if(request.getParameter("Error").equalsIgnoreCase("false")){
			%>
			<div><b> !!! Data saved Successfully !!!</b></div>
			<%
				} 
					}
			%>
		<!-- <table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1">
		<b> </b></font>
		</tr>
		<tr>
		<td colspan="8">-->
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">  	
		<td class="hed">Sr.</td>
		<td class="hed">ReportNumber</td>
		<td class="hed">Report Name</td>
		<td class="hed">JSP Page Name</td>
		<td class="hed">Active Status</td>
		<td class="hed">Entered By</td>
		<td class="hed">Updated DateTime</td>
		</tr>
		<%
		if(chbxAll!=null && chbxAll!="")
		{
			sql="SELECT * from t_nmcreportnumber" ;
			
		}else
		{
			 sql="SELECT * from t_nmcreportnumber "+
					" WHERE updateddatetime BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'" ;
		}
		System.out.println(sql);
				ResultSet rst=st1.executeQuery(sql);
				int i=1;
				while(rst.next())
				{
		%>
			<tr>
			<td class="bodyText"><div align="right"><%=i++%></div></td>
			<td><div align="right"><%=rst.getString("ReportNo")%></div></td>
			<td><div align="left"><%=rst.getString("ReportName")%></div></td>
			<td><div align="left"><%=rst.getString("PageName")%></div></td>
			<td><div align="left"><%=rst.getString("ActiveStatus")%></div></td>
			<td><div align="left"><%=rst.getString("EnteredBy")%></div></td>
			<%
				String UpdatedDateTime="NA";
				try{UpdatedDateTime= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.parse(rst.getString("UpdatedDateTime")));}catch(Exception e){}
			%>
			<td ><div align="right"><%=UpdatedDateTime%></div></td>
			</tr>    	  
		<%
    	  			}
    	  		%>
		  </table>
		  <!-- </td></tr></table>-->
		<%
			}
		%>
	</td>
	</tr>
	</table>
	<%
		/*ReportTracker reportGenerator=new ReportTracker();

		String pageName=this.getClass().getName();
		out.print(reportGenerator.getReportNumber(
				pageName.substring( pageName.lastIndexOf(".")+1 , pageName.length() ).replace("_","."))
				);
		
		out.print(this.getClass().getName());*/
	}catch(Exception e)
	{
		System.out.print("Exceptions "+e);
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
	%>
</form>


