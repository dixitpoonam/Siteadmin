
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
<%@ include file="conn.jsp"%>
<%! 
Statement st,st1;
String sql;
String ss1="";
String uid="";
String fname="", version="";
%>
<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	st=conn.createStatement();
	st1=conn.createStatement();
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
%>
<%
try
{
		String mob="";
		uid=request.getParameter("uid");
		version=request.getParameter("version");
		fname=request.getParameter("filename");
/*		String sqlMob="select MobNo from t_unitmaster where UnitID='"+uid+"'";
		ResultSet rsMob=st.executeQuery(sqlMob);
		if(rsMob.next())
		{
			mob=rsMob.getString("MobNo");
		} 
	*/	
		mob="7875442833";
		try
		{
			String sms="";
			sms="#DOTA";
			sms=URLEncoder.encode(sms);
	        System.out.println("now in send function"+sms);
	        String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to="+mob+"&message="+sms+"&gateway=regular";
	        System.out.println("now in send function"+smsurl);
	        URL url=new URL(smsurl);
	        URLConnection connection = url.openConnection();
	        connection.connect();
	 		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	        String line;
	        while ((line = in.readLine()) != null )
	        {
	            System.out.println(line);
	           
	        }
	     
	        //======Insert Into DB==================================================================================
	        	String sqlInsert="insert into automizeDota(UnitID,VersionBeforeUpdt,DOTAFileName,smsSent) values('"+uid+"','"+version+"','"+fname+"','"+sms+"')";
	        	int i=st.executeUpdate(sqlInsert);
	        //========================================================================================
	     
	        %>
	        <jsp:forward page="updateDota.jsp">
	        <jsp:param name="flgStatus" value="Y"/>
	        </jsp:forward>
	        <%
    	    
		}
		catch(Exception e)
		{
			out.print("");
			%>
	        <jsp:forward page="smsDota.jsp">
	        <jsp:param name="flgStatus" value="N"/>
	        </jsp:forward>
	        <%
		}
		
		
}
catch(Exception e)
{
	out.print("");
}finally{
	conn.close();
}
%>

