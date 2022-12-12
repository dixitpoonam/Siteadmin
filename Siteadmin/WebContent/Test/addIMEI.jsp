
  <%@ include file="headerhtml.jsp" %>

<html>
<head>

<title>Transworld - Leave Application</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript">
function validate(){
	 alert("in validate function");
	
	 var unitid=document.leave.unitid.value;
	// alert(name);
	 
	
	// alert(name);
	 //alert("unitid==>"+unitid);
	
	
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
		 
		    //return true;
				
	}


    
		//alert("UnitId Length==>"+unitid.trim().length);
		if(unitid.trim().length==0)
	{
		
		alert("Please Enter the valid UnitId No");
		return false;
	}

   
    
     
     
	return true;
}


</script>
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
			document.leave.counter.value=b;
			//alert("counter "+document.leave.counter.value);
			document.leave.counter.value=b*document.leave.counter.value;
			counter=document.leave.counter.value;
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

<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Transworld Compressor-Technologies LTD, Leave Application</title>


</head>
<body >


<form method="post" name="leave" action="IMEIInsert.jsp?action=addemp" onsubmit="return validate();">
<table bgcolor="#E0DDFE" border="0" align="center" height="250" width=600">
<tr>
<td align="center"><b><font size="4" color="#151B54">Add IMEI</font></b></td>
</tr>
<%!
Connection c;
Statement st, st1,st2;
String sql, unitid,thedate,thedate1,thedate2,sqlProcessed;
int limit;
Connection conn,conn1;
%>

<%
try{

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);



Statement st1=conn.createStatement();
String updated="",already="";
updated=request.getParameter("inserted");
already=request.getParameter("already");
System.out.println("updated-->"+updated+" already"+already);
if(already==null){
	
}else if(already.equalsIgnoreCase("yes")){
	%>
	<tr>
<td align="center"><b><font size="3" color="blue">IMEI ID is already exist</font></b></td>
</tr>
	
<%	
}
if(updated==null){
	
}
else if(updated.equalsIgnoreCase("yes")){
	%>
	<tr>
<td align="center"><b><font size="3" color="blue">IMEI Added Successfully</font></b></td>
</tr>
	
	<%
}
%>

<tr bgcolor="white"><td><b>Note: *Indicate Fields are Mandatory.</b></td>
</tr>
<tr bgcolor="white">	
	<td>
		<table align="center" border="0" width="95%" height="70%">
<td><b>IMEI No<font  color="#990000">*</font></b></td>
		<td><input type="text" id="imei" name="imei" value="" class="input"/></td>
	</tr>
	<tr>
			<td >
					<label id="custype"><b>Unit ID<font  color="#990000">*</font> :</b></label>
				</td>	
				<td>
					<input type="text" name="unitid" id="unitid" value="" class="input"/>
				</td>
			</tr>
	
	<table align="center">
	     
			<tr>
				<td><input  type="submit" id="submit1" value="Submit" class="button"/></td>
			</tr>
			
			</table>
	

</table>


</td>
</tr>
</table>

</form>

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

<p></p>
 <%@ include file="footerhtml.jsp" %>
</body>
</html>