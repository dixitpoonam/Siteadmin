<%@ include file="headerhtml.jsp" %>

<script type="text/javascript">


onload=function()
{
	document.getElementById("trans").value="Select";
};

function Reload()
{
	//alert("Hej");  
    window.location.reload(); 
}

function toggleDetails(id,num,show)
{
	var name = document.getElementById("name"+id).value;
	var code = document.getElementById("code"+id).value;
	var type = document.getElementById("type"+id).value;
	var trans = document.getElementById("trans"+id).value;
    var lati=document.getElementById("lati"+id).value;
    var longi=document.getElementById("longi"+id).value;
    //alert("**********       "+longi);
	//alert(code);
	//alert(name);
	//alert(type);
//	alert(trans);
   //  alert(num);
	var popup = document.getElementById("popup"+id);
	//alert(popup);
	if(show) {
		popup.style.display = "";
		popup.setfocus();
	} else {
		popup.style.display = "none";
		if(num==2)
		{
			testwindow=window.open("EditGeofence.jsp?name="+name+"&code="+code+"&type="+type+"&trans="+trans+"&lati="+lati+"&longi="+longi,"Update","width=550,height=200,scrollbars=yes");
			testwindow.moveTo(500,250);	
			}
		if(num==3)
		{
			testwindow=window.open("deletegeofencing.jsp?name="+name+"&code="+code+"&type="+type+"&trans="+trans,"Delete","width=550,height=200,");	
			testwindow.moveTo(500,250);	
		}
	}
	
}


function getNames()
{

	var owner=document.getElementById("trans").value;
	//alert("######## "+owner);

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
		  try{
	 // alert(xmlhttp.readyState);
	 // alert(xmlhttp.responseText);
	  document.getElementById("div1").innerHTML=xmlhttp.responseText;
	  //alert(document.getElementById("div1").innerHTML);
		  }catch(e)
		  {
			  alert(e);
		  }
	  }
	};

	xmlhttp.open("GET","AjaxGetGeoNames.jsp?owner="+owner,true);
	xmlhttp.send(null);


}

function openpopup()
{
	testwindow=window.open("geofencelocation.jsp","Add","width=600,height=350,scrollbars=yes");
	testwindow.moveTo(500,250);	
}
</script>


<form name="displaygeofence" method="get" >

<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Geofence Location</i></b></font></td></tr>
<tr><td align="right"><a href="javascript:openpopup();"><font  size="2">Add Geofence</font></a></td></tr>
<tr>
<td>
<%!
	Statement st;
	String sql; 
	Connection conn;
%>
<%
	try
		{ 
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		String PageName=this.getClass().getName();
		System.out.println("PageName "+PageName);
		%>
<table border="0" width="80%" align="center">
<tr>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>Transporter / Group :</b></font></td><td bgcolor="#f5f5f5" align="center">
	<select name="trans" id="trans" onchange="getNames();">
	<option value="Select">Select</option>
	<%
	sql="select TypeValue from(select distinct FullName as TypeValue from t_security where TypeOfUser <> 'SUBUSER' union select distinct(GPName) as TypeValue from t_group where SepReport='Yes')y order by TypeValue Asc";
	//select distinct(TypeValue) as TypeValue from t_security where TypeOfUser in ('Transporter','GROUP') order by TypeValue";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	%>
	<option value="<%=rst.getString("TypeValue")%>"><%=rst.getString("TypeValue")%></option>	
	<%
	}	
	%>
	</select>
</td>
<br>
</tr>
<tr>

<td align="center" colspan="2">
<br>
<div id="div1">

</div>
</td>
</tr>
</table>
<%
	}catch(Exception e)
	{
		out.print("Exception --->"+e);
	}finally{
		st.close();
		conn.close();
	}
%>
</td>
</tr>
</table>


</form>
