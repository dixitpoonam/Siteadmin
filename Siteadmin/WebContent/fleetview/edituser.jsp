<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<%!
String trans="",sql;Connection conn;
Statement st,st1;
String username,fullname,typevalue,typeofuser,activestatus,idtype,expirydate,submit,oldactivestatus;

%>
<%
username=request.getParameter("username");
typevalue=request.getParameter("typevalue");
activestatus=request.getParameter("activestatus");
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	submit=request.getParameter("Submit");
	if(!(null==submit))
	{
		fullname=request.getParameter("fullname");
		typeofuser=request.getParameter("typeofuser");
		idtype=request.getParameter("idtype");
		expirydate=request.getParameter("expirydate");
		oldactivestatus = request.getParameter("oldactivestatus");
		if(activestatus == "Yes" || activestatus.equalsIgnoreCase("Yes"))
		{
			if(oldactivestatus == activestatus || oldactivestatus.equalsIgnoreCase(activestatus))
			{
				sql="update t_security set  FullName='"+fullname+"', TypeOfUser='"+typeofuser+"',ActiveStatus='"+activestatus+"',LoginInfo='"+idtype+"',ExpiryDate='"+expirydate+"' where UserName='"+username+"' and TypeValue='"+typevalue+"' and ActiveStatus ='"+oldactivestatus+"'";
				st.executeUpdate(sql);
				out.print("<div align='center'><font color='brown' size='2'>Record Updated Successfully.</font></div>");
			}
			else
			{
				String  sql1 = "select  * from t_security where UserName='"+username+"' and TypeValue='"+typevalue+"' and ActiveStatus ='Yes' ";
				ResultSet rs = st1.executeQuery(sql1);
				if(rs.next())
				{
					out.print("<div align='center'><font color='brown' size='2'>The username already exist with active status Yes</font></div>");
				}
				else
				{
					sql="update t_security set  FullName='"+fullname+"', TypeOfUser='"+typeofuser+"',ActiveStatus='"+activestatus+"',LoginInfo='"+idtype+"',ExpiryDate='"+expirydate+"' where UserName='"+username+"' and TypeValue='"+typevalue+"' and ActiveStatus ='"+oldactivestatus+"'";
					st.executeUpdate(sql);
					out.print("<div align='center'><font color='brown' size='2'>Record Updated Successfully.</font></div>");
				}
			}
			
	}
		else
		{
			sql="update t_security set  FullName='"+fullname+"', TypeOfUser='"+typeofuser+"',ActiveStatus='"+activestatus+"',LoginInfo='"+idtype+"',ExpiryDate='"+expirydate+"' where UserName='"+username+"' and TypeValue='"+typevalue+"' and ActiveStatus ='"+oldactivestatus+"'";
			st.executeUpdate(sql);
			out.print("<div align='center'><font color='brown' size='2'>Record Updated Successfully.</font></div>");
		}
		
	}
	
	
	sql="select  * from t_security where UserName='"+username+"' and TypeValue='"+typevalue+"' and ActiveStatus ='Yes' ";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
			fullname=rst.getString("FullName");
			typevalue=rst.getString("typevalue");
			typeofuser=rst.getString("typeofuser");
			activestatus=rst.getString("activestatus");
			idtype=rst.getString("LoginInfo");
			expirydate=rst.getString("ExpiryDate");
	}
}catch(Exception e)
{
	out.print("Exception ---->"+e);
}finally{
	conn.close();
}
%>
<p></p>
<p></p>
<table border="0" width="100%" align="center">
<tr><td bgcolor="#2696E8" align="center"><font color="white" size="2">Edit User <%=username%></font></td></tr>
<tr><td>
<form action="" method="get" name="form1">
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2">User Name :</font></td>
<td bgcolor="#f5f5f5"><font size="2"><input type="text" name="username" id="username" value="<%=username%>" readonly="readonly"></font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Full Name :</font></td>
<td bgcolor="#f5f5f5"><input type="text" name="fullname" id="fulllname" value="<%=fullname%>"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Group Name :</font></td>
<td bgcolor="#f5f5f5"><input type="text" name="typevalue" id="typevalue" value="<%=typevalue%>" readonly="readonly"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Type Of User:</font></td>
<td bgcolor="#f5f5f5">
<select name="typeofuser" id="typeofuser">
<option value="Transporter" <% if(typeofuser.equals("Transporter")){%>Selected<%}%> >Transporter</option>
<option value="GROUP" <% if(typeofuser.equals("GROUP")){%>Selected<%}%>>GROUP</option>
<option value="SUBUSER" <% if(typeofuser.equals("SUBUSER")){%>Selected<%}%>>SUBUSER</option>
</select>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Active Status :</font></td>
<td bgcolor="#f5f5f5">
<select name="activestatus" id="activestatus">
<option value="Yes" <% if(activestatus.equals("Yes")){%>Selected<%}%> >Yes</option>
<option value="No" <% if(activestatus.equals("No")){%>Selected<%}%>>No</option>
</select>
<input type="hidden" name="oldactivestatus" id="oldactivestatus" value = "<%=activestatus %>">
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Id Type :</font></td>
<td bgcolor="#f5f5f5">
<select name="idtype" id="idtype">
<option value="New" <% if(idtype.equals("New")){%>Selected<%}%> >New</option>
<option value="Old" <% if(idtype.equals("Old")){%>Selected<%}%>>Old</option>
</select>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Expiry Date :</font></td>
<td bgcolor="#f5f5f5"><input type="text" name="expirydate" id="expirydate" value="<%=expirydate%>">
<img src="../images/calendar.png" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "expirydate",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger" ,      // ID of the button
      showsTime	: "true"				// Allow Time Selection
    }
  );
</script>

</td>
</tr>
<tr>
<td bgcolor="#f5f5f5" colspan="2" align="center"><input type="submit" name="Submit" value="Submit"></td>
</tr>
</table>
</form>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>