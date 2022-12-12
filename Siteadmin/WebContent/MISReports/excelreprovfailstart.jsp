<%@ page contentType="application/vnd.ms-excel; charset=gb2312" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"%>
<% response.setContentType("application/vnd.ms-excel");

String filename="repeatreprovdetails.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>

<%@ include file="conn.jsp" %>
<%!
Connection con1,conn;
%>
<%

try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement(), stmt2=conn.createStatement(), stmt3=conn.createStatement(), stmt4=conn.createStatement();
	ResultSet rs1=null, rs2=null, rs3=null, rs4=null;
	String sql1="", sql2="", sql3="", sql4="";
	
	String today="", sevdaybfre="", msg="";

	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	today = formatter.format(tdydte);

	java.util.Date tdydte1 = new java.util.Date();
	long ms=tdydte.getTime();
	ms=ms-1000 * 60 * 60 *24*1;
	tdydte1.setTime(ms);

	sevdaybfre = formatter.format(tdydte1);
	
	String firstdate=request.getParameter("thedate");
		
	if(firstdate==null)
	{
		msg="Data Status after Re-provision (since 2 days)";
	}
	else
	{
		String thedate1=request.getParameter("thedate1");
		sevdaybfre=firstdate;
		today=thedate1;

		msg="Data Status after Re-provision " + new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(sevdaybfre)) + " till " +new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));
	} 
%>

<table border="0" width="90%" align="center">
<tr>
    <td bgcolor="#f5f5f5" align="center"> <b> <font color="" size="2"> <%=msg%> </font> </b> </td>
    
</tr>
<tr>
    <td align="center">
    	<table border="0" width="100%" align="center">
	    <tr>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Sr No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Mobile No </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Reprovision Date </font> </td>
		<td align="center" bgcolor="#2696B8"> <font color="white" size="2"> Status </font> </td>
</tr>	
<%
	int j=1;
	double yes=0, no=0, i=0;
	sql1="select * from t_reprovisiondailynum where ondate between '"+sevdaybfre+"' and '"+today+"' and VehCode not in('','0','-') ";
	//out.print(sql1);
	rs1=stmt1.executeQuery(sql1);
	while(rs1.next())
	{ 
		String mobno=rs1.getString("MobileNo");
		String repdate=rs1.getString("ondate");
		String vehcode=rs1.getString("VehCode");
		
		try{
			sql3="select * from t_veh"+vehcode+" where TheFieldDataDate ='"+repdate+"' and TheFiledTextFileName='SI'";
			//out.print(sql3);
			rs3=stmt3.executeQuery(sql3);
			if(rs3.next())
			{ 
				yes++;
%>
				<tr>
					<td bgcolor="#f5f5f5"> <%=j%> </td>
					<td bgcolor="#f5f5f5"> <%=mobno%> </td>
					<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(repdate))%> </td>
					<td bgcolor="#f5f5f5"> Yes </td>
				</tr>
<%
			}
			else
			{ 
				no++;
%>
				<tr>
					<td bgcolor="#f5f5f5"> <%=j%> </td>
					<td bgcolor="#f5f5f5"> <%=mobno%> </td>
					<td bgcolor="#f5f5f5"> <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(repdate))%> </td>
					<td bgcolor="#f5f5f5"> No </td>
				</tr>
<%			
				
			}
		j++;
		i++;
		} catch(Exception e)
		{ %> 
			<tr>
				<td bgcolor="#f5f5f5" colspan="3"> NO RECORD FOUND</td>
			</tr>	
<%	 	}
				
	} //close of while

	double yesper=(yes/i)*100;
	double noper=(no/i)*100;

	NumberFormat nf1 = DecimalFormat.getNumberInstance();
	nf1.setMaximumFractionDigits(0);
	nf1.setMinimumFractionDigits(0);	
	nf1.setGroupingUsed(false);

	String totsntrepr=nf1.format(i);
	String totyes=nf1.format(yes);
	String totno=nf1.format(no);

	NumberFormat nf = DecimalFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);	
	nf.setGroupingUsed(false);

	String yesperstr=nf.format(yesper);
	String noperstr=nf.format(noper);
%>
	<table border="10" width="100%" align="center">
		<tr>		
			<td align="center" bgcolor="#2696B8"> <B> Total Sent for Re-Provision </B> </td>
			<td align="center" bgcolor="#2696B8" > <B> Count which sent data <br> on same date (Yes) </B> </td>
			<td align="center" bgcolor="#2696B8"> <B> Count which did not send <br> data on same date (No) </B></td>
			<td align="center" bgcolor="#2696B8"> <B> %age (Yes) </B> </td>
			<td align="center" bgcolor="#2696B8"> <B> %age (No) </B> </td>
		</tr>
		<tr>
			<td bgcolor="#f5f5f5"> <%=totsntrepr%> </td>
			<td bgcolor="#f5f5f5"> <%=totyes%> </td>
			<td bgcolor="#f5f5f5"> <%=totno%> </td>
			<td bgcolor="#f5f5f5"> <%=yesperstr%> </td>
			<td bgcolor="#f5f5f5"> <%=noperstr%> </td>
		</tr>
	</table>	
		
<%
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
finally{
	conn.close();
	con1.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>
</html>
