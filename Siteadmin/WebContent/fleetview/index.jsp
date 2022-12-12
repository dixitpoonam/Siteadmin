<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="headerhtml.html" %>
<!-- All Code Comes Here -->
<script language="javascript">
	function validate()
	{
		if(document.getElementById("username").value=="")
		{
				alert("Please Enter User Name");
				return false;
		}
		if(document.getElementById("pass").value=="")
		{
				alert("Please Enter password");
				return false;
		}
		return true;
	}
</script>
                  
                    <table border="0" cellpadding="5" width="100%">
                      <tr>
                				<td>
                					<b>
                						<font face="Verdana" size="2">Transworld Admin Module
                						</font>
                					</b>
                				</td>
                      </tr>
                      <tr>
                				<td valign="top"> 
                					<p align="left">
                						<font face="Verdana" size="2">
                							Welcome to Transworld FleetView Admin Module.
                						</font>
                					</p>
            					</td>
                      </tr>
                      
                      <tr>
            					<td width="100%">
            					<form name="fleetviewlogin" action="login.jsp" method="post" onsubmit="return validate();">
						<table border="0" width="50%" align="center">
						<tr><td colspan="2" bgcolor="#2696B8">&nbsp;
						<%
						try{
						String msg=request.getParameter("err");
						if(msg.equals("err1"))
						{
							out.print("<font color='borwn'>Please enter currect user name and password</font>");
						}
						if(msg.equals("err2"))
						{
							out.print("<font color='borwn'>Session expired, please login again.</font>");
						}	
							
							}catch(Exception a)
							{
							}			
						%>						
						</td></tr>
						<tr><td  bgcolor="#f5f5f5">User Name :-</td><td  bgcolor="#f5f5f5"><input type="text" name="username" id="username"></td></tr>
						<tr><td  bgcolor="#f5f5f5">Password :-</td><td  bgcolor="#f5f5f5"><input type="password" name="pass" id="pass"></td></tr>
						<tr><td colspan="2" bgcolor="#2696B8" align="center"><input type="submit" name="Submit" value="Submit"></td></tr>					
						</table>            					
            				</form>	
            					</td>
                      </tr>
                     
                    </table>
                    
                   


<!-- All Code End Here -->
<%@ include file="footerhtml.html" %>