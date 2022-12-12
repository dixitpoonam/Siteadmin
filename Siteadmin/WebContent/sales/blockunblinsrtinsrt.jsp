<%@ include file="headerhtml.jsp" %>
<%!
Connection conn;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = conn.createStatement(), stmt2 = conn.createStatement(), stmt3 = conn.createStatement();
		ResultSet rs1=null, rs2=null;
		String sql1="", sql2="", sql3=""; 
		String trans="", msgid="";
		trans=request.getParameter("trans");
		String username=session.getAttribute("username").toString();
		msgid=request.getParameter("msgtyp");
		sql1="select * from t_usermessage where UserTypeValue='"+trans+"' ";
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			sql2="update t_usermessage set MessageId='"+msgid+"' where UserTypeValue='"+trans+"'";
			//out.print(sql2);	
			stmt2.executeUpdate(sql2);
			String PaymentDate=rs1.getString("PaymentDate");
			sql3="insert into t_usermessagehistory (UserTypeValue, MessageID, DisplayStatus,PaymentDate,Status,entby) values ('"+trans+"', '"+msgid+"', 'Yes','"+PaymentDate+"','Update','"+username+"')";
			//out.print(sql3);
			stmt3.executeUpdate(sql3);
		}
		else
		{
			int maxsrno=0;
			sql2="select max(SRNo) as maxsrno from t_usermessage";
			rs2=stmt2.executeQuery(sql2);
			if(rs2.next())
			{
				maxsrno=rs2.getInt("maxsrno");
			}
			maxsrno++;
			String today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			sql3="insert into t_usermessage (SRNo, UserTypeValue, MessageID, DisplayStatus,PaymentDate) values ('"+maxsrno+"', '"+trans+"', '"+msgid+"', 'Yes','"+today+"')";
			//out.print(sql3);
			stmt3.executeUpdate(sql3);
			sql3="insert into t_usermessagehistory (UserTypeValue, MessageID, DisplayStatus,PaymentDate,Status,entby) values ('"+trans+"', '"+msgid+"', 'Yes','"+today+"','Insert','"+username+"')";
			//out.print(sql3);
			stmt3.executeUpdate(sql3);
		}
		response.sendRedirect("setmessage.jsp?updated=successfull");
		return;

	}
	catch(Exception e)
	{ 
		out.println("Exception----->"+e); 
	}finally{
		conn.close();
	}

%>
<%@ include file="footerhtml.jsp" %>