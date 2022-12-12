<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import=" java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>A Category Task</title>
<script src="sorttable.js" type="text/javascript"></script>
<link rel="stylesheet" href="../css/css.css" type="text/css" charset="utf-8" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.index_a_cat.action ="excel.jsp";
          document.forms["index_a_cat"].submit();
}
</script>
</head>
<%!Connection conn = null;
   Statement st = null;
%>
<%
String AcatTask = request.getParameter("AcatTask");
String frmDate = request.getParameter("frmDate");
String toTime = request.getParameter("toTime");
String user_id = request.getParameter("user_id");
String user_name = request.getParameter("user_name");

Class.forName("org.gjt.mm.mysql.Driver");
conn = DriverManager.getConnection("jdbc:mysql://115.112.36.134/dotproject","fleetview","1@flv");
st=conn.createStatement();

System.out.println("The AcatTask Tasks is :"+AcatTask);
System.out.println("The frmDate is :"+frmDate);
System.out.println("The toTime is :"+toTime);
System.out.println("The user_id is :"+user_id);
System.out.println("The username is :"+user_name);
%>
<body id="main_body" >
	
		
<%
	%>
	
	<div id="form_container"  style="width: 100%;" align ="center">
		
	<form id="index_a_cat" name="index_a_cat" method = "post">
	<%
         final String exportFileName="A_Category_Task_Report_of_"+user_name+"_Between_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate))+"_And_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toTime));  
	%>
	<table align="center" width="100%">
			<tr align="center">
				<td align="center">
					<font size="3"><b>A Category Task Report of <%= user_name %> Between <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(frmDate)) %> And <%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toTime)) %></b></font>
				</td>
			</tr>
		</table>
		
	<table width="100%" border="0" align="center">
			<tr>
				<td>
				 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
				 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
								<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
	                           <img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
	        	</td>
			</tr>
			
	</table>	
		
		<div align="center" style="width:100%; background-color: " id="table1">			
		<table width="100%"  align="center" class="sortable">	
		<tr style="">
		<th>Serial No</th>
		<th>Task ID</th>
		<th>Task Name</th>
		<th>Task Owner</th>
		<th> Task Start Date & Time</th>
		<th>Task Duration</th>
		<th>Task End Data & Time</th>
		<th>Task Percent Completed</th>
		</tr>
		<%
		int cnt = 0;
		String  task_id = "",task_name = "",task_owner = "",task_strtDateTime = "",Task_dur = "",taskEndDateTime = "",Task_per_com = "";
		String sql_total ="select * from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+frmDate+"' AND date(task_end_date)<='"+toTime+"'  and a.task_percent_complete=100 and hour(timediff(a.task_completion_date_time,a.task_end_date))<=24 ";
		ResultSet rs = st.executeQuery(sql_total);
		System.out.println("The query is ==>>"+sql_total);
		while(rs.next()){
			++cnt;
			task_id = rs.getString("task_id");
			task_name = rs.getString("task_name");
			task_owner = rs.getString("task_owner");
			task_strtDateTime = rs.getString("task_start_date");
			Task_dur = rs.getString("task_duration");
			taskEndDateTime = rs.getString("task_end_date");
			Task_per_com = rs.getString("task_percent_complete");
		
		
		%>
		<tr>
		<td align="right"><div align="right"><%= cnt %></div></td>
		<td align="right"><div align="right"><%= task_id %></div></td>
		<td align="left" ><div align="left"><%= task_name %></div></td>
		<td align="right"><div align="right"><%= task_owner %></div></td>
		<td align="right"><div align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(task_strtDateTime)) %></div></td>
		<td align="right"><div align="right"><%=  Task_dur %></div></td>
		<td align="right"><div align="right"><%= new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(taskEndDateTime))  %></div></td>
		<td align="right"><div align="right"><%= Task_per_com  %></div></td>
		</tr>
<%} %>		
		</table>
		</div>
			
	</form>	
	</div>	
	</body>
</html>