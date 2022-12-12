<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"_UnitPerformance.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!

Statement st1;
String sql, unitid, vehcode,flag,search,message;
int limit;
Connection conn,conn2;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn2 = DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null,st2=null,st3=null;
String sql=null,sql1=null, unitid=null, vehcode=null,flag=null,search=null,message=null,beforetodate=null,beforefromdate=null,aftertodate=null,afterfromdate=null;
int limit=0;
try{
	NumberFormat nf= NumberFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
    nf.setMinimumFractionDigits(2);
	
	st1=conn.createStatement();
	st2=conn2.createStatement();
	st3=conn2.createStatement();
	beforefromdate=request.getParameter("beforefromdate");
	beforetodate=request.getParameter("beforetodate");
	afterfromdate=request.getParameter("afterfromdate");
	aftertodate=request.getParameter("aftertodate");
	flag=request.getParameter("flag");
	try
	{
	unitid=session.getAttribute("unitid").toString();
	sql=session.getAttribute("sql").toString();
	sql1=session.getAttribute("sql1").toString();
	
	}catch(Exception ex)
	{
		response.sendRedirect("../index.jsp?err=err2");
		return;
	}
	%>
	
			<table  border="0">
				<tr>
					<th  align="center">Sr.</th>
					<th  align="center">Unit ID</th>
					<th  align="center" >SI Count</th>
					<th  align="center" >SI Count 1</th>
					<th  align="center" >Tx count</th>
					<th  align="center" >Tx count 1</th>
					<th  align="center">AVG delay</th>
					<th  align="center">AVG delay 1</th>
					<th  align="center" >Dist fact </th>
					<th  align="center" >Dist fact 1</th>
					<th  align="center">ON count</th>
					<th  align="center">ON count 1</th>
					<th  align="center" >ER count</th>
					<th  align="center" >ER count 1</th>
				</tr>
		<%
			int i=0;
			double totaftersiCount=0,totaftertxCount=0.0,totafteravgDelay=0.0,totafterdistFact=0.0,totafteronCount=0,totaftererCount=0.0;
			double totbeforesiCount=0,totbeforetxCount=0.0,totbeforeavgDelay=0.0,totbeforedistFact=0.0,totbeforeonCount=0,totbeforeerCount=0.0;
			double avgaftersiCount=0,avgaftertxCount=0.0,avgafteravgDelay=0.0,avgafterdistFact=0.0,avgafteronCount=0,avgaftererCount=0.0;
			double avgbeforesiCount=0,avgbeforetxCount=0.0,avgbeforeavgDelay=0.0,avgbeforedistFact=0.0,avgbeforeonCount=0,avgbeforeerCount=0.0;
			 
			 String Sql2="select distinct(unitid) from t_unitperformance where UnitID in ("+unitid+") ";
			 ResultSet unitRst=st2.executeQuery(Sql2);
			 while(unitRst.next())
			 {
				 
				i++;
				double beforesiCount=0,beforetxCount=0.0,beforeavgDelay=0.0,beforedistFact=0.0,beforeonCount=0,beforeerCount=0.0;
				
				double aftersiCount=0,aftertxCount=0.0,afteravgDelay=0.0,afterdistFact=0.0,afteronCount=0,aftererCount=0.0;
				
				String searchUnit=unitRst.getString(1);
				 
				 sql="select sum(SI_count)/count(*),sum(trans_count)/count(*),sum(on_count)/count(*),sum(er_count)/count(*),sum(corr_factor)/count(*),sum(avg_delay)/count(*) from t_unitperformance where UnitID = "+searchUnit+" and thedate between '"+beforefromdate+"' and '"+beforetodate+"'  order by unitid,thedate ";
				 sql1="select sum(SI_count)/count(*),sum(trans_count)/count(*),sum(on_count)/count(*),sum(er_count)/count(*),sum(corr_factor)/count(*),sum(avg_delay)/count(*) from t_unitperformance where UnitID="+searchUnit+" and thedate between '"+afterfromdate+"' and '"+aftertodate+"'  order by unitid,thedate ";
				
				 session.setAttribute("sql",sql);
				 session.setAttribute("sql1",sql1);
				 session.setAttribute("unitid",unitid);
				
				 ResultSet beforeRst=st3.executeQuery(sql);
					if(beforeRst.next())
					{
						
						beforesiCount=beforeRst.getDouble(1);
						beforetxCount=beforeRst.getDouble(2);
						beforeonCount=beforeRst.getDouble(3);
						beforeerCount=beforeRst.getDouble(4);
						beforedistFact=beforeRst.getDouble(5);
						beforeavgDelay=beforeRst.getDouble(6);
						totbeforesiCount+=beforesiCount;
						totbeforetxCount+=beforetxCount;
						totbeforeonCount+=beforeonCount;
						totbeforeerCount+=beforeerCount;
						totbeforedistFact+=beforedistFact;
						totbeforeavgDelay+=beforeavgDelay;
					}
					
					ResultSet afterRst=st3.executeQuery(sql1);
					if(afterRst.next())
					{
						aftersiCount=afterRst.getDouble(1);
						aftertxCount=afterRst.getDouble(2);
						afteronCount=afterRst.getDouble(3);
						aftererCount=afterRst.getDouble(4);
						afterdistFact=afterRst.getDouble(5);
						afteravgDelay=afterRst.getDouble(6);
						totaftersiCount+=aftersiCount;
						totaftertxCount+=aftertxCount;
						totafteronCount+=afteronCount;
						totaftererCount+=aftererCount;
						totafterdistFact+=afterdistFact;
						totafteravgDelay+=afteravgDelay;
					}
					
					
					%>
		<tr>
				
		<td><%=i +"."%></td>
		<td><%=searchUnit %></td>
		<%try{%>
		<td><%=nf.format(beforesiCount)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftersiCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforetxCount)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftertxCount)%></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeavgDelay)%></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afteravgDelay) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforedistFact) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afterdistFact) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeonCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(afteronCount) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(beforeerCount) %></td>
		<%}catch(Exception ex){out.print("0");} %>
		<%try{%>
		<td><%=nf.format(aftererCount) %></td>
			<%}catch(Exception ex){out.print("0");} %>
		</tr>
		
		
	<% } %>
			</table>
			<tr>
			<td>
			<table  border="0" width="100%" class="sortable">
			<tr><th  align="center" colspan="14">Total Avg</th></tr>
					<tr>	
					<th  align="center">SI Count</th>	
					<th  align="center">SI Count 1</th>
					<th  align="center">Tx count</th>
					<th  align="center">Tx count 1</th>
					<th  align="center">AVG delay</th>
					<th  align="center">AVG delay 1</th>
					<th  align="center">Dist fact</th>
					<th  align="center">Dist fact 1</th>
					<th  align="center">ON count</th>
					<th  align="center">ON count 1</th>
					<th  align="center">ER count</th>
					<th  align="center">ER count 1</th>
					</tr>
					<%
					avgbeforeavgDelay=totbeforeavgDelay/i;
					avgbeforedistFact=totbeforedistFact/i;
					avgbeforeerCount=totbeforeerCount/i;
					avgbeforeonCount=totbeforeonCount/i;
					avgbeforesiCount=totbeforesiCount/i;
					avgbeforetxCount=totbeforetxCount/i;
					
					avgafteravgDelay=totafteravgDelay/i;
					avgafterdistFact=totafterdistFact/i;
					avgaftererCount=totaftererCount/i;
					avgafteronCount=totafteronCount/i;
					avgaftersiCount=totaftersiCount/i;
					avgaftertxCount=totaftertxCount/i;
					
					%>
					<tr>
					<%try{%>
					<td><%=nf.format(avgbeforesiCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					
					<%try{%>
					<td><%=nf.format(avgaftersiCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					
					<%try{%>
					<td><%=nf.format(avgbeforetxCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					
					<%try{%>
					<td><%=nf.format(avgaftertxCount)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforeavgDelay)%></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafteravgDelay) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforedistFact) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafterdistFact) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforeonCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgafteronCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgbeforeerCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					<%try{%>
					<td><%=nf.format(avgaftererCount) %></td>
					<%}catch(Exception ex){out.print("0");} %>
					
					</tr>
			</table>
	</td>
	</tr>
	</table>
	
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();
	conn2.close();
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

