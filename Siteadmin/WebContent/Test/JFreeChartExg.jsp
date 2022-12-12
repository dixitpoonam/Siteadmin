<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.jfree.data.DefaultCategoryDataset"%><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <%
   // GenerateBarChat generate= new GenerateBarChat();
    String path=request.getRealPath("/")+"Test/3dbarchart.png";
    String Title="Score Bord";
    String ylable="UI 2142";
    String xlable="Count";
    String barName="UI ";
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();
    dataset.setValue(76.2,"Count", "SI ");
    dataset.setValue(239.3,"Count", "Tx");
    dataset.setValue(13.300,"Count","AVG delay");
    dataset.setValue(10.000,"Count", "Dist fact");
    dataset.setValue(4.7,"Count","ON");
    dataset.setValue(4.8,"Count","ER");
    

  //  generate.genrateBarChat(path,Title,ylable,xlable,barName,dataset);
    
    %>
        <IMG SRC="3dbarchart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart">
    </body>
</html> 