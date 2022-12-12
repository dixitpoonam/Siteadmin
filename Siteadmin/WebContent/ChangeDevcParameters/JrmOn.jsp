<%@ include file="headerhtml.jsp" %>
<%! 

String ss1="";
%>

<form name="jrmform" action="jrmSend.jsp" method="post"">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Enter Unit ID for the vehicle and Route details.
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
<td bgcolor="#f5f5f5"><font size="2">No. of Route Files :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="root" id="root" size="15" value="">
<br><br>
</td>
</tr>

<tr>
<td bgcolor="#f5f5f5"><font size="2">Route ID :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="rootId" id="rootId" size="15" value="">
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