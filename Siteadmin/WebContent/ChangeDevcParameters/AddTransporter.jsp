<%@ include file="headerhtml.jsp" %>

<script language="javascript">
function validate()
{
	var v1,v2;
	v1=document.getElementById("transporter").value;
//	v2=document.transEmail.value;
	alert(v2);
	if(v1=="Select")
	{
		alert("Please Select Location");
		return false;
	}
/*	if(v2=="")
	{
		alert("Please Select Transporter or Location");
		return false;
	}*/
	return true;
}
</script>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Add New Sending/Receiving Location with Mail ID
</b>
<br><br>
</font>
</td></tr>
</table>

<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<table border="0" >
<%
String dispMsg=request.getParameter("dispMsg");
if(!(dispMsg==null))
{
%>
<tr><td align="left"><font size="2" color="red"><b><%=dispMsg %></b></font></td></tr>
<%} %>
<tr><td></td></tr>
</table>
<table border="0" align="center" width="100%">
<tr><td align="center">

<form method="post" action="addtrans.jsp">
<table align="center" width="100%">
<tr>
<td align="center">Sending/Receiving Location Not in Table</td>
<td align="center">	

	<select name="transporter" id="transporter" class="formElement">
	<option value="Select">Select</option>
<% 
	String sPlace="";
	Statement stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
//	String sql="select StartPlace from db_gps.t_startedjourney group by StartPlace order by StartPlace asc";
	String sql="select StartPlace from db_gps.t_startedjourney group by StartPlace "+ 
		"union "+
		"select EndPlace from db_gps.t_startedjourney group by EndPlace "+ 
		"order by 1";
   ResultSet rst3=stmt.executeQuery(sql);
    while(rst3.next())
    {
    	sPlace=rst3.getString("StartPlace");
    	
    	String sqlCh="select TransporterName from db_gps.t_transportermailid where TransporterName like '"+sPlace+"'";
    	ResultSet rsCh=stmt1.executeQuery(sqlCh);
    	if(rsCh.next())
    	{
    	}
    	else
    	{
    		%>
    	     <option value="<%=sPlace%>"> <%=sPlace%></option>
    <% 	}%>
   
 <%} %>
    </select> 
  
</td>
</tr>

<tr>
<td align="center">Enter Email-ID:</td>
<td align="center"><textarea cols="50" rows="3" name="transEmail" id="transEmail"></textarea></td>

</tr>
<tr>
<td></td>
<td align="left"><input type="submit" value="Submit" /></td></tr>
</table>
</form>


</td></tr>
</table>



<%@ include file="footerhtml.jsp" %>