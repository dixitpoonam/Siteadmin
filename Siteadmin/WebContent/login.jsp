<%@ include file="conn.jsp" %>
<%! 
String username, pass,sql;
Statement st,st1;

%>
<%
username=request.getParameter("username");
pass=request.getParameter("pass");
Connection conn;

Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select * from t_security where Username='"+username+"' and Password='"+pass+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		session.setAttribute("username",rst.getString("username"));
		session.setAttribute("role",rst.getString("TypeOfUser"));
		//sql="select * from t_links where UserName='"+username+"' and UserRole='"+rst.getString("TypeOfUser")+"' and MainPage='Yes'";
		sql="select * from t_links where UserRole='"+rst.getString("TypeOfUser")+"' and MainPage='Yes'";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{
			String mpage=SiteRoot+rst1.getString("PageName");
			session.setAttribute("mainpage",mpage);
			session.setAttribute("pagename",rst1.getString("Name"));
			response.sendRedirect(mpage);
			return;
		}
		else
		{
			response.sendRedirect("index.jsp?err=err1");
			return;
		}
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
