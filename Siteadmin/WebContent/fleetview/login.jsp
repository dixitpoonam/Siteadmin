<%@ include file="conn.jsp" %>
<%! 
String username, pass,sql;
Statement st;
Connection conn,conn1;
%>
<%
username=request.getParameter("username");
pass=request.getParameter("pass");


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	sql="select * from t_security where Username='"+username+"' and Password='"+pass+"' and (TypeOfUser='SuperAdmin' or TypeOfUser='FleetViewAdmin' or TypeOfUser='SoftwareAdmin')";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		session.setAttribute("username",rst.getString("username"));
		session.setAttribute("role",rst.getString("TypeOfUser"));
		response.sendRedirect("mainpage.jsp");
		return;
	}
	else
	{
		response.sendRedirect("index.jsp?err=err1");
		return;
	}
}catch(Exception e)
{
	out.print("Login Exception--->"+e);
}finally{
	conn.close();
}


%>
<%@ include file="footerhtml.jsp" %>