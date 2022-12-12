<%@ include file="headerhtml.jsp" %>
<html>
<%@page import="java.util.Date"%>
 
<body>
<%
Connection conn=null,conn2=null;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String fromdate="",todate="";
Statement st1=null,st2=null;
int limit=0;
try{
	st1=conn.createStatement();
	st2=conn.createStatement();
	if(null==request.getQueryString())
	{
	todate=fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	}
	else
	{
 
			todate=request.getParameter("todate");
			todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
 
			fromdate=request.getParameter("fromdate");
			fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
		
	}
	%>
	<form name="unitform" action="insertUnitPerformance.jsp" method="get">
	<table border="0" width="100%" align="center"> 
	
	<tr>
	<td bgcolor="#F5F5F5"> From Date : 
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
	</td>
	<td bgcolor="#F5F5F5">To Date : 
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
 <td bgcolor="#F5F5F5" width="17%">Enter Comma-separated Unit IDs: (Maximum<b> 60</b>)</td>
  <td bgcolor="#F5F5F5">
 	<textarea id="unitids" name="unitids" rows="3" style="width: 180px;"></textarea>
 </td>
 </tr>
 
 <tr>
 <td colspan="4" align="center">
 	<input type="submit" name="submit" value="submit" >
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
</form>
</body>
</html>
