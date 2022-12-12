<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""
    pageEncoding="ISO-8859-1"%>
    <%@ include file="headerhtml.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>IMEI Report</title>
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
function DeleteRow(id)
{
	    
	//alert("DELETE ID==>"+id);
	

		
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
			ajaxRequest.open("GET", "IMEIDelete.jsp" + queryString, true);
			ajaxRequest.send(null); 
	    }
	    else
	    {return false;
	    }
	
 }//


 function EditEmp(id)
 {
	 //alert("UnitID==>"+id);
	 
 	//alert("Control inside deldte function");
 	
 	var agree=confirm("Do You Want to Edit this Record?");
 	    //alert(agree);
 	    
 	    if(agree)
 	    {


 	    	window.location.href="EditIMEI.jsp?UnitId="+id;
 		}
 	    else
 	    {return false;
 	    }

	 
	 
  }
 	
</script>
</head>
<body>


<%!
Connection c;
Statement st, st1,st2;
String sql, unitid,thedate,thedate1,thedate2,sqlProcessed;
int limit;
Connection conn,conn1;
%>

<table width="100%">
<tr>
<td align="center" colspan="2">
<a align="center" style="font-size:1.6em">IMEI Reports</a></td>
</tr>
<tr><td><a href="addIMEI.jsp"><b>Add</b></a> </td>
<td align="right"><a href="#" title="Export to Excel"  onclick="gotoExcel('dept','tableHTML');"><img src="images/excel.jpg" width="18px" height="18px"></a><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></td>
</tr>
</table>
<div align="center">
<form action="" method="post" name="employeeReport">
<%
String exportFileName="IMEIUnits_report.xls";   // GIVE YOUR REPORT NAME
%>
<div id='dept' align="center" style="height: 400px;overflow:scroll;">

<input type="hidden" id="tableHTML" name="tableHTML" value="" />   

	<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" /> 

<table align="center" class="sortable" border="3" style=" color: black;border-collapse:collapse;" >
<thead>
<tr>


<th>Delete</th>
<th><b>Edit</b></th>
<th><b>UnitID</b></th>
<th><b>IMEI NO</b></th>
<th><b>Entered Date</b></th>
<th><b>Entered By </b></th>
</tr>
</thead>
<%

System.out.println(">>>>>>>>@@@@@@@@@@:"); 


try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);


Statement st=conn.createStatement();
 Statement st1=conn.createStatement();
 String date="";
 //String sql = "select * from  t_leaveadmin  where Status='Yes' ORDER BY `EmpID` ASC ";
 String sql = "select * from  db_gps.t_imeidetails  where status='Active'   ";
 ResultSet rs = st.executeQuery(sql);
 System.out.println(">>>>>>>>@@sql@@@@@@@@:"+sql);
 String name="";
 
 while(rs.next())
 {  
 
	 
	 try
   { 
	 date = new SimpleDateFormat("dd-MMM-yyyy hh:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd hh:mm").parse(rs.getString("EnteredDate")));
   }
 catch(Exception e){
	 
	 date="-";
 }
 String color="";
 
 %>
 <tr style="background: <%=color%>;">
 
 <td style="width: 1%"><a href="#" style="font-weight: bold; color: black; " onclick="DeleteRow('<%=rs.getString("unitid")%>');"><img src="images/delete.jpeg" width="20px" height="18px" style="border-style: none" ></img></a></td>
 <td width="1%" align="right"><a href="#"  onclick="EditEmp('<%=rs.getString("unitid")%>');"><img src="images/edit1.jpeg" width ="18px" height="18px"></a></td>
  <td width="2%" align="right"><div align="right"><%=rs.getString("UnitId")%></div></td>
 <td width="2%" align="left"><div align="right"><%=rs.getString("imei")%></div></td>
  <td width="2%" align="right"><div align="right" sort><%=date%></div></td>
 <td width="1%" align="left"><div align="left" ><%=rs.getString("EnteredBy")%></div></td>
 
 
 </tr>
<% }
 
 
 
 conn.close();%>
 
 <%
	
}catch(Exception e)
{
	System.out.println("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();
	conn1.close();
	}catch(Exception ee)
	{
		System.out.println("Exception-->"+ee);
	}
}
%>
</table></div></form></div>


    <%@ include file="footerhtml.jsp" %>


</body>
</html>