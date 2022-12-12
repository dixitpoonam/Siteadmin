<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.*" %>

<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.castrol.action ="excel.jsp";
          document.forms["castrol"].submit();
}
</script>

<%
Statement st = null;
Statement st1 = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;
Statement st5 = null;
Statement st6 = null;

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
		st2=conn.createStatement();	
		st3=conn.createStatement();	
		st4=conn.createStatement();
		st5=conn.createStatement();	
		st6=conn.createStatement();	
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

<form name="castrolEmpViolation" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Castrol Employee Violation Filter</i></b></font></td></tr>
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

<form id="castrol" name="castrol" method="post" >
<%
         final String exportFileName="castrol_employee_violation_report.xls";  
%>
<table width="80%" border="0" align="center">
		<tr>
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
<tr><td align="center"><b><font size="3">Over Speed Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">

<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">Speed</font></th>
<th bgcolor="#f5f5f5"><font size="2">Dur</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		unitId=rs.getString("UnitID");
		
		//check the Violations of Castrol Employee vehciles
		String exception="-",frmDate="-",os60="NO",frmTime="-",speed="-",duration="-",frmDateTime="-";
		String sqlovers ="select * from db_gpsExceptions.t_veh"+vehId+"_overspeed where concat(FromDate,FromTime)>='"+fromDTime+"' and concat(ToDate,ToTime)<='"+toDTime+"' and speed <=70 ";
		ResultSet rsovers=st1.executeQuery(sqlovers);
		System.out.println("The query is ==>>"+sqlovers);
		if(rsovers.next()){
			//OS = rsovers.getString("overspeed");
			frmDate = rsovers.getString("FromDate");
			frmTime = rsovers.getString("FromTime");
			frmDateTime =frmDate+" "+frmTime;
			speed = rsovers.getString("Speed");
			duration = rsovers.getString("Duration");
			exception = "OS";
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDateTime))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="right"><%= speed%></td>
			<td bgcolor="#f5f5f5" align="right"><%= duration%></td>
			</tr>
			<%
			
		}//end of if		
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<table border="0" width="80%" align="center">
<tr><td align="center"><b><font size="3">Rapid Acceleration Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Speed</font></th>
<th bgcolor="#f5f5f5"><font size="2">To Speed</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		unitId=rs.getString("UnitID");
		//check the Violations of Castrol Employee vehciles RA
		String exception="-",frmDate="-",fromspeed="-",tospeed="-";		
		String thedate="-",thetime="-",theDateTime="-";
		
		String sqlra ="select * from db_gpsExceptions.t_veh"+vehId+"_ra where concat(TheDate,TheTime) >='"+fromDTime+"' and concat(TheDate,TheTime)<='"+toDTime+"' and ((ToSpeed-FromSpeed)<=30 or (ToSpeed-FromSpeed)>=50) ";
		ResultSet rsra=st2.executeQuery(sqlra);
		System.out.println("The query is ==>>"+sqlra);
		if(rsra.next()){
			System.out.println("in while");
			thedate = rsra.getString("TheDate");
			thetime = rsra.getString("TheTime");
			theDateTime = thedate+" "+thetime;
			fromspeed = rsra.getString("FromSpeed");
			tospeed = rsra.getString("ToSpeed");
			exception = "RA";			
			%>
			
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(theDateTime))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="right"><%= fromspeed%></td>
			<td bgcolor="#f5f5f5" align="right"><%= tospeed%></td>
			</tr>
			<%
			
		}//end of if
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<table border="0" width="80%" align="center">
<tr><td align="center"><b><font size="3">Rapid Deacceleration Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Speed</font></th>
<th bgcolor="#f5f5f5"><font size="2">To Speed</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		unitId=rs.getString("UnitID");
		
		//check the Violations of Castrol Employee vehciles RD
		String exception="-",frmDate="-",fromspeed="-",tospeed="-";		
		String thedate="-",thetime="-",theDateTime="-";
		
		String sqlrd ="select * from db_gpsExceptions.t_veh"+vehId+"_rd where concat(TheDate,TheTime)>='"+fromDTime+"' and concat(TheDate,TheTime)<='"+toDTime+"' and ((FromSpeed-ToSpeed)<=30 or (FromSpeed-ToSpeed)>=50) ";
		ResultSet rsrd=st3.executeQuery(sqlrd);
		System.out.println("The query is ==>>"+sqlrd);
		if(rsrd.next()){
			System.out.println("in while1");
			thedate = rsrd.getString("TheDate");
			thetime = rsrd.getString("TheTime");
			theDateTime = thedate+" "+thetime;
			fromspeed = rsrd.getString("FromSpeed");
			tospeed = rsrd.getString("ToSpeed");
			exception = "RD";
			
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(theDateTime))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="right"><%= fromspeed%></td>
			<td bgcolor="#f5f5f5" align="right"><%= tospeed%></td>
			</tr>
			<%
			
		}//end of if
				
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<table border="0" width="80%" align="center">
<tr><td align="center"><b><font size="3">Distance Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">Distance</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		unitId=rs.getString("UnitID");
		
		//check the Violations of Castrol Employee vehciles distance
		String exception="-",frmDate="-",distance="-";			
		String sqlds ="select * from db_gpsExceptions.t_veh"+vehId+"_ds where TheDate>='"+fromDate+"' and TheDate<='"+toDate+"' and Distance>=500 ";
		ResultSet rsds=st4.executeQuery(sqlds);
		System.out.println("The query is ==>>"+sqlds);
		if(rsds.next()){
			frmDate = rsds.getString("TheDate");
			distance = rsds.getString("Distance");
			exception = "DS";
			
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate+" 00:00:00"))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="right"><%= distance%></td>
			</tr>
			<%
			
		}//end of if
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<table border="0" width="80%" align="center">
<tr><td align="center"><b><font size="3">Stamping Interval Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">ST Interval</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		unitId=rs.getString("UnitID");
		
		String exception="-",frmDate="-",stinterval="-";
		//check the Violations of Castrol Employee vehciles stamping intervals
		String sqlftpdump ="select * from db_gps.t_ftplastdump where Filedatetime>='"+fromDTime+"' and Filedatetime<='"+toDTime+"' and UnitID='"+unitId+"' and StInterval <>1200 ";
		ResultSet rsdump=st5.executeQuery(sqlftpdump);
		System.out.println("The query is ==>>"+sqlftpdump);
		if(rsdump.next()){
			frmDate = rsdump.getString("Filedatetime");
			stinterval = rsdump.getString("StInterval");
			exception = "SI";
			
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="right"><%= stinterval%></td>
			</tr>
			<%
			
		}//end of if
		
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<table border="0" width="80%" align="center">
<tr><td align="center"><b><font size="3">Over Speed >60 Exceptions</font></b></td></tr>
</table>
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle ID</font></th>
<th bgcolor="#f5f5f5"><font size="2">Vehicle Reg No</font></th>
<th bgcolor="#f5f5f5"><font size="2">From Date Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">Exception</font></th>
<th bgcolor="#f5f5f5"><font size="2">OS >60</font></th>
<th bgcolor="#f5f5f5"><font size="2">Count</font></th>
</tr>
<%
try{
int count =0;
String vehId="",vehRegNo="",unitId="-";
String sql = "select * from db_gps.t_vehicledetails where ownername in ('Castrol East','Castrol South','Castrol West','Castrol North' ,'Castrol ILS')";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		vehId=rs.getString("VehicleCode");
		vehRegNo=rs.getString("VehicleRegNumber");
		
		//check the Violations of Castrol Employee vehciles
		String exception="-",frmDate="-",os60="NO",frmTime="-",speed="-",duration="-",fromDteTime="-";
		String sqlovers ="select * from db_gpsExceptions.t_veh"+vehId+"_overspeed where concat(FromDate,FromTime)>='"+fromDTime+"' and concat(ToDate,ToTime)<='"+toDTime+"'";
		ResultSet rsovers=st1.executeQuery(sqlovers);
		System.out.println("The query is ==>>"+sqlovers);
		if(rsovers.next()){
			//OS = rsovers.getString("overspeed");
			frmDate = rsovers.getString("FromDate");
			frmTime = rsovers.getString("FromTime");
			fromDteTime =frmDate+" "+frmTime;
			
			 DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			 java.util.Date fmdate = formatter.parse(fromDteTime);
			 System.out.println("The util date is :"+fmdate);
			 long millisecs = fmdate.getTime();
			 long minusmillsecs = 10*60*1000;
			 
			 long datemillisecs = millisecs - minusmillsecs;
			 long datemillisecs1 = millisecs + minusmillsecs;
			 
			 java.util.Date df1 = new java.util.Date();
			 java.util.Date df2 = new java.util.Date();
			 df1.setTime(datemillisecs);
			 df2.setTime(datemillisecs1);
			 
			 String d1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(df1);
			 String d2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(df2);

			
			 String count1="";
			 String sqlos ="select count(*) as count from db_gps.t_veh"+vehId+" where Thefielddatadatetime>='"+d1+"' and Thefielddatadatetime<='"+d2+"' and speed >=60";
			 ResultSet rsos=st1.executeQuery(sqlos);
			 System.out.println("The query is ==>>"+sqlos);
			 if(rsos.next()){
				 count1 = rsos.getString("count");
			 }
			if(Integer.parseInt(count1) >1) {
				os60="YES";
				exception = "OS >60";
			}else{
				os60="NO";
			}
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
			<td bgcolor="#f5f5f5" align="right"><%= vehId%></td>
			<td bgcolor="#f5f5f5" align="left"><%= vehRegNo%></td>
			<td bgcolor="#f5f5f5" align="left"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDteTime))%></td>
			<td bgcolor="#f5f5f5" align="left"><%= exception%></td>
			<td bgcolor="#f5f5f5" align="left"><%= os60%></td>
			<td bgcolor="#f5f5f5" align="left"><%= count1%></td>
			</tr>
			<%
			
		}//end of if		
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
}//end of condition
%>
</table>
</div>
</form>