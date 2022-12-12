<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<script language="javascript">
function validate()
{
	if(document.getElementById("oldpass").value=="")
	{
		alert("Please Enter the old Password");
		return false;
	}
	if(document.getElementById("newpass").value=="")
	{
		alert("Please Enter the New Password");
		return false;
	}
	
	if(document.getElementById("renewpass").value=="")
	{
		alert("Please Enter the Re-Enter New Password");
		return false;
	}
	
	if(!(document.getElementById("newpass").value==document.getElementById("renewpass").value))
	{
		alert("New Password and Re-Entered Password is not matching");
		return false;
	}
	
	return true;
}
</script>
<br><br><br>
<%!
 Statement st;
Connection conn;
 String sql,oldpass,newpass,renewpass;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	if(!(null==request.getQueryString()))
	{
		oldpass=request.getParameter("oldpass");
		newpass=request.getParameter("newpass");
		renewpass=request.getParameter("renewpass");
		sql="update t_security set Password='"+newpass+"' where UserName='"+session.getAttribute("username").toString()+"'";
		int a=st.executeUpdate(sql);
		if(a>0)
		{
			%>
		<div align="center"><font color="brown" size="2">Password Changed Successfully !!</font></div>			
			<%
		}
		
	}
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
%>
<form name="form1" action="" method="get" onsubmit="return validate();">
<table border="0" width="100%" align="center">
<tr>
<td colspan="2" align="center" bgcolor="#2696B8"><font color="white">Change Password for <%=session.getAttribute("username").toString()%></font></td>
</tr>
<tr>
<td bgcolor="#f5f5f5" align="left">Old Password :</td>
<td bgcolor="#f5f5f5" align="left"><input type="password" name="oldpass" id="oldpass"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5" align="left">New Password :</td>
<td bgcolor="#f5f5f5" align="left"><input type="password" name="newpass" id="newpass"></td>
</tr>
<tr>
<td bgcolor="#f5f5f5" align="left">Re-Enter Password :</td>
<td bgcolor="#f5f5f5" align="left"><input type="password" name="renewpass" id="renewpass"></td>
</tr>
<tr>
<td colspan="2" align="center" bgcolor="#2696B8"><input type="submit" name="Submit" value="Submit"></td>

</tr>
</table>
</form>
<%                    
                    try{
                    }catch(Exception ff)
                    {
                    	out.print("footer Exception"+ff);
                    	
                    }
                    finally
                    {
                    	try{
                    		conn.close();
                    		//con1.close();
                    		//conn1.close();
                    			}
                    			catch(Exception ex)
                    			{}
                    }
                    %>
