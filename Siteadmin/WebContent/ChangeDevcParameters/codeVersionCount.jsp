	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="headerhtml.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Code Version Count</title>
</head>
<body>
<%
String codeVersion="";
int vCnt=0;
int sr=0;
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=conn.createStatement();
%>
<table  width="60%" align="center">
<tr>
		<td style="text-align: center"><font color="brown"><b>Code Version Details</b></font></td>
		<td align="right">
		
		<a href="codeVersion_Excel.jsp" title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
					<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %>
		
		</td>
</tr>
</table>
<table border="1" width="60%" class="sortable" align="center">
			<tr>
				<th>Sr.</th>
				<th>Count</th>
				<th>Code Version</th>

			</tr>
<%
String sql1="select count(*) as VerCnt, codeversion from db_gps.t_ftplastdump where filedatetime>= '2012-01-01 00:00:00' group by codeversion ";
ResultSet rs1=st.executeQuery(sql1);
while(rs1.next())
{
	sr++;
	vCnt=rs1.getInt("VerCnt");
	codeVersion=rs1.getString("codeversion");
%>
	<tr>
					<td style="text-align: left"><%=sr%></td>
					<td style="text-align: left"><%=vCnt%></td>
					<td style="text-align: left"><a href="codeVersion2ndLevel.jsp?codeversion=<%=codeVersion%>"><%=codeVersion%></a></td>
					
	</tr>
<%	
}
conn.close();
%>
</table>
</body>
</html>