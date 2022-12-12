<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var trans=document.blunblockform.trans.value;
	var msgid=document.blunblockform.msgtyp.value;

	if(trans=="Select")
	{
		alert("Please select Transporter's name");
		return false;
	}

	if(msgid=="")
	{
		alert("Please enter Message Id");
		return false;
	}
	if(isNaN(msgid))
	{
		alert("Please enter proper integer value for Message Id");
		return false;
	}
	
	var msgidint=parseInt(msgid);
	
	if(msgidint<1 || msgidint>6)
	{
		alert("Please enter one value given in the list below");
		return false;
	}	

	return true;
}
   
function GetTypeofMsg(dropdown)
{
  var vv1=dropdown.selectedIndex;
       
  var SelValue = dropdown.options[vv1].value;
	
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

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         
			document.blunblockform.msgtyp.value=reslt;
                                
		     } 
         	  }
             var queryString = "?trans=" +SelValue;
	     ajaxRequest.open("GET", "Ajaxgettypeofmsg.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}

</script>
<table border="0" align="center" width="100%">
<tr><td>
<form name="blunblockform" action="blockunblinsrtinsrt.jsp" onsubmit="return validate();">
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
Statement stmt1 = conn.createStatement();
ResultSet rs1=null, rs2=null;
String sql1="", sql2=""; 

String updated=request.getParameter("updated");

if(updated==null)
{
}
else
{ %>
		<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="red" size="2"> <i><U> Successfully Updated </U></i> </font> </td> 
			</tr>
		</table>	
<% }
%>
	<center>
	<table border="0" width="40%">
		<tr>	
			<td colspan="2" align="center"> <font color="maroon" size="2"> <B> Block </B> </font> </td>
		</tr>	
	</table>
<%
	sql1="select distinct(TypeValue) as TypeValue from t_security where TypeofUser in ('Transporter', 'GROUP') order by TypeValue asc";
	rs1=stmt1.executeQuery(sql1);
%>
	<table border="0" width="60%">
		
		<tr>
			<td> <font color="maroon"> <B> Transporter: </B> </font> </td>
			<td> <select name="trans" onChange="GetTypeofMsg(this);">	
				<option value="Select">Select</option>
				<%
					while(rs1.next())
					{ %>
						<option value="<%=rs1.getString("TypeValue")%>"><%=rs1.getString("TypeValue")%></option>
				<%	}
				%>
			     </select>	
			 </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> Type of Msg. Id: </B> </font> </td>
			<td> <input type="text" name="msgtyp" /> </td>			
		</tr>

		<tr>
			<td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
		</tr>
	</table>
</center>
<br>

<%
	sql2="select * from t_message order by ID asc";
	rs2=stmt1.executeQuery(sql2);
%>
<table border="1" width="100%" class="stats">
	<tr>
		<td colspan="2" align="center">  <font color="maroon"> <B> ID Description </B> </font> </td>
	</tr>
		<td align="center"> <font color="maroon"> Message ID</font> </td>
		<td align="center"> <font color="maroon"> Description</font> </td>
	</tr>
		<%
			while(rs2.next())
			{ %>
	<tr>			
				<td align="center"> <b> <%=rs2.getString("ID")%> </B> </td>
				<td> <b><%=rs2.getString("Message")%> </B> </td>
	</tr>
		<%	}
%>
		</td>
	</tr>
</table>

<% 
} catch(Exception e) { out.println("Exception----->"+e); }
finally
{
conn.close();
}


%>


</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>