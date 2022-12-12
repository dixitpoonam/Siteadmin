
<%-- 
    Document   : creategrpid.jsp
    Created on : April 01, 2010, 13:19:52
    Author     : Ayaz A.
    Discroption: Page To Create Group Ids. 
    last updated : April 13, 2010, 13:19:52 By Ayaz
--%>

<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var trans=document.createidsform.trans.value;
	var fn=document.createidsform.fn.value;
	var un=document.createidsform.un.value;
	var pass=document.createidsform.pass.value;	
	var cpass=document.createidsform.cpass.value;

	
	if(trans=="Select")
	{
		alert("Please enter Transporter Name");
		return false;
	}		

	if(fn=="")
	{
		alert("Please enter Full Name");
		return false;
	}

	if(un=="")
	{
		alert("Please enter User Name");
		return false;
	}

	if(pass=="")
	{
		alert("Please enter Password");
		return false;
	}

	if(cpass=="")
	{
		alert("Please confirm Password");
		return false;
	}

	if(pass!=cpass)	
	{
		document.createidsform.cpass.value="";
		alert("Password and Confirm Password doesn't match");
		return false;
	}		
}
function formsubmit()
{
	var aa=document.createidsform.trans.value;
	if(!(aa=="Select"))
	{	
		document.createidsform.submit();
	}
}
function formsubmit1()
{
	var bb=document.createidsform.owner.value;
	if(!(bb=="Select"))
	{	
		document.createidsform.submit();
	}
}
function redirect()
{
	
	document.createidsform.action="insergrpid.jsp";
	document.createidsform.submit();
	
}
</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Create New Group Login Id</b></i></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1,stmt2; Connection conn;
String sql,sql1;
%>
<%
 try{
 Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 	String OwnerName=request.getParameter("trans");
	 String Vehicle=request.getParameter("veh");
	 stmt1=conn.createStatement();
	 stmt2=conn.createStatement();
	 
%>
<form name="createidsform" action="" onsubmit="return validate();">

	
<table border="0" width="750px">
 <tr>
    <td align="center">

<table border="1" width="550px">

 <tr>
       <td> <font color="maroon"> Owner Name: </font> </td>
       <td>
       
      	 <select name="trans" id="trans" onchange="formsubmit();"> 
         <option value="Select">Select</option>
          <%
 			if(!(null==OwnerName))
 			{
 				%>
 		       
 					<option value="<%=OwnerName %>" selected="selected"><%=OwnerName %></option>
 				 <%
 			}
 		%>
        <%
        sql="select Distinct(OwnerName) as Transporter from t_vehicledetails where OwnerName not like '%del' order by OwnerName";
        ResultSet rs1=stmt2.executeQuery(sql);
        while(rs1.next())
   	   { %>
      		<option value="<%=rs1.getString("Transporter") %> "> <%=rs1.getString("Transporter") %> </option>
	<% } %>
		</select> 
		
   	   </td>
 </tr>
  <tr>

      <td>  <font color="maroon">Vehicles : </font> </td>
      <td> <select name="veh" id="veh">	<!--  onchange="formsubmit1();" -->
           <option value="Select">Select</option>
	   <%
	   sql="select Distinct(VehicleRegNumber) from t_vehicledetails where OwnerName='"+OwnerName+"'";
	   ResultSet rs2=stmt2.executeQuery(sql);
	   while(rs2.next())
   	   { %>
      		<option value="<%=rs2.getString("VehicleRegNumber") %> "> <%=rs2.getString("VehicleRegNumber") %> </option>
	<% } %>
     		
	    </select></td>
  </tr>
  	<%
 			if(!(null==Vehicle))
 			{
 				%>
 		       	<tr>
				<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name: </B> </font> </td>
				<td bgcolor="#f5f5f5"> <input type="text" name="user"/> </td>
				</td>
				</tr>
	 			<tr>
				<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Type Value(Enter Person Name): </B> </font> </td>
				 <td bgcolor="#f5f5f5"> <input type="text" name="typevalue"/> </td>
				</td>
		</tr>
 				 <%
 			}
 		%>
     
     
   <tr>
	<td colspan="2" align="center"><input type="button" name="Submit" value="Submit" class="formElement" onclick="redirect();"></td>
	
  </tr>
</table>

</td>
</tr>
</table>
</form>
</td></tr>
</table>
<%
 }catch(Exception e){
	 
 }finally{
	 conn.close();
 }
%>
<%@ include file="footerhtml.jsp" %>
