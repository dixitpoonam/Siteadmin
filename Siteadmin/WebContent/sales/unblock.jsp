<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<%!
String trans="",sql;
Statement st,st1;
String typeofuser,submit;
Connection conn;
%>
<%
typeofuser=request.getParameter("typevalue");

try
	{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);	
	st=conn.createStatement();
		st1=conn.createStatement();
		
		%>
		<center>
		<p>&nbsp;</p>

		
		<div><font color="Red" size="2">
		<%
		submit=request.getParameter("Yes");
		String username=session.getAttribute("username").toString();
		if(!(null==submit))
		{
			String sql1="select * from t_usermessage where UserTypeValue='"+typeofuser+"'";
			ResultSet rs=st.executeQuery(sql1);
			System.out.println(sql1);
			if(rs.next()){
				System.out.print("in next");
				String sql3="insert into t_usermessagehistory (UserTypeValue, MessageID, DisplayStatus,PaymentDate,Status,entby) values ('"+typeofuser+"', '"+rs.getString("MessageID")+"', 'Yes','"+rs.getString("PaymentDate")+"','Delete','"+username+"')";
				
				st1.executeUpdate(sql3);
				System.out.print(sql3);
			}
			sql="delete from t_usermessage where UserTypeValue='"+typeofuser+"'";
			st.executeUpdate(sql);
			out.print("User "+typeofuser+" Un-Blocked Successfully");
			
		}		
		%>
		</font>
		<br>
		<font color="brown" size="2">
		<form method="get" action="">
		Do you want to Un-Block User <%=typeofuser%>	
		<input type="hidden" name="typevalue" value="<%=typeofuser%>">
		<p>&nbsp;</p>


		<div align="center"><input type="submit" name="Yes" value="Yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="No" value="No" onClick="javascript:window.close();"></div>	
		</form>
		</font></div>		
		</center>		
		<%
	}
	catch(Exception e)
	{
		
	}finally
	{
		conn.close();
		}
	%>
	</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>