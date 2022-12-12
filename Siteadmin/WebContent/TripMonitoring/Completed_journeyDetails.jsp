<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
 <%@page import="java.util.Date"%> 
 <style>
.popup {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>

<script language="javascript">
  
  function toggleDetails1(id, show)
{
	var popupx = document.getElementById("popup"+id);
	if (show) {
		popupx.style.visibility = "visible";
		popupx.setfocus();
		
	} else {
		popupx.style.visibility = "hidden";
	}
}
  </script>

  <script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="") 
  				{
  					alert("Please Select The from date.");
  					return false;
  				}
  				if(document.getElementById("data1").value =="")
  			  	{
  					alert("please select To Date");
  					return false;
  			  	}  		
  					return datevalidate();
  				return true;
  		  }

 			function dateformat(days)
 			{
 				if(days=='Jan')
 					return(1);
 				else
 					if(days=='Feb')
 						return(2);
 					else
 						if(days=='Mar')
 							return(3);
 						else
 							if(days=='Apr')
 								return(4);
 							else
 								if(days=='May')
 									return(5);
 								else
 									if(days=='Jun')
 										return(6);
 									else
 										if(days=='Jul')
 											return(7);
 										else
 											if(days=='Aug')
 												return(8);
 											else
 												if(days=='Sep')
 													return(9);
 												else
 													if(days=='Oct')
 														return(10);
 													else
 														if(days=='Nov')
 															return(11);
 														else
 															if(days=='Dec')
 																return(12);
 			}
	  		  
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			var dd11,yy11,mm1,mm2,mm11,dd22,yy22,mm22;
			
			dd11=date1.substring(0,2);
			dd22=date2.substring(0,2);


			mm1=date1.substring(3,6);
			mm2=date2.substring(3,6);

			mm11=dateformat(mm1);
			mm22=dateformat(mm2);
			
			yy11=date1.substring(7,11);
			yy22=date2.substring(7,11);

			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			
			if(yy11>year || yy22>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
	  			if(mm11>month || mm22>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}

			if(mm11==month && mm22==month)
			{
				if(dd11>day || dd22>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			

			if(yy11 > yy22)
			{
				alert("From date year should not be greater than to date year");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==yy11 && year==yy22)
			{
				 if(mm11>mm22)
				{
					alert("From date month should not be greater than to date month");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(mm11==month && mm22==month) 
			{
				if(yy11==yy22)
				{
					if(dd11 > dd22)
						{
							alert("From date should not be greater than to date");
							document.getElementById("data").value="";
							document.getElementById("data1").value="";
							document.getElementById("data").focus;
							return false;
						}
				}
			}
			else
				if(yy11<yy22)
				{
					return true;
				}
			else
				if(dd11 > dd22)
				{
					if(mm11<mm22)
					{
						return true;
					}
					
					alert("From date should not be greater than to date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			
			return true;
		}

  	</script>
  







<%!
Connection conn,conn1;
%>

<table border="0" width="100%" align="center">
<tr><td>
<form name="journeyDetails" method="get" action="" onsubmit="return validate();">
<% 
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	Statement stmt3 = conn.createStatement();
	Statement st2 = conn.createStatement();
	Statement st1 = conn.createStatement();
	Statement st4=conn1.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql1="", sql2="";
	double stdDist=0,capDist=0;
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="", today="";
	if(!(null==request.getParameter("data")))
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
		fromdate1=request.getParameter("data");
		todate1=request.getParameter("data1");
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	//out.print(todate);
	}
		
	today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		
	
%>		
	<table width="100%" align="center" border="0"  class="bodytext">
	<tr>
		<td align="center" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b>Open Trip Report</font></td>
	</tr>
	<tr><td colspan="8">
			<!-- if date range is not required please remove this code start from this comment to -->
			
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
			<font size="3" color="maroon"><b>Open Trips Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 			<div align="right">
    	     		<a href="Excel_OpenTrip_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %>
			</div>
		</td></tr>
		</table>
	</td></tr>
	<tr><td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="#2696B8">
			<td class="hed" align="center" ><b>Sr.No.</b></td>
			<td class="hed" align="center" > <b>TripID</b></td>
			<!--<td class="hed" align="center" > <b>Caregory</b></td>-->
			<td class="hed" align="center"> <b> Vehicle</b></td>
			<td class="hed" align="center" > <b> Transporter</b></td>
			<td class="hed" align="center" > <b> StartPlace</b></td>
			<td class="hed" align="center" > <b> StartCode</b></td>
			<td class="hed" align="center"> <b> EndPlace</b></td>
			<td class="hed" align="center"> <b> EndCode</b></td>
			<td class="hed" align="center"> <b>StartDate</b></td>
			<td class="hed" align="center" > <b>StdKm</b></td>
			<td class="hed" align="center" > <b>Captured Km</b></td>
			<td class="hed" align="center" > <b>StdTTime</b></td>
			<td class="hed" align="center" > <b>Type of Trips Secondary/Primary/Tanker</b></td>
			<td class="hed" align="center" > <b>StartLat</b></td>
			<td class="hed" align="center" > <b>Start Long</b></td>
			<td class="hed" align="center" > <b>EndLat</b> </td>
			<td class="hed" align="center" > <b>EndLong</b> </td>
			<td class="hed" align="center" > <b>Current Date</b></td>
			<td class="hed" align="center">  <b>Current Time</b></td>
			<td class="hed" align="center">  <b>Current Location</b></td>
			<td class="hed" align="center">  <b>Unit Replaced</b></td>
			<td class="hed" align="center">  <b>Vehicle Attended</b></td>
			<td class="hed" align="center">  <b>Diff in KM</b></td>
			<td class="hed" align="center" > <b>Comment</b> </td>
			<td class="hed" align="center" > <b> Trip Comments</b> </td>
			<td class="hed" align="center" > <b>Action</b> </td>
		</tr>
		<%
				int i=1,x=1;
				
				String tripid="-",startloc="-",endloc="-",vehregno="-",transporter="-";
				String slat,slon,elat,elon;
				java.util.Date dt1 = null;
				String km="-",ttime="-",startcode1="-",startcode2="-",endcode1="-",endcode2="-",gpname="-";
				
				sql1="select rid,TripID,VehRegNo,OwnerName,StartPlace,EndPlace,StartDate,StartTime,StartCode,EndCode,EndLat,EndLong,Vehid,VehRegNo,GPName from t_startedjourney where StartDate between '"+fromdate+"' and '"+todate+"' and JStatus='Completed' and GPName='Castrol' order by StartDate,StartTime asc";
				rs1=stmt1.executeQuery(sql1);
				
				today = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
   				//System.out.println("today--->" + today);
				
				while(rs1.next())
				{
					String lastdate="-",lasttime="-",lastloc="-",stdate="",sttime="",category="-",comment="-",finalComment="-",vehID="-";
					int tripstartkm=0,tripcurrkm=0,totkm=0,loop=0;
					tripid=rs1.getString("TripID");	
					startloc=rs1.getString("StartPlace");
					endloc=rs1.getString("EndPlace");
					dt1=new SimpleDateFormat("yyyy-MM-ddHH:mm:ss").parse(rs1.getString("StartDate")+""+rs1.getString("StartTime"));
					double endlat=rs1.getDouble("EndLat");
					double endlong=rs1.getDouble("EndLong");
					startcode1=rs1.getString("StartCode");
					endcode1=rs1.getString("EndCode");
					double rid=rs1.getDouble("rid");
					vehregno=rs1.getString("VehRegNo");
					vehID=rs1.getString("Vehid");
					transporter=rs1.getString("OwnerName");
					stdate=rs1.getString("StartDate");
					sttime=rs1.getString("StartTime");
					stdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(stdate));
	   				//System.out.println("stdate--->" + stdate);
	   				
					if((sttime==null) || (sttime.equals("")))
					{
						sttime="00:00:00";	
					}
					String sql3="";
					
					sql3="Select TheDate,TheTime,Location,TheDistance from t_onlinedata where VehicleRegNo='"+vehregno+"'";
					
					rs3=stmt3.executeQuery(sql3);
					if(rs3.next())
					{
						lastdate=rs3.getString("TheDate");
						lasttime=rs3.getString("TheTime");
						lastloc=rs3.getString("Location");
						tripcurrkm=rs3.getInt("TheDistance");
					}
					
					sql3="select comment from t_tripcomments where tripid='"+tripid+"' and vehid='"+rs1.getString("Vehid")+"' and  vehregno='"+vehregno+"' order by datetime";
					ResultSet commentRst=stmt3.executeQuery(sql3);
					while(commentRst.next())
					{
						comment=commentRst.getString(1);
						if(!(comment.equalsIgnoreCase("-")))
						{
							if(loop==0)
							{
								finalComment=comment+", ";
							}
							else
							{
								finalComment+=comment+", ";		
							}
						loop++;
						}
						
					}
					if(!(finalComment.equalsIgnoreCase("-")))
					{
					finalComment=finalComment.substring(0,finalComment.lastIndexOf(","));
					}
					sql2="select * from t_veh"+rs1.getString("Vehid")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by TheFieldDataDate,TheFieldDataTime limit 1 ";
					ResultSet rs11=stmt3.executeQuery(sql2);
					 if(rs11.next())
					 {
						 tripstartkm=rs11.getInt("Distance");	 
					 }
					 							 
					 totkm=tripcurrkm-tripstartkm;	
					 
					sql2="Select rid,StartCode,EndCode,Km,TTime,Endlat,EndLong,Startlong,Startlat from t_castrolroutes where StartCode='"+startcode1+"' and EndCode='"+endcode1+"'";
					rs2=stmt2.executeQuery(sql2);
					
					if(rs2.next())
					{
						if(rs2.getDouble("Endlat")>0)
						{
							%>
							<tr>
								<td><%=x%></td>
								<td>
								
								<a href="javascript:toggleDetails1(<%=x%>,true);" title="Click To See the Reports">					
			 					<%=rs1.getString("TripID")%></a>
								<div class="popup" id="popup<%=x%>">
								<table border="1" bgcolor="white">
		   			<tr>  
					<td> <a href="#" onclick="javascript:window.open('samplemap.jsp?&tripid=<%=rs1.getString("TripID") %>&transporter=<%= rs1.getString("OwnerName")%>&startcode=<%=rs1.getString("StartCode") %>&startlocation=<%=rs1.getString("StartPlace") %>&endcode=<%=rs1.getString("EndCode") %>&vehcode=<%=rs1.getString("Vehid")%>&endLocation=<%=rs1.getString("EndPlace")%>&startdate=<%=rs1.getString("StartDate")%>&startTime=<%= rs1.getString("StartTime")%>&vehregno=<%=rs1.getString("VehRegNo") %>&endlat=<%=rs1.getDouble("EndLat") %>&endlon=<%=rs1.getDouble("EndLong") %>');" > Map </a>
					</td>
		   			</tr>
		   			<tr>
		   			<%
		   					
		   			
		   			%>
		   			<td><a href="#" onclick="javascript:window.open('custom_details.jsp?vehcode=<%=rs1.getString("Vehid")%>&data=<%=stdate %>&data1=<%=today%>');">Custom Detail Report</a>
					
					</td>
		   			</tr>
			  		 <tr>
					<td> <a href="javascript:toggleDetails1(<%=x%>,false);">Close </a>
					</td>
		   			</tr>
	   				</table>
								 </div>
								</td>
								<td><%=rs1.getString("VehRegNo")%></td>
								<td><%=rs1.getString("OwnerName")%></td>
								<td><%=rs1.getString("StartPlace")%></td>
								<td><%=rs1.getString("StartCode")%></td>
								<td><%=rs1.getString("EndPlace")%></td>
								<td><%=rs1.getString("EndCode")%></td>
								<td><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt1)%></td>
								<td ><%=rs2.getDouble("Km")%></td>
								<td ><%=totkm%></td>
								<td ><%=rs2.getDouble("TTime")%></td>
									
								<%

									String ss6="select Category from t_alljddata where TripId='"+tripid+"'";
									ResultSet rs6=st2.executeQuery(ss6);
									if(rs6.next())
									{
										category = rs6.getString("Category");
										if(category.equalsIgnoreCase("Primary"))
										{%>
										<td>Primary</td>
										<% 
										}else if(category.equals("BPL")||(category.equals("Tanker")))
										{
											%>
											<td>Tanker</td>
											<% 
										}
										else
										{ %>
										
											<td>Secondary</td>
										<%
										}
									}	
								%>
								<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rs1.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td><%=rst11.getString("Latitude")%></td>
		    <td><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td><%=rstg.getString("Startlat")%></td>
		    <td><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rs1.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td><%=rstg.getString("Endlat")%></td>
			    <td><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td><%="-" %></td>
				<td><%="-" %></td>
				<%
			}
		}


		}
		%>
								<td><%=rs2.getString("Endlat")%></td>
								<td><%=rs2.getString("EndLong")%></td>
								<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(lastdate))%></td>
								<td><%=lasttime %></td>
								<td><%=lastloc %></td>
								<%
									String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rs1.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdate+"' AND '"+todate+"'";
									ResultSet rst13=st2.executeQuery(sql13);
									if(rst13.next())
									{
								%>

									<td><%="Yes" %></td>
								<%
									}
									else
									{
								%>
									<td><%="No" %></td>
								<%
									}
								%>
		<%
			sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rs1.getString("VehRegNo")+"'";
			ResultSet rst2=st4.executeQuery(sql2);
			if(rst2.next())
			{
			%>
					<td>Attended</td>
			<%
			}
			else { 
			%>
			<td><%="Not Attended" %></td>
			<%
				}
			%>
			
	
		<%
	
			String sql="select * from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"' and EndPlace='"+rs1.getString("EndPlace")+"'";
			//System.out.println(sql);
			ResultSet rstdist=st1.executeQuery(sql);
			if(rstdist.next())
			{ 
				stdDist=rstdist.getDouble("Km");
				%>
				<td><%=rstdist.getString("Km")%></td>
				<% 			
			}
			else
			{		
			%>
	
			<td><%= "0" %></td>
			<% } %>
						<td>- </td>
								<td><%=finalComment%></td>
								<td>
								<table style="border: none;"><tr style="border: none;">
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('tripcomment.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">Enter Comment </a></td>
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('endtrip.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">End Trip </a></td>
								</tr></table>
								
								</td>
		   			
							</tr>
						  <%
						}
						else
						{		
						%>
						<tr>
							<td><%= x%></td>
							<td> <a href="javascript:toggleDetails1(<%=x%>,true);" title="Click To See the Reports">					
			 					<%=rs1.getString("TripID")%></a>
								<div class="popup" id="popup<%=x%>">
								<table border="1" bgcolor="white">
		   			<tr>  
					<td> <a href="#" onclick="javascript:window.open('samplemap.jsp?&tripid=<%=rs1.getString("TripID") %>&transporter=<%= rs1.getString("OwnerName")%>&startcode=<%=rs1.getString("StartCode") %>&startlocation=<%=rs1.getString("StartPlace") %>&endcode=<%=rs1.getString("EndCode") %>&vehcode=<%=rs1.getString("Vehid")%>&endLocation=<%=rs1.getString("EndPlace")%>&startdate=<%=rs1.getString("StartDate")%>&startTime=<%= rs1.getString("StartTime")%>&vehregno=<%=rs1.getString("VehRegNo") %>&endlat=<%=rs1.getDouble("EndLat") %>&endlon=<%=rs1.getDouble("EndLong") %>');" > Map </a>
					</td>
		   			</tr>
		   			<tr>
					<td><a href="#" onclick="javascript:window.open('custom_details.jsp?vehcode=<%=rs1.getString("Vehid")%>&data=<%=stdate %>&data1=<%=today%>');">Custom Detail Report</a>
							</td>
		   			</tr>
			  		 <tr>
					<td> <a href="javascript:toggleDetails1(<%=x%>,false);">Close </a>
					</td>
		   			</tr>
	   				</table>
								 </div></td>
							<td><%=rs1.getString("VehRegNo")%></td>
							<td><%=rs1.getString("OwnerName")%></td>
							<td><%=rs1.getString("StartPlace")%></td>
							<td><%=rs1.getString("EndPlace")%></td>
							<td><%=rs1.getString("EndCode")%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt1)%></td>
						
							<td ><%=rs2.getDouble("Km")%></td>
							<td ><%=totkm%></td>
							<td ><%=rs2.getDouble("TTime")%></td>
							

							<%

								String ss6="select Category from t_alljddata where TripId='"+tripid+"'";
								ResultSet rs6=st2.executeQuery(ss6);
								if(rs6.next())
								{
									
									category = rs6.getString("Category");
									System.out.println("category--2->" + category);
										if(category.equalsIgnoreCase("Primary"))
										{%>
										<td>Primary</td>
										<% 
										}else if(category.equals("BPL")||(category.equals("Tanker")))
										{
											%>
											<td>Tanker</td>
											<% 
										}
										else
										{ %>
										
											<td>Secondary</td>
										<%
										}
									}	
								%>
							<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rs1.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td><%=rst11.getString("Latitude")%></td>
		    <td><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td><%=rstg.getString("Startlat")%></td>
		    <td><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rs1.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td><%=rstg.getString("Endlat")%></td>
			    <td><%=rstg.getString("Endlong")%></td>
				<%
			}	
			else
			{
				%>
				<td><%="-" %></td>
				<td><%="-" %></td>
				<%
			}
		}


		}
		%>
							<td ><%=rs2.getString("Endlat")%></td>
							<td ><%=rs2.getString("EndLong")%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(lastdate))%></td>
							
							<td><%=lasttime %></td>
							<td><%=lastloc %></td>
							<td>Not Geofensed</td>
							<%
									String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rs1.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdate+"' AND '"+todate+"'";
									ResultSet rst13=st2.executeQuery(sql13);
									if(rst13.next())
									{
							%>

								<td><%="Yes" %></td>
							<%
								}
								else
								{
							%>
								<td><%="No" %></td>
							<%
								}
							%>
							<%
		sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rs1.getString("VehRegNo")+"'";
		ResultSet rst2=st4.executeQuery(sql2);
		if(rst2.next())
		{%>
		<td>Attended</td>
			
			
			<%
		}
		else
		{%>
		<td><%="Not Attended" %></td>
		<%
			
		}

			%>	<%
	
			String sql="select * from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"' and EndPlace='"+rs1.getString("EndPlace")+"'";
			//System.out.println(sql);
			ResultSet rstdist=st1.executeQuery(sql);
			if(rstdist.next())
			{ 
				stdDist=rstdist.getDouble("Km");
				%>
				<td><%=rstdist.getString("Km")%></td>
				<% 			
			}
			else
			{		
			%>
	
			<td><%= "0" %></td>
			<% } %>
			<td>-</td>
							<td><%=finalComment%></td>
							<td>
							<table style="border: none;"><tr style="border: none;">
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('tripcomment.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">Enter Comment </a></td>
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('endtrip.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">End Trip </a></td>
								</tr></table>
								</td>
		   			
						</tr>
					    <%
						}
				   }
					else
					{
						%>
						<tr>
							<td><%=x%></td>
							<td> <a href="javascript:toggleDetails1(<%=x%>,true);" title="Click To See the Reports">					
			 					<%=rs1.getString("TripID")%></a>
								<div class="popup" id="popup<%=x%>">
								<table border="1" bgcolor="white">
		   			<tr>  
					<td> <a href="#" onclick="javascript:window.open('samplemap.jsp?&tripid=<%=rs1.getString("TripID") %>&transporter=<%= rs1.getString("OwnerName")%>&startcode=<%=rs1.getString("StartCode") %>&startlocation=<%=rs1.getString("StartPlace") %>&endcode=<%=rs1.getString("EndCode") %>&vehcode=<%=rs1.getString("Vehid")%>&endLocation=<%=rs1.getString("EndPlace")%>&startdate=<%=rs1.getString("StartDate")%>&startTime=<%= rs1.getString("StartTime")%>&vehregno=<%=rs1.getString("VehRegNo") %>&endlat=<%=rs1.getDouble("EndLat") %>&endlon=<%=rs1.getDouble("EndLong") %>');" > Map </a>
					</td>
		   			</tr>
		   			<tr>
		   		
					<td><a href="#" onclick="javascript:window.open('custom_details.jsp?vehcode=<%=rs1.getString("Vehid")%>&data=<%=stdate %>&data1=<%=today%>');">Custom Detail Report</a></tr>
			  		 <tr>
					<td> <a href="javascript:toggleDetails1(<%=x%>,false);">Close </a>
					</td>
		   			</tr>
	   				</table>
								 </div></td>
							<td><%=rs1.getString("VehRegNo")%></td>
							<td><%=rs1.getString("OwnerName")%></td>
							<td><%=rs1.getString("StartPlace")%></td>
							<td><%=rs1.getString("StartCode")%></td>
							<td><%=rs1.getString("EndPlace")%></td>
							<td><%=rs1.getString("EndCode")%></td>
							<td><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(dt1)%></td>
							<td >NA</td>
							<td ><%=totkm%></td>
							<td >NA</td>
							

							<%

								String ss6="select Category from t_alljddata where TripId='"+tripid+"'";
								ResultSet rs6=st2.executeQuery(ss6);
								if(rs6.next())
								{
										category = rs6.getString("Category");
										
										if(category.equalsIgnoreCase("Primary"))
										{%>
										<td>Primary</td>
										<% 
										}else if(category.equals("BPL")||(category.equals("Tanker")))
										{
											%>
											<td>Tanker</td>
											<% 
										}
										else
										{ %>
										
											<td>Secondary</td>
										<%
										}
									}	
								%>
							<%
		double lat,lon;
		String sql11="Select Latitude,Longitude from t_warehousedata where WareHouse='"+rs1.getString("StartPlace")+"' limit 1";
		ResultSet rst11=st2.executeQuery(sql11);
		if(rst11.next())
		{
			
			slat=rst11.getString("Latitude");
			slon=rst11.getString("Longitude");

			%>
			<td><%=rst11.getString("Latitude")%></td>
		    <td><%=rst11.getString("Longitude")%></td>
			<%
		}
		else
		{

		String sqlg="Select Startlat,Startlong from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"'";
		ResultSet rstg=st2.executeQuery(sqlg);
		if(rstg.next())
		{
			%>
			<td><%=rstg.getString("Startlat")%></td>
		    <td><%=rstg.getString("Startlong")%></td>
			<%
		}
		else
		{
			String sqlg1="Select Endlat,Endlong from t_castrolroutes where EndPlace='"+rs1.getString("StartPlace")+"'";
			ResultSet rstg1=st2.executeQuery(sqlg1);
			if(rstg1.next())
			{
				
				%>
				<td><%=rstg.getString("Endlat")%></td>
			    <td><%=rstg.getString("Endlong")%></td>
				<%
			}
			else
			{
				%>
				<td><%="-" %></td>
				<td><%="-" %></td>
				<%
			}
		}
		}
		%>
				<td><%=rs1.getString("EndLat")%></td>
				<td><%=rs1.getString("EndLong")%></td>
				<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(lastdate))%></td>
							
				<td><%=lasttime %></td>
				<td><%=lastloc %></td>
							
							<%
									String sql13="Select VehRegNo from t_unitreplacement where VehCode='"+rs1.getString("VehId")+"' and concat(InstDate,' ',InstTime) Between '"+fromdate+"' AND '"+todate+"'";
									ResultSet rst13=st2.executeQuery(sql13);
									if(rst13.next())
									{
							%>

										<td><%="Yes" %></td>
							<%
									}
									else
									{
							%>
									<td><%="No" %></td>
							<%
									}
							%>
							<%
								sql2="Select Complaint from t_complaints1 where TdyDate>='"+fromdate+"' and TdyDate<='"+todate+"' and Status='Solved' and VehicleNo='"+rs1.getString("VehRegNo")+"'";
								ResultSet rst2=st4.executeQuery(sql2);
								if(rst2.next())
								{
							%>
									<td>Attended</td>

							<%
								}
								else
								{
							%>
									<td>Not Attended</td>
							<%
								}
							%>
			
							<%
	
			String sql="select * from t_castrolroutes where StartPlace='"+rs1.getString("StartPlace")+"' and EndPlace='"+rs1.getString("EndPlace")+"'";
			
			ResultSet rstdist=st1.executeQuery(sql);
			if(rstdist.next())
			{ 
				stdDist=rstdist.getDouble("Km");
				%>
				<td><%=rstdist.getString("Km")%></td>
				<% 			
			}
			else
			{		
			%>
			<td><%= "0" %></td>
			<% } %>
	<td>-</td>							
	<td><%=finalComment%></td>
							<td><table style="border: none;"><tr style="border: none;">
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('tripcomment.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">Enter Comment </a></td>
								<td style="border: none;"><a href="javascript: flase" onClick="window.open ('endtrip.jsp?tripid=<%=rs1.getString("TripId")%>&vehcode=<%=rs1.getString("Vehid")%>&vehno=<%=rs1.getString("VehRegNo")%>', 'win1', 'width=600, height=350, location=0, menubar=0, scrollbars=0, status=0, toolbar=0, resizable=0');">End Trip </a></td>
								</tr></table>
								</td>
		   			
						</tr>
						<%
					}
				    
					
							
			x++;
			}//end of rs1.while loop
			
			
}// end of try loop
catch(Exception e)
{
	//System.out.println("Exception----->"+e); 
	e.printStackTrace();
}
finally
{
	try{
		conn.close();
		conn1.close();
	}catch(Exception ex){}
	
}
%>	
	
	</td></tr></table>
	
	</form>
<%@ include file="footerhtml.jsp"%>
