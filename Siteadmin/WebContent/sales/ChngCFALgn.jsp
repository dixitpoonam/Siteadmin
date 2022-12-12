<%@ include file="headerhtml.jsp" %>
<script language="javascript">
function validate()
{
	var id=document.updatecfalogin.id.value;
	var loc=document.updatecfalogin.loc.value;
		
	if(id=="Select")
	{
		alert("Please Select User ID");
		return false;
	}		

	if(loc=="Select")
	{
		alert("Please Select Location");
		return false;
	}

	
}

function getlocByid(dropdown)
{
var vv1=dropdown.selectedIndex;

var lowerLimit = dropdown.options[vv1].value;
//alert ("lowerLimit----->"  + lowerLimit);

var ajaxRequest;

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
	         //	alert ("reslt---->" +  reslt);
             	reslt=ajaxRequest.responseText;
             	document.getElementById("location").innerHTML=reslt; 
            
         } 
	}
	
	
	  	var url="Getlocationforid.jsp";
       	url = url + "?UserID="+lowerLimit;
       //	alert(url);
	    ajaxRequest.open("GET", url , true);
     	ajaxRequest.send(null); 
 
}


</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Change CFA Login Id</b></i></font></td></tr>
<tr><td align="center">
<%!
Statement stmt1,stmt2;Connection conn;
String sql,sql1;
%>
<form name="updatecfalogin" action="UpdateCFALgn.jsp" onsubmit="return validate();">

	<table border="1" width="60%">
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	stmt2=conn.createStatement();
	sql="select distinct(UserId) as UserId from t_subuser where Transporter = 'Castrol' order by UserId Asc";
	ResultSet rs=stmt2.executeQuery(sql);
%>
	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Login ID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"><select name="id" onchange="getlocByid(this);">	
				<option value="Select">Select</option>
				<%
					while(rs.next())
					{ 
					
					%>
						<option value="<%=rs.getString("UserId")%>"><%=rs.getString("UserId")%></option>
						 
				<%	}
				%>
			     </select>	
			</td> </td>
		</tr>
	
	 <tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Current Location: </B> </font> </td>
			<td colspan="2"><div id="location">  </div></td>
			
			
		</tr>
	<!--	<tr>
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
			<td colspan="3" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
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
