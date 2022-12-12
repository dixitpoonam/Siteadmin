<%@ include file="headerhtml.jsp"%>



<script language="javascript">
function getVehicles(trans)
{
		
var xmlhttp;
if (window.XMLHttpRequest)
  {
  // code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else if (window.ActiveXObject)
  {
  // code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
else
  {
  alert("Your browser does not support XMLHTTP!");
  }
xmlhttp.onreadystatechange=function()
{
if(xmlhttp.readyState==4)
  {
  //alert(xmlhttp.responseText);
  document.getElementById("vehiclediv").innerHTML=xmlhttp.responseText;
  }
}
xmlhttp.open("GET","getVehicles.jsp?UserName="+trans,true);
xmlhttp.send(null);
		
	}
</script>
<%
Connection conn,conn1;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmtvehicle=null,stmtvehcode=null,stmtMails=null;
stmtvehicle=conn.createStatement();
stmtvehcode = conn.createStatement();
String sql="",thedate="",thedate1="",thedate2="", vehcode="",OwnerName="",VehicleRegNumber="";

	String datenew1="",datenew2="";
	datenew1=datenew2= new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	%>

<%@page import="java.util.Date"%>
<form name="dataCheck" action="" onSubmit="return validate()">
<table>
	<tr>
		<td colspan="8" align="center" class="sorttable_nosort"><b>Please
		select the date and enter the Unit id to check its data.</b></td>
	</tr>
	<tr>

		<td bgcolor="#F5F5F5">Unit ID :</td>
		<td bgcolor="#F5F5F5"><textarea name="unitid" id="unitid" class="stats"> </textarea> 
				<B> Note: </B> Please separate Unit ID's by comma ',' only &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp; 
			<input type="text" id="data1" name="data1" value="<%=datenew1%>" size="15" readonly />
		</td>
		<td align="left">
			<script type="text/javascript">
	  		Calendar.setup(
	  		  {
	  		    inputField  : "data1",         // ID of the input field
	  		    ifFormat    : "%d-%b-%Y",     // the date format
	   		   button      : "data1"       // ID of the button
	  		  }
	  		);
			</script>
		</td>
		<td><b>To</b> &nbsp;&nbsp;&nbsp;&nbsp; 
			<input type="text"	id="data2" name="data2" value="<%=datenew2%>" size="15" readonly />
		</td>
		<td align="left">
			<script type="text/javascript">
  			Calendar.setup(
    		{
      			inputField  : "data2",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "data2"       // ID of the button
    		}
  			);
			</script>
		</td>
		<td bgcolor="#F5F5F5"><input type="submit" name="submit"
			value="submit" class="stats"></td>
	</tr>
</table>
<%
if(!(null==request.getQueryString()))
{	
	String unitids = request.getParameter("unitid"); 
	//System.out.println(unitids);
%>
	<table width="100%" align="center" class="sortable" border="1">
		<tr>
			<th>Unit Id</th>
			<th>Date</th>
			<th>Expected count of stamps</th>
			<th>received count</th>
			<th>Delay between 0-15</th>
			<th>Delay between 16-30</th>
			<th>Delay between 31-60</th>
			<th>Delay between 61-120</th>
			<th>Delay greater than 120</th>
		</tr>
<%			

	try{
		Statement stGPS=conn.createStatement(); //gps
		Statement stAVL=conn1.createStatement(); //avlalldata
		String stampDateTime="",stampStoredDateTime="",rawDataMailDateTime="",rawDataStoredDateTime="";
		String unitId="",vehiclecode="",vehregnumber="",transporter="";
		int expectedStCount=0;
		int StInterval=0;
		int SIstampCount=0;
		double per=0.00;
		int days=0;
		int fromdate=0;
		int frommonth=0;
		String fromDateTime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
		String toDateTime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
		fromDateTime = fromDateTime+" 00:00:00";
		toDateTime = toDateTime+" 23:59:59";
		
		
		StringTokenizer unitToken = new StringTokenizer(unitids,",");
		while(unitToken.hasMoreTokens()){
			unitId = unitToken.nextToken();
			unitId = unitId.trim();
			per=0.00;
			String sqlvehicledetails = "select * from db_gps.t_vehicledetails where unitid='"+unitId+"'";
			ResultSet rsvehicle = stmtvehicle.executeQuery(sqlvehicledetails);
			if(rsvehicle.next())
			{
				vehiclecode = rsvehicle.getString("vehiclecode");
				vehregnumber = rsvehicle.getString("vehicleregnumber");
				transporter = rsvehicle.getString("ownername");
			}
			
			
			
			String count0_06="0";
			String count06_11="0";
			String count11_16="0";
			String count16_120="0";
			String countgrt_120="0";
			
			stampDateTime 		  = "";
			stampStoredDateTime   = "";
			rawDataMailDateTime   = "";
			rawDataStoredDateTime = "";
			String From_Month="";
			sql="select TXInterval,StInterval,UnitType from db_gps.t_ftplastdump where UnitID='"+unitId+"'";
			ResultSet rstftp = stmtvehcode.executeQuery(sql);
			if(rstftp.next())
			{
				if(rstftp.getString("StInterval")=="-"||rstftp.getString("StInterval").equalsIgnoreCase("-")||rstftp.getString("StInterval").equalsIgnoreCase("")){
   				 StInterval=0;
   			 }else{
      			  	StInterval = rstftp.getInt("StInterval");
   			 }
			}
			expectedStCount = (24 * 3600 *10 )/ StInterval ;
			
			
			String From_Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
			String TO_Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
			String numOfDays = "SELECT TO_DAYS('"+TO_Date+"') - TO_DAYS('"+From_Date+"') as days";
			ResultSet rsNumDays = stmtvehcode.executeQuery(numOfDays);
			int year=0, month=0,day=0;
			if(rsNumDays.next()){
				days = Integer.parseInt(rsNumDays.getString("days"));
				String From_Day = new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
				From_Month = new SimpleDateFormat("MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
				String From_year = new SimpleDateFormat("yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
			//	String To_Day = new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
			//	String To_Month = new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
				day = Integer.parseInt(From_Day);
				month = Integer.parseInt(From_Month);
				year = Integer.parseInt(From_year);
			}
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.set(year,month-1,day); // month values are zero based i.e Jan=0,Feb=1, Mar=2... so on
			String yesrtday = dateFormat.format(cal.getTime()); 
			
			cal.add(Calendar.DATE,-1);
			String date=""; 
			for(int cnt=0;cnt<=days;cnt++){
				cal.add(Calendar.DATE,1);
				date = dateFormat.format(cal.getTime());
			
			 String sqlVeh="select count(distinct(thefielddatadatetime)) as stampCount from db_gps.t_veh"+vehiclecode+" where TheFiledTextFileName='SI' and thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' ";
			// System.out.println("00--sqlVeh---->"+sqlVeh);
			 ResultSet rststamp=stmtvehcode.executeQuery(sqlVeh);
			  if(rststamp.next()){
				  SIstampCount=rststamp.getInt("stampCount");
			//	  System.out.println("stampcount"+SIstampCount);
			  }
			  
			  String sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff <=6"; 
			//	System.out.println("--sqlvehcode---->"+sqlvehcode);
			  ResultSet rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			  if(rsvehcode.next())
				{
				  count0_06= rsvehcode.getString("count");
				} 
					
			 sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >15 and a.timediff <=11 "; 
		//	System.out.println("--sqlvehcode---->"+sqlvehcode);
			 rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count06_11 = rsvehcode.getString("count");
			}
			
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime order by thefielddatadatetime) a where  a.timediff >30 and a.timediff <=16"; 
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count11_16 = rsvehcode.getString("count");
			}
			
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >60 and a.timediff <=120"; 
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count16_120 = rsvehcode.getString("count");
			}
			
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff > 120"; 
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				countgrt_120 = rsvehcode.getString("count");
			}
			
			per=SIstampCount/expectedStCount;
			//System.out.println("per---->"+per);
%>
	<tr>
		<td align="right"><%=unitId%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date))%></td>
		<td align="right"><%=expectedStCount%></td>
		<td align="right"><%=SIstampCount %></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=zerotofifteen');"><%=count0_06%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=sixteentothirty');"><%=count06_11%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=thirtytosixty');"><%=count11_16 %></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=sixtyto120');"><%=count16_120%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=grtr120');"><%=countgrt_120%></a></td>
	</tr>		
<%		
			}
		}// end unitid while
	}
catch(Exception e){
	e.printStackTrace();
}
finally{
	
}
}	
%>
</table>
</form>