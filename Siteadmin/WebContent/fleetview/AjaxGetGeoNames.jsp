<%@ include file="conn.jsp" %>
<%

Statement st,st1,st2;
%>
<%!
Connection conn;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
//System.out.println("Hii");
String owner=request.getParameter("owner");
String name="",code="",type="",trans="";
String lati="",longi=""; 
//System.out.println("owner "+owner);
String PageName=this.getClass().getName();
//System.out.println("PageName "+PageName);
String html="<html><body>";
html=html+"<table border='1' align='center' class='sortable' style='width: 100%'><tr><th align='center'><font size='2'>Location Name</font></th><th align='center'><font size='2'>Location Code</font></th><th align='center' ><font size='2'>Location Type</font></th></tr>";
//System.out.println(html);
String sql = "select WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,PolygonCoordinates,Radius from t_warehousedata where Owner like '"+ owner +"' and Latitude <> '0' and Longitude <> '0' order by WareHouse";
//System.out.println("sql "+sql);
ResultSet rs = st.executeQuery(sql);
int i=1;
while(rs.next())
{
	name=rs.getString("WareHouse");
	code=rs.getString("WareHouseCode");
	type=rs.getString("WType");
	trans=rs.getString("Owner");
	lati=rs.getString("Latitude");
	longi=rs.getString("Longitude");
	//System.out.println("!!!!!!!!!   "+longi);
	html=html+"<tr><td style='text-align: left;'><a href='javascript:toggleDetails("+i+",1,true);' title='Click To See the Reports'><font size='2'>"+name+"</font></a>"
					 +"<div class='popup'  id='popup"+i+"' style='display: none; position: absolute;'><table border='1' bgcolor='#9db5e5' cellpadding='1px' cellspacing='1px' style='width: 8em;'><tr><td><div  align='left'><a href='javascript:toggleDetails("+i+",2,false);'>Edit </a></div></td></tr>"
					 +"<tr><td><div align='left'><a href='javascript:toggleDetails("+i+",3,false);'>Delete </a></div></td></tr><tr><td><div align='left'><a href='javascript:toggleDetails("+i+",4,false);'>Close </a></div></td></tr></table></div>"
					 +"</td><td align='right'><div align='right'><font size='2'>"+code+"</font></div></td><td align='left'><div align='left'><font size='2'>"
					 +type+"</font></div></td></tr><input type='hidden' name='name"+i+"' id='name"+i+"' value='"+name+"'>"
					 +"<input type='hidden' name='code"+i+"' id='code"+i+"' value='"+code+"'><input type='hidden' name='type"+i+"' id='type"+i+"' value='"+type+"'><input type='hidden' name='trans"+i+"' id='trans"+i+"' value='"+trans+"'>"
					 +"<input type='hidden' name='lati"+i+"' id='lati"+i+"' value='"+lati+"'><input type='hidden' name='longi"+i+"' id='longi"+i+"'  value='"+longi+"'>";
     i++;
}
html=html+"</table></body></html>";
//System.out.println(html);

out.println(html);

}
catch(Exception e)
{
	System.out.println("Exception----------> "+e);
}
finally
{
	conn.close();
}
%>

