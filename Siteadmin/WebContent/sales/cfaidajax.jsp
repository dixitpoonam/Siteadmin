


<%@ include file="conn.jsp" %>





<%!
Connection conn;
Statement st1;

%>
<% 
try {
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st1=conn.createStatement();

String sql="";

	String wtype=request.getParameter("wtype");
	System.out.println("***    "+wtype);

/*	if(wtype.equals("All") || wtype.equalsIgnoreCase("All"))
	{
		System.out.println("In If");
		 sql = "select distinct(Zonedesc) as Zonedesc from t_castrolzones where Type = 'CFA' order by Zonedesc Asc";	
		 System.out.println("***    "+sql);
		
	}*/
	//else{
		System.out.println("In Else");

	 sql = "select distinct(Zonedesc) as Zonedesc from t_castrolzones where Type = 'CFA' and Ownername='"+wtype+"' order by Zonedesc Asc";
	System.out.println("***    "+sql);
	//}
	ResultSet rs = st1.executeQuery(sql);
	%>
			<option value="Select">Select</option>
	
	<%
	while(rs.next())
	{
		%>
		
			<option value="<%=rs.getString("Zonedesc")%>">
			<%=rs.getString("Zonedesc")%></option>					
		<%
	}

	
	
	
}
catch(Exception e)
{
	e.printStackTrace();
}finally
{
	// st.close();
	conn.close();
}
%>




	