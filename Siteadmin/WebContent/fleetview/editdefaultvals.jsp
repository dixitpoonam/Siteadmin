<%@ include file="conn.jsp" %>
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<%!
String trans="",sql;Connection conn;
Statement st,st1;
int sokm,ossec,rakm,rdkm,stmin,cdmin,ddmin;
String ftime,ttime,what;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=conn.createStatement();
st1=conn.createStatement();
trans=request.getParameter("tran");
what=request.getParameter("what");

if(!(null==what))
{
	sokm=Integer.parseInt(request.getParameter("oslimit"));
	ossec=Integer.parseInt(request.getParameter("osduration"));
	rakm=Integer.parseInt(request.getParameter("ra"));
	rdkm=Integer.parseInt(request.getParameter("rd"));
	stmin=Integer.parseInt(request.getParameter("stoptime"));
	cdmin=Integer.parseInt(request.getParameter("cd"));
	ddmin=Integer.parseInt(request.getParameter("dd"));
	ftime=request.getParameter("nstopfrom");
	ttime=request.getParameter("nstopto");
	if(what.equals("update"))
	{
		sql="update t_defaultvals set overspeedlimit='"+sokm+"', overspeeddurationinsecs='"+ossec+"', accelerationspeedvarlimit='"+rakm+"', decelerationspeedvarlimit='"+rdkm+"', stoppagesgreaterthaninmins='"+stmin+"', continuousrunhrslimit='"+cdmin+"', disconnectedperiod='"+ddmin+"', nightdrivingfromtime='"+ftime+"', nightdrivingtotime='"+ttime+"' where OwnerName='"+trans+"'";
		st.executeUpdate(sql);
		out.print("<div align='center'><font color='red' size='2'>Record Updated Successfully</font></div>");
	}
	else
	{
		sql="insert into t_defaultvals (overspeedlimit,overspeeddurationinsecs,accelerationspeedvarlimit,decelerationspeedvarlimit,stoppagesgreaterthaninmins,continuousrunhrslimit,disconnectedperiod,nightdrivingfromtime,nightdrivingtotime,OwnerName) values ('"+sokm+"', '"+ossec+"', '"+rakm+"', '"+rdkm+"', '"+stmin+"', '"+cdmin+"', '"+ddmin+"','"+ftime+"', '"+ttime+"','"+trans+"')";
		st.executeUpdate(sql);
		out.print("<div align='center'><font color='red' size='2'>Record Updated Successfully</font></div>");

	}	
	
	
}
sql="select * from t_defaultvals where OwnerName='"+trans+"'";
ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	sokm=rst.getInt("overspeedlimit");
	ossec=rst.getInt("overspeeddurationinsecs");
	rakm=rst.getInt("accelerationspeedvarlimit");
	rdkm=rst.getInt("decelerationspeedvarlimit");
	stmin=rst.getInt("stoppagesgreaterthaninmins");
	cdmin=rst.getInt("continuousrunhrslimit");
	ddmin=rst.getInt("disconnectedperiod");
	ftime=rst.getString("nightdrivingfromtime");
	ttime=rst.getString("nightdrivingtotime");
	what="update";
}
else
{
sql="select * from t_defaultvals where OwnerName='Default'";
ResultSet rst1=st1.executeQuery(sql);
if(rst1.next())
{
	sokm=rst1.getInt("overspeedlimit");
	ossec=rst1.getInt("overspeeddurationinsecs");
	rakm=rst1.getInt("accelerationspeedvarlimit");
	rdkm=rst1.getInt("decelerationspeedvarlimit");
	stmin=rst1.getInt("stoppagesgreaterthaninmins");
	cdmin=rst1.getInt("continuousrunhrslimit");
	ddmin=rst1.getInt("disconnectedperiod");
	ftime=rst1.getString("nightdrivingfromtime");
	ttime=rst1.getString("nightdrivingtotime");
	what="insert";
}
}

}catch(Exception e)
{
	out.print("Exception---> "+e);
}finally{
	conn.close();
}
%>
<form name="editdefaultvals" method="get" action="">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#2696E8" align="center"><font color="white" size="2"><%=trans%></font></td></tr>
<tr><td>
<table border="0" width="100%" align="center">
<tr>
<td bgcolor="#f5f5f5"><font size="2">Over Speed Limit Km:</font></td>
<td bgcolor="#f5f5f5">
<input type="hidden" name="tran" id="tran" value="<%=trans%>">
<select name="oslimit" id="oslimit">
<%
for(int i=1;i<=150;i++)
{
%>
<option value="<%=i%>" <% if(i==sokm){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Over Speed Duration Sec:</font></td>
<td bgcolor="#f5f5f5">
<select name="osduration" id="osduration">
<%
for(int i=1;i<=25;i++)
{
%>
<option value="<%=i%>" <% if(i==ossec){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Rapid Acceleration in Km :</font></td>
<td bgcolor="#f5f5f5">
<select name="ra" id="ra">
<%
for(int i=1;i<=30;i++)
{
%>
<option value="<%=i%>" <% if(i==rakm){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Rapid Deceleration in Km :</font></td>
<td bgcolor="#f5f5f5">
<select name="rd" id="rd">
<%
for(int i=1;i<=30;i++)
{
%>
<option value="<%=i%>" <% if(i==rdkm){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Night Stop From :</font></td>
<td bgcolor="#f5f5f5"><input type="text" name="nstopfrom" id="nstopfrom" size="15" value="<%=ftime%>">
<img src="../images/calendar.png" id="trigger" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "nstopfrom",         // ID of the input field
      ifFormat    : "%H:%M:%S",     // the date format
      button      : "trigger" ,      // ID of the button
      showsTime	: "true"				// Allow Time Selection
    }
  );
</script>

</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Night Stop To :</font></td>
<td bgcolor="#f5f5f5"><input type="text" name="nstopto" id="nstopto" size="15" value="<%=ttime%>">
<img src="../images/calendar.png" id="trigger1" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "nstopto",         // ID of the input field
      ifFormat    : "%H:%M:%S",     // the date format
      button      : "trigger1",       // ID of the button
      showsTime	: "true"				// Allow Time Selection
    }
  );
</script>
</td>
</tr>
<tr>
<td bgcolor="#f5f5f5"><font size="2">Stop Time In Min. :</font></td>
<td bgcolor="#f5f5f5">
<select name="stoptime" id="stoptime">
<%
for(int i=1;i<=60;i++)
{
%>
<option value="<%=i%>" <% if(i==stmin){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>
</td>
</tr>

<tr>
<td bgcolor="#f5f5f5"><font size="2">Continuous Driving In Min. :</font></td>
<td bgcolor="#f5f5f5">
<select name="cd" id="cd">
<%
for(int i=1;i<=500;i++)
{
%>
<option value="<%=i%>" <% if(i==cdmin){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>

</td>
</tr>


<tr>
<td bgcolor="#f5f5f5"><font size="2">Device Disconnection Period In Min.:</font></td>
<td bgcolor="#f5f5f5">
<select name="dd" id="dd">
<%
for(int i=1;i<=11000;i++)
{
%>
<option value="<%=i%>" <% if(i==ddmin){ %>Selected<% } %> ><%=i%></option>
<%
}
%>
</select>

</td>

</tr>
<tr>
<td bgcolor="#f5f5f5" colspan="2" align="center">
<input type="hidden" name="what" id="what" value="<%=what%>">
<input type="submit" name="Submit" value="Submit"></td>
</tr>
</table>
</form>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
