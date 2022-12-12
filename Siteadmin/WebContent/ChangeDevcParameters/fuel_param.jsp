<%@ include file="headerhtml.jsp" %>
<%! 

String ss1="";
%>

<form name="fuelform" action="fuelSend.jsp" method="post"">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Enter Unit ID for the vehicle and changed fuel parameters.
</b>
<br><br>
</font>
</td></tr>
</table>
<table border="0" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2">Unit ID :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="uid" id="uid" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 1 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p1" id="p1" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 2 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p2" id="p2" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 3 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p3" id="p3" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 4 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p4" id="p4" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 5 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p5" id="p5" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Parameter 6 :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="p6" id="p6" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5" colspan="2" align="center"><font size="2"><input type="submit" name="Submit" value="Submit"></font></td>
<br><br><br><br>
</tr>

</table>
</form>
<%
try
{
ss1=request.getParameter("flag");
if(ss1.equals("Y"))
{
%>
<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>Message sent successfully!</b></font></div>
				</td>
			</tr>
		</table>
<%
}
if(ss1.equals("N"))
{
	%>
	<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>Unable to send message</b></font></div>
				</td>
			</tr>
		</table>
	<%	
}
}
catch(Exception e)
{
	out.println("");
}

%>

<%@ include file="footerhtml.jsp" %>