<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat"
    import="java.util.Timer" import="java.util.TimerTask" 
    %>
<%@ include file="conn.jsp" %>
<%
String u_id=request.getParameter("uid");
String root_files=request.getParameter("root");
String root_id=request.getParameter("rootId");
String mob="";
String uname=session.getAttribute("username").toString();
String msg_type="JRM_ON Msg";
java.util.Date d12=new java.util.Date();  	
Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String now1= frt2.format(d12);

String vehreg="-",OwnerName="-";
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

try
{
Statement stmt=conn.createStatement();
Statement stmt3=conn.createStatement();


String sql1="select MobNo from t_unitmaster where UnitID='"+u_id+"'";
ResultSet rs=stmt.executeQuery(sql1);
while(rs.next())
{
	mob=rs.getString("MobNo");
}

String sql22="select VehicleRegNumber,OwnerName   from db_gps.t_vehicledetails where UnitID='"+u_id+"'";
ResultSet rs32=stmt3.executeQuery(sql22);
if(rs32.next())
{
	
	
	vehreg=rs32.getString("VehicleRegNumber");
	OwnerName=rs32.getString("OwnerName");
}

System.out.println("OwnerName==>"+vehreg);
System.out.println("OwnerName==>"+OwnerName);



}
catch(Exception e)
{
	out.println("Exception="+e);
}
%>
<%
	String sms="",flg1="N";
           
	try{
		
		
		sms="UI"+u_id+"#SET0010:0000,JRMON,"+root_files+","+root_id+"";
		sms=URLEncoder.encode(sms);
        System.out.println("now in send function"+sms);
        if(sms.contains("%23") || sms.contains("%3A") || sms.contains("%2C"))
		 {
			
		 
		 
			sms=sms.replace("%23","#"); 
			sms=sms.replace("%3A",":"); 
			sms=sms.replace("%2C"," "); 
			
			System.out.println(">>>Afeter onVersion>>>>>sms>>>"+sms);
			 
			 
		 }
		 
		 				 
		
		
		
		System.out.println(">>>Afeter ConVersion>Replacement>>>>sms>>>"+sms);
        
        
        String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to="+mob+"&message="+sms+"&gateway=regular";
 //		String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=vikram&sender=Demo&cdmasender=&to="+mob+"&message="+sms+"";

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
        Statement stmt2=conn.createStatement();
        
        String newmsg="insert into db_gps.t_serveralerts "+ 
		"(UnitID,Message,MobNo,SentStatus,EntryBy,MsgType,SenderID,VehicleRegNo,Transporter) values ("+
		"  '"+u_id+"','"+sms+"','"+mob+"','No','SiteAdmin-JRM','"+msg_type+"','"+uname+"','"+vehreg+"','"+OwnerName+"' )";
		System.out.println("sqlSentMessage===newmsg=>"+newmsg);
	stmt2.executeUpdate(newmsg);
	System.out.println("sqlSentMessage=RESET QUERY = after of installtiopn =newmsg=>"+newmsg);
        
        
        String sql2="insert into t_msgSentDetails(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time) values('"+u_id+"', '"+mob+"','"+sms+"','"+msg_type+"','"+uname+"','"+now1+"')";
        int i=stmt1.executeUpdate(sql2);
        
        %>
        <jsp:forward page="JrmOn.jsp">
        <jsp:param name="flag" value="Y"/>
        </jsp:forward>
        <% 
       
	} catch (Exception e) 
    {
        out.print("SMS Sending Exception --->"+e);
        %>
        <jsp:forward page="JrmOn.jsp">
        <jsp:param name="flag" value="N"/>
        </jsp:forward>
        <%
    }finally{
    	conn.close();
    }
	//	return "done";
	
%>