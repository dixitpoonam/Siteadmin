<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Department Report</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script src="js/sorttable.js" type="text/javascript"></script>
<!--<script type="text/javascript" src="js/jquery-latest.js"></script> 
<script type="text/javascript" src="js/jquery.tablesorter.js"></script> 
<link href="css/cpanel_002.css" rel="stylesheet" type="text/css" />
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
	<script type="text/javascript" src="js/ajax-dynamic-content.js"></script>
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/ajax-tooltip.js"></script>	
	<script src="js/sorttable.js" type="text/javascript"></script>

-->


    <style>
th
{
background: #C6DEFF;
}
</style>
<script type="text/javascript">
function gotoExcel (elemId, frmFldId)  
{  
//alert("*********** ");

         var obj = document.getElementById(elemId);  

         var oFld = document.getElementById(frmFldId); 

          oFld.value = obj.innerHTML;  

          document.employeeReport.action ="excel.jsp";     // CHANGE FORM NAME HERE

          document.forms["employeeReport"].submit();       // CHANGE FORM NAME HERE

} 
function DeleteRow(id,Status)
{
	    
	//alert("Control inside deldte function");
	if(Status=="No")
	{
		alert("Employee Already Deactivated");
		return false;
	}
	else
	{
	
	var agree=confirm("Do You Want to Delete this Record?");
	    //alert(agree);
	    if(agree)
	    {
		 var ajaxRequest;  // The variable that makes Ajax possible!
		    try
		    {	// Opera 8.0+, Firefox, Safari
				ajaxRequest = new XMLHttpRequest();
		    }  
			catch (e)
			{	// Internet Explorer Browsers
				try
				{	ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
				} 
				catch (e)
				{	try
					{
						ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
					} 
					catch (e)
					{	// Something went wrong
						alert("Your browser broke!");
						return false;
					}
				}
			}
			// Create a function that will receive data sent from the server
			ajaxRequest.onreadystatechange = function()
			{	//alert("ddddddddddddddddddddddd");
				if(ajaxRequest.readyState == 4)
				{	var reslt=ajaxRequest.responseText;
				   //alert(">>>    "+reslt);
				  var data=reslt.trim();
				  
				 // alert("<***data**  "+data);
				  //var mySplitResult = reslt.split("#");
                  //var mySplitResult1=  mySplitResult[0]; 
                  //var mySplitResult2=  mySplitResult[1]
				  
				  
                 // alert("<***mySplitResult1**  "+mySplitResult);
				 //alert("<***mySplitResult1**  "+mySplitResult1);
                //alert("<***mySplitResult2**  "+mySplitResult2);
					if(data="Yes")
					{					
                        alert("Data Deleted Successfully.");
				    	window.location.reload();
					}
					if(data="No")
					{					
                       // alert("Data Not Deleted Successfully.");
				    	window.location.reload();
					}
	           } 
			}
			var queryString = "?action=delete&id="+id;
			ajaxRequest.open("GET", "AjaxContractDelete1.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
	}//end of else
 }//


 function EditEmp(id,status)
 {
	// alert("st"+status);
	 if(status=="Yes")
	 {
 	    
 	//alert("Control inside deldte function");
 	
 	var agree=confirm("Do You Want to Edit this Record?");
 	    //alert(agree);
 	    
 	    if(agree)
 	    {


 	    	window.location.href="editEmp.jsp?EmpID="+id+"&status="+status;
 		}
 	    else
 	    {return false;
 	    }

	 }
	 else
	 {
		 
		 alert(" Selected Employee is deactivated!!! ");
		 var conf=confirm("Still you want to edit this employee..");
		 if(conf)
		 {
			 window.location.href="editEmp.jsp?EmpID="+id+"&status="+status; 
		 }
		 else
	 	    {return false;
	 	    }
		 //editEmp.jsp?EmpID=&status=
	 }
  }
 	
</script>
</head>
<body>

<table width="100%">
<tr>
<td align="center" colspan="2">
<a align="center" style="font-size:1.6em">New Joinee Reports</a></td>
</tr>
<tr><td><a href="addEmployee.jsp"><b>Add</b></a> &nbsp
<a href=""><b>Delete</b></a></td>
<td align="right"><a href="#" title="Export to Excel"  onclick="gotoExcel('dept','tableHTML');"><img src="images/excel.jpg" width="18px" height="18px"></a><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></td>
</tr>
</table>
<div align="center">
<form action="" method="post" name="employeeReport">
<%
String exportFileName="Contractor_report.xls";   // GIVE YOUR REPORT NAME
%>
<div id='dept' align="center" style="height: 400px;overflow:scroll;">

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<table align="center" class="sortable" border="3" style=" color: black;border-collapse:collapse;" >
<thead>
<tr>


<th>Delete</th>
<th><b>Edit</b></th>
<th><b>Contractor ID</b></th>
<th><b>Name</b></th>
<th><b>User Name</b></th>
<th><b>Email</b></th>
<th><b>Type of user</b></th>
<th><b>Type of<br> Department</b></th>
<th><b>Status</b></th>
<th><b>Entered By </b></th>
<th width="5%"><b>Date</b></th>
<th><b>Week Off</b></th>
<th><b>Report Time</b></th>
<th><b>Exit Time</b></th>
</tr>
</thead>
<%

 Statement st=conn.createStatement();
 Statement st1=conn.createStatement();
 String date="";
 //String sql = "select * from  t_leaveadmin  where Status='Yes' ORDER BY `EmpID` ASC ";
 String sql = "select * from  t_leaveadmin  ORDER BY `EmpID` ASC ";
 ResultSet rs = st.executeQuery(sql);
 String name="";
 
 while(rs.next())
 {  int weekOff=rs.getInt("weekOff");
	 String weekOff1="";
    switch(weekOff)
    {
    case 0:weekOff1="Sunday";
           	break;
    case 1:weekOff1="Monday";
    		break;
    case 2:weekOff1="Tuesday";
    		break;
    case 3:weekOff1="Wednesday";
    		break;
    case 4:weekOff1="Thursday";
    		break;
    case 5:weekOff1="Friday";
    		break;
    case 6:weekOff1="Saturday";
    		break;
    }
 try
   { 
	 date = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(rs.getString("inserteddatetime")));
   }
 catch(Exception e){}
 String color="";
 if (rs.getString("Status").equalsIgnoreCase("No")) {
		color = "#FF8080";

	} else 
	{

		color = "#CCFF99";
	}
System.out.println("colorrrrrrr"+color);
 %>
 <tr style="background: <%=color%>;">
 
 <td style="width: 1%"><a href="#" style="font-weight: bold; color: black; " onclick="DeleteRow('<%=rs.getString("EmpID")%>','<%=rs.getString("Status")%>');"><img src="images/delete.jpeg" width="20px" height="18px" style="border-style: none" ></img></a></td>
 <td width="1%" align="right"><a href="#"  onclick="EditEmp('<%=rs.getString("EmpID")%>','<%=rs.getString("Status") %>');"><img src="images/edit1.jpeg" width ="18px" height="18px"></a></td>
  <td width="2%" align="right"><div align="right"><%=rs.getString("EmpID")%></div></td>
 <td width="2%" align="left"><div align="left"><%=rs.getString("Name")%></div></td>
 <td width="1%" align="left"><div align="left" ><%=rs.getString("UName")%></div></td>
 <td width="2%" align="left"><div align="left"><%=rs.getString("Email")%></div></td>
 <td width="2%" align="left"><div align="left"><%=rs.getString("URole")%></div></td>
 <td width="2%" align="left"><div align="left"><%=rs.getString("TypeValue")%></div></td>
 <td width="2%" align="left"><div align="left"><%=rs.getString("Status")%></div></td>
 <td width="2%" align="right"><div align="right"><%=rs.getString("ERPUser")%></div></td>
 <td width="2%" align="right"><div align="right" sort><%=date%></div></td>
 <td width="2%" align="right"><div align="right"><%=weekOff1%></div></td>
 <td width="2%" align="right"><div align="right"><%=rs.getString("ReportTime")%></div></td>
 <td width="2%" align="right"><div align="right"><%=rs.getString("exittime")%></div></td>
 
 
 </tr>
<% }conn.close();%>
</table></div></form></div>
<div id="footer"><p>
<a href="http://www.myfleetview.com">
Copyright &copy; 2009 by Transworld Compressor Technologies Ltd. All Rights Reserved.</a></p>
</div>
</body>
</html>