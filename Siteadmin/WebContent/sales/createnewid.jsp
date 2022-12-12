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

	var sss=validateEmail(un);
	if(!sss)
	{
	    //alert(sss);
		alert("Please enter valid Username");
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


function validateEmail(email)
{
     var splitted = email.match("^(.+)@(.+)$");
    if(splitted == null) return false;
    if(splitted[1] != null )
    {
      var regexp_user=/^\"?[\w-_\.]*\"?$/;
      if(splitted[1].match(regexp_user) == null) return false;
    }
    if(splitted[2] != null)
    {
      var regexp_domain=/^[\w-\.]*\.[A-Za-z]{2,4}$/;
      if(splitted[2].match(regexp_domain) == null) 
      {
	    var regexp_ip =/^\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\]$/;
	    if(splitted[2].match(regexp_ip) == null) return false;
      }// if
      return true;
    }
return false;
}
</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Create New Login Id</b></i></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1;
String sql,sql1;Connection conn;
%>
<%
String flag = request.getParameter("inserted");
if(flag != null && flag.equals("1"))
{
	out.println("<div align='center'><font color='brown' size='2'>The username already exist !!</font></div>");
}
else
	if(flag != null && flag.equals("2"))
	{
		out.println("<div align='center'><font color='brown' size='2'>Added Successfully</font></div>");
	}
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
		stmt1=conn.createStatement();
	
	sql1="select distinct(TypeValue) as TypeValue from(select distinct(TypeValue) as TypeValue from t_transporter where ActiveStatus = 'Yes' union select distinct(GPName) as TypeValue from t_group where SepReport='Yes' and Active = 'Yes') y order by TypeValue Asc";
//"select distinct(TypeValue) as TypeValue from t_security where TypeofUser in ('Transporter', 'GROUP') union  order by TypeValue asc";
	ResultSet rs1=stmt1.executeQuery(sql1);
%>
<form name="createidsform" action="createidsinsrt.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Transporter: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <select name="trans">	
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
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Full Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="fn"/> </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="un"/> <div>Please enter email id as username</div></td>
			
		</tr>	
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Password: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="password" name="pass"/> </td>
		</tr>	
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Confirm Password: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="password" name="cpass"/> </td>
		</tr>
		<tr>
			
			<td colspan="2" align="left" bgcolor="#f5f5f5"> <input type="checkbox" name="admin" value="admin"/> <font color="maroon"><b>Admin</b></font>  </td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
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
