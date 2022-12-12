<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
<%@ include file="conn.jsp" %>
<%
String u_id=request.getParameter("uid");
String sim_type=request.getParameter("sim");
String mob="";
String uname=session.getAttribute("username").toString();
String msg_type="APN Change Msg";
java.util.Date d12=new java.util.Date();  	
Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String now1= frt2.format(d12);
//-----------------------------------------
/*
String nwfrmtdte=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender1")));//format(new java.util.Date());
out.println("--------"+nwfrmtdte);*/
//-----------------------------------------
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
Statement stmt=conn.createStatement();
String sql1="select MobNo from t_unitmaster where UnitID='"+u_id+"'";
ResultSet rs=stmt.executeQuery(sql1);
while(rs.next())
{
	mob=rs.getString("MobNo");
}

}
catch(Exception e)
{
	out.println("Exception="+e);
}
%>
<%
	String sms="";
	try{
		
		sms="UI"+u_id+"#SET0009:0000,"+sim_type+",-,-,-";
		sms=URLEncoder.encode(sms);
        System.out.println("now in send function"+sms);
        
        String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to="+mob+"&message="+sms+"&gateway=regular";
    //String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=vikram&sender=Demo&cdmasender=&to="+mob+"&message="+sms+"";
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
         
        Statement stmt1=conn.createStatement();
      //  out.println("Unit ID="+u_id+", Mob No.="+mob+",Actual Msg="+sms+",Msg Type="+msg_type+",Sender ID="+uname+",Date_Time="+now1);
        String sql2="insert into t_msgSentDetails(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time) values('"+u_id+"', '"+mob+"','"+sms+"','"+msg_type+"','"+uname+"','"+now1+"')";
        int i=stmt1.executeUpdate(sql2);
        out.println("Message sent!");         
        %>
        <jsp:forward page="ApnChange.jsp">
        <jsp:param name="flag" value="Y"/>
        </jsp:forward>
        <% 

        
        
        //response.sendRedirect("Reset.jsp");
       
	} catch (Exception e) 
    {
        out.print("SMS Sending Exception --->"+e);
        %>
        <jsp:forward page="ApnChange.jsp">
        <jsp:param name="flag" value="N"/>
        </jsp:forward>
        <%
    }finally{
    	conn.close();
    }
	//	return "done";
	
%>