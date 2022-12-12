<%@ include file="headerhtml.jsp" %>
<table border="0" width="100%" align="center">
<tr><td>
<form name="checkbystamp" action="" onsubmit="return validate();">
<%! Connection con1; %>
<% 
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	ResultSet rs1=null, rs2=null;
	String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	String owner=request.getParameter("owner");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	String pagefrom=request.getParameter("pagefrom");
	
%>		
	<table width="100%" align="center" border="0"  class="bodytext">
		
	<tr><td colspan="8">
		<table  border="0" width="100%">
		<tr><td colspan="5" align="center" bgcolor="">
			<font size="3" color="maroon"><b> Vehiclewise Count Report of <%=owner %>  from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 			<div align="right">
    	     		<a href="Excelcount.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %></font>
			</div>
		</td></tr>
		</table>
	</td></tr>
	<tr><td colspan="8">
		<table  border="0" width="100%"  >
		<tr>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>Sr.No</b></font></td>
			<td align="left" bgcolor="#2696B8"> <font color="white" size="2"><b> Vehicle Reg No</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>OS1 Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>OS2 Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>ER Count</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>ON Count</b></font> </td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>SI gap1</b></font> </td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b>SI gap2</b></font> </td>
		</tr>
		<%
				int i=1;
				int totos1=0,totos2=0,toter=0,toton=0,totgap1=0,totgap2=0,totveh=0;
				sql1="select VehRegNo,sum(os1)as os1,sum(os2)as os2,sum(ER) as er,sum(ONCount) as oncount,sum(SIGap1) as gap1,sum(SIGap2) as gap2 from t_stampdetails  where ownername like '"+owner+"' and (TheDate between '"+fromdate+"' and '"+todate+"') group by vehregno ";
				rs1=stmt1.executeQuery(sql1);
				while(rs1.next())
				{
					
				String vehregno=rs1.getString("VehRegNo");
					
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
			<td align="right"><font size="2"><%=vehregno %></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=OS1&pagefr=veh"><font size="2"><%=os1%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=OS2&pagefr=veh"><font size="2"><%=os2%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=ER&pagefr=veh"><font size="2"><%=er%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=ON&pagefr=veh"><font size="2"><%=on%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=SIGap1&pagefr=veh"><font size="2"><%=gap1 %></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=<%=vehregno %>&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=SIGap2&pagefr=veh"><font size="2"><%=gap2 %></font></a></td>
		</tr>
<%
				i++;
				}
%>
		<tr>
			<td align="center" bgcolor="#2696B8" colspan="2"> <font color="white" size="2"><b>Total</b></font></td>
			
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totos1 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totos2 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=toter %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=toton %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totgap1 %></b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totgap2 %></b></font></td>
			
		</tr>
		</table>
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
	</td></tr>	
	</table>
	</form>
<%@ include file="footerhtml.jsp" %>