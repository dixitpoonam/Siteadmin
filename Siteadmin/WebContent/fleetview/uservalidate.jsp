<%@ include file="headerhtml.jsp" %>
<script type="text/javascript">
<!--

//-->


function submitform()
{
	if(!(document.getElementById("trans").value=="Select"))
	{
		document.form1.submit();
	}
}
function sendMail(user, pass)
{
	//alert("function madhe ala");	
//user="a_kalaskar@transworld-compressor.com";
//pass="1234";
	var ajaxRequest;
	//alert("1");
	try
	{
     // Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
		//alert("2");
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
	//alert("3");
	ajaxRequest.onreadystatechange = function()
	{
    	if(ajaxRequest.readyState == 4)
    	{
          	var reslt=ajaxRequest.responseText;
          	//alert("result is before :- "+reslt);
          	reslt=reslt.replace(/^\s+|\s+$/g,"");
			//alert("result is after :- "+reslt);
          	if(reslt=="Success")
          	{
          		alert("Email has been sent successfully.");
          	}	
          	//alert("the result is:- "+reslt);
		} 
	}
	
	
	ajaxRequest.open("get","sendemail.jsp?UserName="+user+"&Password="+pass,true);
	ajaxRequest.send(null);
}


</script>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5" align="center">
<font color="black" size="2">
Validate User Login Id
</font>
</td>
</tr>
<tr><td>
<%!
Statement st, st1;
String sql,trans,conno,conname;
Connection conn;
%>
<%
trans="";
trans=request.getParameter("trans");
if(null==trans)
{
	trans="-";
}


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select Distinct(TypeValue) from t_security where TypeOfUser in ('Transporter','Group','EndUser') order by TypeValue";
	ResultSet rsttrans=st.executeQuery(sql);
	%>
	<form name="form1" action="" method="get">
	<select name="trans" id="trans" onchange="submitform();">	
	<option value="Select">Select</option>
	<option value="ALL">ALL</option>
	<%
	while(rsttrans.next())
	{
	%>
	<option value="<%=rsttrans.getString("TypeValue")%>" <% if(trans.equals(rsttrans.getString("TypeValue"))) {%>Selected<%}%>><%=rsttrans.getString("TypeValue")%></option>
	<%
	}
%>
</select> <font color="red" size="2"> Note:-</font> <font color="brown" size="2"> Please select the transporter or group name to show his logins.</font>
</form>
<%
}
catch(Exception e)
{
	out.print("Exception ----"+e);
}
%>
</td></tr>
<%
if(!(trans.equals("-")))
{
%>
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2"><b>
The Login Id's for <%=trans%></b>
</font>
</td>
</tr>
<%
}
%>
<tr>
<td>
<table border="0" width="100%" align="center">
<tr>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Sr.</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">User ID</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Full Name</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Contact No</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Location</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Type Value</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Type Of User</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Active Status</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">ID Type</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Expiry Date</font></td>
<td align="center" bgcolor="#2696B8"><font color="white" size="2">Action</font></td>
</tr>
<%
if(!(trans.equals("-")))
{
	try{
		sql="select * from t_security where TypeValue='"+trans+"' order by UserName";
		ResultSet rstlogin=st.executeQuery(sql);
		int i=1;
		while(rstlogin.next())
		{
			sql="select * from t_userdetails where UserName='"+rstlogin.getString("UserName")+"' order by MobNo desc";
			ResultSet rstcontact=st1.executeQuery(sql);
			conno="";
			conname="";
			if(rstcontact.next())
			{
				conno=rstcontact.getString("MobNo");
				conname=rstcontact.getString("Location");
			}
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><%=i%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("UserName")%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("FullName")%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=conno%></td>
			<td bgcolor="#f5f5f5" align="left"><%=conname%></td>
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("TypeValue")%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("TypeOfUser")%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("ActiveStatus")%></td>	
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("LoginInfo")%></td>
			<td bgcolor="#f5f5f5" align="left"><%=rstlogin.getString("ExpiryDate")%></td>
			<td bgcolor="#f5f5f5" align="left"><a href="javascript:flase" onclick="sendMail('<%=rstlogin.getString("UserName")%>','<%=rstlogin.getString("Password")%>');" title="Click to Mail User Name and Password"><img src="../images/mail.jpg" border="0"></a>&nbsp;&nbsp;<a href="javascript: flase" title="click to edit values" 
			onclick="window.open('edituser.jsp?username=<%=rstlogin.getString("UserName")%>&typevalue=<%=rstlogin.getString("TypeValue")%>&activestatus=<%=rstlogin.getString("ActiveStatus")%>','win1','width=500,height=350,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td>
			</tr>			
			<%
			i++;
		}
	}catch(Exception e)
	{
		out.print("Exception ---->"+e);
	}finally{
		conn.close();
	}
}
%>
</table>
</td>
</tr>
</table>
<%@ include file="footerhtml.jsp" %>
