<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<%!
String trans="",sql;
Statement st,st1;
String typeofuser,submit;
String instcount,ordercount;Connection conn;

%>
<%
typeofuser=request.getParameter("typevalue");
instcount=request.getParameter("instcount");
ordercount=request.getParameter("ordercount");
try
	{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	st=conn.createStatement();
		
		submit=request.getParameter("submit");
		if(!(null==submit))
		{
			sql="update t_noofinstallations set TotalInst='"+ordercount+"' where Transporter='"+typeofuser+"'";
			int a=st.executeUpdate(sql);
			if(a >0)
			{
				out.print("<div align='center'><font color='red' size='2'>Updated Successfully !</font></div>");
			}
			else
			{
				sql="insert into t_noofinstallations (Transporter,TotalInst) values ('"+typeofuser+"','"+ordercount+"')";
				st.executeUpdate(sql);
				out.print("<div align='center'><font color='red' size='2'>Inserted Successfully !</font></div>");
			}
		}
		%>
		<p>&nbsp;</p>
		<form action="" method="get">
		<table border="0" width="100%" align="center">		
		<tr>
		<td colspan="2" align="center" bgcolor="#2696B8"><font color="white" size="2"><b><i>Edit Installation Limit</b></i></font></td>
		</tr>
		<tr>
		<td bgcolor="#f5f5f5" align="left"><b>Transporter :</b></td>
		<td bgcolor="#f5f5f5" align="left"><%=typeofuser%><input type="hidden" name="typevalue" value="<%=typeofuser%>"></td>
		</tr>	
		<tr>
		<td bgcolor="#f5f5f5" align="left"><b>Total Inst. Count :</b></td>
		<td bgcolor="#f5f5f5" align="left"><%=instcount%><input type="hidden" name="instcount" value="<%=instcount%>"></td>
		</tr>	
		<tr>
		<td bgcolor="#f5f5f5" align="left"><b>Total Order Count :</b></td>
		<td bgcolor="#f5f5f5" align="left"><input type="text" name="ordercount" value="<%=ordercount%>"></td>
		</tr>	
		<tr>
		<td colspan="2" align="center" bgcolor="#2696B8"><input type="submit" name="submit" value="submit"></td>
		</tr>			
		</table>
		</form>
		<%
	}
	catch(Exception e)
	{
		out.print("Exception--->"+e);
	}finally
	{
		conn.close();
		}
	%>
	</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>