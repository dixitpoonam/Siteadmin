<%@ include file="headerhtml.jsp" %>
<%! 

String ss1="";
String uid="";
String version="", fname="";
%>

<%
try
{
		uid=request.getParameter("uid");
		version=request.getParameter("version");
		fname=request.getParameter("filename");
		
		ss1=request.getParameter("fileStatus");
		if(ss1.equals("Y"))
		{
		%>
		<table border="0" width="100%" bgcolor="white">
					<tr>
						<td>
						<div align="center"><font color="red"><b>DOTA File Created and Uploaded Successfully For Entered Unit ID.</b></font></div>
						</td>
					</tr>
		</table>
		<%
		}
}
catch(Exception e)
{
	out.print("");
}
%>
<form name="createDotaFile" action="createDotaFile.jsp" method="post"">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="0f55f0" size="3">
<b>Send DOTA SMS To Unit.</b>
<br><br>
</font>
</td></tr>
</table>
<table border="0" align="center">
<tr>
<br><br>
<a href="sendDotaSms.jsp?uid=<%=uid%>&version=<%=version%>&filename=<%=fname%></a>">Send SMS</a></td>
<br><br>
</td>
</tr>
</table>
</form>
<%
try
{
		String status=request.getParameter("flgStatus");
		if(status.equals("N"))
		{
		%>
		<table border="0" width="100%" bgcolor="white">
					<tr>
						<td>
						<div align="center"><font color="red"><b>Unable to send sms to Unit.</b></font></div>
						</td>
					</tr>
				</table>
		<%
		}
}
catch(Exception e)
{
	out.print("");
}
%>

