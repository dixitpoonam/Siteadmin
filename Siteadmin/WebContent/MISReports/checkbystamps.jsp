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
	if(!(null==request.getParameter("data")))
	{
		//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
		//todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
	fromdate1=request.getParameter("data");
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
	todate1=request.getParameter("data1");
	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
	//out.print(fromdate);
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	//out.print(todate);
	}
%>		
	<table width="100%" align="center" border="0"  class="bodytext">
	<tr>
		<td align="center" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b>Check By Stamp Report</font></td>
	</tr>
	<tr><td colspan="8">
			<!-- if date range is not required please remove this code start from this comment to -->
			<script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
  				return datevalidate();
  		  }
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dy1>dy2)
			{
				alert("From date year is should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2) if(dm1>dm2)
			{
				alert("From date month is should not be greater than to date month 5");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			if(dm1==dm2) 
			{
				if(dd1 > dd2)
				{
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			return true;
		}

  	</script>
  		<table border="0" width="100%">
		<tr bgcolor="lightgrey">
			<td align="right">
			  <input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15" class="formElement" readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger" class="formElement" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script>
			</td>
			<td align="right">
			  	<input type="text" id="data1" name="data1"  value="<%=todate1 %>" class="formElement"  size="15" readonly/></td><td align="left">
  			  	<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
			<td colspan="3">
				<input type="submit" name="submit" id="submit" value="submit" class="formElement" >
			</td>
		</tr>
		</table>
		<!-- if date range is not required please remove this code start from this comment to -->
	</td></tr>
	<tr><td colspan="8">
		<table  border="0" width="100%">
		<tr><td colspan="5" align="center" bgcolor="">
			<font size="3" color="maroon"><b>Stamp Time Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 			<div align="right">
    	     		<a href="ExcelCheckByStamp.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %>
			</div>
		</td></tr>
		</table>
	</td></tr>
	<tr><td colspan="8">
		<table  border="0" width="100%"  >
		<tr>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>Sr.No</b></font></td>
			<td align="left" bgcolor="#2696B8"> <font color="white" size="2"><b> OwnerName</b></font></td>
			<td align="left" bgcolor="#2696B8"> <font color="white" size="2"><b> Vehicle Count</b></font></td>
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
				sql1="select ownername,count(vehregno) as vehcount,sum(os1)as os1,sum(os2)as os2,sum(ER) as er,sum(ONCount) as oncount,sum(SIGap1) as gap1,sum(SIGap2) as gap2 from t_stampdetails  where TheDate between '"+fromdate+"' and '"+todate+"' group by Ownername order by ownername asc";
				rs1=stmt1.executeQuery(sql1);
				while(rs1.next())
				{
					String owner=rs1.getString("ownername");	
					int vehcount=rs1.getInt("vehcount");
					totveh=totveh+vehcount;
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
			<td align="left"><font size="2"><b><%=owner %></b></font></a></td>
			<td align="right"><a href="vehdetails.jsp?owner=<%=owner%>&fromdate=<%=fromdate %>&todate=<%=todate %>"><font size="2"><%=vehcount %></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=OS1&pagefr=check"><font size="2"><%=os1%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=OS2&pagefr=check"><font size="2"><%=os2%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=ER&pagefr=check"><font size="2"><%=er%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=ON&pagefr=check"><font size="2"><%=on%></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=SIGap1&pagefr=check"><font size="2"><%=gap1 %></font></a></td>
			<td align="right"><a href="countdetails.jsp?owner=<%=owner%>&vehregno1=-&fromdate=<%=fromdate %>&todate=<%=todate %>&pagefrom=SIGap2&pagefr=check"><font size="2"><%=gap2 %></font></a></td>
		</tr>
<%
				i++;
				}
%>
		<tr>
			<td align="center" bgcolor="#2696B8" colspan="2"> <font color="white" size="2"><b>Total</b></font></td>
			<td align="right" bgcolor="#2696B8"> <font color="white" size="2"><b><%=totveh %></b></font></td>
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