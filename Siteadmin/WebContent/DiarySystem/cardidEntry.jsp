<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="headerhtml.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
function validate()
{
	var cardid=document.cardidentryform.id.value;
	var ref=document.cardidentryform.ref.value;
	
	if(cardid=="")
	{
		alert("Please enter Card Id.");
		return false;
	}else{
			if(isNaN(cardid)){
					alert("Only numbers are allowed for CARD ID,Please enter valid CARD ID");
					return false;
				}
		}		

	if(ref=="")
	{
		alert("Please enter Card Reference No.");
		return false;
	}
}
</script>

</head>
<body>
<table border=0 align="center" width="100%">
  <tr><td align="center"><font color="brown" size="2"><b><i>Enter the Card Id</i></b></font></td></tr>
  <tr><td align="center">
  <%!
Statement stmt1;
String sql,sql1;
Connection conn1;
%>
<%
     if(request.getQueryString()!=null)
     {
          String msg=request.getParameter("inserted");
          out.println(msg);
     }
%>


<form name="cardidentryform" action="insrtCardID.jsp" onsubmit="return validate();">
 <table border="0" width="60%">
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Card ID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="id"/></td>
	</tr>
	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Card Reference: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <input type="text" name="ref"/> </td>
	</tr>
	<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit"/> </td>
	</tr>

 </table>
</form> 
  </td></tr>
</table>
</body>
</html>