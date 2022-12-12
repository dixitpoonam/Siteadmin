<%@ include file="headerhtml.jsp" %>
<%! 
String sql;
String ss1="";
String uid="";
String version="";
%>

<%
try
{
//	out.println("------create Dota---------");
		version=request.getParameter("version"); 
		uid=request.getParameter("uid");
		ss1=request.getParameter("flag");
//		out.println("===="+version+"======"+uid+"========="+ss1+"========");
		if(ss1.equals("Y"))
		{
		%>
		<table border="0" width="100%" bgcolor="white">
					<tr>
						<td>
						<div align="center"><font color="red"><b>Entered Unit ID is Valid.</b></font></div>
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
<br><br>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="0f55f0" size="4">
<b>Create DOTA File</b>
<br><br>
</font>
</td></tr>
</table>
<table border="0" align="center">
<tr>
<br><br>
<a href="createDotaFile.jsp?uid=<%=uid%>&vehVersion=<%=version%></a>"><b><font size="2">Generate DOTA File</font></b></a></td>
<br><br>
</td>
</tr>
</table>
</form>
<%
try
{
		String status=request.getParameter("fileStatus");
		if(status.equals("N"))
		{
		%>
		<table border="0" width="100%" bgcolor="white">
					<tr>
						<td>
						<div align="center"><font color="red"><b>Unable to create DOTA file.</b></font></div>
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

