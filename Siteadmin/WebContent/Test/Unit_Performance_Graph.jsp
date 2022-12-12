<%@ include file="headerhtml.jsp" %>



<%@page import="java.io.File"%><html>
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
                		document.getElementById("flag").value="test";
                		document.unitform.Search[0].checked="false";
                		document.unitform.Search[1].checked="true";
                		document.getElementById("edit").value="Edit";
                		document.getElementById("add").value="Add New Group";
                		
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
	if (ind=="2")//testunits
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

<%!
Connection conn,conn2;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn2 = DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null,st2=null,st3=null;
String sql=null,sql1=null, unitid=null, vehcode=null,flag=null,search=null,message=null,unitgroup=null,unitgroupname=null,beforetodate=null,beforefromdate=null,aftertodate=null,afterfromdate=null;
NumberFormat nf= NumberFormat.getNumberInstance();
String folderName=null;
int limit=0;
try{
	
	try{
		
				folderName=session.getId();
		}catch(Exception ex)
		{
				response.sendRedirect("../index.jsp?err=err2");
				return;
		}
	String today=new SimpleDateFormat("yyyy_MM_dd").format(new Date());
	nf.setMaximumFractionDigits(2);
    nf.setMinimumFractionDigits(2);
	st1=conn.createStatement();
	st2=conn2.createStatement();
	st3=conn2.createStatement();
	
	if(null==request.getQueryString())
	{
		beforefromdate=beforetodate=aftertodate=afterfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	}
	else
	{
		try{
				beforetodate=request.getParameter("beforetodate");
				beforetodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(beforetodate));
			
		}catch(Exception e){}
		try{
			beforefromdate=request.getParameter("beforefromdate");
			beforefromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(beforefromdate));
		
		}catch(Exception e){}
		
		try{
			aftertodate=request.getParameter("aftertodate");
			aftertodate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(aftertodate));
		
		}catch(Exception e){}
		try{
			afterfromdate=request.getParameter("afterfromdate");
			afterfromdate=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(afterfromdate));
			
		}catch(Exception e){}
		
	}
	%>
	<form name="unitform" action="" method="get">
	<table border="0" width="100%" align="center" class="sortable">
	
	<tr><td colspan="6" align="center" class="sorttable_nosort" style="border: none;"><b>Please select the search option to see the Unit Performance Data.</b> </td></tr>
	<!--Before date	-->
	<tr><td colspan="6" >
	<table>
	<tr><td  style="border: none;background: gray; " ><font size="2" color="white">Before</font></td><td  style="border: none;background: gray;"><font size="2" color="white">After</font></td></tr>
	<tr>
	<td style="border: none;">
	<table><tr><td bgcolor="#F5F5F5" style="border: none;">
	<input type="button" name="The Date" value="From Date" id="beforetrigger">
	</td><td bgcolor="#F5F5F5" style="border: none;">
	<input type="text" id="beforefromdate" name="beforefromdate" value="<%=beforefromdate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "beforefromdate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "beforetrigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5" style="border: none;">
	<input type="button" name="The Date" value="To Date" id="beforetrigger1">
	</td><td bgcolor="#F5F5F5" style="border: none;">
	<input type="text" id="beforetodate" name="beforetodate" value="<%=beforetodate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "beforetodate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "beforetrigger1"       // ID of the button
    }
  );
</script>
	</td></tr></table>
	</td>
	<!-- 	End After date 	-->
	<!--	Start date	-->
	<td style="border: none;">
	<table><tr><td bgcolor="#F5F5F5" style="border: none;">
	<input type="button" name="The Date" value="From Date" id="aftertrigger">
	</td><td bgcolor="#F5F5F5" style="border: none;">
	<input type="text" id="afterfromdate" name="afterfromdate" value="<%=afterfromdate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "afterfromdate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "aftertrigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5" style="border: none;">
	<input type="button" name="The Date" value="To Date" id="aftertrigger1">
	</td><td bgcolor="#F5F5F5" style="border: none;">
	<input type="text" id="aftertodate" name="aftertodate" value="<%=aftertodate %>"  size="12" readonly/>
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "aftertodate",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "aftertrigger1"       // ID of the button
    }
  );
</script>
	</td></tr></table>
	<!-- End After Date	-->
	</td>
	</tr>
	</table>
	
	</td>
	</tr><!--
	
	####################################### all search criteria ####################################3
	
	
	--><tr>
	<td bgcolor="#F5F5F5">
	<table><tr>
	<td bgcolor="#F5F5F5" style="border: none;"><label><input type="radio" name="Search" onclick="SearchCrit(0);" checked/>Unit id</label></td>
	<!--
	<td bgcolor="#F5F5F5" style="border: none;">
	<label><input type="radio"  name="Search" onclick="SearchCrit(1);" /> ALL </label>
	</td>
	
	-->
	<td bgcolor="#F5F5F5" style="border: none;"><label>	<input type="radio"  name="Search" onclick="SearchCrit(2);" />Test Units</label></td>
	
	
	<td bgcolor="#F5F5F5" style="border: none;">
	<input type="hidden" name="flag" id="flag" value="unit">
	<table border="0" style="border: none"><tr style="border: none">
	<td style="border: none"><input type="text" name="unitid" id="unitid" class="stats"  style="display:block"></input> 
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
	
	<td bgcolor="#F5F5F5" style="border: none;">
	<input type="submit" name="primary" value="submit" class="stats">
	</td>
	<td style="border: none"><input type="button" id="add" name="add" value="Add New Group" onclick="addgroup();" ></input></td>
	</tr></table>
	</td>
	</tr>
	<tr>
	<td colspan="6" >
	<%
	if(!(null==request.getQueryString()))
	{
		flag=request.getParameter("flag");
		
		try{
			
				beforetodate=request.getParameter("beforetodate");
				beforetodate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(beforetodate));
			
		}catch(Exception e){}
		try{
				beforefromdate=request.getParameter("beforefromdate");
				beforefromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(beforefromdate));
			
		}catch(Exception e){}
		
		try{
				aftertodate=request.getParameter("aftertodate");
				aftertodate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(aftertodate));
			
		}catch(Exception e){}
		try{
				afterfromdate=request.getParameter("afterfromdate");
				afterfromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(afterfromdate));
			
		}catch(Exception e){}
		
		if(flag.equalsIgnoreCase("unit"))
		{
			 unitid=request.getParameter("unitid");
		}
		else{
			
			unitid=request.getParameter("testunits");
			unitgroup=request.getParameter("unitid");
			unitgroupname=request.getParameter("grpname");
			if(unitgroup!=null && unitgroup.trim().length()!=0)
			{
				unitid=unitgroup;
			}
			
		}
		
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<!-- -->
		<th colspan="9" class="hed" bgcolor="#2696B8" align="center">
				<font color="white" size="1"><b>Units Averages Report</b></font>
				<div align="left"><a href="excelunitperformance_graph.jsp?beforetodate=<%=beforetodate%>&beforefromdate=<%=beforefromdate%>&afterfromdate=<%=afterfromdate %>&aftertodate=<%=aftertodate %>&flag=<%=flag %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> 
		</th>
		</tr>
		<tr>
		<td colspan="9">
			<table  border="0" width="100%" class="sortable">
					<tr>						
					<th  align="center">Sr.</th>
					<th  align="center">Unit ID</th>
					<th  align="center" >SI Count</th>
					<th  align="center" >SI Count 1</th>
					<th  align="center" >Tx count</th>
					<th  align="center" >Tx count 1</th>
					<th  align="center">AVG delay</th>
					<th  align="center">AVG delay 1</th>
					<th  align="center" >Dist fact </th>
					<th  align="center" >Dist fact 1</th>
					<th  align="center">ON count</th>
					<th  align="center">ON count 1</th>
					<th  align="center" >ER count</th>
					<th  align="center" >ER count 1</th>
					</tr>
		<%
		
			int i=0;
			double totaftersiCount=0,totaftertxCount=0.0,totafteravgDelay=0.0,totafterdistFact=0.0,totafteronCount=0,totaftererCount=0.0;
			double totbeforesiCount=0,totbeforetxCount=0.0,totbeforeavgDelay=0.0,totbeforedistFact=0.0,totbeforeonCount=0,totbeforeerCount=0.0;
			double avgaftersiCount=0,avgaftertxCount=0.0,avgafteravgDelay=0.0,avgafterdistFact=0.0,avgafteronCount=0,avgaftererCount=0.0;
			double avgbeforesiCount=0,avgbeforetxCount=0.0,avgbeforeavgDelay=0.0,avgbeforedistFact=0.0,avgbeforeonCount=0,avgbeforeerCount=0.0;
			 
			String Sql2="select distinct(unitid) from t_unitperformance where UnitID in ("+unitid+") ";
			System.out.println("Sql2----->" +Sql2);
	
			 ResultSet unitRst=st2.executeQuery(Sql2);
			 while(unitRst.next())
			 {
				 
				i++;
				double beforesiCount=0,beforetxCount=0.0,beforeavgDelay=0.0,beforedistFact=0.0,beforeonCount=0,beforeerCount=0.0;
				
				double aftersiCount=0,aftertxCount=0.0,afteravgDelay=0.0,afterdistFact=0.0,afteronCount=0,aftererCount=0.0;
				
				String searchUnit=unitRst.getString(1);
				 
				 sql="select sum(SI_count)/count(*),sum(trans_count)/count(*),sum(on_count)/count(*),sum(er_count)/count(*),sum(corr_factor)/count(*),sum(avg_delay)/count(*) from t_unitperformance where UnitID = "+searchUnit+" and thedate between '"+beforefromdate+"' and '"+beforetodate+"'  order by unitid,thedate ";
				 
				 System.out.println("sql---->"+ sql);
				 
				 sql1="select sum(SI_count)/count(*),sum(trans_count)/count(*),sum(on_count)/count(*),sum(er_count)/count(*),sum(corr_factor)/count(*),sum(avg_delay)/count(*) from t_unitperformance where UnitID="+searchUnit+" and thedate between '"+afterfromdate+"' and '"+aftertodate+"'  order by unitid,thedate ";
				 
				 System.out.println("sql1---->" + sql1);
				 session.setAttribute("sql",sql);
				 session.setAttribute("sql1",sql1);
				 session.setAttribute("unitid",unitid);
				
				 ResultSet beforeRst=st3.executeQuery(sql);
					if(beforeRst.next())
					{
						
						beforesiCount=beforeRst.getDouble(1);
						beforetxCount=beforeRst.getDouble(2);
						beforeonCount=beforeRst.getDouble(3);
						beforeerCount=beforeRst.getDouble(4);
						beforedistFact=beforeRst.getDouble(5);
						beforeavgDelay=beforeRst.getDouble(6);
						totbeforesiCount+=beforesiCount;
						totbeforetxCount+=beforetxCount;
						totbeforeonCount+=beforeonCount;
						totbeforeerCount+=beforeerCount;
						totbeforedistFact+=beforedistFact;
						totbeforeavgDelay+=beforeavgDelay;
					}
					
					ResultSet afterRst=st3.executeQuery(sql1);
					if(afterRst.next())
					{
						aftersiCount=afterRst.getDouble(1);
						aftertxCount=afterRst.getDouble(2);
						afteronCount=afterRst.getDouble(3);
						aftererCount=afterRst.getDouble(4);
						afterdistFact=afterRst.getDouble(5);
						afteravgDelay=afterRst.getDouble(6);
						totaftersiCount+=aftersiCount;
						totaftertxCount+=aftertxCount;
						totafteronCount+=afteronCount;
						totaftererCount+=aftererCount;
						totafterdistFact+=afterdistFact;
						totafteravgDelay+=afteravgDelay;
					}
					
					
					%>
				
					<tr>	
					<td><%=i +"."%></td>
		<td><%=searchUnit %></td>
		<%try{%>
		<td><%=nf.format(beforesiCount)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftersiCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforetxCount)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftertxCount)%></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeavgDelay)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afteravgDelay) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforedistFact) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afterdistFact) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeonCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afteronCount) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeerCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftererCount) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		</tr>

	<% 
		}
	%>	
			<table  border="0" width="100%" class="sortable">
			<tr><th  align="center" colspan="14">Total Avg</th></tr>
					<tr>	
					<th  align="center">SI Count</th>
					<th  align="center">SI Count 1</th>
					<th  align="center">Tx count</th>
					<th  align="center">Tx count 1</th>
					<th  align="center">AVG delay</th>
					<th  align="center">AVG delay 1</th>
					<th  align="center">Dist fact</th>
					<th  align="center">Dist fact 1</th>
					<th  align="center">ON count</th>
					<th  align="center">ON count 1</th>
					<th  align="center">ER count</th>
					<th  align="center">ER count 1</th>
					</tr>
					
					<%
					avgbeforeavgDelay=totbeforeavgDelay/i;
					avgbeforedistFact=totbeforedistFact/i;
					avgbeforeerCount=totbeforeerCount/i;
					avgbeforeonCount=totbeforeonCount/i;
					avgbeforesiCount=totbeforesiCount/i;
					avgbeforetxCount=totbeforetxCount/i;
					
					avgafteravgDelay=totafteravgDelay/i;
					avgafterdistFact=totafterdistFact/i;
					avgaftererCount=totaftererCount/i;
					avgafteronCount=totafteronCount/i;
					avgaftersiCount=totaftersiCount/i;
					avgaftertxCount=totaftertxCount/i;
					%>
					<tr>
					<%try{%>
					<td><%=nf.format(avgbeforesiCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgaftersiCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforetxCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgaftertxCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforeavgDelay)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafteravgDelay) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforedistFact) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafterdistFact) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforeonCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafteronCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					
					<%try{%>
					<td><%=nf.format(avgbeforeerCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgaftererCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					</tr>
			</table>
	</td>
	</tr>
	</table></td></tr></table>
	
	<%
	}
}catch(Exception e)
{
	System.out.print("Exceptions ----->"+e);
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