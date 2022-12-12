
<%@ include file="header.jsp" %> 

<html>
<head>

<title>Transworld - Leave Application</title>
<link href="css/style.css" rel="stylesheet" type="text/css"  />
<script type="text/javascript">
function validate(){
	// alert("in validate function");
	  var id=document.leave.empid.value;
	 var name=document.leave.cName.value;
	// alert(name);
	 var username=document.leave.username.value;
	 var email=document.leave.email.value;
	//  		 alert(username);
     var pass=document.leave.pass.value;
   //  		alert(pass);
     var confirm=document.leave.confirm.value;
     var department=document.leave.deptName.value;
   //			 alert(confirm);
	var reason1=document.leave.reason1.checked;
	var reason2=document.leave.reason2.checked;
     
     if(isNaN(id))
	 	{
	 	alert("Invalid Contractor Id");
	 	return false;
	 	}
     if(id==""){
    	 alert("Please Enter Contractor Id");
 			return false;
         }
	     
     if(name=="")
 	{
 		alert("Please Enter the Contractor Name");
 		return false;
 	}
     
 /*    if(name==""){
    	 alert("Please Enter Full Name");
 		return false;
         }
*/
     if(username==""){
    	 alert("Please Enter User Name");
 		return false;
         }else
     	{
     		// var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-]{1,3})+\.)+([a-zA-Z0-9]{2,4})+$/;
     		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     		    if (!filter.test(username)) {
     		    alert('Please provide a valid User Name');
     		    email.focus;
     		    return false;
     		    }
     	} 
     	
     
     if(email==""){
    	 alert("Please Enter Email ID");
 		return false;
         }else
     	{
     		// var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-]{1,3})+\.)+([a-zA-Z0-9]{2,4})+$/;
     		 var filter = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     		    if (!filter.test(email)) {
     		    alert('Please provide a valid email ID');
     		    email.focus;
     		    return false;
     	} 
     	}
     
     if(pass==""){
    	 alert("Please Enter Password");
 		return false;
         }

    
//     alert(Details);
   

     if(confirm==""){
    	 alert("Please Confirm Password");
 		return false;
         }

		if(pass==confirm){
		}else{
			alert("confirm password does not match");
	 		return false;
			}  

		  if(reason1==true){
			    //	alert(reason1.value);
			    }else if(reason2==true){
			    	// alert(reason2.value);
			       }else{
								alert("Please select Type Of User");
								return false;
			                }
					   
		if( department == "-1" )
	    {
	      alert( "Please Select Department" );
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
<body bgcolor="Silver">

<table bgcolor="white" border="0" height="450" width="750" align="center">

<tr><td>
<form method="post" name="leave" action="addEmployeeInsert.jsp?action=addemp" onsubmit="return validate();">
<table bgcolor="#E0DDFE" border="0" align="center" height="450" width=550">
<tr>
<td align="center"><b><font size="4" color="#151B54">Add Contractor</font></b></td>
</tr>
<%
Statement st1=conn.createStatement();
String updated="",already="";
updated=request.getParameter("inserted");
already=request.getParameter("already");
System.out.println("updated-->"+updated+" already"+already);
if(already==null){
	
}else if(already.equalsIgnoreCase("yes")){
	%>
	<tr>
<td align="center"><b><font size="3" color="blue">Contractor ID is already exist</font></b></td>
</tr>
	
<%	
}
if(updated==null){
	
}
else if(updated.equalsIgnoreCase("yes")){
	%>
	<tr>
<td align="center"><b><font size="3" color="blue">Contractor Added Successfully</font></b></td>
</tr>
	
	<%
}
%>

<tr bgcolor="white"><td><b>Note: *Indicate Fields are Mandatory.</b></td>
</tr>
<tr bgcolor="white">	
	<td>
		<table align="center" border="0" width="95%" height="90%">
<td><b>Contractor ID<font  color="#990000">*</font></b></td>
		<td><input type="text" id="empid" name="empid" value="" class="input"/></td>
	</tr>
	<tr>
			<td >
					<label id="custype"><b>Contractor Name<font  color="#990000">*</font> :</b></label>
				</td>	
				<td>
					<input type="text" name="cName" id="cName" value="" class="input"/>
				</td>
			</tr>
	<tr>
		<td><b>User Name <font  color="#990000">*</font></b></td>
		<td><input type="text" id="username" name="username" value="" class="input"/></td>
	</tr>
	<tr>
		<td><b>Email Id<font  color="#990000">*</font></b></td>
		<td><input type="text" id="email" name="email" value="" class="input"/></td>
	</tr>
	<tr>
		<td><b>Password <font  color="#990000">*</font></b></td>
		<td><input type="password" name="pass" id="pass" value="" class="input"/></td>
	</tr>
	<tr>
		<td><b>Confirm Password <font  color="#990000">*</font></b></td>
		<td><input type="password" name="confirm" id="confirm" class="input"/></td>
	</tr>
	<tr>
		<td><b>Type Of User<font  color="#990000">*</font></b></td>
		<td><input type="radio" name="typeOfUser" id="reason1" value="contractor"/>Contractor
			<input type="radio" name="typeOfUser" id="reason2" value="hod"/>HOD
		</td>
	</tr>
	<tr>
		<td align="left"><b>Weekly Off<font  color="#990000">*</font></b></td>
		<td align="left"><select name="weekoff" id="weekoff" class="formElement">
			     <option value="0">Sunday</option>
			     <option value="1">Monday</option>
			     <option value="2">Tuesday</option>
			     <option value="3">Wednesday</option>
			     <option value="4">Thursday</option>
			     <option value="5">Friday</option>
			     <option value="6">Saturday</option>
			 </select>
		</td>
	</tr>
	<tr>
			<td style="vertical-align:top;">
				<b>Type Of Department<font  color="#990000">*</font></b>
			</td>
			<td style="vertical-align: bottom;">
			
			
					  <select name="deptName" id="deptName" class="formElement"  >
						<option value="-1">Select</option>
						<% 
						try
						{
							String sqlCat="select DeptCode,DeptName from t_department where status='Active'";
						    ResultSet rsCat=st1.executeQuery(sqlCat);
						    while(rsCat.next())
						    { %>
						     <option value="<%=rsCat.getString("DeptCode") %>"> <%=rsCat.getString("DeptName") %> </option>
						<%  } 
						}
						catch(Exception e)
						{
							System.out.println("Exception======>>"+e);
						 }%>
				      </select>
				
				<!--<input type="radio" name="reason11" id="reason11" value="Software"/>Software
				<input type="radio" name="reason11" id="reason12" value="RnD"/>Embedded
				<input type="radio" name="reason11" id="reason13" value="Service"/>Service
				<br><input type="radio" name="reason11" id="reason14" value="Service"/>HR/Admin
				<input type="radio" name="reason11" id="reason15" value="Service"/>Purchase
				<input type="radio" name="reason11" id="reason16" value="Sales&Marketing"/>Sales & Marketing<br>
				<input type="radio" name="reason11" id="reason17" value="Accounts"/>Account
				<input type="radio" name="reason11" id="reason18" value="Production"/>Production
			-->
			</td>
	</tr>
	<!--<tr>
	<td style="vertical-align:top;">
	<b>Reporting to Hod<font  color="#990000">*</font></b>
	</td>
	<td style="vertical-align:top;"><input type="text" autocomplete="off" id="reportingto" name="reportingto" onkeyup="getHod(1)"  class="input"/></td>
	<td align="left">
<div id='transporterlist' align="left" style="border: thin;">
<div style="height: 110px; width: 300px; overflow: auto;">
<table style="display: none;">
</table>
<input type="hidden" name="counter" id="counter" value="10"/>
  <input type="hidden" name="usertypevalue" id="usertypevalue" value="< %=session.getValue("usertypevaluemain").toString() %>"/>
<input type="hidden" name="counter" id="counter" value="10"/>
<input type="hidden" name="anothercounter" id="anothercounter" value="10"/>
</div>
									
									</div>
									</td>
	</tr>
	
	--></table>

	<table align="center">
	     
			<tr>
				<td><input  type="submit" id="submit1" value="Submit" class="button"/></td>
			</tr>
			
			</table>
	

</table>
</form>
</td></tr>

</table>
<p></p>
<div id="footer"><p>
<a href="http://www.myfleetview.com">
Copyright &copy; 2009 by Transworld Compressor Technologies Ltd. All Rights Reserved.</a></p>
</div>
</body>
</html>