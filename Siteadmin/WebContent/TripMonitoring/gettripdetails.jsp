<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.GenerateKML" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String user="";
try
{
	 user=session.getAttribute("username").toString();
}catch(Exception e)
{
	response.sendRedirect("index.jsp");
}
	String dir=request.getRealPath("/");
	//String dir="/home/sujata/Desktop/KML";
	//System.out.println("dir--->"+dir);
	dir=dir+"KMLFiles/";
	System.out.println("dir--->"+dir);
	String tripid=request.getParameter("tripid");
	String start=request.getParameter("startloc");
	String end=request.getParameter("endloc");
	GenerateKML Gk=new GenerateKML();
	boolean flag=Gk.gettripdetails(tripid,dir,start,end,user);
	response.sendRedirect("GenerateKMLFiles.jsp?flag="+flag);

%>
</body>
</html>