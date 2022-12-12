<%@ include file="headerhtml.jsp" %>
<html>
<%@page import="java.util.Date"%>
<body>

<%
Connection conn=null;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;

String todate="",fromdate="";
int limit=0;
try{
	
	st1=conn.createStatement();
	if(null==request.getQueryString())
	{
	todate=fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	}
	else
	{
		try{
			todate=request.getParameter("todate");
			todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
			System.out.println(" in main todate"+todate);
		}catch(Exception e){}
		try{
			fromdate=request.getParameter("fromdate");
			fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
			System.out.println("in main fromdate"+fromdate);
		}catch(Exception e){}
		
	}
	%>
	<form name="unitform" action="" method="get">
	<table border="0" width="100%" align="center" class="sortable">
	
	<tr><td colspan="10" align="center" class="sorttable_nosort"><b>Check UnitPerformance Status</b> 
	</td></tr>
	
	<tr>
	<td bgcolor="#F5F5F5" width="65%">Entered Between :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="fromdate" name="fromdate" value="<%=fromdate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "fromdate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "fromdate"       // ID of the button
    }
  );
</script>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="text" id="todate" name="todate" value="<%=todate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "todate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "todate"       // ID of the button
    }
  );
</script>
	</td>
	 
	<td bgcolor="#F5F5F5">
	<input type="submit" name="sumbit" value="submit" class="stats">
	</td>
	</tr>
	
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(request.getParameter("todate")));
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy")
				.parse(request.getParameter("fromdate")));
			
		if(request.getParameter("Error")!=null){
	 		if(request.getParameter("Error").equalsIgnoreCase("true")){
			%>
			<div> <b>!!! Data <u>NOT</u> saved due to some problem !!!</b> </div>
			<%} else  if(request.getParameter("Error").equalsIgnoreCase("false")){%>
			<div><b> !!! Data saved Successfully !!!</b></div>
			<%} 
		}%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1">
		<b> </b></font>
		</tr>
		<tr>
		<td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Entered On</td>
		<td class="hed" align="center">From Date</td>
		<td class="hed" align="center">To Date</td>
		<td class="hed" align="center">Unitd Ids</td>
		<td class="hed" align="center">User</td>

		<td class="hed" align="center">Process Status</td>
		</tr>
		<%
		String sql="SELECT * from t_unitperformanceunits "+
					" WHERE updateddatetime BETWEEN '"+fromdate+" 00:00:00' AND '"+todate+" 23:59:59'" ;
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{																																																																																																																																																																																																																																								
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
						<td align="right"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
			.parse(rst.getString("updateddatetime"))) %></td>
			<td  align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
			.parse(rst.getString("fromdate"))) %></td>
			<td  align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd")
			.parse(rst.getString("todate"))) %></td>
			<td  align="left"><%=rst.getString("unitids") %></td>
			<td  align="right"><%=rst.getString("enteredby") %></td>
			<td align="right"><%=rst.getString("status") %></td>
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
	out.print("Exceptions "+e);
}
finally
{
	conn.close();
}
%>
</form>
</body>
</html>
