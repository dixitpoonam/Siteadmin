<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="headerhtml.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Code Version Count</title>
</head>
<body>
<%
try{
	session.invalidate();
	response.sendRedirect("../index.jsp");
}
catch(Exception e)
{
	out.print("Logout Exception--->"+e);
}

%>
<%@ include file="footerhtml.jsp" %>
</body>
</html>