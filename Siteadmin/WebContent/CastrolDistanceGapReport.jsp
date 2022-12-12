<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.*" %>


<%@page import="java.util.Date"%><script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.castrolgap.action ="excel.jsp";
          document.forms["castrolgap"].submit();
}
</script>

<%
Statement st = null;
Statement st1 = null;

try {
		Connection conn = null;
		
		String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME = "fleetview";
		String MM_dbConn_PASSWORD = "1@flv";
		String MM_dbConn_GPS = "jdbc:mysql://localhost";            

		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		System.out.println("===========connection created=============");
	
	} catch (Exception e) {
		System.out.print("GetConnection Exception ---->" + e);
	}
%>
<%

String datenew1="";
String datenew2="";

if(request.getParameter("data")!=null)
{
  datenew1=request.getParameter("data");
  datenew2=request.getParameter("data1");
  }

else {
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}

%>

<% 
		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));
		int counter=0;
		
%>

<form name="castrolDistancegapReport" method="get"  onsubmit="" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Castrol Distance Gap Report</i></b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="40%" align="center">
<tr>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>From Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">

			<input type="text" id="data" name="from_date1" size="12" value="<%=datenew1%>" 
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
			<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>

		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>To Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
		
			<input type="text" id="data1" name="to_date1" size="12" value="<%=datenew2%>"
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
				<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>
		
		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><input type="submit" name ="sub" id ="sub" value="submit" style="background-color:#f5f5f5; "></input></font></td>
</tr>
</table>
</table>
</form>



<%
String fromDate = request.getParameter("from_date1");
String toDate = request.getParameter("to_date1");
	
	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
if(fromDate !=null && toDate !=null) {
	
	fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDate));
	toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
	
	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
	String fromDTime =fromDate+" 00:00:00";
	String toDTime =toDate+" 00:00:00";
	
	System.out.println("The from Date Time is :"+fromDTime);
	System.out.println("The to Date time is :"+toDTime);
%>

<form id="castrolgap" name="castrolgap" method="post" >
<%
         final String exportFileName="castrol_distance_gap_report.xls";  
%>
<table width="80%" border="0" align="center">
		<tr>
			
			<%
				try{
				
						String sql ="select count(*) as count from db_gps.t_castroldistancegapreport where FromDateTime >='"+fromDTime+"' and FromDateTime <='"+toDTime+"'";
						ResultSet rs1=st.executeQuery(sql);
						System.out.println("The query is ==>>"+sql);
						if(rs1.next())
						{
							String count=rs1.getString("count");
							
							%>
								
								<td bgcolor="" align="left"><b>Total Records :</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= count%></td>
								
								<%
						
				}//end of outer while
				}catch(Exception e) {
					System.out.println("The Exception is ==>>"+e);
				}
				%>
			<td>
			 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
        	</td>
		</tr>
		
		</table>

<div style="width:100%;" align="center" id="table1" >
<table border="0" width="80%" align="center">

</table><br>

<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">To Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Duration</font></th>
<th bgcolor="#f5f5f5"><font size="2">Distance Diff</font></th>
</tr>
<%
try{
int count =0;

		String sqlpre ="select * from db_gps.t_castroldistancegapreport where FromDateTime >='"+fromDTime+"' and FromDateTime <='"+toDTime+"'";
		ResultSet rs=st1.executeQuery(sqlpre);
		System.out.println("The query is ==>>"+sqlpre);
		while(rs.next())
		{
			String VehID=rs.getString("VehID");
			String VehRegNo=rs.getString("VehRegNo");
			String FromDateTime = rs.getString("FromDateTime");
			String ToDateTime = rs.getString("ToDateTime");
			String Duration = rs.getString("Duration");
			String DistanceDiff = rs.getString("DistanceDiff");
			
			%>
				<tr>
				<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
				<td bgcolor="#f5f5f5" align="right"><%= VehID%></td>
				<td bgcolor="#f5f5f5" align="left"><%= VehRegNo%></td>
				<td bgcolor="#f5f5f5" align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(FromDateTime))%></td>
				<td bgcolor="#f5f5f5" align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ToDateTime))%></td>
				<td bgcolor="#f5f5f5" align="right"><%= Duration%></td>
				<td bgcolor="#f5f5f5" align="right"><%= DistanceDiff %></td>
				</tr>
				<%
		
}//end of outer while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<%
}//end of condition
%>

</div>
</form>