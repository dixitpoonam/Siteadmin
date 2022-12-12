
<%@ include file="conn.jsp" %>
<%!
Connection conn;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null,st2=null,st3=null;
try{
System.out.println("heloooooo ur hereee");
	st1=conn.createStatement();
	st2=conn.createStatement();
	String action=request.getParameter("action");
	
	String newlist=request.getParameter("newlist");
	String oldlist=request.getParameter("oldlist");
	String msg="-";
	String listcheck="Select * from t_testunits where unitlist='"+newlist+"'";
	ResultSet rs=st2.executeQuery(listcheck);
	if(rs.next())
	{
		msg="Group already present";
	}
	else if(action.equalsIgnoreCase("insert"))
	{
		
	String groupsql="INSERT INTO db_gps.t_testunits (unitlist)VALUES ('"+newlist+"')";
	System.out.println("update--->>"+groupsql);
	int i=st1.executeUpdate(groupsql);
	if(i>0)
		msg="Added Sucessfully";
	}
	else
	{
		String groupsql="Update t_testunits set unitlist='"+newlist+"' where unitlist='"+oldlist+"' ";
		System.out.println("update--->>"+groupsql);
		int i=st1.executeUpdate(groupsql);
		if(i>0)
			msg="Updated Sucessfully";
	}
	out.println(msg.trim()+"#");
	
	out.println("<select id='testunits' name='testunits'");
			out.println("<option value='Select'>Select</option>");
		String unitsql="Select * from t_testunits";
	ResultSet unitrst=st1.executeQuery(unitsql);
	while(unitrst.next())
	{
	
		out.println("<option value='"+unitrst.getString("unitlist")+"'>"+unitrst.getString("unitlist")+"</option>");
	} 
	
	out.println("</select>");
	out.println("#");
	
}catch(Exception ex){
	
	System.out.println("error"+ex);
}finally{
	conn.close();
}


%>