//<%@ include file="headerhtml.jsp" %>

<script language="javascript">

function validate()
{
	var vehno=document.analyzefueldata.vehs.value;

	if(vehno=="Select")
	{
		alert("Please select Vehicle No");
		return false;	
	}		
}
function confirmSubmit()
{
	var agree=confirm("Are you sure you wish to continue?");
	if (agree)
		return true ;
	else
		return false ;
	
	
}
</script>

<%!
Statement st, st1;Connection conn;
%>

<form name="analyzefueldata" method="get" action="" onSubmit="return validate();">
<%
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
	st1=conn.createStatement();
		
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String today = formatter.format(tdydte);
	
	String vehno=request.getParameter("vehno");
	String vehcode=request.getParameter("vehcode");
	String date1=request.getParameter("date1");
	String date2=request.getParameter("date2");
	
	String updated=request.getParameter("updated");
	if(!(updated==null))
	{ %>
			<table border="0" width="100%" align="center">
				<tr><td bgcolor="#f5f5f5" align="center"><b><font color="" size="2"> Successfully Updated</font></b></td></tr>
			</table>
<%	}
%>	
<table border="0" width="100%" align="center">
<tr><td bgcolor="#f5f5f5" align="center"><b><font color="" size="2">Analyze Data of <%=vehno %> between <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %> and <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></font></b></td></tr>
</table>

<table border="0" width="100%" align="center">

<tr><td align="center">
<table border="0" width="80%" align="center">

<tr>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Date-Time</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Speed</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Distance</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Data Valid</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Stamp</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Fuel Level</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Validate</font></td>
<tr>	
<%
	int i=1, dist=0;
	int prevfuel=0,diff=0,curlevel=0;
	String loc="",lat="",lon="",datavalid="";
	String sql1="select * from t_veh"+vehcode+" where TheFieldDataDate between '"+date1+"' and '"+date2+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
	ResultSet rs1=st.executeQuery(sql1);
	
	while(rs1.next())
	{ 
		
		if(i==1)
		{
			dist=rs1.getInt("Distance");
			prevfuel=Integer.parseInt(rs1.getString("FuelLevel"));			
		}
		
		curlevel=Integer.parseInt(rs1.getString("FuelLevel"));
		loc=rs1.getString("TheFieldSubject");
		lon=rs1.getString("LonginDec");
		lat=rs1.getString("LatinDec");
		datavalid=rs1.getString("DataValid");
		diff=prevfuel-curlevel;
		String datetime=rs1.getString("TheFieldDataDate")+" "+rs1.getString("TheFieldDataTime");
		
		String bgcolor="";
		
		if(rs1.getString("TheFiledTextFileName").equals("FT1"))
		{
			bgcolor="yellow";
		}
	%>
		<tr bgcolor=<%=bgcolor %>>
			<td> <%=i %> </td>
			<td> <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(datetime)) %> </td>
			<td> <%=rs1.getString("Speed") %></td>
			<td> <%=rs1.getInt("Distance") -dist%></td>
			<td> <%=rs1.getString("DataValid") %></td>
			<td> <%=rs1.getString("TheFiledTextFileName") %></td>
			<td> <%=rs1.getString("FuelLevel") %></td>
			<%
				if(rs1.getString("TheFiledTextFileName").equals("FT1"))
				{	
			%>
					<td align="center"> <a href="changefuelstamp.jsp?fielddate=<%=rs1.getString("TheFieldDataDate") %>&fieldtime=<%=rs1.getString("TheFieldDataTime") %>&vehid=<%=vehcode %>&vehno=<%=vehno %>&seldate1=<%=date1 %>&seldate2=<%=date2 %>&currfuellevel=<%=rs1.getString("FuelLevel") %>&prvfuellevel=<%=prevfuel %>&diff=<%=diff %>&loc=<%=loc %>&latin=<%=lat %>&lon=<%=lon %>" onClick="return confirmSubmit();"> Validate</a></td>
			<%	}
				else
				{ %>
					<td align="center">  NA  </td>
			<%	}		
			%>		
		</tr>
	<%
		i++;
		if(datavalid.equals("Yes"))
		{	
			prevfuel=curlevel;
		}	
	}
%>

	</table>

</td></tr>
</table>

<%		
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
	}finally{
		conn.close();
	}
%>	
</form>
<%@ include file="footerhtml.jsp" %>
