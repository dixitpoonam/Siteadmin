<%@ include file="headerhtml.jsp" %>

<%!
Connection c;
Statement st, st1,st2;
String sql, unitid,thedate,thedate1,thedate2,sqlProcessed;
int limit;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	c= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_ujjainmails","ujjain","u@1jn");
	st=c.createStatement();
	st1=c.createStatement();
	st2=c.createStatement();
	%>
	
<%@page import="java.util.Date"%><table border="0" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its data.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5">
	<input type="text" id="data" name="data" value=""  size="12" readonly/>
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
<input type="radio" name="limit" value="All" > All
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="7">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		Date date1=new SimpleDateFormat("yyyy-MM-dd").parse(thedate1);
		Date change= new SimpleDateFormat("yyyy-MM-dd").parse("2010-03-02");
		
		long startdate=date1.getTime();
		long changedate=change.getTime();
		long diff=startdate-changedate;
		thedate2=thedate1.replace("-","_");
		
		
		
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
		<th colspan="8" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
		<div align="right"><a href="excelcheckunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		
		sql="select   * from db_ujjain.t_onlinedata where VehicleCode in( select VehicleCode from db_ujjain.t_vehicledetails where unitid='"+unitid+"' ) ";
		System.out.println(sql);
		ResultSet rst1=st2.executeQuery(sql);
		if(rst1.next())
		{
			%>
		<tr >
		<td colspan="8" class="hed" align="center">The current location of unit <%=unitid %> is  <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate"))+" "+rst1.getString("TheTime") +"   "+rst1.getString("Location")%></B></td>
		</tr>
			<%
		}
		%>
		<tr>
		<td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">StoredTime</td>
		<td class="hed" align="center">Vehicle No</td>
		<td class="hed" align="center">Vehicle Code</td>
		<td class="hed" align="center">Transporter</td>
		<td class="hed" align="center">MailBody</td>
		<td class="hed" align="center">Unprocessed Stamps</td>
		<td class="hed" align="center">Unit Type</td>
		</tr>
		<%
		//try typeunit from ftplastdump as per requirement of reshma maner
	//	String sqlUnitTyp = "select * from db_gps.t_unitmaster where unitid='"+unitid+"'";
		 
			sqlProcessed="SELECT StoredTime,VehRegNo,Vehid,Transporter,Body,UnProcessedStamps,MailFrom FROM t_mails"+thedate2+"  where Unitid='"+unitid+"'  UNION select StoredTime,VehRegNo,Vehid,Transporter,Body,UnProcessedStamps,MailFrom from t_mails"+thedate2+"Processed where Unitid='"+unitid+"' order by storedtime desc "+limit;
		 
		
		System.out.println(sqlProcessed);
		ResultSet rst=st1.executeQuery(sqlProcessed);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td  align="center"><%=i %></td>
			<td  align="center"><%=rst.getTime("StoredTime") %></td>
			<td  align="left"><%=rst.getString("VehRegNo") %></td>
			<td  align="right"><%=rst.getString("Vehid") %></td>
			<td  align="left"><%=rst.getString("Transporter") %></td>
			<td  align="left"><%=rst.getString("Body") %></td>
			<td  align="left"><%=rst.getString("UnProcessedStamps") %></td>
			<td  align="center"><%=rst.getString("MailFrom") %></td>
			</tr>
		<%
		i++;
		}
		 
		%>
		
		 </table>
		  </td></tr></table>
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
}catch(Exception e)
{
	System.out.println("Exceptions ----->"+e);
}
finally
{
	try{
	c.close();

	}catch(Exception ee)
	{
		System.out.println("Exception-->"+ee);
	}
}
%>

