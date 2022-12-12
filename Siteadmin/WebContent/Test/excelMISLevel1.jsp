<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename="MIS_Level1_Report_"+showdatex+".xls";
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
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="", vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",defaultDate1="",calstatus="";
String stamp = "";
int count=0;
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	
	thedate=request.getParameter("data");
	thedate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate));
	//thedate2 = request.getParameter("data1");
//	thedate3=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2));
	stamp = request.getParameter("stamp");
	%>
	<table border="0" width="100%" align="center">
			<tr bgcolor="#2696B8">
			<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>MIS Level 1 Report  of Rejected <%if(stamp.equalsIgnoreCase("stamp")){%> stamps<%}else {%> <%=stamp %>  stamps<%} %>  for date <%=thedate1 %></b></font>
			</th>
			</tr>
			<tr>
		<td  class="hed" align="center">
		<table  border="0"  class="sortable" align="center" style="width: 650px;">
		<tr>
		<td class="hed" align="center" style="width: 5px;">Sr.No.</td>
		<td class="hed" align="center" style="width: 40px;">UnitID</td>
		<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
		<td class="hed" align="center" style="width: 40px;">Date </td>
		<td class="hed" align="center" style="width: 150px;">Transporter</td>
		<td class="hed" align="center" style="width: 40px;">Count</td>
		</tr>
		<%
		if(stamp.equalsIgnoreCase("AC"))
		{
			sql = "select unitid,VehRegNo,Transporter,Date(TheDateTime) as thedate,count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('AC1','AC1D','ACDuplicate') group by unitid order by count(*) desc";
		}
		else
		if(stamp.equalsIgnoreCase("DC"))
		{
			sql = "select unitid,VehRegNo,Transporter,Date(TheDateTime) as thedate,count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('DC1','DC1D','DCDuplicate') group by unitid order by count(*) desc";
		}
		else
			if(stamp.equalsIgnoreCase("OS"))
			{
				sql = "select unitid,VehRegNo,Transporter,Date(TheDateTime) as thedate,count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('OS3','OS3D','OSDuplicate','OSIgnore') group by unitid order by count(*) desc";
			}
			else
				if(stamp.equalsIgnoreCase("SI"))
				{
					sql = "select unitid,VehRegNo,Transporter,Date(TheDateTime) as thedate,count(*) as cnt from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('SI1') group by unitid order by count(*) desc";
				}
				else
					if(stamp.equalsIgnoreCase("stamp"))
					{
						sql = "select unitid,storeddate,count(*) as cnt from db_gps.t_invaliddata where storeddate = '"+thedate+"'   group by unitid order by count(*) desc";
					}
		
		ResultSet rs = st.executeQuery(sql);
		while(rs.next())
		{
			
			count++;
			if(stamp.equalsIgnoreCase("stamp"))
			{
				String sql1 = "select * from db_gps.t_vehicledetails where unitid = '"+rs.getString("unitid")+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				if(rs1.next())
				{
					unitid = rs.getString("unitid");
					VehicleRegNumber = rs1.getString("vehicleregnumber");
					defaultDate =new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate"))) ;
					OwnerName = rs1.getString("OwnerName");
				}
				else
				{
					unitid = rs.getString("unitid");
					VehicleRegNumber = "-";
					defaultDate = "-";
					OwnerName = "-";
				}
			}
			else
			{
				unitid = rs.getString("unitid");
				VehicleRegNumber = rs.getString("VehRegNo");
				defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("thedate")));
				OwnerName = rs.getString("Transporter");
			}
			
			%>
			<tr>
			<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
			<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=thedate1 %></div></td>
			<td class="bodyText" align="left" ><div align="left"><%=OwnerName%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=rs.getInt("cnt")%></div></td>
			</tr>
			<%
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