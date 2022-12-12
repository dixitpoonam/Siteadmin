<%@ include file="headerhtml.jsp" %>
<html>
<%@page import="java.util.Date"%>
 
 <script type="text/javascript">
 function validate()
 {
	 var name=document.getElementById("reportName").value;
	 var pname=document.getElementById("pageName").value;
      if(name.length==0)
      {
          alert("Please enter the Report Name!!!");
          return false;
      }
      else
      {
          if(pname.length==0)
          {
        	  alert("Please enter the Page Name!!!");
              return false;
          }
          else
          {
              return true;
          }
      }
	 
 }
 
 </script>
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
	/*if(null==request.getQueryString())
	{
	todate=fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	}
	else
	{
 
			todate=request.getParameter("todate");
			todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
 
			fromdate=request.getParameter("fromdate");
			fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
		
	}*/
	
	String Msg=request.getParameter("Msg");
	if(Msg!=null && Msg.equals("1"))
	{
		%>
		<script type="text/javascript">
	alert("Page Name already exist!!!");
		</script>
		<%
	}
	%>
	<form name="reportTrack" action="insertNMCReportTrack.jsp" method="post" onsubmit="return validate();">
	<table border="0" width="100%" align="center"> 
	<div align="right"><font size="2"><a href="NMCReportTrackDetails.jsp">Show Report Names</a></font></div>
	<tr>
	<td bgcolor="#F5F5F5" align="center"> Report Name : 
	<input type="text" id="reportName" name="reportName" value=""  size="20" autocomplete="off" />
	 
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Page Name: 
	 <input type="text" id="pageName" name="pageName" value=""  size="20" autocomplete="off"/>
 </td>
 
	<!-- <td bgcolor="#F5F5F5"> Report Number: 
	 <input type="text" id="reportNumber" name="reportNumber" value=""  size="12" />
 </td>-->
 
 
 </tr>
 
 <tr>
 <td colspan="4" align="center">
 <br>
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
