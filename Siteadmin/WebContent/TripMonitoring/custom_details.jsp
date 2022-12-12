<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
<html>
<head>
<script language="javascript">
function Validate()
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
function datevalidate()
{
	var date1=document.getElementById("data").value;
	var date2=document.getElementById("data1").value;
	var dm1,dd1,dy1,dm2,dd2,dy2;
	dy1=date1.substring(0,4);
	dy2=date2.substring(0,4);
	dm1=date1.substring(5,7);
	dm2=date2.substring(5,7);
	dd1=date1.substring(8,10);
	dd2=date2.substring(8,10);
	var date=new Date();
	var month=date.getMonth()+1;
	var day=date.getDate();
	var year=date.getFullYear();
	
	if(dy1>year || dy2>year)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}
	else if(year==dy1 && year==dy2) if(dm1>month || dm2>month)
	{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
	}

	if(dm1==month){
		if(dd1>day || dd2>day)
		{
		alert("selected date should not be greater than todays date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;

		return false;
	
		}
	}
	if(dy1>dy2)
	{
		alert("From date year is should not be greater than to date year");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	
	else if(year==dy1 && year==dy2) if(dm1>dm2)
	{
		alert("From date month is should not be greater than to date month");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	if(dm1==dm2) {
	if(dd1 > dd2)
	{
		alert("From date is should not be greater than to date");
		document.getElementById("data").value="";
		document.getElementById("data1").value="";
		document.getElementById("data").focus;
		return false;
	}
	}
	return true;
}
</script>
</head>
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
datenew1=request.getParameter("data");
String myfromdate =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew1));
datenew2=request.getParameter("data1");
String mytodate =new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(datenew2));

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
<table border="0" width="100%" bgcolor="white">  
<tr align="center">
<td>

<font size="3"><div><b>Custom Detail Report<b></div></font></center>
<div class="bodyText" align="right">

</div>
</td>
</tr>
<tr>
<td>
<form name="customdetail" method="get" action="" >
	<input type="hidden" name="vehcode" value="<%=VehicleCode%>">
	<table border="0" width="100%" align="right">  
 	<tr>
 	<td align="left">
		<input type="text" id="data" name="data" size="12" value="<%=datenew1%>" readonly/>
	</td>
		<td>
		<select name="ftime1" id="ftime1">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<24;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		</select>
		<select name="ftime2" id="ftime2">
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<60;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		
		</select>
  		</td>
		<td align="left">
		<input type="button" name="From Date" value="From Date" id="trigger">
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
		<td align="left">
			<input type="text" id="data1" name="data1" value="<%=datenew2%>"  size="12" readonly/>
		</td>
		<td>
		<select name="ttime1" id="ttime1" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<23;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="23" selected>23</option>
		</select>
		<select name="ttime2" id="ttime2" >
		<option value="00">00</option>
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<%
			for(int i=10;i<59;i++)
			{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%
			}		
		%>
		<option value="59" selected>59</option>
		</select>		
		</td><td align="left">
  		<input type="button" name="To Date" value="To Date" id="trigger1">
		<script type="text/javascript">
  			Calendar.setup(
    		{
      			inputField  : "data1",       // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"     // ID of the button
    		}
 		);
		</script>
	</td>
	<td><div align="left" > 
		<!--<font color="Blue" size="1"> Note- Enter date in format(yyyy-mm-dd)</font>-->
		
	<input type="submit" name="submit" value="Submit">
	</div></td>
	<%
	
	if(!(null==request.getParameter("data")))
	{	
		fromdate = request.getParameter("data");
		todate =request.getParameter("data1");
	}
	
	%>
	</tr>
	</table>
</td></tr>
<tr><td>
<%
if(!(null==request.getParameter("data")))
{
/* all code comes here */
%>
<table width="100%" align="center">
<tr>
<td align="center"><font size="3"><b> Detail Report for Vehicle <%=vehregno%> from <%=datenew1 %>  to <%=datenew2%> </b></font>

<div class="bodyText" align="left">

	
<div class="bodyText" align="right"> 
<a href="print_detail_custom_report.jsp?vehcode=<%=VehicleCode%>&data=<%=fromdate%>&data1=<%=todate%>" title="Export to Excel">
<img src="../images/excel.jpg" width="15px" height="15px"></a>	 
</div>

</td></tr>
</table>
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
sql="select * from t_veh"+VehicleCode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+myfromdate+" "+fromtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime) <='"+mytodate+" "+totime+"' and TheFiledTextFileName in ('SI','OF','ON') order by concat(TheFieldDataDate,' ',TheFieldDataTime) asc";

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
		<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>
		
													
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
					<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>	
				
												
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
					<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>
					
													
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
				<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>
				
													
				
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
						<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>					
							
									</tr>
									<%		
					i++;
					%>
					
					<tr>
							<td class="bodyText"><div align="right"><%=i%></div></td>
							<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
							<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
							<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>					
					</tr>	
													
					<%		
					i++;
					%>
					
					<tr>
							<td class="bodyText"><div align="right"><%=i%></div></td>
							<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
							<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="START"%></div></td>
							<td class="bodyText"><div align="right"><%=ds2-dist%></div></td>
							<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>					
												
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
							<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>					
							
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
								<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>
								</tr>
											<%		
									i++;
											%>
											<tr>
												<td class="bodyText"><div align="right"><%=i%></div></td>
												<td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(dt2)%></div></td>
												<td class="bodyText"><div align="right">&nbsp;&nbsp;<%="ON"%></div></td>
												<td class="bodyText"><div align="right"><%=ds3-dist%></div></td>
												<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>	
											
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
														<td class="bodyText"><div align="right"><a href="#"  onclick="popWin=open('shownewmap.jsp?lat=<%=rst1.getString("LatinDec")%>&long=<%=rst1.getString("LonginDec")%>&discription=<%=rst1.getString("TheFieldSubject")%>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%= rst1.getString("TheFieldSubject") %></a></div></td>	
														
												
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
