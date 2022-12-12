<%@ page contentType="application/vnd.ms-excel;" language="java" import="java.util.*" import="java.sql.*" import="java.text.*"%>
<%
	response.setContentType("application/vnd.ms-excel");
	
	String filename="2ndLevelCodeVersion_Excel.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<html>
<body>
<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
String codeVersion=request.getParameter("codeversion");
int sr=0;
double rid=0,rmclat=0,rmclon;
String StoredDateTime="",Filedatetime="",FileName="",UnitID="",WMSN="",SimNo="",UnitType="",Server="",FromID="",ToID="",FTPServer="",Username="",Callno1="";
String CallNo2="",TXInterval="",StInterval="",CodeVersion="",FW="",RmcString="",APN="",rmcdate="",rmctime="",location="",IMEI_No="";
Statement st=conn.createStatement();
%>
<table  width="60%" align="center">
<tr><td style="text-align: center"><font color="brown"><b>Code Version Details</b></font></td>
<td align="right"><a href="2ndLevelCodeVersion_Excel.jsp?codeversion=<%=codeVersion%>" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %></td>
</tr>
</table>
<table border="1" width="60%" class="sortable" align="center">
			<tr>
				<th>Sr.</th>
				<th>rid</th>
				<th>StoredDateTime</th>
				<th>Filedatetime</th>
				<th>FileName</th>
				<th>UnitID</th>
				<th>WMSN</th>
				<th>SimNo</th>
				<th>UnitType</th>
				<th>Server</th>
				<th>FromID</th>
				<th>ToID</th>
				<th>FTPServer</th>
				<th>Username</th>
				<th>Callno1</th>
				<th>CallNo2</th>
				<th>TXInterval</th>
				<th>StInterval</th>
				<th>CodeVersion</th>
				<th>FW</th>
				<th>RmcString</th>
				<th>APN</th>
				<th>rmcdate</th>
				<th>rmctime</th>
				<th>rmclat</th>
				<th>rmclon</th>
				<th>location</th>
				<th>IMEI_No </th>
				

			</tr>
<%
try{
//String sql1="select * from db_gps.t_ftplastdump where codeversion='"+codeVersion+"' group by codeversion";
String sql1="select * from db_gps.t_ftplastdump where codeversion='"+codeVersion+"'";
ResultSet rs1=st.executeQuery(sql1);
while(rs1.next())
{
	sr++;
	rid=rs1.getDouble("rid");
	StoredDateTime=rs1.getString("StoredDateTime");
	Filedatetime=rs1.getString("Filedatetime");
	FileName=rs1.getString("FileName");
	UnitID=rs1.getString("UnitID");
	WMSN=rs1.getString("WMSN");
	SimNo=rs1.getString("SimNo");
	UnitType=rs1.getString("UnitType");
	Server=rs1.getString("Server");
	FromID=rs1.getString("FromID");
	ToID=rs1.getString("ToID");
	FTPServer=rs1.getString("FTPServer");
	Username=rs1.getString("Username");
	Callno1=rs1.getString("Callno1");
	CallNo2=rs1.getString("CallNo2");
	TXInterval=rs1.getString("TXInterval");
	StInterval=rs1.getString("StInterval");
	CodeVersion=rs1.getString("CodeVersion");
	FW=rs1.getString("FW");
	RmcString=rs1.getString("RmcString");
	APN=rs1.getString("APN");
	rmcdate=rs1.getString("rmcdate");
	rmctime=rs1.getString("rmctime");
	rmclat=rs1.getDouble("rmclat");
	rmclon=rs1.getDouble("rmclon");
	location=rs1.getString("location");
	IMEI_No=rs1.getString("IMEI_No");
%>
	<tr>
					<td style="text-align: left"><%=sr%></td>
					<td style="text-align: left"><%=rid%></td>
					<td style="text-align: left"><%=StoredDateTime%></td>
					<td style="text-align: left"><%=Filedatetime%></td>
					<td style="text-align: left"><%=FileName%></td>
					<td style="text-align: left"><%=UnitID%></td>
					<td style="text-align: left"><%=WMSN%></td>
					<td style="text-align: left"><%=SimNo%></td>
					<td style="text-align: left"><%=UnitType%></td>
					<td style="text-align: left"><%=Server%></td>
					<td style="text-align: left"><%=FromID%></td>
					<td style="text-align: left"><%=ToID%></td>
					<td style="text-align: left"><%=FTPServer%></td>
					<td style="text-align: left"><%=Username%></td>
					<td style="text-align: left"><%=Callno1%></td>
					<td style="text-align: left"><%=CallNo2%></td>
					<td style="text-align: left"><%=TXInterval%></td>
					<td style="text-align: left"><%=StInterval%></td>
					<td style="text-align: left"><%=CodeVersion%></td>
					<td style="text-align: left"><%=FW%></td>
					<td style="text-align: left"><%=RmcString%></td>
					<td style="text-align: left"><%=APN%></td>
					<td style="text-align: left"><%=rmcdate%></td>
					<td style="text-align: left"><%=rmctime%></td>
					<td style="text-align: left"><%=rmclat%></td>
					<td style="text-align: left"><%=rmclon%></td>
					<td style="text-align: left"><%=location%></td>
					<td style="text-align: left"><%=IMEI_No %></td>
					
	</tr>
<%	
}
}
catch(Exception e){out.println("Exception------>"+e);}
finally{
	conn.close();
}

%>
</table>
</body>
</html>