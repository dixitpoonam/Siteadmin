<%@ include file="headerhtml.jsp" %>

<script language="javascript">
function validate()
{
	var v1,v2;
	v1=document.getElementById("transporter").value;
//	v2=document.transEmail.value;
//	alert(v2);
	if(v1=="Select")
	{
		alert("Please Select Transporter or Location");
		return false;
	}
/*	if(v2=="")
	{
		alert("Please Select Transporter or Location");
		return false;
	}*/
	return true;
}
function getTrans(transporter)
{
		
		var xmlhttp;
		if (window.XMLHttpRequest)
		  {
		  // code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		  }
		else if (window.ActiveXObject)
		  {
		  // code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
		else
		  {
		  alert("Your browser does not support XMLHTTP!");
		  }
		xmlhttp.onreadystatechange=function()
		{
		if(xmlhttp.readyState==4)
		  {
		  //alert(xmlhttp.responseText);
         var a=xmlhttp.responseText;
         //alert(">>>a>>"+a);
         var mySplitResult =  xmlhttp.responseText.split("$");
         //var mySplitResult1 =  xmlhttp.responseText.split("&");
         //var mySplitResult2 =  xmlhttp.responseText.split("#");
         //var mySplitResult3 =  xmlhttp.responseText.split("&");
         //var lt=mySplitResult.length;
          //var data1= mySplitResult[0];
         // var data11 =data1.split(",");
          
                        //alert("data11>>>0"+data11[0]);
                        //alert("data11>>>1"+data11[1]);
                                 //var data2= mySplitResult[1];
                                 //var data3= mySplitResult[2];
                                //alert("length"+mySplitResult.length);
                                 //alert("mySplitResult0>>>>>>"+mySplitResult[0]);
                                //alert("mySplitResult1>>>>>>"+mySplitResult[1]);
                               // alert("mySplitResult3>>>>>>"+mySplitResult[2]);
                                //alert("mySplitResult2>>>>>>"+mySplitResult[3]);
                                 //alert("data2 lngth>>>>"+data2.length);
                                 //alert("data3 lngth2>>>>"+data3.length);
         //alert(">>>c>>"+c);
             var i;
              var m;
              //for(m=1;m<lt;m++)
             // {
            	  //alert("data1>>m>>>"+data1[m]);      
            	  document.getElementById("transEmail").innerHTML=mySplitResult[0].trim();
             // }
             
            //for(i=0;i< lt;i++){
		  


      		 // document.getElementById("transEmail").innerHTML=mySplitResult[i].trim();
		//alert(xmlhttp.responseText);
		  document.getElementById("transEmail1").innerHTML=mySplitResult[1].trim();
		  document.getElementById("transEmail2").innerHTML=mySplitResult[2].trim();
          
		 //alert(document.getElementById("transEmail11").innerHTML=mySplitResult[3]);
          try{
        	  //alert("mySplitResult2>>>>>>"+mySplitResult[3]);
        	  first.transEmail11.innerHTML = mySplitResult[3].trim();
        	  //document.getElementsByName("transEmail11").innerHTML=mySplitResult[3].trim();
        	 //alert(document.getElementById("transEmail11").value);
            }catch(e)
            {
             alert(">>>>>"+e);
            }
          //}

		  
		  }
		}
		
		xmlhttp.open("GET","getTrans.jsp?Transporter="+transporter,true);
		xmlhttp.send(null);
		//alert(">>>>hi");
		
}
</script>
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Edit Transporter, Sending/Receiving Location with Mail ID
</b>
<br><br>
</font>
</td></tr>
</table>

<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<table border="0" >
<%
String dispMsg=request.getParameter("dispMsg");
if(!(dispMsg==null))
{
%>
<tr><td align="left"><font size="2" color="red"><b><%=dispMsg %></b></font></td></tr>
<%} %>
<tr><td></td></tr>
</table>
<table border="0" align="center" width="100%">
<tr><td align="center">

<form name="first" method="post" action="edittrans.jsp" onSubmit="return validate();">
<table align="center" width="100%">
<tr>
<td align="center">Transporter, Sending/Receiving Location</td>
<td align="center">	

	<select name="transporter" id="transporter" class="formElement" onchange="getTrans(this.value);">
	<option value="Select">Select</option>
<% 
	Statement stmt=conn.createStatement();
	String sql="select * from db_gps.t_transportermailid order by TransporterName asc" ;
   ResultSet rst3=stmt.executeQuery(sql);
    while(rst3.next())
    { %>
     <option value="<%=rst3.getString("TransporterName") %>"> <%=rst3.getString("TransporterName") %>(<%=rst3.getString("Category")%>) </option>
<%  } %>
        </select>
</td>
</tr>
<tr>
<td align="center">Transporter Code:</td>
<td align="center">


<textarea cols="15" rows="1" name="transEmail11" id="transEmail11" readonly="readonly"></textarea></td>


</tr>
<tr>
<td align="center">Edit Email-ID:</td>
<%
/*String sql1="select Email_Id from db_gps.t_transportermailid where TransporterName like 'test'" ;
ResultSet rst1=stmt.executeQuery(sql1);
if(rst1.next())
{
	email=rst1.getString("Email_Id");
}*/
%>
<td align="center"><textarea cols="50" rows="2" name="transEmail" id="transEmail"></textarea></td>


</tr> 
<tr>
<td align="center">Edit Rmemail-ID:</td>

<td align="center"><textarea cols="50" rows="2" name="transEmail1" id="transEmail1"></textarea></td>


</tr>
<tr>
<td align="center">Edit Trainer-ID:</td>
<td align="center"><textarea cols="50" rows="2" name="transEmail2" id="transEmail2"></textarea></td>


</tr>
<tr>
<td></td>
<td align="left"><input type="submit" value="Submit" /></td></tr>
</table>
</form>


</td></tr>
</table>



<%@ include file="footerhtml.jsp" %>