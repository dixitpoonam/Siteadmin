<%@page import="java.sql.Date"%>


<%@ include file="conn.jsp"%>

<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<%!
Connection con1;
Statement stmt;
%>

<%
	try	
	{
		System.out.println("in jsp page");
        String email=request.getParameter("UserName");
        System.out.println("email address==>"+email);
        //email="k_gawande@transworld-compressor.com";
        //System.out.println("email   "+email);
        String password=request.getParameter("Password");
        System.out.println("password==>"+password);
        try
        {
        	Class.forName(MM_dbConn_DRIVER);
        	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

        	stmt=con1.createStatement();
        	
        	String sqlinsert="";
        }catch(Exception e)
        {
        	System.out.println("exception"+e.getMessage());
        }
        	
              Properties props = new Properties();
              //String host="smtp.transworld-compressor.com";
              String host="a.mobileeye.in";
              String protocol="smtp";
              //String user="jd@mobile-eye.in"; 
              String user="jd@mobile-eye.in";
              String pass="transworld";
              props.put("mail.smtp.starttls.enable","true");
              props.put("mail.smtp.auth", "true");
              props.put("mail.smtp.user", "user");
              props.put("mail.smtp.password", "pass");  
              props.put("mail.store.protocol", protocol);
              props.put("mail.smtps.host", host);
              java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
              Session session1 = Session.getDefaultInstance(props, null);
              System.out.println("step1");
               // Construct the message
               Message msg = new MimeMessage(session1);
               msg.setSubject("User Name And Password for FleetView");
               msg.setSentDate(new java.util.Date());
               Address add1=new InternetAddress(email,"");
               msg.addRecipient(Message.RecipientType.TO,add1);
               Address fromAddress=new InternetAddress("jd@mobile-eye.in","transworld");  // in second "", it is short name
               msg.setFrom(fromAddress);
               System.out.println("step2");
               msg.setContent("Hello Sir/Mam,\n\n\t Your User Name and Password for www.myfleetview.com is as follows, \n User Name :-"+email+" \n Password :- "+password+" \n\n Note :- Please Change your password After first login. \n\n\n\t Thanks and Regards, \n\t Transworld Team" ,"text/plain"); 
               // Send the message
             String mailbody="<html><body>Hello Sir/Mam,<br/> Your User Name and Password for www.myfleetview.com is as follows,<br>  User Name :-"+email+" <br> Password :- "+password+"  <br/> Note :- Please Change your password After first login. <br/> Thanks and Regards,  Transworld Team</body></html>";
              String subject="User Name And Password for FleetView"; 
               
               Transport t = session1.getTransport("smtps");
               msg.saveChanges();
            	   System.out.println("step3");
            	  // t.connect(host, user, pass);
                  //  t.sendMessage(msg, msg.getAllRecipients());
                  
                  DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                 
                  
                
                  Calendar cal = Calendar.getInstance();

                  
                  String dt1=dateFormat.format(cal.getTime());
                		  
                 
				System.out.println("dt1==>"+dt1);
                  
                  
                  
                       String sqlinsert="insert into t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,MailStatus,SenderName,EntryDateTime) values ('Transworld Username and password','"+"-"+"','"+mailbody+"','"+subject+"','"+email+"','jd@twphd.in','Pending','avlsupport@mobile-eye.in','"+dt1+"')";//'jd@twphd.in'
					  
                       int num=stmt.executeUpdate(sqlinsert);
					  
					   System.out.println("insert query :- "+sqlinsert);	
					   
					   System.out.println("inserted successfully");					  
					             		 
                  		if(num>0)
                  		{
                  			out.println("Success");
                  		}
                  		else
                  		{
                  			out.println("<html><body>Exception</body></html>");
                  		}	
                    
                    System.out.println("step4");
              
               System.out.println("step5");
               //Transport.send(msg);
               System.out.println("step6");
               
               
			// out.print("Yes");
               //response.sendRedirect("mainpage.jsp?inserted=yes&ordrrno="+ordrrno);
               //return;  
               
               
       }
        catch(Exception e)
        {
        	
        	System.out.println("exception******* "+e.getMessage());
        	e.printStackTrace();
           //   out.println("Sorry, your mail cannot be sent due to Congestion");
           // out.print("Your message is not sent");
 
        }
  %>
 