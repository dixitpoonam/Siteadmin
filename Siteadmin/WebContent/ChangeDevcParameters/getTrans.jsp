<%@ include file="conn.jsp" %>
<%
String tr,sql,email;
String rmemailid="",trainer="",trnscode="";
Statement st,st1,st2;
%>
<%!
Connection conn;
%>
<%
try
	{ 
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	tr=request.getParameter("Transporter");
	sql="select Email_Id,rmemailid ,trainer ,TransporterCode from db_gps.t_transportermailid where TransporterName like '"+tr+"'";
	ResultSet rst=st.executeQuery(sql);
	System.out.println(">>>>sql"+sql);
	
	if(rst.next())
	{
		email=rst.getString("Email_Id");
		rmemailid=rst.getString("rmemailid");
		trainer=rst.getString("trainer");
		trnscode=rst.getString("TransporterCode");
		
		
		
		
		
		out.print(email+"$"+rmemailid+"$"+trainer+"$"+trnscode);
		//out.print(rmemailid);
		//out.print(trainer);
	
		
	}
	//System.out.println(">>>>email"+email);
	//System.out.println(">>>>rmemailid"+rmemailid);
	//System.out.println(">>>>trainer"+trainer);

}catch(Exception e)
{
	out.print("Exception--->"+e);
	e.printStackTrace();
}
finally
{
	conn.close();
}

%>
