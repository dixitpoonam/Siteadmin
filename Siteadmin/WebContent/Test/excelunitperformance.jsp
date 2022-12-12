<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"_UnitPerformance.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!

Statement st1;
String sql, unitid, vehcode,flag,search,message;
int limit;
Connection conn,conn1,conn2;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn2 = DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null,st2=null,st3=null;
String sql=null, unitid=null, vehcode=null,flag=null,search=null,message=null,todate=null,fromdate=null;
int limit=0;
try{
	NumberFormat nf= NumberFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
    nf.setMinimumFractionDigits(2);
	
	st1=conn.createStatement();
	st2=conn1.createStatement();
	st3=conn2.createStatement();
	
	%>
	
<table border="0" width="100%" align="center" class="sortable">
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		
		sql=request.getParameter("sql");
		message=request.getParameter("message");	
		System.out.println("sql"+sql+" message "+message);
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8"></br>
		<th colspan="31" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="3"><b><%=message %> </b></font>
		</tr>
		<tr>
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Date</td>
		<td class="hed" align="center">Customer</td>
		<td class="hed" align="center">Vehregno</td>
		<td class="hed" align="center">VehId</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Unit Type</td>
		<td class="hed" align="center">Stamp Interval </td>
		<td class="hed" align="center">Trans Interval</td>
		<td class="hed" align="center">Codeversion</td>
		<td class="hed" align="center">APN</td>
		<td class="hed" align="center">SI Count</td>
		<td class="hed" align="center">Trans Count</td>
		<td class="hed" align="center">ON Count</td>
		<td class="hed" align="center">ER Count</td>
		<td class="hed" align="center">RA Count</td>             
		<td class="hed" align="center">RD Count</td>
		<td class="hed" align="center">OS Count</td>
		<td class="hed" align="center">OS1 Count</td>
		<td class="hed" align="center">OS2 Count</td>
		<td class="hed" align="center">FTP Count</td>
		<td class="hed" align="center">AVG_Delay</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Last date</td>
		<td class="hed" align="center">Last time</td>
		<td class="hed" align="center">Last Location</td>
		<td class="hed" align="center">Corr Dist</td>
		<td class="hed" align="center">Corr Factor</td>
		<td class="hed" align="center">Trans %</td>
		<td class="hed" align="center">Stamp %</td>
		<td class="hed" align="center">FTP File Count</td>
		</tr>
		<%
		
		ResultSet rst=st3.executeQuery(sql);
		int i=1;
		while(rst.next())
		{																																																																																																																																																																																																																																								
																																																																																																																																																																																																																																						
			
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<%try{%>
			<td class="bodyText" align="center"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))  %></td>
			<% }catch(Exception e){ out.print("-");} %>
			<% try{
			String cust=rst.getString("customer");
			if(cust==null || cust.trim().length()<=0)
				cust="-";
			%>
			<td class="bodyText" align="center"><%=cust %></td>
			<% }catch(Exception e){out.print("-");} %>
			<% try{
				String vehregno=rst.getString("vehregno");
				if(vehregno==null || vehregno.trim().length()<=0)
					vehregno="-";
			%>
			<td class="bodyText" align="left"><%=vehregno %></td>
			<% }catch(Exception e){out.print("-");} %>
			
			<td  align="right"><%=rst.getString("vehid") %></td>
			<td  align="left"><%=rst.getString("unitid") %></td>
			<td  align="left"><%=rst.getString("unittype") %></td>
			<td  align="left"><%=rst.getString("stamp_interval") %></td>
			<td  align="center"><%=rst.getString("transmission_interval") %></td>
			<td  align="center"><%=rst.getString("codeversion") %></td>
			<td  align="center"><%=rst.getString("apn") %></td>
			<td  align="center"><%=rst.getString("SI_count") %></td>
			<td  align="center"><%=rst.getString("trans_count") %></td>
			<td  align="center"><%=rst.getString("on_count") %></td>
			<td  align="center"><%=rst.getString("er_count") %></td>
			<td  align="center"><%=rst.getString("ra_count") %></td>
			<td  align="center"><%=rst.getString("rd_count") %></td>
			<td  align="center"><%=rst.getString("os_count") %></td>
			<td  align="center"><%=rst.getString("os1_count") %></td>
			<td  align="center"><%=rst.getString("os2_count") %></td>
			<td  align="center"><%=rst.getString("ftp_count") %></td>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("avg_delay")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			
			<td  align="center"><%=rst.getString("distance") %></td>
			<td  align="center"><%=rst.getString("last_date") %></td>
			<td align="center"><%=rst.getString("last_time") %></td>
			<td  align="center"><%=rst.getString("last_location") %></td>
			<td  align="center"><%=rst.getString("corr_dist") %></td>
			<td  align="center"><%=rst.getString("corr_factor") %></td>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("trans_perc")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("st_perc")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			<td align="center"><%=rst.getString("ftp_file_count") %></td>
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
	conn1.close();
	conn2.close();
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

