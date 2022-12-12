<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename="checkbystamp.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<html>
<head>
<%!
String VehicleCode, fromdate, todate, desc,vehregno;
//,fromtime,totime;
String datenew1,datenew2;
Connection conn;
Statement st;
String sql;
boolean flag=true;
%>

<% 
String empnamee="";

VehicleCode=request.getParameter("vehcode");

System.out.println("VehicleCode--->" + VehicleCode);
datenew1=request.getParameter("data");
System.out.println("datenew1------------->" +datenew1);
datenew2=request.getParameter("data1");
System.out.println("datenew2----------->" + datenew2);
if(null==datenew1)
{
	datenew1=datenew2=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
}
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	sql="select * from t_vehicledetails where VehicleCode='"+VehicleCode+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		vehregno=rst.getString("VehicleRegNumber");
	}
%>

	<%
	
	if(!(null==request.getParameter("data")))
	{
		
	//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
	fromdate = request.getParameter("data");

	

	//todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	todate =request.getParameter("data1");
	
	//fromtime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
	
	//totime=request.getParameter("ttime1")+":"+request.getParameter("ttime2")+":00";
	
	//out.print(fromtime+"  "+totime);
			}
	
	
	%>

<%

System.out.println("request.getParameter(data)==>" + request.getParameter("data"));
if(!(null==request.getParameter("data")))
{
/* all code comes here */
%>

<table width="100%" align="center" class="sortable" border="1">
<tr>
<th>Sr.</th>
<th>Date-Time</th>
<th>Speed</th>
<th>Distance</th>
<th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Location</th>
</tr>
<%
String fromtime = "00:00:00";
	
String totime ="23:59:59";	
sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+fromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+todate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";
System.out.println("Jspsql::>>"+sql);
ResultSet rst1=st.executeQuery(sql);
String location="";
int i=1;
int x=0;
int dist=0;

if(rst1.first())
{
	if(i==1)
	{
		dist=rst1.getInt("Distance");
		//System.out.println("dist::>>"+dist);
	}
%>
	<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		<td class="bodyText"><%= rst1.getString("TheFieldSubject") %></td>
		
													
	</tr>
<%
i++;

}

while(rst1.next())
{
	
	if(rst1.getString("TheFiledTextFileName").equals("SI"))
	{
		
		if(rst1.getInt("Speed")==0)
		{
			
			if(flag)
			{
				
				flag=false;
				x=1;
				%>
				<tr >
					<td class="bodyText"><div align="right"><%=i%></div></td>
					<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText" ><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
					<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
					<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>	
				
												
				</tr>
				<%
				i++;
			}
		}
		
		else
		{//SI wid  sp>0
			if(x==1)
			{
				flag=true;
				%>
				<tr>
					<td class="bodyText"><div align="right"><%=i%></div></td>
					<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
					<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="Start"%></div></td>
					<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
					<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>
					
													
				</tr>
				<%
				i++;
				x++;
			}
			
			flag=true;	
			%>
			<tr>
				<td class="bodyText"><div align="right"><%=i%></div></td>
				<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
				<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
				<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
				<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>
				
													
				
			</tr>
			<%
			i++;
		}
	}//ens of SI check
	else
    {
		if(rst1.getString("TheFiledTextFileName").equals("OF"))
    
		{
			String long1,long2,long3,lat1,lat2,lat3,loc1,loc2,loc3;
			int ds1,ds2,ds3;
			java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
			loc1=rst1.getString("TheFieldSubject");
			lat1=rst1.getString("LatinDec");
			long1=rst1.getString("LonginDec");
			ds1=rst1.getInt("Distance");
			if(rst1.next())
			{
				if(rst1.getString("TheFiledTextFileName").equals("ON")||rst1.getString("TheFiledTextFileName").equals("SI"))
				{
					if(rst1.getString("TheFiledTextFileName").equals("SI"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						
						if(mils3 > 20)
						{
							%>
							<tr>
						<td class="bodyText"><div align="right"><%=i%></div></td>
						<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></div></td>
						<%
						if(mils3>=60)
						{
							hrs=mils3/60;
							mins=mils3%60;
							%>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
							<%								
						}
						
						else
						{
							
							%>
						<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
						<%
						}
						%>
						
						
						<td class="bodyText"><div align="right"><%=ds1-dist%></div></td>
						<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>					
							
									</tr>
									<%		
					i++;
					%>
					
					<tr>
							<td class="bodyText"><div align="right"><%=i%></div></td>
							<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
							<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
							<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>					
							
							
					</tr>	
													
					<%		
					i++;
					%>
					
					
					<tr>
												<td class="bodyText"><div align="right"><%=i%></div></td>
												<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="START"%></div></td>
												<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
												<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>					
												
													</tr>	
													<%		
					i++;
					flag=true;
					%>
					
					
					<tr>
							<td class="bodyText"><div align="right"><%=i%></div></td>
							<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
							<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
							<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>					
							
								</tr>	
								<%
								i++;
						}
					}//end of SI check after OF stamp
					
					else if(rst1.getString("TheFiledTextFileName").equals("ON"))
					{
						java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("TheFieldDataDate")+" "+rst1.getString("TheFieldDataTime"));
						loc2=rst1.getString("TheFieldSubject");
						lat2=rst1.getString("LatinDec");
						long2=rst1.getString("LonginDec");
						ds2=rst1.getInt("Distance");
						long hrs=00,mins=00;
						long mils1=dt1.getTime();
						long mils2=dt2.getTime();
						long mils3=mils2-mils1;
						mils3=mils3/1000/60;
						
						if(mils3 > 20)
						{
							if(rst1.next())
							{
								if(rst1.getString("TheFiledTextFileName").equals("SI"))
								{
									loc3=rst1.getString("TheFieldSubject");
									//System.out.println("Stamp::>>"+rst1.getString("TheFiledTextFileName"));
									lat3=rst1.getString("LatinDec");
									long3=rst1.getString("LonginDec");
									ds3=rst1.getInt("Distance");
									
									%>
									<tr>
								<td class="bodyText"><div align="right"><%=i%></div></td>
								<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt1)%></div></td>
								<%
								if(mils3>=60)
								{
									hrs=mils3/60;
									mins=mils3%60;
									%>
									<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=""+hrs+" Hrs. "+mins+" Mins. OFF"%></div></td>
									<%								
								}
								
								else
								{
									
									%>
								<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="00 Hrs. "+mils3+" Mins. OFF"%></div></td>
								<%
								}
								%>
								
								
								<td class="bodyText"><div align="right"><%=ds1-dist%></div></td>
								<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>
								</tr>
											<%		
									i++;
											%>
											<tr>
												<td class="bodyText"><div align="right"><%=i%></div></td>
												<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
												<td class="bodyText"><div align="right"><%=ds3-dist%></div></td>
												<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>	
											
											</tr>	
													<%
													i++;
													if(rst1.getInt("Speed")==0)
													{%>
														<tr>
														<td class="bodyText"><div align="right"><%=i%></div></td>
														<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%>  <%=" "+rst1.getString("TheFieldDataTime")%></div></td>
														<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="Stop"%></div></td>
														<td class="bodyText"><div align="right"><%=ds3-dist%></div></td>
														<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>	
														
												
													</tr>
													<%
													i++;
													}
							
								}
							}
						}
					}//end of ON stamp after OF stamp
				}//end of SI or ON stamp check
			}
		}//end of OF stamp check
		//flag=true;
    }
}//end of while loop

				
					

		
if(rst1.last())
{
%>
	<tr>
		<td class="bodyText"><div align="right"><%=i%></div></td>
		<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheFieldDataDate"))%> <%=rst1.getString("TheFieldDataTime")%></div></td>
		<td class="bodyText"><div align="right">&nbsp;&nbsp;<%=rst1.getInt("Speed")%></div></td>
		<td class="bodyText"><div align="right"><%=rst1.getInt("Distance")-dist%></div></td>
		<td class="bodyText"><div align="right"><%= rst1.getString("TheFieldSubject") %></div></td>	
	
												
	</tr>
<%
i++;

}
%>
</table>
<%
/* code end here*/
}

%>
</td></tr>

</table>
<%
}
catch(Exception e)
{}finally{
	conn.close();
}
%>


</html>
