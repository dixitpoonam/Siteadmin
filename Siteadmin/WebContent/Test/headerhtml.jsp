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

<link href="css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="js/sorttable.js"></script>
<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%
String role=(String)session.getAttribute("role");
%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" link="#333333" vlink="#333333" alink="#C0C0C0">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" bgcolor="#2696B8"><img src="images/L2_top1.gif" width="19" height="8"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="17%" height="76"> <div align="center"><img src="images/logo2.jpg"></div></td>
    <td width="48%">
      <p align="left"><font color="#333333" size="6" face="Impact"><img src="images/ind11.jpg"></font></p>
    </td>
    
    <td width="35%" valign="top">
   
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="top"> 
          <td width="23%" height="25"> <div align="right"><img src="images/L2_top2.gif" width="27" height="25"></div></td>
          <td width="77%" bgcolor="#31404E"><img src="images/L2_top5.gif" width="8" height="23"> </td>
        </tr>
        <tr><td colspan="2" align="center">
        <%
        
        //out.println("i do come here");
        System.out.println("i do come here");
        
			try{
					out.print("<b>Welcome </b>&nbsp;&nbsp;&nbsp;&nbsp;<font color='green'>"+session.getAttribute("username").toString()+"</font>");
					%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="logout.jsp">LogOut</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript: flase" title="Change Password" onclick="window.open('changepass.jsp','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')">Change Password</a><%
			
			}catch(Exception er)
			{
				response.sendRedirect("index.jsp?err=err2");
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
    <td valign="top" bgcolor="#2696B8"><img src="images/L2_top1.gif" width="19" height="8"></td>
  </tr>
</table>
<table width="100%" height="488" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="18%" height="488" valign="top"> 
      <table width="182" border="0" cellspacing="1" cellpadding="2">
        <tr> 
          <td height="22" valign="middle" bgcolor="#2696B8"> <div align="center" class="bodytxt"><strong><font color="#FFFFFF" size="2" face="Verdana">Menu</font></strong></div></td>
        </tr>
        <tr> 
          <td height="171" valign="top" bgcolor="#f5f5f5"><div align="center">
              <p align="left"><br>
              <font size="2" face="Verdana">
              &raquo; </font><strong><a href="<%=session.getAttribute("mainpage").toString()%>"><font face="Verdana" size="2"><%=session.getAttribute("pagename").toString()%></font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="fleetview/mainpage.jsp"><font face="Verdana" size="2">FleetView Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="DiarySystem/mainpage.jsp"><font face="Verdana" size="2"> DiarySystem Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="sales/mainpage.jsp"><font face="Verdana" size="2">Sales Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="billing/mainpage.jsp"><font face="Verdana" size="2">Billing Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="manageuser/mainpage.jsp"><font face="Verdana" size="2">Manage Users</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="MISReports/mainpage.jsp"><font face="Verdana" size="2">MIS Reports</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="Test/mainpage.jsp"><font face="Verdana" size="2">Test Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="TripMonitoring/mainpage.jsp"><font face="Verdana" size="2">TripMonitoring Admin</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="uploadTask.jsp"><font face="Verdana" size="2">Upload Task</font></a></strong><font size="2" face="Verdana"><br>
               &raquo; </font><strong><a href="castrolEmpViolationFilter.jsp"><font face="Verdana" size="2">Castrol Emp violation Filter</font></a></strong><font size="2" face="Verdana"><br>
                &raquo; </font><strong><a href="CastrolDistanceGapReport.jsp"><font face="Verdana" size="2">Castrol Distance Gap Report</font></a></strong><font size="2" face="Verdana"><br>
                 &raquo; </font><strong><a href="TaskIndexCalculation.jsp"><font face="Verdana" size="2">Task Index Report</font></a></strong><font size="2" face="Verdana"><br>
              <%if(role.equalsIgnoreCase("SoftwareAdmin") || role=="SoftwareAdmin") 
              {%>
              &raquo; </font><strong><a href="ReportTrack.jsp"><font face="Verdana" size="2">Report Name Entry</font></a></strong><font size="2" face="Verdana"><br>
               &raquo; </font><strong><a href="TWReportReg.jsp"><font face="Verdana" size="2">Register TW Report Name</font></a></strong><font size="2" face="Verdana"><br>
             &raquo; </font><strong><a href="ERPReport.jsp"><font face="Verdana" size="2">Register ERP Report Name</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="TWReportReg_diary.jsp"><font face="Verdana" size="2">Register Diary Report Name</font></a></strong><font size="2" face="Verdana"><br>
              &raquo; </font><strong><a href="SmartGridReport.jsp"><font face="Verdana" size="2">Register SmartGrid Report Name</font></a></strong><font size="2" face="Verdana"><br>
              <%} %>
              &raquo; </font><strong><a href="ChangeDevcParameters/mainpage.jsp"><font face="Verdana" size="2">ChangeDeviceParameter</font></a></strong><font size="2" face="Verdana"><br>
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
                  <p align="center"><b><font face="Verdana" size="2" color="#FFFFFF">Admin Module</font></b></td>
          </tr>
          <tr>
                <td height="11">
                  <div align="center">
                  
                  <!-- Code Comes Here -->
