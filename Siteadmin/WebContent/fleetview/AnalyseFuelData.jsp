<%@ include file="headerhtml.jsp" %>

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
	
	String date1=request.getParameter("thedate");
	
	
%>	
<table border="0" width="100%" align="center">
<tr><td bgcolor="#f5f5f5" align="center"><b><font color="" size="2">Analyze Fuel Data</font></b></td></tr>
<tr>
	<td>    
   		<input type="text" id="thedate" name="thedate" size="13" class="formElement" value="<%=today%>" readonly/>
		<img src="../images/calendar.png" id="trigger" border="0">
		<!-- <input type="button" name="trigger" id="trigger" value="From Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "thedate",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="text" id="thedate1" name="thedate1" size="13" class="formElement" value="<%=today%>" readonly/>
		<img src="../images/calendar.png" id="trigger1" border="0">
		<!-- <input type="button" name="trigger1" id="trigger1" value="To Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "thedate1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger1"       // ID of the button
             }
                           );
             </script>
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="Submit" name="Submit" Value="Submit" class="formElement">
   </td>
</tr>
</table>

<%
if(!(date1==null))
{
	
	String date2=request.getParameter("thedate1");
%>
<table border="0" width="100%" align="center">

<tr><td align="center">
<table border="0" width="60%" align="center">
<tr>
	<td colspan="3" align="center"> <b> Analysis between <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date1)) %> and <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date2)) %></b> </td>
</tr>
<tr>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Vehicle No</font></td>
	<td align="center" bgcolor="#2696B8"><font color="white" size="2">Count</font></td>
<tr>	
<%
	int i=1;
	String sql1="select * from t_vehicledetails where Description='FUELFLOW' order by VehicleRegNumber asc";
	//out.print(sql1);
	ResultSet rs1=st.executeQuery(sql1);
	while(rs1.next())
	{
		int  dist=0, j=0, count=0;
		boolean flag=false;
		
		String vehcode=rs1.getString("VehicleCode");
		String vehno=rs1.getString("VehicleRegNumber");
		
		String sql3="select * from t_veh"+vehcode+" where TheFieldDataDate between '"+date1+"' and '"+date2+"' and TheFiledTextFileName='FT1' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		//out.print(sql3);
		ResultSet rs3=st1.executeQuery(sql3);
		while(rs3.next())
		{
			flag=true;
			count++;
		}
		
		if(flag==true)
		{	
			
		%>
			<tr>
				<td> <%=i %> </td>
				<td>   <%=vehno %>  </td>
				<td> <a href="analysealldata.jsp?vehcode=<%=vehcode %>&vehno=<%=vehno %>&date1=<%=date1 %>&date2=<%=date2 %>"> <%=count %> </a> </td>
								
			</tr>
<%			i++;	
			j++;
			count++;
		}	
	
	}
		
		
		
%>

</table>
<% } // close of if %>
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
