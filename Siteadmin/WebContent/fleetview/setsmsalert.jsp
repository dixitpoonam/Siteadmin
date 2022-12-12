<%@ include file="headerhtml.jsp" %>
<%! 
Statement st,st1;
String sql;
Connection conn,conn1;
%>

<script language="javascript">
	function validate()
	{
		alert("hi");
		return false;
	}
</script>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Set SMS Alert for Violations
</b>
</font>
</td></tr>
<tr><td>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"" align="center"><a href="setsmsalert.jsp">Set Data Delay Alert</a></td>
<td bgcolor="#f5f5f5"" align="center"><a href="stopalert.jsp">Set Stop Alert</a></td>
<td bgcolor="#f5f5f5"" align="center"><a href="ndalert.jsp">Set Night Driving Alert</a></td>
<td bgcolor="#f5f5f5"" align="center"><a href="osalert.jsp">Set OverSpeed Alert</a></td>
<td bgcolor="#f5f5f5"" align="center"><a href="locationalert.jsp">Set Location</a></td>
</tr>
</table>
</td></tr>
<tr><td>
<table border="0" width="100%" align="center">
<tr><td align="center"><font color="brown" size="2"><b>Set SMS alert for vehicles which stop sending data.</b></font></td></tr>
<tr>
<td>
<form name="alertform" action="instsmsalert.jsp" method="post" onsubmit="javascript:return validate();">
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2">Transporter Name :</font></td>
<td bgcolor="#f5f5f5"><font size="2">
<select name="trans" id="trans">
<%


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	st=conn.createStatement();
	sql="select Distinct(TypeValue) from t_security where TypeOfUser in ('Transporter') order by TypeValue";
	ResultSet rsttrans=st.executeQuery(sql);
	while(rsttrans.next())
	{
	%>
	<option value="<%=rsttrans.getString("TypeValue")%>"><%=rsttrans.getString("TypeValue")%></option>
	<%
	}
}catch(Exception e)
{
	out.print("Exception---->"+e);
}finally{
	conn.close();
}
	%>
</select>
</font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Delay Period In Hrs. :</font></td>
<td bgcolor="#f5f5f5"><font size="2">
<select name="delayperiod" id="delayperiod">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
<option value="11">11</option>
<option value="12">12</option>
</select>
</font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Mobile Numbers :</font></td>
<td bgcolor="#f5f5f5">
<textarea name="mobno" id="mobno"></textarea>
<font size="1" color="red">Note: Please enter coma seprated mobile numbers</font>

</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Contact Names :</font></td>
<td bgcolor="#f5f5f5"><textarea name="contactname" id="contactname"></textarea>
<font size="1" color="red">Note: Please enter coma seprated contact name for above numbers</font>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5" colspan="2" align="center"><font size="2"><input type="submit" name="Submit" value="Submit"></font></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>