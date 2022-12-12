<%@ page language="java"%>
  <%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript">

/////////////////////////////////////////////
function getHodDetails(transporter)
{
	//alert("**********************************   ");
	//alert(transporter);
	//alert("**********66666666666 ************   ");
	
	document.getElementById("transporterlist").style.visibility="hidden";
	document.getElementById("reportingto").value=transporter;
	
}

function getHod(num)
{
	try{
	//alert("Hii");
	var b=0;
	var hodName=document.getElementById("reportingto").value;
    if(hodName.length>0)
    {
	document.getElementById("transporterlist").style.visibility="visible";
	//alert(transporter);
	//var user=document.getElementById("usertypevalue").value;
	//var counter=document.leave.counter.value;
	/*if(counter>100)
	{
		counter=0;
	}*/
	if(num==1)
	{
		counter=20;
	}
	else if(num==2)
	{
		counter=0;
	}
	
	var ajaxRequest;  // The variable that makes Ajax possible!
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
	ajaxRequest.onreadystatechange = function()
	{
		if(ajaxRequest.readyState == 4)
		{
			var reslt=ajaxRequest.responseText;
			document.getElementById("transporterlist").innerHTML=reslt;
			var b=document.getElementById("element").value;
			//alert("b "+b);
			document.editempfrm.counter.value=b;
			//alert("counter "+document.editempfrm.counter.value);
			document.editempfrm.counter.value=b*document.editempfrm.counter.value;
			counter=document.editempfrm.counter.value;
			//alert("counter "+counter);
		} 
	};
	var queryString = "?hodName="+hodName+"&limitcount="+counter+"";
	ajaxRequest.open("GET", "AjaxGetHodName.jsp" + queryString, true);
	ajaxRequest.send(null); 
    }
    else
    {
    	document.getElementById("transporterlist").style.visibility="hidden";
    }
	}catch(e)
	{
		//alert(e);
	}
}

</script>
<title>Transworld Contractor Edition</title>

<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<script LANGUAGE="JavaScript" type="text/javascript">

function validate()
{
	//alert("Inside Validate**************");
		var imei=document.getElementById("imei").value;
		
		//alert("imei==>"+imei);
		//alert("imei=LENGHT=>"+imei.length);
		
		
		if(imei.length<15)
	{
		
		alert("Please Enter the valid IMEI No");
		return false;
	}
	else
	{
		// var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-]{1,3})+\.)+([a-zA-Z0-9]{2,4})+$/;
		 
		    return true;
				
	}

	
	
	

		


	/*
 
 if((!URole.checked) || (!URole1.checked))
	{
	 alert("Please select Type Of User");
	 return false;
 	}
 */
	
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
<%


//Date today = new Date();
//String date=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String EmpID="";
String qry=""; 
Statement st =conn.createStatement();

%>
<% 

String unitid=request.getParameter("UnitId");
System.out.println("unitid----->"+unitid);

try
{
	

//qry = "select * from t_leaveadmin where EmpID='"+EmpID+"'";
qry = "select * from db_gps.t_imeidetails where unitid='"+unitid+"' ";
// and status='Yes'";
System.out.println("EmpID================"+qry);
ResultSet rs = st.executeQuery(qry);
System.out.println("ROleeeeeeeeeeeeee-->"+qry);
while(rs.next())
{
  %>
  
<br><br>
<form name="editempfrm" action="IMEIInsert.jsp?action=editemp" method="post" >
<table bgcolor="#E0DDFE" border="0" height="250" width="600" align="center">

<tr>
	<td align="center">
	<b><font size="4" color="#151B54">Edit IMEI</font></b>
	</td>
</tr>

<tr bgcolor="white">	
	<td>
		<table border="0" align="center" height="100">
			
			<tr >
				<td >
					<label id="custype"><b>IMEI No<font  color="#990000">*</font> :</b></label>
				</td>
				<td>
					<input type="text" name="imei" id="imei"  value="<%=rs.getString("imei")%>" style="width:200px; padding: 4px 5px 2px 5px;
	                 border-color: activeborder;  font: normal 11px Arial, Helvetica, sans-serif; color: #000000;" />
				</td>
			</tr>
			<tr>
			<td >
					<label id="custype"><b>UnitId<font  color="#990000">*</font> :</b></label>
				</td>	
				<td>
					<input type="text" name="unitid" id="unitid" value="<%=rs.getString("unitid") %>" style="width:200px; padding: 4px 5px 2px 5px;
	                 border-color: activeborder; font: normal 11px Arial, Helvetica, sans-serif; color: #000000;" />
				</td>
			</tr>
			
			
				
				
			
			
			
			
			
              <%} %> 
			<%
		
} catch(Exception e){}

  
conn.close();%> 
			
		</table>
		<table align="center">
			<tr>
				<td align="center"><input  type="submit" id="submit1" value="Update" onclick="return validate();" style="border: outset;"></td>
			</tr>
		</table>
<br>	</td>
</tr>

</table>
</form>
<br><br><br>
<%

String sendMsg=request.getParameter("sendMsg");
%>
<input type="hidden" name="sendMsg" id="sendMsg" value="<%=sendMsg %>"></input>
<%
if(!(sendMsg==null))
{
	System.out.println("======="+sendMsg+"=======");
	%>
	<script LANGUAGE="JavaScript" type="text/javascript">
	
	//alert("company created");
	var sendMsg=document.getElementById("sendMsg").value;
	//alert(sendMsg+"\n");

	</script>
	
<%}%>
 <%@ include file="footerhtml.jsp" %>
</body>
</html>