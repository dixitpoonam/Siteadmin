<%@ include file="headerhtml.jsp" %>
<%! 
String ss1="";
%>

<form name="validateUnit" action="validateUnit.jsp" method="post"">
<br>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="0f55f0" size="4">
<b>Version Upgradation Of The Unit.</b>
<br><br>
<font size="2"><b>Enter Unit ID For Which Version Upgradation To Be Done.</b></font>
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
<td bgcolor="#f5f5f5" colspan="2" align="center"><font size="2"><input type="submit" name="Submit" value="Submit"></font></td>
<br><br><br><br>
</tr>
</table>
</form>
<%
try
{
ss1=request.getParameter("flag");
if(ss1.equals("N"))
{
	%>
	<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>Entered Unit ID is not valid for Version Updation.</b></font></div>
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
try
{
String status=request.getParameter("flgStatus");
if(ss1.equals("Y"))
{
	%>
	<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>DOTA sms has been sent to the Unit successfully.</b></font></div>
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

