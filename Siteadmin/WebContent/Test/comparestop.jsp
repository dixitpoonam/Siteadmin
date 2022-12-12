<%@ include file="headerhtml.jsp" %>

<%!

Statement st, st1;
int limit;
Connection conn;
%>
<script type="text/javascript">
function validate()
{ 
	try
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

	if(document.getElementById("unitid").value=="") 
	{
		alert("Please Enter the Unit ID.");
		return false;
	}
	
	
	return datevalidate();
	return true;
	}
	catch(e)
	{
		alert(e);
	}
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
	if(yy11>year  || yy22>year) 
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
					if(days=='May') //timeformat: "%M:%S"
						
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

</script>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="", vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",defaultDate1="",calstatus="";

int count=0;
boolean flag=true;

try{
	st=conn.createStatement();
	st1=conn.createStatement();
	defaultDate= new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	defaultDate1 = new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	if(!(null==request.getQueryString()))
	{
		defaultDate=request.getParameter("data");
		defaultDate1=request.getParameter("data1");
	}
	String thedate11="",thedate12="",thedate13="";
	%>
	
<%@page import="java.util.Date"%><form name="unitform" action="" method="get" onsubmit="return validate();"><table border="0" width="100%" align="center" class="sortable">
	
	<tr><td colspan="10" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its data.</b> </td></tr>
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
	<td bgcolor="#F5F5F5">
	<input type="text" id="data1" name="data1" value="<%=defaultDate1 %>"  size="12" readonly/>
	</td><td bgcolor="#F5F5F5">
  	<input type="button" name="The Date1" value="To Date" id="trigger1">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data1",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger1"       // ID of the button
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
	<input type="radio" name="limit" value="xx" checked> <input type="text" name="lim" value="10" size="5" class="stats" /> <br>
<input type="radio" name="limit" value="All" > ALL
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>

	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate2 = request.getParameter("data1");
		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate2));
		
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
		<div align="right"><a href="excelcomparestop.jsp?data=<%=thedate %>&unitid=<%=unitid %>&data1=<%=thedate2 %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		System.out.println("Vehicle details Table" +sql);
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
		}
		%>
		
		<tr>
		<td colspan="">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Vehicle Code</td>
		<td class="hed" align="center">Vehicle No</td>
		<td class="hed" align="center">Date </td>
		<td class="hed" align="center">Time</td>
				<td class="hed" align="center">Speed</td>
		
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Location</td>
		
		</tr>
		<%
		try{
		String sqlck="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('ST','SP') and TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime  "+limit;
		
		System.out.println("Main Query" +sqlck);

		ResultSet rst=st1.executeQuery(sqlck);
		int i=1;
		while(rst.next())
		{
			thedate11=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheFieldDataDate"));

			
		%>
			<tr>
			<td class="bodyText" align="right"><div align="right"><%=i %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
			<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=thedate11 %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=rst.getTime("TheFieldDataTime") %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=rst.getString("Speed") %></div></td>
			
			<td class="bodyText" align="left"><div align="left"><%=rst.getString("TheFiledTextFileName") %></div></td>
			<td class="bodyText" align="left"><div align="left"><%=rst.getString("TheFieldSubject") %></div></td>
			
		
			</tr>
		<%
		i++;
		}
		%>
		 
		 <%
		 String fromdate = thedate1;
		 String fromtime = "00:00:00";
		 String sqlnew="select * from t_veh"+vehcode+" where TheFieldDataDateTime <='"+fromdate+" "+fromtime+"' and TheFiledTextFileName in ('SI','OF','ON','ST','SP') order by TheFieldDataDateTime desc limit 1";
		 ResultSet rstnew=st.executeQuery(sqlnew);
		 if(rstnew.next())
		 {
		 	fromdate=rstnew.getString("TheFieldDataDate");
		 	fromtime=rstnew.getString("TheFieldDataTime");
//		 	System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
		 	
		 }
		
		String sqlckstop="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('SI','OF','ON','ST','SP') and TheFieldDataDateTime >='"+fromdate+" "+fromtime+"' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime  "+limit;		
		System.out.println("Main Current Query" +sqlckstop);

		ResultSet rstop=st1.executeQuery(sqlckstop);
		int k=1;
		int x=0;

		if(rstop.first())
		{
			
		}
		while(rstop.next())
		{
			if(rstop.getString("TheFiledTextFileName").equals("SI") || rstop.getString("TheFiledTextFileName").equals("ST") || rstop.getString("TheFiledTextFileName").equals("SP"))
			{			
			if(rstop.getInt("Speed")==0)
			{
				if(flag==true)
				{				
					flag=false;
					x=1;
					thedate12=new SimpleDateFormat("dd-MMM-yyyy").format(rstop.getDate("TheFieldDataDate"));

		%>
			<tr>
			<td class="bodyText" align="right"><div align="right"><%=k++ %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
			<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=thedate12 %></div></td>
			<td class="bodyText" align="left"><div align="right"><%=rstop.getTime("TheFieldDataTime") %></div></td>
		    <td class="bodyText" align="right"><div align="right"><%=rstop.getString("Speed") %></div></td>
			<td class="bodyText" align="left"><div align="left"><%="Stop"%></div> </td>
			<td class="bodyText" align="left"><div align="left"><%=rstop.getString("TheFieldSubject") %></div></td>
			
		
			</tr>
			
		<%
		
		
		}
				
			}
			else if(rstop.getInt("Speed")>0 && x==1)				
			{
				
				flag=true;
				thedate13=new SimpleDateFormat("dd-MMM-yyyy").format(rstop.getDate("TheFieldDataDate"));				
		%>
		<tr>
		    <td class="bodyText" align="right"><div align="right"><%=k++ %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
			<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=thedate13 %></div></td>
			<td class="bodyText" align="left"><div align="right"><%=rstop.getTime("TheFieldDataTime") %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=rstop.getString("Speed") %></div></td>			
			<td class="bodyText" align="left"><div align="left"><%="Start"%> </div></td>
			<td class="bodyText" align="left"><div align="left"><%=rstop.getString("TheFieldSubject") %></div></td>
			
		
			</tr>
		<%x++;}
			}
			else
			{
				if(rstop.getString("TheFiledTextFileName").equals("OF"))
				{
					java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstop.getString("TheFieldDataDate")+" "+rstop.getString("TheFieldDataTime"));
					if(rstop.next())
					{
						if(rstop.getString("TheFiledTextFileName").equals("ON"))
						{
							java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstop.getString("TheFieldDataDate")+" "+rstop.getString("TheFieldDataTime"));							
							long hrs=00,mins=00;
							long mils1=dt1.getTime();
							long mils2=dt2.getTime();
							long mils3=mils2-mils1;
							mils3=mils3/1000/60;						
							if(mils3 > 20)
							{
								if(rstop.next())
								{
									if(rstop.getString("TheFiledTextFileName").equals("SI") || rstop.getString("TheFiledTextFileName").equals("ST") || rstop.getString("TheFiledTextFileName").equals("SP"))
									{
										if(rst1.getInt("Speed")==0)
										{
										    if(flag==true)
										     {
										         flag=false;	 
										         x=1;
										         %>
										         <tr>
			<td class="bodyText" align="right"><div align="right"><%=k++ %></div></td>
			<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
			<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
			<td class="bodyText" align="right"><div align="right"><%=thedate12 %></div></td>
			<td class="bodyText" align="left"><div align="right"><%=rstop.getTime("TheFieldDataTime") %></div></td>
		    <td class="bodyText" align="right"><div align="right"><%=rstop.getString("Speed") %></div></td>
			<td class="bodyText" align="left"><div align="left"><%="Stop"%></div> </td>
			<td class="bodyText" align="left"><div align="left"><%=rstop.getString("TheFieldSubject") %></div></td>
			
		
			</tr>
										         <%
										     }
										}
									}
								}
							}
							
						}
					}
					
					rstop.previous();
				}
			}
		}
		}catch(Exception e){
			
			e.printStackTrace();
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
		</form>
	<%
	
}catch(Exception e)
{
e.printStackTrace();}
finally
{
	try{
	conn.close();

	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

