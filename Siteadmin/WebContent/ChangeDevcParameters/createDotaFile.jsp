
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
    import="java.sql.Connection" import="java.sql.DriverManager" import="java.util.*" import="java.io.BufferedReader" import="java.io.InputStreamReader"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" import="java.io.File"
    import="java.io.*" import="com.jcraft.jsch.*" import="java.util.Properties"
    %>
<%@ include file="conn.jsp"%>
<%! 
Statement st,st1;
String sql;
String ss1="";
String uid="";
String vehVersion="";
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
		String wmsn="";
		uid=request.getParameter("uid");
		vehVersion=request.getParameter("vehVersion");
		System.out.println(uid);
		String sqlWMSN="select * from t_ftpdump where UnitID='"+uid+"' order by UnitID desc limit 1";
		System.out.println(sqlWMSN);
		ResultSet rsWMSN=st.executeQuery(sqlWMSN);
		if(rsWMSN.next())
		{
			wmsn=rsWMSN.getString("WMSN");
		}
		String fn="";
		try
		{
			//-----Create File To Copy-----------------------------------------------------------------
			try
			{
				File afile =new File("/home/sujata/Desktop/Vodafone_AVL_Ver_5pt05.wpb.dwl");
	    	//    fn="/home/sumedh/Desktop/"+wmsn+".wpb.dwl";
	    //		File afile =new File("/home/javaprg/newjar/Vodafone_AVL_Ver_5pt05.wpb.dwl");
	    //	    fn="/home/javaprg/newjar/"+wmsn+".wpb.dwl";
	    fn="/home/sujata/Desktop/"+wmsn+".wpb.dwl";
				File bfile =new File(fn);
	    	    InputStream inStream=new FileInputStream(afile);
	    	    OutputStream outStream =new FileOutputStream(bfile);
	    	    byte[] buffer = new byte[1024];
	    	    int length;
	    	    while ((length = inStream.read(buffer)) > 0)
	    	    {
	    	       	outStream.write(buffer, 0, length);
	    	    }
	    	    inStream.close();
	    	    outStream.close();
	    	    System.out.println("=================File Copied==================");
	    	    
			}
			catch(Exception e)
			{
				System.out.println("File Exception--------->>"+e);
			}
			//-----------------------------------------------------------------------------------------
			
	//======Copy File On FTP=======================================================================================		
			try
			{
				JSch jsch=new JSch();
				
				Session session1 = jsch.getSession("dota", "ftp.mobileeye.in");
		        
		        java.util.Properties config1 = new java.util.Properties(); 
	        	config1.put("StrictHostKeyChecking", "no");
	        	session1.setConfig(config1);
		        
		        session1.setPassword("ku45ma23");
		        session1.connect();

		        Channel channel = session1.openChannel("sftp");
		        ChannelSftp sftpChannel = (ChannelSftp) channel;
		        sftpChannel.connect();
		        System.out.println("==========Connected===============");
		        sftpChannel.put(fn, "/home/dota", ChannelSftp.OVERWRITE);
		        sftpChannel.exit();
		        session1.disconnect();
		        System.out.println("============File Uploaded=================");
				
			}
			catch(Exception e)
			{
				out.print("Session Exception--------->>"+e);
			}
	//=============================================================================================	
		//	File bfile =new File("ftp://dota@ftp.mobileeye.in/"+wmsn+".wpb.dwl");
	//	ftp://dota@ftp.mobileeye.in/700270044302405.wpb.dwl
	//		File bfile =new File(wmsn+".wpb.dwl");
	/*		File bfile =new File("test.txt"); 
    	    InputStream inStream=new FileInputStream(afile);
    	    OutputStream outStream =new FileOutputStream(bfile);
    //       OutputStream outStream =new FileOutputStream(afile);
    	    byte[] buffer = new byte[1024];
    	    int length=0;
    	    while ((length = inStream.read(buffer)) > 0)
    	    {
    	       	outStream.write(buffer, 0, length);
    	    }
    	    inStream.close();
    	    outStream.close();
    	    out.print("--------File Copied---------");
    	    */
    	   // s.disconnect();
    	    %>
	        <jsp:forward page="smsDota.jsp">
	        <jsp:param name="fileStatus" value="Y"/>
	        <jsp:param name="uid" value="<%=uid%>"/>
	        <jsp:param name="version" value="<%=vehVersion%>"/>
	        <jsp:param name="filename" value="<%=fn%>"/>
	        </jsp:forward>
	        <%
		}
		catch(Exception e)
		{
			out.print("File Exception---->>"+e);
			
		}
		
		
}
catch(Exception e)
{
	out.print("Exception------->>>"+e);
}finally{
	conn.close();
}
%>

