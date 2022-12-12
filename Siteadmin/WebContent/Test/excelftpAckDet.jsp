<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>

<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"_FTPAckData.xls";
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
	<td >
	<%
	if(!(null==request.getQueryString()))
	{
		sql=request.getParameter("sql");
		message=request.getParameter("message");		
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="6" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b><%=message %> </b></font>
		 </th>
		</tr>
		<tr>
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Stored Date Time</td>
		<td class="hed" align="center">File Date Time</td>
		<td class="hed" align="center">File Name </td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">WMSN</td>
		</tr>
		<%
		
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td align="center"><%=i %></td>
			<td align="center">
			<% try{%>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StoredDateTime"))) %>
			<% }catch(Exception e){out.print("-");} %>
			</td>
			<td align="left">
			<% try{%>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("Filedatetime"))) %>
			<% }catch(Exception e){out.print("-");} %>
			</td>
			<td align="right"><%=rst.getString("FileName") %></td>
			<td  align="left"><%=rst.getString("UnitID") %></td>
			<td  align="left"><%=rst.getString("WMSN") %></td>
			
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
