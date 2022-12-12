<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"_FTPDumpData.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!

Statement st1;
String sql, unitid, vehcode,flag,search,message;
int limit;
Connection conn;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st1=conn.createStatement();
	
	
	%>
	<table border="0" width="100%" align="center" class="sortable">
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		sql=request.getParameter("sql");
		message=request.getParameter("message");		
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b><%=message %> </b></font>
		 </th>
		</tr>
		<tr>
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Stored Date Time</td>
		<td class="hed" align="center">File Date Time</td>
		<td class="hed" align="center">File Name </td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Routeid ID</td>
		<td class="hed" align="center">WMSN</td>
		<td class="hed" align="center">SimNo</td>
		<td class="hed" align="center">Unit Type</td>
		<td class="hed" align="center">Server</td>
		<td class="hed" align="center">FromID</td>
		<td class="hed" align="center">To ID</td>
		<td class="hed" align="center">FTPServer</td>
		<td class="hed" align="center">User Name</td>             
		<td class="hed" align="center">Call No1</td>
		<td class="hed" align="center">Call No2</td>
		<td class="hed" align="center">Trasmission Interval</td>
		<td class="hed" align="center">Stamp Interval</td>
		<td class="hed" align="center">Code Version</td>
		<td class="hed" align="center">FW</td>
		<td class="hed" align="center">APN</td>
		<td class="hed" align="center">Rmc String</td>
		<td class="hed" align="center">Rmc Date</td>
		<td class="hed" align="center">Rmc Time</td>
		<td class="hed" align="center">Rmc Lat</td>
		<td class="hed" align="center">Rmc Lon</td>
		<td class="hed" align="center">Location</td>
		<td class="hed" align="center">IMEI No</td>
		<td class="hed" align="center">OS</td>
		<td class="hed" align="center">OS1</td>
		<td class="hed" align="center">OS2</td>
		</tr>
		<%
		
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<% try{%>
			<td class="bodyText" align="center"><%=rst.getString("StoredDateTime") %></td>
			<% }catch(Exception e){out.print("-");} %>
			<% try{%>
			<td class="bodyText" align="left"><%=rst.getString("Filedatetime") %></td>
			<% }catch(Exception e){out.print("-");} %>
			
			<td class="bodyText" align="right"><%=rst.getString("FileName") %></td>
			<td class="bodyText" align="left"><%=rst.getString("UnitID") %></td>
			<td class="bodyText" align="left"><%=rst.getString("routeid") %></td>
			<td class="bodyText" align="left"><%=rst.getString("WMSN") %></td>
			<td class="bodyText" align="left"><%=rst.getString("SimNo") %></td>
			<td class="bodyText" align="center"><%=rst.getString("UnitType") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Server") %></td>
			<td class="bodyText" align="center"><%=rst.getString("FromID") %></td>
			<td class="bodyText" align="center"><%=rst.getString("ToID") %></td>
			<td class="bodyText" align="center"><%=rst.getString("FTPServer") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Username") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Callno1") %></td>
			<td class="bodyText" align="center"><%=rst.getString("CallNo2") %></td>
			<td class="bodyText" align="center"><%=rst.getString("TXInterval") %></td>
			<td class="bodyText" align="center"><%=rst.getString("StInterval") %></td>
			<td class="bodyText" align="center"><%=rst.getString("CodeVersion") %></td>
			<td class="bodyText" align="center"><%=rst.getString("FW") %></td>
			<td class="bodyText" align="center"><%=rst.getString("APN") %></td>
			<td class="bodyText" align="center"><%=rst.getString("RmcString") %></td>
			<td class="bodyText" align="center"><%=rst.getString("RmcDate") %></td>
			<td class="bodyText" align="center"><%=rst.getString("RmcTime") %></td>
			<td class="bodyText" align="center"><%=rst.getString("RmcLat") %></td>
			<td class="bodyText" align="center"><%=rst.getString("RmcLon") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Location") %></td>
			<td class="bodyText" align="center"><%=rst.getString("IMEI_No") %></td>
			<td class="bodyText" align="center"><%=rst.getString("OS") %></td>
			<td class="bodyText" align="center"><%=rst.getString("OS1") %></td>
			<td class="bodyText" align="center"><%=rst.getString("OS2") %></td>
			</tr>
		<%
		i++;
		}
		%>
		  </table>
		<%
	}%>
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
		
	}
}
%>
