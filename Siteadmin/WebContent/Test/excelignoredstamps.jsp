<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename="RejectedStamps_"+showdatex+".xls";
  response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!

Statement st, st1;
int limit;
Connection conn;
%>
<%

ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="", vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",defaultDate1="",calstatus="";
int count=0;
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	String lim1=request.getParameter("limit");
	String limit = "";
	if(!(null==request.getQueryString()))
	{
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2 = request.getParameter("data1");
		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate2));
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
		<td class="bodyText" align="right" style="width: 5px;"><div align="left"><%=i %></div></td>
		<td class="bodyText" align="right" style="width: 30px;"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheDateTime")))  %></div></td>
		<td class="bodyText" align="left" style="width: 30px;"><div align="left"><%=rst.getString("Stamp") %></div></td>
		<td class="bodyText" align="left" style="width: 100px;"><div align="left"><%=rst.getString("Reason") %></div></td>
		<td class="bodyText" align="right" style="width: 20px;"><div align="left"><%=rst.getString("Speed") %></div></td>
		<td class="bodyText" align="right" style="width: 20px;"><div align="left"><%=rst.getString("Duration") %></div></td>
		<td class="bodyText" align="right" style="width: 30px;"><div align="left"><%=rst.getString("Latitude") %></div></td>
		<td class="bodyText" align="right" style="width: 30px;"><div align="left"><%=rst.getString("Longitude") %></div></td>
		<td class="bodyText" align="right" style="width: 20px;"><div align="left"><%=rst.getString("RouteID") %></div></td>
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
