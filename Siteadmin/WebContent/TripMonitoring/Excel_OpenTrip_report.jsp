<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=showdatex+"_excel_open_trip_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%! 
Connection conn,conn1;
%>
<table border="1" width="100%" align="center">
<tr><td>

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
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	double stdDist=0,capDist=0;
	//if(!(null==request.getParameter("data")))
	//{
	//	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("fromdate")));
	//	todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("todate")));	
	//fromdate1=request.getParameter("data");
	//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
	//todate1=request.getParameter("data1");
	//todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
	//out.print(fromdate);
	//}
	//else
	//{
	//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	//todate=fromdate;
	//fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	//todate1=fromdate1;
	//out.print(todate);
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	System.out.println("fromdate"+fromdate);
	System.out.println("todate"+todate);
	%>
<table width="100%" align="center" border="0"  class="bodytext">
	<tr>
		<td align="center" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b>Open Trip Report</font></td>
	</tr>
	<tr><td colspan="25">
		<table  border="0" width="100%">
		<tr><td colspan="5" align="center" bgcolor="">
			<font size="3" ><b>Open Trips Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></b></font>
			</td>
			</tr></table>
			</td>
			</tr>
			
			<tr><td colspan="25">
		<table  border="0" width="100%" class="sortable" >
		<tr >
			<td class="hed" align="center" > <font color="black" size="2"><b>Sr.No.</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>TripID</b></font></td>
			<td class="hed" align="center"> <font color="black" size="2"><b> Vehicle</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b> Transporter</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b> StartPlace</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b> StartCode</b></font></td>
			<td class="hed" align="center"> <font color="black" size="2"><b> EndPlace</b></font></td>
			<td class="hed" align="center"><font color="black" size="2"> <b> EndCode</b></font></td>
			<td class="hed" align="center"> <font color="black" size="2"><b>StartDate</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>StdKm</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>Captured Km</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>StdTTime</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>Type of Trips Secondary/Primary/Tanker</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>StartLat</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>Start Long</b></font></td>
			<td class="hed" align="center" > <font color="black" size="2"><b>EndLat</b></font> </td>
			<td class="hed" align="center" > <font color="black" size="2"><b>EndLong</b></font> </td>
			<td class="hed" align="center"><font color="black" size="2"><b>Current date</b></font></td>
			<td class="hed" align="center"><font color="black" size="2"><b>Current time</b></font></td>
			<td class="hed" align="center"><font color="black" size="2"><b>Current Location</b></font></td>
			<td class="hed" align="center"><font color="black" size="2">  <b>Unit Replaced</b></font></td>
			<td class="hed" align="center"><font color="black" size="2">  <b>Vehicle Attended</b></font></td>
			<td class="hed" align="center"><font color="black" size="2">  <b>Diff in KM</b></font></td>
			<td class="hed" align="center"> <font color="black" size="2"><b>Comment</b></font> </td>
			<td class="hed" align="center"><font color="black" size="2"><b> Trip Comments</b></font> </td>
			
		</tr>
		
		<%
				int i=1,x=1;
				
				String tripid="-",startloc="-",endloc="-",vehregno="-",transporter="-";
				String slat,slon,elat,elon;
				java.util.Date dt1 = null;
				String km="-",ttime="-",startcode1="-",startcode2="-",endcode1="-",endcode2="-",gpname="-";
				
				sql1="select rid,TripID,VehRegNo,OwnerName,StartPlace,EndPlace,StartDate,StartTime,StartCode,EndCode,EndLat,EndLong,Vehid,VehRegNo,GPName from t_startedjourney where StartDate between '"+fromdate+"' and '"+todate+"' and JStatus='Running' and GPName='Castrol' order by StartDate,StartTime asc";
				rs1=stmt1.executeQuery(sql1);
				
				//today = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
   				//System.out.println("today--->" + today);
				
				while(rs1.next())
				{
					
					String lastdate="-",lasttime="-",lastloc="-",stdate="",startdate="",sttime="",category="-",comment="-",finalComment="-",vehID="-";
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
					startdate=stdate;
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
					sql2="select * from t_veh"+rs1.getString("Vehid")+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+startdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by TheFieldDataDate,TheFieldDataTime limit 1 ";
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
								<td><%=rs1.getString("TripID")%></td>
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
										   			
							</tr>
						  <%
						}
						else
						{ 		
						%>
						<tr>
							<td><%= x%></td>
							<td><%=rs1.getString("TripID")%></td>
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
						<td><%=finalComment%></td>
							
		   			
						</tr>
					    <%
						}
				   }
					else
					{
						%>
						<tr>
							<td><%=x%></td>
							<td><%=rs1.getString("TripID")%></td>
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
				<td>- </td>			
	<td><%=finalComment%></td>
									   			
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
	conn.close();
	conn1.close();
}
%>	
	
	</td></tr></table>
	
	
	<%@ include file="footerhtml.jsp"%>
					