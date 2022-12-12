<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="headerhtml.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try{

	String date = request.getParameter("fromdate");
	String vehiclecode = request.getParameter("vehcode");
	String unitId = request.getParameter("unitid");
	String range = request.getParameter("range");
	String vehicleregnumber = request.getParameter("vehregnumber");
	String ownername = request.getParameter("ownername");
	int i=1;
	String TEMPLATE = "";
	if("zerotofifteen".equalsIgnoreCase(range)){
		TEMPLATE = " <= 15";
	}
	if("sixteentothirty".equalsIgnoreCase(range)){
		TEMPLATE = " > 15 and a.timediff <=30";
	}
	else if("thirtytosixty".equalsIgnoreCase(range)){
		TEMPLATE = " > 30 and a.timediff <=60";
	}
	else if("sixtyto120".equalsIgnoreCase(range)){
		TEMPLATE = " > 60 and a.timediff <=120";
	}
	else if("grtr120".equalsIgnoreCase(range)){
		TEMPLATE = "> 120";
	}
%>
<table width="100%" align="center" class="sortable" border="1">
<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr bgcolor="#2696B8">
				<th colspan="16" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="3"><b>The Data of unit <%=unitId %> on <%=date %>  <%=TEMPLATE %> min</b></font>
				<div align="right"><a href="exceldetaildatadelay.jsp?fromdate=<%=date%>&ownername=<%=ownername%>&vehregnumber=<%=vehicleregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=<%=range%>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div></th>
			</tr>
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Unit Id</td>
			</tr>
			<tr>
			<td colspan="4"><%=vehicleregnumber%></td>
			<td colspan="4"><%=vehiclecode %></td>
			<td colspan="4"><%=ownername%></td>
			<td colspan="3"><%=unitId%></td>
			</tr>
			</table>
			</td>
			</tr>
		<tr>
			<th>Sr No.</th>
			<th>Stamp</th>
			<th>Stamp Date-Time</th>
			<th>Processed Date-Time</th>
			<th>Processing Delay (In min)</th>
			<th>Raw Data Mail Date-Time</th>
			<th>Raw Data Stored Date-Time</th>
		
		</tr>
<%

	
	//System.out.println("--TEMPLATE---->"+TEMPLATE);
	Connection conn,conn1;
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmtvehicle=null,stmtvehcode=null,stmtMails=null;
	stmtvehicle=conn.createStatement();
	stmtvehcode = conn.createStatement();
	long stampdt=0,storeddt=0;
	String stampDateTime="", processedDateTime="", rawDataMailDateTime="", rawDataStoredDataDateTime="",stamp;
	String sqlvehcode ="select TheFiledTextFileName,Thefielddatadatetime,TheFieldDataStoredDate,TheFieldDataStoredTime,RDataMailDateTime,RDataStoredTime,timediff from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff,TheFiledTextFileName,Thefielddatadatetime,TheFieldDataStoredDate,TheFieldDataStoredTime,RDataMailDateTime,RDataStoredTime FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff  "+TEMPLATE;
	//System.out.println("--TEMPLATE---->"+sqlvehcode);
	ResultSet rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
	while(rsvehcode.next())
	{
		stamp = rsvehcode.getString("TheFiledTextFileName");
		stampDateTime = rsvehcode.getString("Thefielddatadatetime");
		processedDateTime = rsvehcode.getString("TheFieldDataStoredDate")+" "+rsvehcode.getString("TheFieldDataStoredTime");

		if(null==rsvehcode.getString("RDataMailDateTime") || "null".equalsIgnoreCase(rsvehcode.getString("RDataMailDateTime"))){
			rawDataMailDateTime = "-";
		}
		else{
			rawDataMailDateTime = rsvehcode.getString("RDataMailDateTime");
		}
		if(null==rsvehcode.getString("RDataStoredTime") || "null".equalsIgnoreCase(rsvehcode.getString("RDataStoredTime"))){
			rawDataStoredDataDateTime = "-";
		}
		else{
			rawDataStoredDataDateTime = rsvehcode.getString("RDataStoredTime");
		}
		
		%>
		<tr>
		<td align="right"><%=i++%></td>
		<td align="left"><%=rsvehcode.getString("thefiledtextfilename") %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsvehcode.getString("Thefielddatadatetime"))) %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsvehcode.getString("TheFieldDataStoredDate")+" "+rsvehcode.getString("TheFieldDataStoredTime"))) %></td>
		<td align="right"><%=rsvehcode.getString("timediff") %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rawDataMailDateTime)) %></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rawDataStoredDataDateTime)) %></td>
		</tr>
		<%
		
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
%>
</table>
</body>
</html>