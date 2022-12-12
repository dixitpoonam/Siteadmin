<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.*" %>

<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.indexcalc.action ="excel.jsp";
          document.forms["indexcalc"].submit();
}
function confirmSubmit() {

	var dept = document.getElementById("dept").options[document.getElementById("dept").selectedIndex].value;
	if(dept=="select") {
			
			alert("Please select Department!");
		return false;
	}
	
}
</script>

<%
Statement st = null;
Statement stt = null;
Statement sta = null;
Statement stb = null;
Statement stc = null;
Statement std = null;
Statement st_up = null;
Statement st_up1 = null;
Statement st_user_id = null;

try {
		Connection conn = null;
		
		String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME = "fleetview";
		String MM_dbConn_PASSWORD = "1@flv";
		String MM_dbConn_GPS = "jdbc:mysql://115.112.36.134/dotproject";            

		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st=conn.createStatement();
		stt=conn.createStatement();
		sta=conn.createStatement();	
		stb=conn.createStatement();	
		stc=conn.createStatement();
		std=conn.createStatement();	
		st_up=conn.createStatement();	
		st_up1=conn.createStatement();	
		st_user_id=conn.createStatement();	
		System.out.println("===========connection created=============");
	
	} catch (Exception e) {
		System.out.print("GetConnection Exception ---->" + e);
	}
%>
<%

String datenew1="";
String datenew2="";
String date1 = "";
String date2 = "";
String dept = "";
String user_id1 = "";
String tDate1 = "";
String tDate2 = "";

datenew1 = request.getParameter("from_date1");
datenew2 = request.getParameter("to_date1");
dept = request.getParameter("dept");

System.out.println("==datenew1=="+datenew1+">>datenew2"+datenew2);

if(datenew1==null){
	
		System.out.println("==in if==");
		datenew1 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		datenew2 = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
		
		tDate1 = datenew1;
		tDate2 = datenew2;
}
else{
	System.out.println("==in else==");
	 date1 = datenew1;
	 date2 = datenew2;
	 
	 	tDate1 = date1;
		tDate2 = date2;
	
		//select the user_ids from active_users table
		int cnt = 0;
		String sql_active = "select user_id from dotproject.active_users where department = '"+dept+"' and Active_Status = 'Yes'";
		ResultSet rs_active = st_user_id.executeQuery(sql_active);
		while(rs_active.next()){
			++cnt;
			if(cnt == 1)
			{
				user_id1 = rs_active.getString("user_id");
			}else
			{
				user_id1 = user_id1 +","+ rs_active.getString("user_id");
			}
			
		}
		
/*	 if(dept == "Software" || dept.equals("Software")) {
		 user_id1 = "(49,51,59,64,70,72,75,76,77,78,82,83)";
	 }else{
		 user_id1 = "(28,60,62,66,67,74,79,80,81,84,85)";
	 } */
}

 
		DateFormat df123= new SimpleDateFormat("dd-MMM-yyyy");
		DateFormat df1234= new SimpleDateFormat("yyyy-MM-dd");
		String dataDate1=df1234.format(df123.parse(datenew1));
		String dataDate2=df1234.format(df123.parse(datenew2));
		int counter=0;
		
%>

<form name="indexReport" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Task Index Report Between <%= tDate1%> And <%=tDate2 %></i></b></font></td></tr>
<tr></tr>
<tr>
<td>
<br>
<table border="0" width="60%" align="center">
<tr>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>Department</b></font></td>
<td>
		<div >
			<select class="element select medium" id="dept" name="dept" style="width: 100px; height: 25px;">
			<%if(dept != null) { 	
				%><option value="select">select</option><%
			}else{
				 %><option value="select" selected>select</option><%
				 %><option value="Software">Software</option><%
				 %><option value="RnD">RnD</option><%
				
			}
			if(dept != null){
			if(dept.equals("Software") || dept == "Software") {	
				 %><option value="Software" selected>Software</option><%
				}else{System.out.println("in else s");
					 %><option value="Software">Software</option><%
				}
			
			if(dept.equals("RnD")) {		
				 %><option value="RnD" selected>RnD</option><%
				}else{
					 %><option value="RnD">RnD</option><%
				}
			}	
		     %>     		      
		      </select>
		</div> 
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>From Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">

			<input type="text" id="data" name="from_date1" size="12" value="<%=datenew1%>" 
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;"readonly />
			<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "data"       // ID of the button
					    }
					  );
				</script>

		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><b>To Date</b></font></td>
<td bgcolor="#f5f5f5" align="center"><font size="2">
		
			<input type="text" id="data1" name="to_date1" size="12" value="<%=datenew2%>"
			style="width: 90px; height: 20px; padding: 4px 5px 2px 5px; border: 1px solid #DEDEDE; background: #FFFFFF; font: normal 11px Arial, Helvetica, sans-serif; background: #C6DEFF;" readonly />
				<script type="text/javascript">
					  Calendar.setup(
					    {
					      inputField  : "data1",         // ID of the input field
					      ifFormat    : "%d-%b-%Y",    // the date format
					      button      : "trigger1"       // ID of the button
					    }
					  );
				</script>
		
		</font>
</td>
<td bgcolor="#f5f5f5" align="center"><font size="2"><input type="submit" name ="sub" id ="sub" value="submit" style="background-color:#f5f5f5; "></input></font></td>
</tr>
</table>
</table>
</form>



<%
DecimalFormat df = new DecimalFormat("0.00");
String fromDate = request.getParameter("from_date1");
String toDate = request.getParameter("to_date1");
	
	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
if(fromDate !=null && toDate !=null) {
	
	fromDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromDate));
	toDate = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(toDate));
	
	System.out.println("The from Date is :"+fromDate);
	System.out.println("The to Date is :"+toDate);
	
	String fromDTime =fromDate+" 00:00:00";
	String toDTime =toDate+" 00:00:00";
	
	System.out.println("The from Date Time is :"+fromDTime);
	System.out.println("The to Date time is :"+toDTime);
%>

<form id="indexcalc" name="indexcalc" method="post" >
<%
         final String exportFileName="Task_Index_Report_Between_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDTime))+"_And_"+new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDTime))+".xls";  
%>
<table width="85%" border="0" align="center">
		<tr>
			<td>
			 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
        	</td>
		</tr>
		
</table>

<div style="width:85%;" align="center" id="table1" >
<table border="0" width="100%" align="center" class = "sortable">

<tr >
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Sr<br>No</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">User<br>Name</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Total<br>Tasks</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">A<br>Category</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">B<br>Category</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">C<br>Category</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">D<br>Category</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">A<br>Category %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">B<br>Category %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">C<br>Category %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">D<br>Category %</font></th>
<th bgcolor="#f5f5f5"><font size="2" face="Arial" color="black">Performance<br>Index %</font></th>
</tr>
<%
try{
	
int count =0;

String sql = "Select user_id, user_username from dotproject.users where user_id in ("+user_id1+") order by user_username ASC";
ResultSet rs = st.executeQuery(sql);
System.out.println("The query is ==>>"+sql);
while(rs.next()) {
	
		String user_id = rs.getString("user_id");
		String user_name = rs.getString("user_username");
		
	//	int cnt = 0;
				//update the task_completion_date_time field table
				String sql_up ="select a.task_id,a.task_completion_date_time,c.task_log_date from dotproject.tasks a, dotproject.user_tasks b,dotproject.task_log c where a.task_id=b.task_id AND b.task_id = c.task_log_task and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"' AND a.task_completion_date_time = '0000-00-00 00:00:00' ";
				ResultSet rsup = st_up.executeQuery(sql_up);
		//		System.out.println("The query is ==>>"+sql_up);
				while(rsup.next()){
				//++cnt;
					String task_completion_date_time = "";
					String task_id = rsup.getString("task_id");
					try{
						 task_completion_date_time = rsup.getString("task_completion_date_time");
					}catch(Exception e){
						task_completion_date_time = "NA";
					}
					String task_log_date = rsup.getString("task_log_date");
					
			//		System.out.println(">>>>>>>>>"+cnt+">>>>>>>>The Task id is :"+task_id+ "task_completion_date_time :"+task_completion_date_time+" task_log_date "+task_log_date);
					
					//update the completeion date time field
					String sql_up1 ="update dotproject.tasks SET task_completion_date_time = '"+task_log_date+"' where task_id = '"+task_id+"' ";
					int k = st_up1.executeUpdate(sql_up1);
		//			System.out.println("Query =>"+sql_up1);
					System.out.println("The recorded updated is ==>>"+k);
					
					
				}
				
		
				double total_task = 0.0,a_cat = 0.0, b_cat = 0.0, c_cat = 0.0, d_cat = 0.0; double a_cat_per = 0.0,b_cat_per = 0.0, c_cat_per = 0.0,d_cat_per = 0.0,per_index = 0.0;
				
				String sql_total ="select count(*) as total_tasks from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"' ";
				ResultSet rst = stt.executeQuery(sql_total);
		//		System.out.println("The query is ==>>"+sql_total);
				if(rst.next()){
		
			  		total_task = rst.getInt("total_tasks");
				}
			
				
				//calculate the a cat task
				String sql_a = "select count(*) as a_cat from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"'  and a.task_percent_complete=100 and hour(timediff(a.task_completion_date_time,a.task_end_date))<=24 ";
				ResultSet rsa = sta.executeQuery(sql_a);
			//	System.out.println("The query is ==>>"+sql_a);
				if(rsa.next()){
				
					a_cat = rsa.getInt("a_cat");
				}
				
				//calculate the b cat task
				String sql_b = "select count(*) as b_cat from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"' and a.task_percent_complete=100 and hour(timediff(a.task_completion_date_time,a.task_end_date))>24 and hour(timediff(a.task_completion_date_time,a.task_end_date))<=144 ";
				ResultSet rsb = stb.executeQuery(sql_b);
		//		System.out.println("The query is ==>>"+sql_b);
				if(rsb.next()){
				
					b_cat = rsb.getInt("b_cat");
				}
			
				//calculate the c cat task
				String sql_c = "select count(*) as c_cat from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"'  and a.task_percent_complete=100 and hour(timediff(a.task_completion_date_time,a.task_end_date))>144";
				ResultSet rsc = stc.executeQuery(sql_c);
			//	System.out.println("The query is ==>>"+sql_c);
				if(rsc.next()){
				
					c_cat = rsc.getInt("c_cat");
				}
			
				//calculate the d cat task
				String sql_d = "select count(*) as d_cat from dotproject.tasks a, dotproject.user_tasks b where a.task_id=b.task_id and user_id='"+user_id+"' and date(task_end_date)>='"+fromDTime+"' AND date(task_end_date)<='"+toDTime+"' and a.task_percent_complete<>100 ";
				ResultSet rsd = std.executeQuery(sql_d);
			//	System.out.println("The query is ==>>"+sql_d);
				if(rsd.next()){
				
					d_cat = rsd.getInt("d_cat");
				}
				
				
				
				//get the percentage parameters
				if(total_task >0) {
					 
					 a_cat_per = (a_cat * 100 / total_task);
				 }else{
					 
					 a_cat_per = 0.0;
				 }
				
				 if(total_task >0) {
					 
					 b_cat_per = (b_cat * 50 / total_task);
				 }else{
					 
					 b_cat_per = 0.0;
				 }
				 
				if(total_task >0) {
					 
					 c_cat_per = (c_cat * 25 / total_task);
				 }else{
					 
					 c_cat_per = 0.0;
				 }
				if(total_task >0) {
					 
					 d_cat_per = (d_cat * 0 / total_task);
				 }else{
					 
					 d_cat_per = 0.0;
				 }
				
				// calculate the total index
				
				per_index = a_cat_per + b_cat_per + c_cat_per + d_cat_per;
			
			//set all the values to report
			%>
			<tr>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%= ++count%></div> </td>
			<td bgcolor="#f5f5f5" align="left"><div align="left"><%= user_name%></div></td>
			<%if(total_task > 0) {  %>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="#" onclick="window.open('showTotalTaskInIndexReport.jsp?totalTask=<%=(int)total_task%>&frmDate=<%= fromDTime%>&toTime=<%= toDTime%>&user_id=<%=user_id %>&user_name=<%= user_name%>','mywindow','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 '); "><%= (int)total_task%></a></div></td>
			<%} else {%>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><%= (int)total_task%></div></td>
			<%} %>
			<%if(a_cat > 0) {  %>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="#" onclick="window.open('showAcatTaskInIndexReport.jsp?AcatTask=<%=(int)a_cat%>&frmDate=<%= fromDTime%>&toTime=<%= toDTime%>&user_id=<%=user_id %>&user_name=<%= user_name%>','mywindow','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 '); "><%= (int)a_cat%></a></div></td>
			<%} else {%>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><%= (int)a_cat%></div></td>
			<%} %>
			<%if(b_cat > 0) {  %>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="#" onclick="window.open('showBcatTaskInIndexReport.jsp?BcatTask=<%=(int)b_cat%>&frmDate=<%= fromDTime%>&toTime=<%= toDTime%>&user_id=<%=user_id %>&user_name=<%= user_name%>','mywindow','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 '); "><%= (int)b_cat%></a></div></td>
			<%} else {%>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><%= (int)b_cat%></div></td>
			<%} %>
			<%if(c_cat > 0) {  %>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="#" onclick="window.open('showCcatTaskInIndexReport.jsp?CcatTask=<%=(int)c_cat%>&frmDate=<%= fromDTime%>&toTime=<%= toDTime%>&user_id=<%=user_id %>&user_name=<%= user_name%>','mywindow','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 '); "><%= (int)c_cat%></a></div></td>
			<%} else {%>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><%= (int)c_cat%></div></td>
			<%} %>
			<%if(d_cat > 0) {  %>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><a href="#" onclick="window.open('showDcatTaskInIndexReport.jsp?DcatTask=<%=(int)d_cat%>&frmDate=<%= fromDTime%>&toTime=<%= toDTime%>&user_id=<%=user_id %>&user_name=<%= user_name%>','mywindow','width=900, height=500, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes,left=50, top=50 '); "><%= (int)d_cat%></a></div></td>
			<%} else {%>
				<td bgcolor="#f5f5f5" align="right"><div align="right"><%= (int)d_cat%></div></td>
			<%} %>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%= df.format(a_cat_per) %></div></td>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%= df.format(b_cat_per) %></div></td>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%= df.format(c_cat_per) %></div></td>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%= df.format(d_cat_per) %></div></td>
			<td bgcolor="#f5f5f5" align="right"><div align="right"><%=df.format(per_index)  %></div></td>
			</tr>
			<%			
		
		
}//end of while
}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
<%
}//end of condition
%>
</div>
</form>
