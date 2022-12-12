<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
 <%@page import="java.util.Date"%> 
  <script language="javascript">
 			function validate()
  			{


 	  			
  				if(document.getElementById("startplace").value=="Select") 
  				{
  					alert("Please Select The StartPlace.");
  					return false;
  				}
  				/*if(document.getElementById("endplace").value =="Select")
  			  	{
  					alert("Please Select The EndPlace");
  					return false;
  			  	}  	*/

  				
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
			
			//dy1=date1.substring(0,4);
			//dy2=date2.substring(0,4);
			//dm1=date1.substring(5,7);
			//dm2=date2.substring(5,7);
			//dd1=date1.substring(8,10);
			//dd2=date2.substring(8,10);
			
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
			
			//if(dy1>dy2)
			//{
			//	alert("From date year is should not be greater than to date year");
			//	document.getElementById("data").value="";
			//	document.getElementById("data1").value="";
		//		document.getElementById("data").focus;
		//		return false;
		//	}
			

  	</script>
  <script language="javascript">

function CheckUncheckAll()
{
	var cntr=parseInt(document.kmlreports.cntr.value);

	for (i = 1; i < cntr; i++)
	{ 
		if(document.kmlreports.main.checked==true)
		{
			document.getElementById("chk"+i).checked = true;
		}
		else
		{
			document.getElementById("chk"+i).checked = false;
		}
	} 
}


function deactive()
{

	//-------------------------------------
	
			var flag=false;
  				var len=document.getElementById("cntr").value;
  				//alert(len);
  				//alert(mobno+len);
  				var i=0;
  			
  				if(len>=0)
  				{
  	  				//alert("inside if");
  				for(i=1;i<len;i++)
  				{
  	  				//alert(document.getElementById("chk"+i).value);
  					if(document.getElementById("chk"+i).checked)
  					{

  						status=document.getElementById("status"+i).value;
  						//alert("status"+status);
  						if(status==0)
  						{
  							var trip=document.getElementById("trip"+i).value;
  							alert("Trip Id "+trip+" is already deactivated");
  							flag=true;
  							return false;
  						}
  						else
  						{
  	  						flag=true;
  						}  						
  					}
  					
  				}
  				//alert(flag);
  				if(flag!=true)
  				{
  					alert("Please Select the checkbox");
  					return false;
  				}
  				else
  				{
  	  				document.getElementById("btnchk").value="Deactive";
  					document.kmlreports.action="activedeactiveKML.jsp";
  					
  					document.kmlreports.submit();
  					
  				}
  				}
	//-------------------------------------------


	

}

		function active()
		{
			//alert("inside active");
			
			var flag=false;
  				var len=document.getElementById("cntr").value;
  				//alert(len);
  				//alert(mobno+len);
  				var i=0;
  			
  				if(len>=0)
  				{
  	  				//alert("inside if");
  				for(i=1;i<len;i++)
  				{
  	  				//alert(document.getElementById("chk"+i).value);
  					if(document.getElementById("chk"+i).checked)
  					{

  						status=document.getElementById("status"+i).value;
  						//alert("status"+status);
  						if(status==1)
  						{
  							var trip=document.getElementById("trip"+i).value;
  							alert("Trip Id "+trip+" is already Activated");
  							flag=true;
  							return false;
  						}
  						else
  						{
  	  						flag=true;
  						}  						
  					}
  					
  				}
  				//alert(flag);
  				if(flag!=true)
  				{
  					alert("Please Select the checkbox");
  					return false;
  				}
  				else
  				{
  	  				//alert("inside submit else");
  	  			document.getElementById("btnchk").value="Active";
  					document.kmlreports.action="activedeactiveKML.jsp?btn=Active";
  					
  					document.kmlreports.submit();
  					
  				}
  				}
			
		}
		function visibledate()
		{
			if(document.getElementById("chkdate").checked)
			{
				document.getElementById("divdate").style.display='block';
			}
			else
				document.getElementById("divdate").style.display='none';
		}
</script>


<style>
.popupx {
background-color: #98AFC7;
position: absolute;
visibility: hidden;
}
</style>






<table border="0" width="100%" align="center">
<tr><td>
<form name="kmlreports" method="get" action="" onsubmit="return validate();">
<% 
Connection conn;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	Statement stmt1 = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	Statement stmt3 = conn.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null;
	String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	if(!(null==request.getParameter("data")))
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	fromdate1=request.getParameter("data");
	//fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
	todate1=request.getParameter("data1");
	//todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
	//out.print(fromdate);
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	//out.print(todate);
	}
	String startplace=request.getParameter("startplace");
	String flag=request.getParameter("flag");
	
	//System.out.println("FromDate"+fromdate);
	//System.out.println("ToDate"+todate);
	//System.out.println("FromDate1"+fromdate1);
	//System.out.println("ToDate1"+todate1);
	
%>		
	<table width="100%" align="center" border="0"  class="bodytext">
	<%if(flag!=null && flag.equalsIgnoreCase("true")){ %>
	<tr><td colspan="7" align="center"><font size="2" color="red"><b>Updated Successfully...........</b></font></td></tr>
	<%} %>
	<tr>
		<td align="center" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b>KML Report</font></td>
	</tr>
	<tr><td colspan="8">
			<!-- if date range is not required please remove this code start from this comment to -->
			
  		<table border="1" width="100%">
		<tr bgcolor="lightgrey">
			<td colspan="3" align="center">
			
			<%
		
			String chk=request.getParameter("chkdate");
			System.out.println("chk"+chk);
			String str="SELECT startpalce,endplace FROM t_kmltrip group by startpalce,endplace order by startpalce,endplace";
			//String str="Select Distinct(startpalce) from t_kmltrip";
			ResultSet rs=stmt1.executeQuery(str);
			
			%>
			<b>Select Location</b><select name="startplace" id="startplace" class="formElement">
			<option value="Select">Select</option>
			<option value="All">ALL</option>
			<%while(rs.next())
			{ %>
			<option value="<%=rs.getString("startpalce")+"-"+rs.getString("endplace") %>"><%=rs.getString("startpalce")+"-"+rs.getString("endplace") %></option>
			<%} %>
			</select>
  	
  		
				
			</td></tr><tr bgcolor="lightgrey">
			<td ><b> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Select Date Range</b> 
			<input type="checkbox" name="chkdate" id="chkdate" onclick="visibledate()"></input></td><td><div id="divdate" style="display: none">
			<input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15" class="formElement" readonly/>
			  	<input type="button" name="From Date" value="From Date" id="trigger" class="formElement" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script> &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp; &nbsp;&nbsp;<input type="text" id="data1" name="data1"  value="<%=todate1 %>" class="formElement"  size="15" readonly/>
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
				 &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
			
			</div></td>	
				<td><input type="submit" name="btnsubmit" id="btnsubmit" value="submit" class="formElement" >
			</td>
			
		</tr>
		</table>
		<!-- if date range is not required please remove this code start from this comment to -->
	</td></tr>
	<%if(startplace!=null)
	{ 
		
		String start="",end="";
		if(startplace != null && (!startplace.equalsIgnoreCase("ALL")))
		{
			 start=startplace.substring(0,startplace.indexOf("-"));
			 end=startplace.substring(startplace.indexOf("-")+1,startplace.trim().length());
			System.out.println(start+" "+end);
		}
		String tripid="-",startloc="-",endloc="-",vehregno="-",transporter="-";
		java.util.Date dt1 = null;
		String km="-",ttime="-",startcode1="-",startcode2="-",endcode1="-",endcode2="-",gpname="-";
		
		String showdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate)); 
		String showtodt=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
		String msg="";
		if(chk==null && startplace.equalsIgnoreCase("ALL"))
		{
			sql1="select * from t_kmltrip";
			msg="Location : ALL";
		}
		else if(chk==null && !(startplace.equalsIgnoreCase("ALL")))
		{
			sql1="select * from t_kmltrip where startpalce='"+start+"' and endplace='"+end+"'";
			msg="StartPlace : "+ start + " & EndPlace : "+ end;
		}
		else if(chk!=null && startplace.equalsIgnoreCase("ALL"))
		{
			sql1="select * from t_kmltrip where Datetime between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59'";
			msg=fromdate+" to "+todate+" Location : ALL";
		}
		else 
		{
		sql1="select * from t_kmltrip where Datetime between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' and startpalce='"+start+"' and endplace='"+end+"'";
		msg=fromdate+" to "+todate+" StartPlace : "+ start + " & EndPlace : "+ end;
		}
	%>
	<tr><td colspan="8">
		<table  border="0" width="100%">
		
		<tr><td colspan="5" align="center" bgcolor="">
			<font size="3" color="maroon"><b>KML Report  <%=msg %></b></font>
 			<div align="right">
    	     	<!-- 	<a href="Excel_OpenTrip_report.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a> -->&nbsp;&nbsp;&nbsp;
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
		<td  align="center" class="sorttable_nosort"><b><input type="checkbox" name="main" value="main" onClick="CheckUncheckAll();" > </b></td>
			<td class="hed" align="center" ><b>Sr.No.</b></td>
			<td class="hed" align="center" > <b>TripID</b></td>
	
		
			<td class="hed" align="center" > <b> StartPlace</b></td>
			<td class="hed" align="center"> <b> EndPlace</b></td>
			<td class="hed" align="center"> <b>Distance</b></td>
			
			<td class="hed" align="center"><b>DateTime</b></td>
			<td class="hed" align="center"><b>Entered By</b></td>
			<td class="hed" align="center"><b>KML File Name</b></td>
			<td class="hed" align="center" > <b>Status</b> </td>
			
		</tr>
		<%
				int i=1;
				
				
				System.out.println(sql1);
				rs2=stmt1.executeQuery(sql1);
				
				
		
				while(rs2.next())
				{
					//System.out.println("-----Entered in while rs1 loop-----");
						 
							%>
							<tr><input type="hidden" name="trip<%=i%>" id="trip<%=i%>" value="<%=rs2.getString("tripid")%>" ></input>
							<td><input type="checkbox" name="chk<%=i %>" id="chk<%=i%>"></input></td>
							<td><%=i %></td>
								<td><%=rs2.getString("tripid")%></td>
								<td><%=rs2.getString("startpalce")%></td>
								<td><%=rs2.getString("endplace")%></td>
								<td><%=rs2.getDouble("Distance")%></td>
								<%
								String date=rs2.getString("Datetime");
								if(date!=null)
									{%>
								<td><%=new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss a").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date))%></td>
								<%}
								else
								{%>
								<td>-</td>
								<%} %>
								<td ><%=rs2.getString("EntBy")%></td>
									<td ><%=rs2.getString("kmlfilename")%></td>
								<%
								int status=rs2.getInt("status");
								
								if(status==0)
								{
									%>
								<td>Deactive</td>
								<%}
								else
								{
								%>
								<td>Active</td>
								<%} %>	
							
							
								<input type="hidden" name="status<%=i %>" id="status<%=i%>" value="<%=rs2.getInt("status")%>" ></input>
							
								
									
							</tr>
						  <%
						i++;
					}
					%>
					<input type="hidden" name="btnchk" id="btnchk" value=""></input>
					
										<input type="hidden" name="cntr" id="cntr" value="<%=i %>" />
					</table>
						<table  border="0" width="100%" align="center" >
			<tr><td><input type="button" value="Active" name="btn" id="btn" onclick="active()"></input><input type="button" name="btn" id="btn" value="Deactive" onclick="deactive()"></input></td></tr>
				</table>
				<%} %>
<%}// end of try loop
catch(Exception e)
{
	//System.out.println("Exception----->"+e); 
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>	
	
	
	
	</form>
<%@ include file="footerhtml.jsp"%>