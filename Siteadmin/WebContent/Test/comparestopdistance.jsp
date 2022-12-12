<%@ include file="headerhtml.jsp" %>
<%!
Statement st, st1;
int limit;
Connection conn;
%>
<script type="text/javascript">
function validate()
{
	try{
	if(document.getElementById("data").value=="") 
	{		alert("Please Select The from date.");
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

function gotoExcel(elemId, frmFldId)  
{  
	      //alert("asdas"+elemId+"   "+frmFldId);
	      try{
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.index_a_cat.action ="excel.jsp";
          document.forms["index_a_cat"].submit();
	      }
	      catch(e)
	      {
	    	  alert(e);
	      }
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
	
<%@page import="java.util.Date"%>
<form name="unitform" action="" method="get" onsubmit="return validate();">
<table border="0" width="100%" align="center" class="sortable">	
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
		System.out.print(thedate);
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
			</tr>
	</table>
	</form>
		<form name="index_a_cat" id="index_a_cat" method="post">
			<%
						
         final String exportFileName="Data_Gap_Analysis_Report_of_"+thedate+"_And_"+thedate2;  
	%>
		<div   id="table1" align="center" style="width:100%; background-color: ">			
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
						<td>
				 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
				 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
								<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
	                           <img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
	        	</td>
<%-- 		<th colspan="16" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font> --%>
<%-- 		<div align="right"><a href="excelcomparestopdistance.jsp?data=<%=thedate %>&unitid=<%=unitid %>&data1=<%=thedate2 %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th> --%>
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
		
		<tr><td colspan="">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Vehicle Code</td>
		<td class="hed" align="center">Vehicle No</td>
		<td class="hed" align="center">Transporter</td>
		<td class="hed" align="center">FromDT</td>
		<td class="hed" align="center">FromLoc</td>
		<td class="hed" align="center">FromDist</td>
		<td class="hed" align="center">ToDT</td>
		<td class="hed" align="center">ToLoc</td>
		<td class="hed" align="center">ToDist</td>
		<td class="hed" align="center">DistDiff</td>		
		</tr>
		<%
		try{
			String FromDate="",FromLoc="",ToDate="",ToLoc="";
			int FromDist=0,ToDist=0,DistDiff=0;
		String sqlck="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('SI') and TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime Asc "+limit;
		System.out.println("Main Query" +sqlck);
		ResultSet rst=st1.executeQuery(sqlck);
		int i=1;
		int Valid=0,Invalid=0;
		while(rst.next())
		{
			FromDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")));
			FromDist=rst.getInt("CDistance");
			FromLoc=rst.getString("TheFieldSubject");
			System.out.println("DistDiff : "+DistDiff);
			
			if(rst.next())
			{
				ToDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")));
				ToDist=rst.getInt("CDistance");
				ToLoc=rst.getString("TheFieldSubject");
				DistDiff=ToDist-FromDist;
				System.out.println("DistDiff : "+DistDiff);	
				if(DistDiff>3)
				{ Invalid++;
					%>
					<tr>
					<td class="bodyText" align="right"><div align="right"><%=i %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
					<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
					<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
					<td class="bodyText" align="left"><div align="left"><%=OwnerName%></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromDate %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromLoc %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromDist %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToDate %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToLoc %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToDist %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=DistDiff %></div></td>
					</tr>
					<%
					i++;									
				}
				else
				{
					Valid++;		
				}
			}
			rst.previous();			
		}		
		System.out.println("Valid Count " +Valid);
		System.out.println("Invalid Count " +Invalid);
		%>
				<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Vehicle Code</td>
		<td class="hed" align="center">Vehicle No</td>
		<td class="hed" align="center">Transporter</td>
		<td class="hed" align="center">FromDT</td>
		<td class="hed" align="center">FromLoc</td>
		<td class="hed" align="center">FromDist</td>
		<td class="hed" align="center">ToDT</td>
		<td class="hed" align="center">ToLoc</td>
		<td class="hed" align="center">ToDist</td>
		<td class="hed" align="center">TimeDiff</td>
		
		
		</tr>
		
		<tr>
		<%
		String FromLatitude="",FromLongitude="",ToLatitude="",ToLongitude="";
		String sqlckstop="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('SI') and TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime asc "+limit;
		System.out.println("Main Current Query" +sqlckstop);
		rst=st1.executeQuery(sqlckstop);
		int k=1;
		int x=0;
		String DBFromDate="",DBToDate="";
			
		while(rst.next())
		{
			FromDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")));
			DBFromDate=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
			FromDist=rst.getInt("CDistance");
			FromLoc=rst.getString("TheFieldSubject");
			FromLatitude=rst.getString("LatinDec");
			FromLongitude=rst.getString("LonginDec");
			//System.out.println("DistDiff : "+DistDiff);
			if(rst.next())
			{
				ToDate=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime")));
				DBToDate=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
				ToDist=rst.getInt("CDistance");
				ToLoc=rst.getString("TheFieldSubject");
				ToLatitude=rst.getString("LatinDec");
				ToLongitude=rst.getString("LonginDec");
				
				System.out.println("From "+FromLatitude+","+FromLongitude);
				System.out.println("TO "+ToLatitude+","+ToLongitude);				
				int geoDistDiff=0,timeDiff=0;				
				ResultSet rstd=st.executeQuery("SELECT TIME_TO_SEC(TIMEDIFF('"+DBToDate+"', '"+DBFromDate+"')) diff");
				System.out.println("SELECT TIME_TO_SEC(TIMEDIFF('"+DBToDate+"', '"+DBFromDate+"')) diff");
				
				if(rstd.next())
					{
					timeDiff= rstd.getInt("diff");
					}
				System.out.println("timeDiff "+timeDiff);
				if(timeDiff>300)
				{
					//System.out.println("From "+FromLatitude);					
				String dist="Select (2.0 * 3958.75 * ATAN(SQRT(SIN(RADIANS('"+FromLatitude+"' - "+ToLatitude+")*0.5) * SIN(RADIANS('"+FromLatitude+"' - "+ToLatitude+")*0.5) + COS(RADIANS("+ToLatitude+")) * COS(RADIANS('"+FromLatitude+"')) *SIN(RADIANS('"+FromLongitude+"' - "+ToLongitude+")*0.5) *SIN(RADIANS('"+FromLongitude+"' - "+ToLongitude+")*0.5)), SQRT(1.0-(SIN(RADIANS('"+FromLatitude+"' - "+ToLatitude+")*0.5) *SIN(RADIANS('"+FromLatitude+"' - "+ToLatitude+")*0.5) +COS(RADIANS("+ToLatitude+")) * COS(RADIANS('"+FromLatitude+"')) *SIN(RADIANS('"+FromLongitude+"' - "+ToLongitude+")*0.5) *SIN(RADIANS('"+FromLongitude+"' - "+ToLongitude+")*0.5)) )) * 1609.344)/1000 AS distance1";
				System.out.println("dist>>>"+dist);
				 rstd=st.executeQuery(dist);
				if(rstd.next())
						{
						geoDistDiff=rstd.getInt("distance1");
						}
							
				System.out.println("geoDistDiff : "+geoDistDiff+" timeDiff"+timeDiff);							
				if(timeDiff>300 && geoDistDiff>500)
				{ Invalid++;
					%>
					<tr>
					<td class="bodyText" align="right"><div align="right"><%=i %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=unitid%></div></td>
					<td class="bodyText" align="right"><div align="right"><%=vehcode%></div></td>
					<td class="bodyText" align="left"><div align="left"><%=VehicleRegNumber%></div></td>
					<td class="bodyText" align="left"><div align="left"><%=OwnerName%></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromDate %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromLoc %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=FromDist %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToDate %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToLoc %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=ToDist %></div></td>
					<td class="bodyText" align="right"><div align="right"><%=timeDiff %></div></td>
					</tr>
					<%
					i++;
									
				}
				else
				{
					Valid++;
				}
			}
			}
			rst.previous();
			
		}
		
		}
		catch(Exception e){
			
			e.printStackTrace();
		}
		
		%>
		
		
		
		 </table>
		  </td>
		  </tr>
		
		
	
		  
		  </table>
		  
		  
	  </div>
		  
		<%
	}
	%>
	
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

