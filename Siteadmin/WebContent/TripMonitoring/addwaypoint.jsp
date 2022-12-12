<%@ include file="headerhtml.jsp"%>

<html>
<%!
Connection conn;
%>
<%


String dd=request.getQueryString();
if(dd==null)
{
}
else
{
	String city, lat, lon, imgname, name, discription, user;
	lat=request.getParameter("lon");
	lon=request.getParameter("lat");
	name=request.getParameter("name");
	discription=request.getParameter("discription");
	user=session.getAttribute("usertypevalue").toString();
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	// Class.forName(MM_dbConn_DRIVER);
	//Connection conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=conn.createStatement();
	String sql2="insert into t_waypoints (Name, Lat, Lon, Discription, OwnerName) values('"+name+"','"+lat+"','"+lon+"','"+discription+"','"+user+"')";
	int rst2=st.executeUpdate(sql2);
	if(rst2<=0)
	{
		out.print("Error :Not Inserted");
	}
	else
	{
		response.sendRedirect("waypoint.jsp");
		return;
	}
}catch(Exception e)
{
	out.print("Exception "+e);
}finally{
	conn.close();
}
}
%>
</html>
