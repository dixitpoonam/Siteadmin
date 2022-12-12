
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
String tripid=request.getParameter("tripid");


String StartPlace="", EndPlace="", longi="";

sql1="select * from db_gps.t_completedjourney where tripid='"+tripid+"' order by KmTravelled desc ";
System.out.print(sql1);

rs1=stmt1.executeQuery(sql1);
if(rs1.next())
{ 
	StartPlace=rs1.getString("StartPlace");
	out.println(StartPlace+"#");
	EndPlace=rs1.getString("EndPlace");
	out.println(EndPlace+"#");
	longi="Yes";
	
}else{
	
	out.println(StartPlace+"#");
	out.println(EndPlace+"#");
	longi="No";
}
out.println(longi+"#");
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






