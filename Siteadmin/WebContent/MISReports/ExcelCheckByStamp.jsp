<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename="checkbystamp.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!Connection con1;%>
<%
try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt=con1.createStatement();
	Statement stmt1=con1.createStatement();
	String stat="",location="",StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	String sql1="";
	if(!(null==request.getParameter("fromdate")||null==request.getParameter("todate")))
	{
		fromdate=request.getParameter("fromdate");
		fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
		//fromdate1=new SimpleDateFormat("dd-MM-yyyy").format(fromdate);
		todate=request.getParameter("todate");
		todate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
		//out.print(fromdate);
	}
	else
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
		todate=fromdate;
		todate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
		//out.print(todate);
	}
	
%>
<table border="2" width="100%" class="stats">
<tr>
	<td colspan="5" align="right">
	<font size="2">
		Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		String sdt = fmt.format(new java.util.Date());
		out.print(sdt); %>
	</font>
	</td>
</tr>
<tr><td colspan="5" align="center"><b><font size="3" color="maroon">Check By Stamp Report from <%=fromdate1 %> to <%=todate1 %></font></b></td></tr>
<tr><td colspan="5">
<table  border="0" width="100%"  >
		<tr>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>Sr.No</b></font></td>
			<td align="left" bgcolor="#2696B8" colspan="2"> <font color="white" size="2"><b>OwnerName</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>OS1 Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>OS2 Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>ER Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>ON Count</b></font> </td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>SI gap1</b></font> </td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>SI gap2</b></font> </td>
		</tr>
		<%
				int i=1;
				int totos1=0,totos2=0,toter=0,toton=0,totgap1=0,totgap2=0;
				sql1="select ownername,sum(os1)as os1,sum(os2)as os2,sum(ER) as er,sum(ONCount) as oncount,sum(SIGap1) as gap1,sum(SIGap2) as gap2 from t_stampdetails  where TheDate between '"+fromdate+"' and '"+todate+"' group by Ownername order by ownername asc";
				ResultSet rs1=stmt1.executeQuery(sql1);
				while(rs1.next())
				{
					String owner=rs1.getString("ownername");				
					int os1=rs1.getInt("os1");
					totos1=totos1+os1;
					int os2=rs1.getInt("os2");
					totos2=totos2+os2;
					int er=rs1.getInt("er");
					toter=toter+er;
					int on=rs1.getInt("oncount");
					toton=toton+on;
					int gap1=rs1.getInt("gap1");
					totgap1=totgap1+gap1;
					int gap2=rs1.getInt("gap2");
					totgap2=totgap2+gap2;
		%>
		<tr bgcolor="#f5f5f5">
			<td align="center"><font size="2"><%=i %></font></td>
			<td align="left" colspan="2"><font size="2"><%=owner %></font></td>
			<td align="right"><font size="2"><%=os1%></font></td>
			<td align="right"><font size="2"><%=os2%></font></td>
			<td align="right"><font size="2"><%=er%></font></td>
			<td align="right"><font size="2"><%=on%></font></td>
			<td align="right"><font size="2"><%=gap1 %></font></td>
			<td align="right"><font size="2"><%=gap2 %></font></td>
		</tr>
<%
				i++;
				}
%>
		<tr>
			<td align="center" bgcolor="#2696B8" colspan="3"> <font color="white" size="2"><b>Total</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totos1 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totos2 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=toter %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=toton %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totgap1 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totgap2 %></b></font></td>
			
		</tr>
<%	
}
catch(Exception e)
{
	out.println("Exception----->"+e); 
}
finally
{
	con1.close();
}
%>		
		</table>
</td></tr>

<tr><td colspan="5">
		<table border="1" width="100%" > 
		<tr>
			<td class="copyright" width="100%" colspan="8" align="center">
			<b><font color="maroon" size="1">Copyright &copy; 2008 by Transworld 
			Compressor Technologies Ltd. All Rights Reserved.</font></center>
		</td></tr>
		</table>
	</td></tr>
</table>

</body>
</html>
