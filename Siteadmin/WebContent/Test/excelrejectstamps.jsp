<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename="MIS_Summary_Report_"+showdatex+".xls";
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

int count=0;
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	
	if(!(null==request.getQueryString()))
	{
		
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2 = request.getParameter("data1");
		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate2));
	
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>MIS Summary Report of Rejected Data<%=thedate %> To <%=thedate2 %></b></font>
		</th>
		</tr>
		<tr>
		<td  class="hed" align="center">
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
			<td class="bodyText" align="right" ><div align="right"><%=ACcount%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=DCcount%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=oscount%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=SIcount%></div></td>
			<td class="bodyText" align="right" ><div align="right"><%=stampcount%></div></td>
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