<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var trans=document.createidsform.name.value;
	var fn=document.createidsform.user.value;
	var un=document.createidsform.utype.value;
	

	
	if(trans=="")
	{
		alert("Please enter User Name");
		return false;
	}		

	if(fn=="")
	{
		alert("Please enter User ID");
		return false;
	}

	if(un=="")
	{
		alert("Please enter User Type");
		return false;
	}

	
}

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Create New DiarySystem Login Id</i></b></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1;
String sql,sql1;
Connection conn1;
%>
<form name="createidsform" action="inserdsid.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"><input type="text" name="name"/></td></td>
			
		</tr>
	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User ID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="user"/> </td>
			 </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Email ID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="email"/> </td>
			 </td>
		</tr>
<%

try{


Class.forName(MM_dbConn_DRIVER);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stmt1=conn1.createStatement();
	sql1="select distinct(UserType) as UserType from t_admin where URole='service' order by UserType asc";
	ResultSet rs1=stmt1.executeQuery(sql1);
%>
			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Type: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"><select name="utype">	
				<option value="Select">Select</option>
				<%
					while(rs1.next())
					{ 
						//String vehcode=rs1.getString("VehicleCode");
					%>
						<option value="<%=rs1.getString("UserType")%>"><%=rs1.getString("UserType")%></option>
				<%	}
				%>
			     </select>	
			</td> </td>
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
	conn1.close();
}
%>
<%@ include file="footerhtml.jsp" %>