<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="conn.jsp" %>
<html>
<head>
<title>Transworld Admin Module</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="keywords" Content="">
<meta name="description" Content="">
<STYLE>A:link {
	TEXT-DECORATION: none
}
A:visited {
	TEXT-DECORATION: none
}
</STYLE>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" link="#333333" vlink="#333333" alink="#C0C0C0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" bgcolor="#2696B8"><img src="../images/L2_top1.gif" width="19" height="8"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="17%" height="76"> <div align="center"><img src="../images/logo2.jpg"></div></td>
    <td width="48%">
      <p align="left"><font color="#333333" size="6" face="Impact"><img src="../images/ind11.jpg"></font></p>
    </td>
    
    <td width="35%" valign="top">
   
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top"> 
          <td width="23%" height="25"> <div align="right"><img src="../images/L2_top2.gif" width="27" height="25"></div></td>
          <td width="77%" bgcolor="#31404E"><img src="../images/L2_top5.gif" width="8" height="23"> </td>
        </tr>
        <tr><td colspan="2" align="center">
			<%
			try{
					out.print("Welcome &nbsp;&nbsp;&nbsp;&nbsp;<font color='green'>"+session.getAttribute("username").toString()+"</font>");
					%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp">LogOut</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript: flase" title="Change Password" onclick="window.open('../changepass.jsp','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')">Change Password</a><%
			}catch(Exception er)
			{
				response.sendRedirect("../index.jsp?err=err2");
				return;
			}			
			%>        
        </td></tr>
      </table>
      
      </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="23">
  <tr> 
    <td valign="top" bgcolor="#31404E" height="23"> 
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1">
  <tr>
    <td valign="top" bgcolor="#2696B8"><img src="../images/L2_top1.gif" width="19" height="8"></td>
  </tr>
</table>
<table width="100%" height="488" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="25%" height="488" valign="top"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="2">
        <tr> 
          <td height="22" valign="middle" bgcolor="#2696B8"> <div align="center" class="bodytxt"><strong><font color="#FFFFFF" size="2" face="Verdana">Menu</font></strong></div></td>
        </tr>
        <tr> 
          <td height="171" valign="top" bgcolor="#f5f5f5"><div align="center">
              <p align="left"><br>
              <font size="2" face="Verdana">
               &raquo; </font><strong><a href="<%=session.getAttribute("mainpage").toString()%>"><font face="Verdana" size="2">Home</font></a> </strong><font size="2" face="Verdana"><br>
               <%!
					Statement stlink;
					String sqllink;Connection conn12;					              
              %>
              <%
					try{
						Class.forName(MM_dbConn_DRIVER);
						conn12 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
						stlink=conn12.createStatement();
							sqllink="select * from t_links where  UserRole='"+session.getAttribute("role").toString()+"' and AccessStatus='Yes' and OnPage='mainpage' and ModuleName='tripmonitoring'";			
							ResultSet rstlink=stlink.executeQuery(sqllink);
							while(rstlink.next())
							{
							%>
							&raquo; </font><strong><a href="<%=rstlink.getString("pagename")%>"><font face="Verdana" size="2"><%=rstlink.getString("name")%></font></a> </strong><font size="2" face="Verdana"><br>
							<%
							}
					}catch(Exception e)
					{
						out.print("Link Exceptions---->"+e);
					}finally{
						conn12.close();
					}
              %>
              	</font> </span></div></td>
        </tr>
      </table>
      <br>
    </td>
    <td width="510" valign="top">
      <div align="center">
        <center>
        <table border="0" cellpadding="2" width="100%" cellspacing="1">
          <tr>
                <td bgcolor="#2696B8" height="22">
                  <p align="center"><b><font face="Verdana" size="2" color="#FFFFFF">Trip Monitoring  Admin Module</font></b></td>
          </tr>
          <tr>
                <td height="11">
                  <div align="center">
                  
                  <!-- Code Comes Here -->
