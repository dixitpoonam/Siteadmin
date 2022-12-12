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
function downloadExcelFormat()  
{  
	     window.location = "Task_List_Format.xls";
         
}
/*function Editvalues() {

	var f = uploadTask.file.value;
//	alert(">>file"+f);
	window.open ("uploadTask1.jsp?filename="+f);
	
}*/
function confirmSubmit()
{
	//alert("hi");
	var user= document.getElementById("uploadedby").options[document.getElementById("uploadedby").selectedIndex].value;
	if(user=="select") {
			
			alert("Please select uploaded by!");
		return false;
		}
	
	var fup = uploadTask.file.value;
	var ext = fup.substring(fup.lastIndexOf('.') + 1);

//alert(">>"+fup+">>>>"+ext);
    if(ext =="xls")
    {
      // return true;
    }
    else
    {
        alert("Upload Excel file only");
        return false;
    }
	
var agree=confirm("Are you sure you wish submit this Task List?");
if (agree)
	return true ;
else
	return false ;
}
</script>
<%
Connection con = null;
Statement st = null;

			try {
				String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
				String MM_dbConn_USERNAME = "fleetview";
				String MM_dbConn_PASSWORD = "1@flv";
			//	String MM_dbConn_GPS = "jdbc:mysql://192.168.2.55/dotprojectfortesting"; 
				String MM_dbConn_GPS = "jdbc:mysql://115.112.36.134/dotproject"; 
			
				Class.forName(MM_dbConn_DRIVER);
				con = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
				st=con.createStatement();					
				System.out.println("===========conn created=============");			
			} catch (Exception e) {
				System.out.print("GetConnection Exception ---->" + e);
			}
%>

<form name="uploadTask" method="post" enctype="multipart/form-data" onsubmit="return confirmSubmit()" action="uploadTask1.jsp">

<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Upload Task</i></b></font></td></tr>
<tr></tr>
<tr>
<td>

<table border="0" align="center" width="70%">
<tr><td>
<table border="0" width="100%" align="center">
<tr>
<td align="right"  width="100%" colspan="2" ><font size="2"><b>Download Excel Format</b> </font>
<a href="#" style="font-weight: bold; color: black; " onclick="downloadExcelFormat();">
	                           <img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none" title="download excel format"></img></a>
</td>
</tr>

<tr>
<td  align="center" bgcolor="#f5f5f5" width="40%"><font size="2"><b>Uploaded By :</b></font></td><td align="left" bgcolor="#f5f5f5" width="60%">
	<div>
		<select class="element select medium" id="uploadedby" name="uploadedby" style="width: 130px; height: 25px;" > 
			<option value="select" >select</option>
			<%
            String query = "select DISTiNCT(user_username) as username  from dotproject.users where user_signature = 'M'";
			System.out.println("The query is :"+query);
             ResultSet rs = st.executeQuery(query);
             while(rs.next())
              {
%>
			<option value="<%=rs.getString("username") %>" ><%=rs.getString("username")%></option>
			<%} %>
			
		</select>
	</div> 
</td>
</tr>
<tr><td></td></tr>
</table>
<table border="0" width="100%" align="center">
<tr>
<td  align="center" bgcolor="#f5f5f5" width="40%"><font size="2"><b>Browse excel file :</b></font></td><td  align="left" bgcolor="#f5f5f5" width="60%">
	<INPUT NAME="file" id ="file" TYPE="file" size="20">
</td>
</tr>
<tr><td></td></tr>
<tr>
</table>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b><input type ="submit" name ="uploadexl" id="uploadexl" value="submit"/></b></font></td>
</tr>
</table>

<%
String msg=request.getParameter("msg");
System.out.println("The msg is :"+msg);
if(msg !=null) {
 %>
<table border="0" width="100%" align="center">
<tr>
<td  align="center" bgcolor="#f5f5f5"><font size="2"><b>File Uploaded successfully</b></font></td>
</tr>
</table>
<%}else{ %>
<table border="0" width="100%" align="center" >
<tr>
<td  align="center" bgcolor="#f5f5f5"><font size="2"><b>Please upload only excel files with proper format.</b></font></td>
</tr>
</table>
<%} %>
</table>
</td></tr>
</table>

</form>
