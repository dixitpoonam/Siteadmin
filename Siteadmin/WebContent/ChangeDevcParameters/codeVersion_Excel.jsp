<%@ page contentType="application/vnd.ms-excel;" language="java" import="java.util.*" import="java.sql.*" import="java.text.*"%>
<%
	response.setContentType("application/vnd.ms-excel");
	
	String filename="CodeVersion_Excel.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<html>
<body>
<%
String codeVersion="";
int vCnt=0;
int sr=0;
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st=conn.createStatement();
try{
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
String sql1="select count(*) as VerCnt, codeversion from db_gps.t_ftplastdump group by codeversion";
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
}}catch(Exception e){
	
}finally{
	conn.close();
}
%>
</table>
</body>

					