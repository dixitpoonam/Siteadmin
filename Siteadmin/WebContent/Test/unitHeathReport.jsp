<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="headerhtml.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
-->
<script type="text/javascript">
</script>

<%!

Connection conn;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;
String sql=null,message=null;
int limit=0;
try{
	String fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	st1=conn.createStatement();
	if(!(null==request.getParameter("data")))
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	fromdate1=request.getParameter("data");
	todate1=request.getParameter("data1");
	System.out.println(fromdate1);
	System.out.println(todate1);
	message="Exception Report from "+fromdate1+" to "+todate1;
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	message="";	 
	//out.print(todate);
	}
	/*
	ReportTracker reportGenerator=new ReportTracker();

	String pageName=this.getClass().getName();
	String pageno=reportGenerator.getReportNumber(
			pageName.substring( pageName.lastIndexOf(".")+1 , pageName.length() ).replace("_","."));
	System.out.println(pageno);
	System.out.println(pageName);
	out.print(reportGenerator.getReportNumber(
			pageName.substring( pageName.lastIndexOf(".")+1 , pageName.length() ).replace("_","."))
			);
	
	out.print(this.getClass().getName());
	*/
%>
	<form name="unithealthreportform" action="" method="get">
    <table border="20" width="100%" align="center" class="sortable">
	
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the search option to see the Unit Health Report.</b> </td></tr>
	<tr>
	<td align="right">
			  <input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15"  readonly/>
  			
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
			<td align="right">
			  	<input type="text" id="data1" name="data1"  value="<%=todate1 %>"   size="15" readonly/></td><td align="left">
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		sql="select Vehid,VehRegNo,Transporter,UnitID,TheDate,SpeedLimitExceedCount,RACountExceedCount,RDCountExceedCount,OSCountExceedCount,OFCountExceedCount,ONCountExceedCount,AC1CountExceedCount,DC1CountExceedCount,OS3CountExceedCount,ERCountExceedCount,NGCountExceedCount,VDCountExceedCount,DailyDistanceExceed,DistanceZerobutLocationChange,ZeroDistance,Nodata,NoDataYesterdayAvailabletoday,DifferenceinUnitDistandCorrectedDist from t_unitHealthReport where TheDate between '"+fromdate+"' and '"+todate+"' order by UpdatedDateTime desc";
		System.out.println(sql);
				
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center" style="border: none;">
		<tr bgcolor="#2696B8" style="border: none;">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center" style="border: none;"><font color="white" size="3"><b><%=message %> </b></font>
		<div align="right"><a href="?sql=<%=sql %>&message=<%=message %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		<tr style="border: none;" ><td colspan="27" style="border: none;">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr No</td>
		<td class="hed" align="center">Veh ID</td>
		<td class="hed" align="center">VehRegNo</td>
		<td class="hed" align="center">Transporter</td>
		<td class="hed" align="center">Unit<br>ID </td>
		<td class="hed" align="center">Date</td>
		<td class="hed" align="center">SpeedLimit<br>(>90)</td>
		<td class="hed" align="center">RACount<br>(>5)</td>
		<td class="hed" align="center">RDCount<br>(>5)</td>
		<td class="hed" align="center">OSCount<br>(>5)</td>
		<td class="hed" align="center">OFCount<br>(>5)</td>
		<td class="hed" align="center">ONCount<br>(>5)</td>
		<td class="hed" align="center">AC1Count<br>(>1)</td>
		<td class="hed" align="center">DC1Count<br>(>1)</td>
		<td class="hed" align="center">OS3Count<br>(>1)</td>
		<td class="hed" align="center">ERCount<br>(>5)</td>
		<td class="hed" align="center">NGCount<br>(>3)</td>
		<td class="hed" align="center">VDCount<br>(>10)</td>
		<td class="hed" align="center">DailyDistance<br>(>350)</td>
		<td class="hed" align="center">Zero Distance<br> But <br>Location Change</td>
		<td class="hed" align="center">Zero Distance</td>
		<td class="hed" align="center">Data<br>Available</td>
		<td class="hed" align="center">No Data Yesterday but<br>Available today</td>
		<td class="hed" align="center">Difference In Unit<br>Distance and Corrected Distance</td>
		
		</tr>
	<%
		String vehcode="",vehno="",trans="",unitid="";
		int speed=0,RA=0,RD=0,OS=0,OF=0,ON=0,AC1=0,DC1=0,OS3=0,ER=0,NG=0,VD=0,DailyDistnce=0;
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		speed=rst.getInt("SpeedLimitExceedCount");
		RA=rst.getInt("RACountExceedCount");
		RD=rst.getInt("RDCountExceedCount");
		OS=rst.getInt("OSCountExceedCount");
		OF=rst.getInt("OFCountExceedCount");
		ON=rst.getInt("ONCountExceedCount");
		AC1=rst.getInt("AC1CountExceedCount");
		DC1=rst.getInt("DC1CountExceedCount");
		OS3=rst.getInt("OS3CountExceedCount");
		ER=rst.getInt("ERCountExceedCount");
		NG=rst.getInt("NGCountExceedCount");
		VD=rst.getInt("VDCountExceedCount");
		DailyDistnce=rst.getInt("DailyDistanceExceed");
		%>
		<tr>
			<td><div align="right"><%=i%></div></td>
			<td><div align="left"><%=rst.getString("Vehid") %></div></td>
			<td><div align="left"><%=rst.getString("VehRegNo") %></div></td>
			<td><div align="left"><%=rst.getString("Transporter") %></div></td>
			<td><div align="right"><%=rst.getString("UnitID") %></div></td>
			<td align="left">
			<% try{%>
			<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("TheDate")))%>
			<% }catch(Exception e){out.print("-");} %>
			</td>
		    <td><div align="right"><%=speed%></div></td>
			<td><div align="right"><%=RA%></div></td>
			<td><div align="right"><%=RD%></div></td>
			<td><div align="right"><%=OS %></div></td>
			<td><div align="right"><%=OF %></div></td>
			<td><div align="right"><%=ON %></div></td>
			<td><div align="right"><%=AC1 %></div></td>
			<td><div align="right"><%=DC1%></div></td>
			<td><div align="right"><%=OS3 %></div></td>
			<td><div align="right"><%=ER %></div></td>
			<td><div align="right"><%=NG %></div></td>
			<td><div align="right"><%=VD %></div></td>
			<td><div align="right"><%=DailyDistnce %></div></td>
			<td><div align="left"><%=rst.getString("DistanceZeroButLocationChange") %></div></td>
			<td><div align="left"><%=rst.getString("ZeroDistance") %></div></td>
			<%
			if("Avail".equalsIgnoreCase(rst.getString("NoData"))){ 
				%>
				<td><div align="left">Available</div></td>
				<%
				
			}else{
			%>
			<td><div align="left">Not Available</div></td>
			<%
			}
			%>
			<td><div align="left"><%=rst.getString("NoDataYesterdayAvailabletoday") %></div></td>
			<td><div align="right"><%=rst.getString("DifferenceinUnitDistandCorrectedDist") %></div></td>
			
			</tr>
		<%
		i++;
		}
		%>
		  </table>
		  </td></tr></table>
		 
		<%
	}%>	
	</td>
	</tr>
</table>	
	</form>
<%
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
		try{
			conn.close();
			
			}catch(Exception ee)
			{
				
			}
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>
	
	