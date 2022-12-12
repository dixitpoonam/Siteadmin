<%@ include file="headerhtml.jsp" %>
<%! 

String ss1="";
%>

<form name="trstform" action="trstSend.jsp" method="post"">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Enter the Unit ID for the vehicle and changed Transmission and Stamping value.
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
<td bgcolor="#f5f5f5"><font size="2">New Transmission value :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="trans" id="trans" size="15" value="">
<br><br>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">New Stamping value :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="stamp" id="stamp" size="15" value="">
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
System.out.println("ss1===newmsg=>"+ss1);
System.out.println("ss1121212121===newmsg=>"+ss1);
if(ss1!=null)
{
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
}
catch(Exception e)
{
	out.println(""+e);
}

%>

<%@ include file="footerhtml.jsp" %>