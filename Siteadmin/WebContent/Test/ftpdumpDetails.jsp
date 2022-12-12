<%@ include file="headerhtml.jsp" %>
<script type="text/javascript">
function SearchCrit(ind)
{ 
	if(ind=="1")
	{
		document.getElementById("unitid").disabled=true;
		document.getElementById("flag").value="flase";
	}
	else
	{
		document.getElementById("unitid").disabled=false;
		document.getElementById("flag").value="true";
 	}
}
</script>
<%!
Connection conn;
Statement st1,st2;
String sql, unitid, vehcode,flag,search,message;
int limit;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn.createStatement();
	st2=conn.createStatement();
	
	%>
	<table border="0" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the search option to see the FTP data.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5"><label>
	<input type="radio" name="Search" onclick="SearchCrit(0);"   />Unit id</label>
	</td><td bgcolor="#F5F5F5"><label>
  	<input type="radio" name="Search" onclick="SearchCrit(1);" checked/> ALL </label>
	<input type="hidden" name="flag" id="flag" value="false">
	</td>
	<td bgcolor="#F5F5F5"><input type="text" name="unitid" id="unitid" class="stats" disabled="disabled"></input> </td>
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
		unitid=request.getParameter("unitid");
		 message="The FTP Data of unit "+unitid; 
		flag=request.getParameter("flag");
		if(flag.equalsIgnoreCase("true"))
		{   
		 
			 unitid=request.getParameter("unitid");
			 message="The FTP Data of unit "+unitid;
			 String rid="";
			 String ssql="select rid,max(StoredDateTime) as rr from db_gps.t_ftplastdump where unitid in ("+unitid+") group by UnitID order by  StoredDateTime";
			 System.out.println(ssql);	 
			 ResultSet rst11=st2.executeQuery(ssql);
			 if(rst11.next())
				{				
			 	rid="\'"+rst11.getString("rr")+"\'";
				}	
			 while(rst11.next())
				{
				 rid+=",\'"+rst11.getString("rr")+"\'";			 	
				}

			
			
		 sql="select * from t_ftplastdump where StoredDateTime in ("+rid+") order by StoredDateTime desc ";
		 System.out.println(sql);
		}
		else
		{
			message="All FTP Data ";
			sql="select * from t_ftplastdump order by StoredDateTime desc";
		}
				
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		
		<table border="0" width="100	%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b><%=message %> </b></font>
		<div align="right"><a href="excelftpdumpdata.jsp?sql=<%=sql %>&message=<%=message %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		<tr><td colspan="27">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		
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
		<td class="hed" align="center">JRM Status</td>
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
			<td align="center"><%=i %></td>
			<% try{%>
			<td align="center"><%=rst.getString("StoredDateTime") %></td>
			<% }catch(Exception e){out.print("-");} %>
			<% try{%>
			<td align="left"><%=rst.getString("Filedatetime") %></td>
			<% }catch(Exception e){out.print("-");} %>
			
			<td align="right"><%=rst.getString("FileName") %></td>
			<td  align="left"><%=rst.getString("UnitID") %></td>
			<td  align="left"><%=rst.getString("routeid") %></td>
			<td  align="left"><%=rst.getString("WMSN") %></td>
			<td  align="left"><%=rst.getString("SimNo") %></td>
			<td  align="center"><%=rst.getString("UnitType") %></td>
			<td  align="center"><%=rst.getString("Server") %></td>
			<td  align="center"><%=rst.getString("FromID") %></td>
			<td  align="center"><%=rst.getString("ToID") %></td>
			<td  align="center"><%=rst.getString("FTPServer") %></td>
			<td  align="center"><%=rst.getString("Username") %></td>
			<td  align="center"><%=rst.getString("Callno1") %></td>
			<td  align="center"><%=rst.getString("CallNo2") %></td>
			<td  align="center"><%=rst.getString("TXInterval") %></td>
			<td  align="center"><%=rst.getString("StInterval") %></td>
			<td  align="center"><%=rst.getString("CodeVersion") %></td>
			<td  align="center"><%=rst.getString("FW") %></td>
			<td  align="center"><%=rst.getString("APN") %></td>
			<td  align="center"><%=rst.getString("JS") %></td>
			<td align="center"><%=rst.getString("RmcString") %></td>
			<td align="center"><%=rst.getString("RmcDate") %></td>
			<td  align="center"><%=rst.getString("RmcTime") %></td>
			<td  align="center"><%=rst.getString("RmcLat") %></td>
			<td  align="center"><%=rst.getString("RmcLon") %></td>
			<td  align="center"><%=rst.getString("Location") %></td>
			<td align="center"><%=rst.getString("IMEI_No") %></td>
			<td align="center"><%=rst.getString("OS") %></td>
			<td align="center"><%=rst.getString("OS1") %></td>
			<td align="center"><%=rst.getString("OS2") %></td>
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

