<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
 <%@page import="java.util.Date"%> 

 <script language="javascript">
 function validate()
{
	var v1=document.getElementById("tripid").value;
	var v2=document.getElementById("startloc").value;
	var v3=document.getElementById("endloc").value;
	if(v1=="")
	{
		alert("Please Enter Trip Id with Comma Seperation" );
		return false;
	}
	if(v2=="")
	{
		alert("Please Enter Start Location");
		return false;
	}
	if(v3=="")
	{
		alert("Please Enter End Location");
		return false;
	}
	return true; 
}
 
 </script>
<table border="0" width="100%" align="center">
<tr><td>
<form name="kmlfiles" method="get" action="gettripdetails.jsp" onsubmit="return validate();">
<%! 
Connection conn;
%>
<% 
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	Statement stmt3 = conn.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql1="", sql2="";
	String flag=request.getParameter("flag");	
	
%>		
<%if(flag!=null && flag.equalsIgnoreCase("true"))
	{%>
	<table align="center">
	<tr align="center"><td><font color="maroon">Generated Successfully.........</td></font></tr>
	</table>
	<%} %>

<table width="100%" align="right" border="0"  class="bodytext">
	<tr>
		<td align="right" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b><a href="KMLReports.jsp"><u>Click here to see the Report</u></a></font></td>
	</tr>
	</table><br></br>
	<table width="100%" align="center" border="1"  class="bodytext">
	
	
	<tr>
		<td align="center" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b>Generate KML Files</font></td>
	</tr>
	<tr><td colspan="8">
			<!-- if date range is not required please remove this code start from this comment to -->
			
  		<table border="0" width="100%">
  		<tr>
  		<td>
  		<b>Enter Multiple Trip Id's (with comma seperation):</b></td><td><textarea row="4" cols="30" name="tripid" id="tripid"></textarea>
  		
	</td></tr>
	<tr><td><b>Enter Start Location:</b></td><td><input type="text" row="4" cols="30" name="startloc" id="startloc"></input></td></tr>
	<tr><td><b>Enter End Location:</b></td><td><input type="text" row="4" cols="30" name="endloc" id="endloc"></input></td></tr>
	<tr><td>&nbsp;</td><td><input type="submit" name="submit" value="Generate"></input>&nbsp;&nbsp;<input type="reset" value="Cancel"></input></td></tr>
		
	<%		
}// end of try loop
catch(Exception e)
{
	//System.out.println("Exception----->"+e); 
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>	
	
	
	</table>	
	</form>
<%@ include file="footerhtml.jsp"%>