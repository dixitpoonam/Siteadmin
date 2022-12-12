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
	message="The data from "+fromdate1+" to "+todate1;
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
	%>
	<table border="20" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the search option to see the FTP data.</b> </td></tr>
	<tr>
	<td align="right">
			  <input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15"  readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger"  >
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
  			  	<input type="button" name="To Date" value="To Date" id="trigger1"  >
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
		 sql="select * from t_ftpacknowledge where StoredDateTime between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' order by StoredDateTime desc";
		System.out.println(sql);
				
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center" style="border: none;">
		<tr bgcolor="#2696B8" style="border: none;">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center" style="border: none;"><font color="white" size="1"><b><%=message %> </b></font>
		<div align="right"><a href="excelftpAckDet.jsp?sql=<%=sql %>&message=<%=message %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		<tr style="border: none;" ><td colspan="27" style="border: none;">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
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

