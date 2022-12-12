<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename="MIS_Level2_Report_"+showdatex+".xls";
  response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%@page import="java.util.Date"%>
<%!

Statement st, st1;
int limit;
Connection conn;
%>

<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql = "",sql1 = "",unitid = "",vehregno = "",transporter = "",Defaultdate = "",DefaultTime = "",reason = "",stamp1 = "",stamp = "",thedate = "",thedate1 = "";

int count=0;
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	
	thedate=request.getParameter("data");
	thedate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate));
	//thedate2 = request.getParameter("data1");
//	thedate3=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2));
	stamp = request.getParameter("stamp");
	unitid = request.getParameter("unitid");
	
	System.out.println("unitid "+unitid);
	%>
	<table border="0" width="100%" align="center">
			<tr bgcolor="#2696B8">
			<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>MIS Level 1 Report  of Rejected <%if(stamp.equalsIgnoreCase("stamp")){%> stamps<%}else {%> <%=stamp %>  stamps<%} %> for date <%=thedate1 %></b></font>
			</th>
			</tr>
			<tr>
		<td  class="hed" align="center">
		<table  border="0"  class="sortable" align="center" width="100%">
		<tr>
		<%
		if(stamp.equalsIgnoreCase("stamp"))
		{
		%>
		 	<td class="hed" align="center" style="width: 5px;">Sr.No.</td>
			<td class="hed" align="center" style="width: 40px;">UnitID</td>
			<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
			<td class="hed" align="center" style="width: 40px;">Date </td>
			<td class="hed" align="center" style="width: 40px;">Time </td>
			<td class="hed" align="center" style="width: 150px;">Transporter</td>
			<td class="hed" align="center" style="width: 200px;">Stamp</td>
			<td class="hed" align="center" style="width: 150px;">Reason</td>
		
		<%
		}
		else
		{
			%>
		<td class="hed" align="center" style="width: 3px;">Sr.No.</td>
		<td class="hed" align="center" style="width: 30px;">UnitID</td>
		<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
		<td class="hed" align="center" style="width: 30px;">Date </td>
		<td class="hed" align="center" style="width: 30px;">Time </td>
		<td class="hed" align="center" style="width: 150px;">Transporter</td>
		<td class="hed" align="center" style="width: 30px;">Stamp</td>
		<td class="hed" align="center" style="width: 150px;">Reason</td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>From Speed<%}else{%>Speed<%} %></td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>To Speed<%}else if(stamp.equalsIgnoreCase("OS")){%>Duration<%}else{%>Distance<%}%></td>
		<td class="hed" align="center" style="width: 30px;">Latitude</td>
		<td class="hed" align="center" style="width: 30px;">Longitude</td>
		<%
		if(stamp.equalsIgnoreCase("OS"))
		{
			%>
			<td class="hed" align="center" style="width: 30px;">RouteID</td>
			<td class="hed" align="center" style="width: 30px;">Zone</td>
			<%
		}
		%>
		<td class="hed" align="center" style="width: 50px;">Program</td>
			<%
		}
		%>
		</tr>
		<%
		if(stamp.equalsIgnoreCase("AC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('AC1','AC1D','ACDuplicate')  and unitid = '"+unitid+"' order by TheDatetime";
		}
		else
		if(stamp.equalsIgnoreCase("DC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('DC1','DC1D','DCDuplicate') and unitid = '"+unitid+"' order by TheDatetime ";
		}
		else
			if(stamp.equalsIgnoreCase("OS"))
			{
				sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('OS3','OS3D','OSDuplicate','OSIgnore') and unitid = '"+unitid+"' order by TheDatetime";
			}
			else
				if(stamp.equalsIgnoreCase("SI"))
				{
					sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('SI1') and unitid = '"+unitid+"' order by TheDatetime ";
				}
				else
					if(stamp.equalsIgnoreCase("stamp"))
					{
						sql = "select * from db_gps.t_invaliddata where storeddate = '"+thedate+"'   and unitid = '"+unitid+"' order by storeddate,storedtime ";
					}
		
		ResultSet rs = st.executeQuery(sql);
		System.out.println("sql "+sql);
		while(rs.next())
		{
			count++;
			if(stamp.equalsIgnoreCase("stamp"))
			{
				 sql1 = "select * from db_gps.t_vehicledetails where unitid = '"+rs.getString("unitid")+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				if(rs1.next())
				{
					unitid = rs.getString("unitid");
					vehregno = rs1.getString("vehicleregnumber");
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter = rs1.getString("OwnerName");
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				else
				{
					unitid = rs.getString("unitid");
					vehregno = "-";
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter ="-";
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" "><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				</tr>
				<%
			}
			else
			{
				unitid = rs.getString("unitid");
				vehregno = rs.getString("VehRegNo");
				Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				transporter = rs.getString("Transporter");
				reason = rs.getString("Reason");
				reason = reason.replace("<overSpeedDurationInSecs"," Less Than overSpeedDurationInSecs");
				stamp1 = rs.getString("Stamp");
				//System.out.println("reason  "+reason);
				
				
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Speed")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Duration")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Latitude")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Longitude")%></div></td>
				<%
				if(stamp.equalsIgnoreCase("OS"))
				{
					%>
					<td class="bodyText" align="right" ><div align="right"><%=rs.getString("RouteID")%></div></td>
					<td class="bodyText" align="left" ><div align="left"><%=rs.getString("Zone")%></div></td>
					<%
				}
				%>
				<td class="bodyText" align="left" ><div align="left"><%=rs.getString("ProgramName")%></div></td>
				</tr>
				<%
			}
			
			
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
		