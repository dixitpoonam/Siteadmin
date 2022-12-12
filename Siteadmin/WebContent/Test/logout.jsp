<%@ include file="headerhtml.jsp" %>
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