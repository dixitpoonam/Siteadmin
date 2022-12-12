<%@ page import="java.io.PrintWriter" %>  
<%@ page contentType="application/vnd.ms-excel" language="java" %>  
  
<%  
    String fileName =  request.getParameter("fileName");
    String CSV = request.getParameter("tableHTML");  
    response.reset();  
    response.setContentType("application/vnd.ms-excel");  
    response.setHeader("Content-Disposition","inline; filename ="+fileName);  
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Pragma", "public");
    response.setHeader("Cache-Control", "max-age=0");
    String mimeType = "application/vnd.ms-excel";
    response.setContentType(mimeType);	
    
    PrintWriter op = response.getWriter();  
    if (CSV == null)  
    {  
        CSV="NO DATA";  
    }  
    if (fileName == null)  
	{  
 	   CSV="NO FILE NAME SPECIFIED";  
	}  
  
op.write(CSV);  
%>  