
<%@ include file="conn.jsp" %>
<%!
Connection conn;
%>
<%
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=conn.createStatement();
ResultSet rs1=null;
String sql1="";
String gethrs=request.getParameter("hrs");
String getmins=request.getParameter("mins");
String vehcode=request.getParameter("vehcode");
String seldte=request.getParameter("seldte");
String vehno=request.getParameter("vehno");
String time=gethrs+":"+getmins+":00";

String location="", latitu="", longi="";

sql1="select * from t_veh"+vehcode+" where TheFieldDataDate = '"+seldte+"' and TheFieldDataTime >= '"+time+"' limit 1";
System.out.print(sql1);

rs1=stmt1.executeQuery(sql1);
while(rs1.next())
{ 
	location=rs1.getString("TheFieldSubject");
	latitu=rs1.getString("LatinDec");
	longi=rs1.getString("LonginDec");
%>
	<table border="0" width="100%">
     	<tr>
		<td colspan="2" align="left"> <B> <font color="maroon"> Location at <%=gethrs%>:<%=getmins%> on <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(seldte))%>: </font>  
	<a href="shownewmap.jsp?lat=<%=latitu%>&long=<%=longi%>&discription=<%="<b>" + vehno + "</b><br>"%><%=location%>" onclick="popWin = open('shownewmap.jsp?lat=<%=latitu%>&long=<%=longi%>&discription=<%="<b>" + vehno + "</b><br>"%><%=location%>','myWin','width=500,height=500');popWin.focus();return false">  <%=location%> </a> </b> </td>
       </tr>		
</table>
<%
 
}

} catch(Exception e) {out.println(e);}

finally
{
	try{
		conn.close();
			}
			catch(Exception ex)
			{}
}

%>






