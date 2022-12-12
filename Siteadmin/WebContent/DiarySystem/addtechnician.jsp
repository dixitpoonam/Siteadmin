<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var techname=document.createidsform.techname.value;
	var mobno=document.createidsform.mobno.value;
	var location=document.createidsform.location.value;
	var techuname=document.createidsform.techuname.value;
	
	
	if(techname=="")
	{
		alert("Please Enter Technician Name");
		return false;
	}		
	if(techuname=="")
	{
		alert("Please Enter Tecnician User Name");
		return false;
	}
	if(mobno=="")
	{
		alert("Please Enter Mobile Number");
		return false;
	}

	if(location=="")
	{
		alert("Please Enter Location Name");
		return false;
	}
	
	
}

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Add New Technician</b></i></font></td></tr>
<tr><td align="center">

<form name="createidsform" action="insertech.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techname"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techuname"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Mob No: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="mobno"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Location: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="location"/> </td>
			 </td>
		</tr>	
		
		<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
		</tr>
	</table>
</form>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>