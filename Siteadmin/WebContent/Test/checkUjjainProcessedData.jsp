<%@ include file="headerhtml.jsp" %>

<%!

Statement st, st1;
int limit;

%>
<%
ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="", vehcode="",OwnerName="",routeId="",VehicleRegNumber="",defaultDate="",calstatus="";
Connection c=null;
int count=0;
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	c= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_ujjainmails","ujjain","u@1jn");
	st=c.createStatement();
	st1=c.createStatement();
	
	defaultDate= new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	if(!(null==request.getQueryString()))
	{
		defaultDate=request.getParameter("data");
	}
	%>
	
<%@page import="java.util.Date"%><table border="0" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its data.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5">
	<input type="text" id="data" name="data" value="<%=defaultDate %>"  size="12" readonly/>
	</td><td bgcolor="#F5F5F5">
  	<input type="button" name="The Date" value="From Date" id="trigger">
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
	<td bgcolor="#F5F5F5">Unit ID :</td>
	<td bgcolor="#F5F5F5">
	<input type="text" name="unitid" id="unitid" class="stats"></input> 
	</td>
	<td bgcolor="#F5F5F5">Limit : </td>
	<td bgcolor="#F5F5F5">
	<input type="radio" name="limit" value="xx" checked> <input type="text" name="lim" value="10" size="5" class="stats"> </input><br>
<input type="radio" name="limit" value="All" > ALL
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		
		String lim1=request.getParameter("limit");
		String limit;
		if(lim1.equals("xx"))
		{
			limit=" limit "+request.getParameter("lim");
		}
		else
		{
			limit="";
		}
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="16" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
		<div align="right"><a href="excelcheckprocessedunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		sql="SELECT * FROM db_ujjain.t_vehicledetails where unitid='"+unitid+"'";
		System.out.println(sql);
		ResultSet rr=st.executeQuery(sql) ;

		if(rr.next())
		{
			vehcode=rr.getString("VehicleCode");
			VehicleRegNumber=rr.getString("VehicleRegNumber");
			routeId=rr.getString("RouteId");
		}
		else
		{
			vehcode="0";
			VehicleRegNumber="NA";
		}
 
		 %>
		<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="2" align="center">Vehicle Code</td>
			<td class="hed" colspan="2" align="center">Route Id</td>
			</tr>
			<tr>
			<td colspan="4"><%=VehicleRegNumber %></td>
			<td colspan="2"><%=vehcode %></td>
			<td colspan="2"><%=routeId %></td>
			</tr>
			</table>
			</td>
			</tr>
		<%	
		 
		%>
		
		<tr>
		<td colspan="16">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Stamp time</td>
		<td class="hed" align="center">Stored Time</td>
		<td class="hed" align="center">Stamp </td>
		<td class="hed" align="center">Loc</td>
		
		<td class="hed" align="center">Speed</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Latitude</td>
		<td class="hed" align="center">Longitude</td>
		</tr>
		<%

	 
		sql="select * from db_ujjain.t_veh"+vehcode+" where TheFieldDataDate='"+thedate1+"' order by TheFieldDataTime desc "+limit;
		 
 
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
			
 
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<td class="bodyText" align="center"><%=rst.getTime("TheFieldDataTime") %></td>
					 <td class="bodyText" align="center"><%=rst.getString("TheFieldDataStoredTime") %></td>
			<td class="bodyText" align="left"><%=rst.getString("TheFiledTextFileName") %></td>
			<td class="bodyText" align="right"><%=rst.getString("TheFieldSubject") %></td>
			<td class="bodyText" align="left"><%=rst.getString("Speed") %></td>
			<td class="bodyText" align="left"><%=rst.getString("Distance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LatinDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LonginDec") %></td>
 			</tr>
		<%
		i++;
		}
		%>
		  </table>
		  </td>
		  </tr>
		  </table>
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	c.close();
//	conn.close();
//	conn1.close();

	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

