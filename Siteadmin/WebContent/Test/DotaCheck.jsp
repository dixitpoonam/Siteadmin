<%@ include file="headerhtml.jsp" %>
 
<%
Statement st=null, st1=null;
Connection conn=null;
%>

<form name="analyzefueldata" method="get" action="" >
<%
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String today = formatter.format(tdydte);
	
	String fromDate=request.getParameter("thedate");
	//if(null!=request.getParameter("thedate"))
	//	today=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("thedate")));
	String fromTime=request.getParameter("ftime1")+":"+request.getParameter("ftime2")+":00";
	
	StringBuffer unitIds=new StringBuffer("");
	String codeVersions=request.getParameter("codeVersion");
	
	 NumberFormat nf=NumberFormat.getInstance();
	nf.setMinimumIntegerDigits(2);
	
	
%>	
<table border="0" width="100%" align="center">
<tr><td bgcolor="#f5f5f5" align="center"><b><font color="" size="2">Latest Code Version </font></b></td></tr>
<tr>
	<td align="center">  <b> From : </b> 
   		<input type="text" id="thedate" name="thedate" size="13"  value="<%=today%>" readonly/>
		<!-- <input type="button" name="trigger" id="trigger" value="From Date" class="formElement"> -->
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "thedate",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "thedate"       // ID of the button
             }
                           );
             </script>
            &nbsp;&nbsp;&nbsp;
             
             
           
		<select name="ftime1" id="ftime1">
		<%
			for(int i=0;i<24;i++)
			{
			%>
				<option value="<%=nf.format(i)%>"><%=nf.format(i)%></option>
			<%
			}		
		%>
		</select>
		&nbsp;&nbsp;
 
		<select name="ftime2" id="ftime2" >
		<%
			for(int i=0;i<59;i++)
			{
			%>
				<option value="<%=nf.format(i)%>"><%=nf.format(i)%></option>
			<%
			}		
		%>
		<option value="59" selected>59</option>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Code Version:</b>
		<select name="codeVersion" id="codeVersion"> 
 <%
		  String sqlCodeVersions="SELECT CodeVersion FROM t_CodeVersions WHERE ActiveStatus=1";
		 ResultSet rsCodeVersion=st.executeQuery(sqlCodeVersions);
		 while(rsCodeVersion.next())
		 {
		 %>
		 		<option value="<%=rsCodeVersion.getString(1) %>"><%=rsCodeVersion.getString(1) %> </option>
		 <%} %>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="Submit" name="Submit" Value="Submit" class="formElement">
   </td>
</tr>
</table>

<%
if(!(fromDate==null))
{
	
%>
<table border="0" width="100%" align="center">

<tr><td align="center">
 	<table width="100%" align="center" class="sortable" border="1">
		<tr>
			<th>Sr No</th>
			<th>UnitId</th>
			<th>Stored Time</th>
			<th>Filed Time</th>
			<th>File Name</th>
			<th>WMSN</th>
			<th>Server</th>
			<th>CodeVersion</th>
			<th>RmcString</th>
			<th>IMEI</th>
		</tr>
<%
	int i=1;
	String sqlLastDump="SELECT UnitID FROM db_gps.t_ftplastdump WHERE codeversion = '"+codeVersions+"'  "+
						" AND StoredDateTime>='"+fromDate+" "+fromTime+"' ";
	
	ResultSet rsFTPLastDump=st.executeQuery(sqlLastDump);
	
	unitIds.append("(");
	while(rsFTPLastDump.next())
	{
		unitIds.append(rsFTPLastDump.getString("UnitID")+",");
	}
	unitIds.deleteCharAt(unitIds.length()-1);
	unitIds.append(")");
	
	System.out.println("*******   "+unitIds);

	String sql1="SELECT count(*) as cnt,UnitId "+
				" FROM db_gps.t_ftpdump WHERE UNITID IN "+unitIds+" "+
				" AND CodeVersion='"+codeVersions+"'  AND StoredDateTime>='"+fromDate+" "+fromTime+"'  "+
				" GROUP BY UnitId HAVING cnt>1   ";
				
				System.out.println(sql1);
				
	ResultSet rs1=st.executeQuery(sql1);
	while(rs1.next())
	{
		String sqlVersionChange="SELECT UnitId,StoredDateTime,Filedatetime,FileName, "+
		" WMSN,Server,Server,CodeVersion,RmcString,IMEI_No from t_ftpdump "+
		" WHERE CodeVersion='"+codeVersions+"' AND UnitId='"+rs1.getString("UnitId")+"' "+
		"  AND StoredDateTime>='"+fromDate+" "+fromTime+"' ORDER BY  StoredDateTime LIMIT 1";
		
		ResultSet rs=st1.executeQuery(sqlVersionChange);
		if(rs.next()){
		%>
		<tr>
			<td><%=i++ %></td>
			<td><%=rs.getString("UnitId") %></td>
			<td><%=rs.getString("StoredDateTime") %></td>
			<td><%=rs.getString("Filedatetime") %></td>
			<td><%=rs.getString("FileName") %></td>
			<td><%=rs.getString("WMSN") %></td>
			<td><%=rs.getString("Server") %></td>
			<td><%=rs.getString("CodeVersion") %></td>
			<td><%=rs.getString("RmcString") %></td>
			<td><%=rs.getString("IMEI_No") %></td>
		</tr>
<%		
		}
	}
%>
	</table>
	<% } // close of if %>
	</td></tr>
	</table>

<%		
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
		System.out.print("Exception---->"+e);
	}finally{
		conn.close();
	}
%>	
</form>
<%@ include file="footerhtml.jsp" %>
