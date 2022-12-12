<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var fn=document.mainpageform.fn.value;
	var un=document.mainpageform.un.value;
	var pass=document.mainpageform.pass.value;	
	var cpass=document.mainpageform.cpass.value;
	var typuser=document.mainpageform.typeuser.value;
	var add=document.mainpageform.add.value;
	var totinst=document.mainpageform.totinst.value;
	var mnthlyrental=document.mainpageform.monthlyrent.value;
	var sla=document.mainpageform.sla.value;

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
		document.mainpageform.cpass.value="";
		alert("Password and Confirm Password doesn't match");
		return false;
	}	

	if(typuser=="Select")
	{
		alert("Please select Type of User");
		return false;
	}

	if(add=="" || add.length < 2)
	{
		alert("Please enter Address");
		return false;
	}

	if(totinst=="")
	{
		alert("Please enter Maximum no. of Installations");
		return false;
	}
	if(isNaN(totinst))
	{
		alert("Please enter integer value for No. of Installations");
		return false;
	}

	if(mnthlyrental=="")
	{
		alert("Please enter value for Monthly Rental");
		return false;
	}
	if(isNaN(mnthlyrental))
	{
		alert("Please enter integer value for Monthly Rental");
		return false;
	}

	if(sla=="")
	{
		alert("Please enter value for SLA");
		return false;
	}
	if(isNaN(sla))
	{
		alert("Please enter integer value for SLA");
		return false;
	}			
}

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b>Add New Customer</b></font></td></tr>
<tr><td align="center">
<form name="mainpageform" action="custdetailsinsrt.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
		<tr><td colspan="2" align="center"><i><font color="Red" size="2">
		<%
		String succ=request.getParameter("inserted");
		if(!(null==succ) && succ.equals("successfull"))
		{
		out.print("Successfully Inserted ");
		}	
		%>		
		</font></i></td></tr>
		<tr>
			<td> <font color="maroon"> <B> Full Name: </B> </font> </td>
			<td> <input type="text" name="fn"/> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> User Name: </B> </font> </td>
			<td> <input type="text" name="un"/> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> Password: </B> </font> </td>
			<td> <input type="password" name="pass"/> </td>
		</tr>	
		<tr>
			<td> <font color="maroon"> <B> Confirm Password: </B> </font> </td>
			<td> <input type="password" name="cpass"/> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> Type of User: </B> </font> </td>
			<td> <select name="typeuser">
				<option value="Select">Select</option> 
				<option value="Transporter">Transporter</option>
				<option value="Group">Group</option>
			     </select>	
			 </td>
		</tr>	
		<tr>
			<td> <font color="maroon"> <B> Address: </B> </font> </td>
			<td> <textarea name="add" class="formElement"> </textarea> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> Total Installations: </B> </font> </td>
			<td> <input type="text" name="totinst"/> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> Monthly Rental: </B> </font> </td>
			<td> <input type="text" name="monthlyrent" /> </td>
		</tr>
		<tr>
			<td> <font color="maroon"> <B> SLA: </B> </font> </td>
			<td> <input type="text" name="sla" /> </td>
		</tr>
		<tr>
			<td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
		</tr>
	</table>

</form>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>