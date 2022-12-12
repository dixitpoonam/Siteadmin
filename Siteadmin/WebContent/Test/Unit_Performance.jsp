<%@ include file="headerhtml.jsp" %>
<html>
<%@page import="java.util.Date"%><script type="text/javascript">
function addgroup(){
	
	 //get start date 
	//	alert("1");
	var checklist=document.getElementById("unitid").value;
	var buttonval=document.getElementById("add").value;
	checklist=checklist.replace(/^\s+|\s+$/g,"");//trim
	if(checklist.lenght==0 || checklist=="")
	{
	alert("Please enter a value to "+ buttonval);
	return false;	
	}
	
	if(buttonval=="Update")
	{
		var newlist=document.getElementById("unitid").value;
		var i=document.getElementById("testunits").selectedIndex;	
		var oldlist=document.getElementById("testunits").options[i].text;
		var queryString="action=edit&newlist="+newlist+"&oldlist="+oldlist;
	}
	else
	{
	var newlist=document.getElementById("unitid").value;
	var queryString="action=insert&newlist="+newlist;
	}
	//alert("2 ="+newlist);	
	 try{
			// Opera 8.0+, Firefox, Safari
		            ajaxRequest = new XMLHttpRequest();
		    }  
		    catch (e)
		        {
		            // Internet Explorer Browsers
		            try
		                {
		                   ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		                } 
		            catch (e)
		                {
		                   try
		                    {
		                       ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
		                    } 
		                    catch (e)
		                    {
		                      // Something went wrong
		                      alert("Your browser broke!");
		                      return false;
		                    }
		                }
		            }
						
		         // Create a function that will receive data sent from the server
		        
		       	   ajaxRequest.onreadystatechange = function()
                   { 
   	 	   if(ajaxRequest.readyState ==4)
                      {
                         	
                       	
							var reslt=ajaxRequest.responseText;
							
                         	var mySplitResult = reslt.split("#");
                         	var val=mySplitResult[0];
                         	 val =val.replace(/^\s+|\s+$/g,"");//trim
                          alert(val);
                          document.getElementById("unitlist").innerHTML=mySplitResult[1];
                        document.getElementById("unitid").value="";
                  		document.getElementById("unitid").style.display="none";
                  		document.getElementById("unitid").disabled=false;
                		document.getElementById("testunits").style.display="block";
                		document.getElementById("edit").style.display="block";
                	//	document.getElementById("cancel").style.display="none";
                		document.getElementById("flag").value="test";
                		document.unitform.Search[0].checked="false";
                		document.unitform.Search[1].checked="false";
                		document.unitform.Search[2].checked="true";
                		document.getElementById("edit").value="Edit";
                		document.getElementById("add").value="Add New Group";
                		//document.unitform.submit(); 
                     } 
       	   		}
		       
		               
		            	//alert("hi"+queryString);
		            //alert("updateunitgroup.jsp?"+queryString);
		             
		                ajaxRequest.open("GET", "updateunitgroup.jsp?"+queryString, true);
		                ajaxRequest.send(null);  
	 }

function editvalues(id)
{
	action=id.value;	
	if(action=="Edit")
	{
		var i=document.getElementById("testunits").selectedIndex;	
		var check=document.getElementById("testunits").options[i].text;
		if(check=="Select")
		{
			alert("Please select a group name to edit");
			return false; 
		}
		
	document.getElementById("add").value="Update";
	document.getElementById("edit").value="Cancel";
	document.getElementById("testunits").style.display="none";
	document.getElementById("unitid").value=document.getElementById("testunits").value;
	document.getElementById("unitid").style.display="block";
	}
	else//add
	{
		document.getElementById("add").value="Add New Group";
		document.getElementById("unitid").value="";
		document.getElementById("unitid").style.display="none";
		document.getElementById("testunits").style.display="block";
		document.getElementById("edit").value="Edit";
		//document.getElementById("cancel").style.display="none";
	}	
}
function SearchCrit(ind)
{ 
	if(ind=="1")//all
	{
		document.getElementById("edit").value="Edit";
		document.getElementById("unitid").value="";
		document.getElementById("unitid").style.display="block";
		document.getElementById("testunits").style.display="none";
		document.getElementById("add").value="Add New Group";
		document.getElementById("edit").style.display="none";
		//document.getElementById("cancel").style.display="none";
		document.getElementById("unitid").disabled=true;
		document.getElementById("add").disabled=true;
		document.getElementById("flag").value="all";
	}
	else if (ind=="2")//testunits
	{
		document.getElementById("edit").value="Edit";
		document.getElementById("unitid").value="";
		document.getElementById("unitid").disabled=false;
		document.getElementById("add").disabled=false;
		document.getElementById("unitid").style.display="none";
		document.getElementById("testunits").style.display="block";
		document.getElementById("add").value="Add New Group";
		document.getElementById("edit").style.display="block";
		//document.getElementById("cancel").style.display="none";
		document.getElementById("flag").value="test";
	}
	else//unitid search
	{
		document.getElementById("add").disabled=false;
		document.getElementById("edit").value="Edit";
		document.getElementById("unitid").value="";
		document.getElementById("unitid").style.display="block";
		document.getElementById("testunits").style.display="none";
		document.getElementById("add").value="Add New Group";
		document.getElementById("edit").style.display="none";
		//document.getElementById("cancel").style.display="none";
		document.getElementById("unitid").disabled=false;
		document.getElementById("flag").value="unit";
 	}
}
</script>
<body>

<%
Connection conn,conn2;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn2 = DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null,st2=null,st3=null;
String sql=null, unitid=null, vehcode=null,flag=null,search=null,message=null,todate=null,fromdate=null,unitgroup=null,unitgroupname=null;
NumberFormat nf= NumberFormat.getNumberInstance();
int limit=0;
try{
	
	nf.setMaximumFractionDigits(2);
    nf.setMinimumFractionDigits(2);
	st1=conn.createStatement();
	st3=conn2.createStatement();
	if(null==request.getQueryString())
	{
	todate=fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	}
	else
	{
		try{
			todate=request.getParameter("todate");
			todate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate));
			System.out.println(" in main todate"+todate);
		}catch(Exception e){}
		try{
			fromdate=request.getParameter("fromdate");
			fromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate));
			System.out.println("in main fromdate"+fromdate);
		}catch(Exception e){}
		
	}
	%>
	<form name="unitform" action="" method="get">
	<table border="0" width="100%" align="center" class="sortable">
	
	<tr><td colspan="10" align="center" class="sorttable_nosort"><b>Please select the search option to see the Unit Performance Data.</b> 
	<div align="right" ><a href="runUnitPerformance.jsp"><input type="button" value="RUN UNIT PERFORMANCE"  /></a>
	<a href="ListUnitPerformance.jsp"><input type="button" value="Check Status" /></a></div>
	</td></tr>
	
	<tr>
	<td bgcolor="#F5F5F5">
	<input type="button" name="The Date" value="From Date" id="trigger">
	</td><td bgcolor="#F5F5F5">
	<input type="text" id="fromdate" name="fromdate" value="<%=fromdate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "fromdate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5">
	<input type="button" name="The Date" value="To Date" id="trigger1">
	</td><td bgcolor="#F5F5F5">
	<input type="text" id="todate" name="todate" value="<%=todate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "todate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5"><label>
	<input type="radio" name="Search" onclick="SearchCrit(0);"/>Unit id</label>
	
	</td><td bgcolor="#F5F5F5"><label>
  	<input type="radio"  name="Search" onclick="SearchCrit(1);" checked/> ALL </label>
	<input type="hidden" name="flag" id="flag" value="all">
	</td>
	<td bgcolor="#F5F5F5"><label>
	<input type="radio"  name="Search" onclick="SearchCrit(2);"/>Test Units</label>
	
	</td>
	<td bgcolor="#F5F5F5">
	<table border="0" style="border: none"><tr style="border: none">
	<td style="border: none"><input type="text" name="unitid" id="unitid" class="stats" disabled="disabled" style="display:block"></input> 
		<div id="unitlist">
		<select id="testunits" name="testunits" style="display: none">
		<option value="Select">Select</option>
		<%
		String unitsql="Select * from t_testunits";
		ResultSet unitrst=st1.executeQuery(unitsql);
		while(unitrst.next())
		{
		%>
			<option value="<%=unitrst.getString("unitlist") %>"><%=unitrst.getString("unitlist") %></option>
		<%} %>
		
		</select>
		</div>
		</td>
	<td style="border: none"><input type="button" id="edit" name="edit" value="Edit" onclick="editvalues(this);" style="display: none" ></input></td>
	</tr>
	</table>
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="primary" value="submit" class="stats">
	</td>
	<td style="border: none"><input type="button" id="add" name="add" value="Add New Group" onclick="addgroup();" disabled="disabled"></input></td>
	</tr>
	
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		flag=request.getParameter("flag");
		try{
			todate=request.getParameter("todate");
			todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate));
			System.out.println("todate"+todate);
		}catch(Exception e){}
		try{
			fromdate=request.getParameter("fromdate");
			fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate));
			System.out.println("fromdate"+fromdate);
		}catch(Exception e){}
		
		
		if(flag.equalsIgnoreCase("unit"))
		{
			
		 unitid=request.getParameter("unitid");
		 message="Performance of Unit id "+unitid;
		 sql="select * from t_unitperformance where UnitID in ("+unitid+") and thedate between '"+fromdate+"' and '"+todate+"'  order by unitid,thedate ";
		 System.out.println("sql"+sql);
		}
		else if (flag.equalsIgnoreCase("test"))
		{
				unitid=request.getParameter("testunits");
				unitgroup=request.getParameter("unitid");
				unitgroupname=request.getParameter("grpname");
				if(unitgroup!=null && unitgroup.trim().length()!=0)
				{
					unitid=unitgroup;
					
					
				}
			 message="Performance of Unit id's "+unitid;
			 sql="select * from t_unitperformance where UnitID in ("+unitid+") and thedate between '"+fromdate+"' and '"+todate+"'  order by unitid,thedate ";
			 System.out.println("sql"+sql);
		}
		else
		{
			message="All Unit Data ";
			sql="select * from t_unitperformance where thedate between '"+fromdate+"' and '"+todate+"' order by unitid,thedate";
			System.out.println("sql"+sql);
		}
				
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8"></br>
		<th colspan="27" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b><%=message %> </b></font>
		<div align="left"><a href="excelunitperformance.jsp?sql=<%=sql %>&message=<%=message %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		<tr>
		<td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Date</td>
		<td class="hed" align="center">Customer</td>
		<td class="hed" align="center">Vehregno</td>
		<td class="hed" align="center">VehId</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Unit Type</td>
		<td class="hed" align="center">Stamp Interval </td>
		<td class="hed" align="center">Trans Interval</td>
		<td class="hed" align="center">Codeversion</td>
		<td class="hed" align="center">APN</td>
		<td class="hed" align="center">SI Count</td>
		<td class="hed" align="center">Trans Count</td>
		<td class="hed" align="center">ON Count</td>
		<td class="hed" align="center">ER Count</td>
		<td class="hed" align="center">RA Count</td>             
		<td class="hed" align="center">RD Count</td>
		<td class="hed" align="center">OS Count</td>
		<td class="hed" align="center">OS1 Count</td>
		<td class="hed" align="center">OS2 Count</td>
		<td class="hed" align="center">FTP Count</td>
		<td class="hed" align="center">AVG_Delay</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Last date</td>
		<td class="hed" align="center">Last time</td>
		<td class="hed" align="center">Last Location</td>
		<td class="hed" align="center">Corr Dist</td>
		<td class="hed" align="center">Corr Factor</td>
		<td class="hed" align="center">Trans %</td>
		<td class="hed" align="center">Stamp %</td>
		<td class="hed" align="center">FTP File Count</td>
		</tr>
		<%
		
		ResultSet rst=st3.executeQuery(sql);
		int i=1;
		while(rst.next())
		{																																																																																																																																																																																																																																								
																																																																																																																																																																																																																																						
			
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<%try{%>
			<td class="bodyText" align="center"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheDate"))  %></td>
			<% }catch(Exception e){ out.print("-");} %>
			<% try{
			String cust=rst.getString("customer");
			if(cust==null || cust.trim().length()<=0)
				cust="-";
			%>
			<td class="bodyText" align="center"><%=cust %></td>
			<% }catch(Exception e){out.print("-");} %>
			<% try{
				String vehregno=rst.getString("vehregno");
				if(vehregno==null || vehregno.trim().length()<=0)
					vehregno="-";
			%>
			<td class="bodyText" align="left"><%=vehregno %></td>
			<% }catch(Exception e){out.print("-");} %>
			
			<td  align="right"><%=rst.getString("vehid") %></td>
			<td  align="left"><%=rst.getString("unitid") %></td>
			<td  align="left"><%=rst.getString("unittype") %></td>
			<td  align="left"><%=rst.getString("stamp_interval") %></td>
			<td  align="center"><%=rst.getString("transmission_interval") %></td>
			<td  align="center"><%=rst.getString("codeversion") %></td>
			<td  align="center"><%=rst.getString("apn") %></td>
			<td  align="center"><%=rst.getString("SI_count") %></td>
			<td  align="center"><%=rst.getString("trans_count") %></td>
			<td  align="center"><%=rst.getString("on_count") %></td>
			<td  align="center"><%=rst.getString("er_count") %></td>
			<td  align="center"><%=rst.getString("ra_count") %></td>
			<td  align="center"><%=rst.getString("rd_count") %></td>
			<td  align="center"><%=rst.getString("os_count") %></td>
			<td  align="center"><%=rst.getString("os1_count") %></td>
			<td  align="center"><%=rst.getString("os2_count") %></td>
			<td  align="center"><%=rst.getString("ftp_count") %></td>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("avg_delay")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			
			<td  align="center"><%=rst.getString("distance") %></td>
			<td  align="center"><%=rst.getString("last_date") %></td>
			<td align="center"><%=rst.getString("last_time") %></td>
			<td  align="center"><%=rst.getString("last_location") %></td>
			<td  align="center"><%=rst.getString("corr_dist") %></td>
			<td  align="center"><%=rst.getString("corr_factor") %></td>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("trans_perc")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			<%try{%>
			<td  align="center"><%=nf.format(rst.getDouble("st_perc")) %></td>
			<%}catch(Exception ex){out.print("0");} %>
			<td align="center"><%=rst.getString("ftp_file_count") %></td>
			</tr>    	  
		<%
		i++;
		}
		%>
	
		  </table>
		  </td></tr></table>
		  
		<%
	}%>
	</td>
	</tr>
	</table>
	
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();
	conn2.close();
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>
</form>
</body>
</html>
