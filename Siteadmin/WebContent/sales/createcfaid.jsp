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

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Create New Group Login Id</b></i></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1;
String sql,sql1;Connection conn;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<form name="createidsform" action="insercfaid.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> User Name / ID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="user"/> </td>
			 </td>
		</tr>
	
	<!-- <tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Target Page: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="targetpage"/> </td>
			 </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Group Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="grpname"/> </td>
			 </td>
		</tr>
	 -->			
		
<!--  		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Transporter: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <select name="trans">
			<option value="Select">Select</option>
			<option value="Castrol East">Castrol East</option>
			<option value="Castrol West">Castrol West</option>
			<option value="Castrol North">Castrol North</option>
			<option value="Castrol South">Castrol SouthSelect</option>
			<option value="Castrol ILS">Castrol ILS</option>
			
			
			 </td>
			 </td>
		</tr>
-->		
<%

stmt1=conn.createStatement();
	sql1="select distinct(Zonedesc) as Zonedesc from t_castrolzones where Type = 'CFA' order by Zonedesc Asc";
	ResultSet rs1=stmt1.executeQuery(sql1);
%>

			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Location (CFA): </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"><select name="loc">	
				<option value="Select">Select</option>
				<%
					while(rs1.next())
					{ 
						//String vehcode=rs1.getString("VehicleCode");
					%>
						<option value="<%=rs1.getString("Zonedesc")%>"><%=rs1.getString("Zonedesc")%></option>
						 
				<%	}
				%>
			     </select>	
			</td> </td>
		</tr>
		
		
<!--  	 	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Type Value(Enter Person Name): </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="typevalue"/> </td>
			 </td>
		</tr>
-->		
	 
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