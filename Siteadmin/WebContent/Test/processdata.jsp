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

function gotoExcel(elemId, frmFldId)  
{  

         try{
          //alert("HI>>>>>>");
    
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  

           //alert("11111");

           try{
             document.unitform.action ="excel.jsp";

           //alert("222222");
          document.forms["unitform"].submit();
        // alert("33333");


           }catch(e){alert("exception>>>"+e);}
           }
         catch(e)
           {
        	   alert("exception>>>"+e);
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
		<div align="right"><a href="excelcheckprocessedunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		boolean flag=false;
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			flag=true;
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
			sql="Select count(*) from t_fuelleveldata1 where vehregno like '"+VehicleRegNumber+"'";//checking if calibrated
			rst2=st1.executeQuery(sql);
			if(rst2.next())
			{
				calstatus = "Calibrated";
				count=rst2.getInt(1);
			}
			else
			{
				calstatus = "Not Calibrated";
			}
			%>
			<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4"><%=VehicleRegNumber %></td>
			<td colspan="4"><%=vehcode %></td>
			<td colspan="4"><%=OwnerName %></td>
			<td colspan="3"><%=calstatus %></td>
			</tr>
			</table>
			</td>
			</tr>
		<%}
		else
		{%>
		<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="3">NA</td>
			</tr>
			</table>
			</td>
			</tr>
		<%	
		}
		%>
		
		<tr>
		<td colspan="16">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">StoredDateTime</td>
		<td class="hed" align="center">StampDate</td>
		<td class="hed" align="center">StampTime</td>
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Location </td>
		<td class="hed" align="center">Speed</td>
		<td class="hed" align="center">Data Valid</td>
		<td class="hed" align="center">Fuel Level</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Unit Distance</td>
		<td class="hed" align="center">Latitude</td>
		<td class="hed" align="center">Longitude</td>
		<td class="hed" align="center">Sen 1</td>
		<td class="hed" align="center">Sen 2</td>
		<td class="hed" align="center">Sen 3</td>
		<td class="hed" align="center">Calibration Ltr. Value</td>
		<td class="hed" align="center">Calibration Ltr. Default Value</td>
		</tr>
		<%
		if(flag)
		{
		sql="select * from t_veh"+vehcode+" where TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime desc "+limit;
		
		}
		else
		{
			sql="select * from t_veh0 where TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' and unitid='"+unitid+"' order by TheFieldDataDateTime desc "+limit;
		}
		ResultSet rst=st1.executeQuery(sql);
		System.out.println("query==>"+sql);
		int i=1;
		while(rst.next())
		{
			String caliberationval="0",defaultCaliberationval="0"; 
			String TheFieldDataDate=rst.getDate("TheFieldDataDate").toString();
		    System.out.println("TheFieldDataDate"+TheFieldDataDate);
		    String TheFieldDataDate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TheFieldDataDate));
		    System.out.println("new======>TheFieldDataDate"+TheFieldDataDate1);
			String sen3="";
			try{
			
				sen3=rst.getString("Sen3").trim();
			
			}catch(Exception e){ sen3="0";}
			if(calstatus.equalsIgnoreCase("Calibrated"))
			{
				if(sen3.equals("0"))
				{
					caliberationval="0";
					defaultCaliberationval="0";
				}
				else if(count<=20 && count>0)
				{
					sql="select Ltr from t_fuelleveldatanew where vehregno= 'Default' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						defaultCaliberationval=rst3.getString("Ltr");
					}
					
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
				else
				{
					defaultCaliberationval="0";
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
			}
			else
			{
				caliberationval="N/A";
				defaultCaliberationval="N/A";
			}
			
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<td class="bodyText" align="center"><%=rst.getDate("TheFieldDataStoredDate")+" "+rst.getTime("TheFieldDataStoredTime") %></td>
			<td class="bodyText" align="center"><%=TheFieldDataDate1%></td>
			<td class="bodyText" align="center"><%=rst.getTime("TheFieldDataTime") %></td>
			<td class="bodyText" align="left"><%=rst.getString("TheFiledTextFileName") %></td>
			<td class="bodyText" align="right"><%=rst.getString("TheFieldSubject") %></td>
			<td class="bodyText" align="left"><%=rst.getString("Speed") %></td>
			<td class="bodyText" align="left"><%=rst.getString("DataValid") %></td>
			<td class="bodyText" align="left"><%=rst.getString("FuelLevel") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Distance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("CDistance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LatinDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LonginDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen1") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen2") %></td>
			<td class="bodyText" align="center"><%=sen3 %></td>
			<td class="bodyText" align="center"><%=caliberationval %></td>
			<td class="bodyText" align="center"><%=defaultCaliberationval %></td>
			</tr>
		<%
		i++;
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
	out.print("Exceptions ----->"+e);
}
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

