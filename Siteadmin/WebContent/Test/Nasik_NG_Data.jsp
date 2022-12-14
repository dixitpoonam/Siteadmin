<%@ include file="headerhtml.jsp" %>

<%!
Connection c;
Statement st;
String sql ,thedate;
int limit;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	c= DriverManager.getConnection("jdbc:mysql://172.16.8.17/db_avlalldata","fleetview","1@flv");
	st=c.createStatement();
	%>
	
<center>NASIK : NG STAMPS RECEIVED FROM UNITS IN LAST 2 HRS.</center>
	<%

		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table  border="0" width="100%" class="sortable" >
		<tr>
		<th>Sr no</th>
		<th>Unit Id</th>
		</tr>
		<%
		java.util.Date dt =new java.util.Date();
		long dateTimeInMilliseconds=dt.getTime();
		
		dateTimeInMilliseconds=dateTimeInMilliseconds-7200000;
		dt.setTime(dateTimeInMilliseconds);
		
		String mailTime=new SimpleDateFormat("HH:mm:ss").format(dt);
		out.println("(Since:  "+mailTime+"  )");

		
		thedate=new SimpleDateFormat("yyyy-MM-dd").format(dt);
		
		sql="SELECT distinct(unitid) FROM t_mails"+thedate.replace("-","_")+"Processed where body like ('%NG,%')   "+
		"	AND MailTime>'"+mailTime+"'	"+
		" AND unitid IN ( SELECT unitid from db_gps.t_vehicledetails where ownername like ('Nasik %') ) "+
		" ORDER BY unitid";
		
		ResultSet rst=st.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td  align="center"><b><%=i++  %></b></td>
			<td  align="center"><%=rst.getString("unitid")  %></td>
			</tr>
		<%
		}
		 
		%>
		
		 </table>
<%	
}catch(Exception e)
{
	 out.println("Exceptions ----->"+e);
}
finally
{
	try{
	c.close();
	}catch(Exception ee)
	{
		out.println("Exception-->"+ee);
	}
}
%>

