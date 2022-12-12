<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename="CountDetails.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%! Connection con1; %>
<%
try
{
	
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	ResultSet rs1=null, rs2=null;
	String sql1="", sql2="";
	String StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	String owner=request.getParameter("owner");
	fromdate=request.getParameter("fromdate");
	todate=request.getParameter("todate");
	String pagefrom=request.getParameter("pagefrom");
	String vehregno1=request.getParameter("vehregno1");
	String pagefr=request.getParameter("pagefr");
	
%>		
	<table width="100%" align="center" border="0">
	<tr><td colspan="12">
		<table  border="0" width="100%">
		<tr><td colspan="9" align="center" >
			<font size="3" color="maroon"><b><%=pagefrom%>
			
			 Count Report of 
			 <% if(vehregno1.equals("-"))
			 	{
			 %>
			 	<%=owner %>
			 <%
			 	}
			 	else
			 	{
			 %>	
			 		<%=vehregno1 %>
			 <%
			 	}
			 %>		
			 		  from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 			</td>
    	     	<td colspan="3">	
					<font size="2"><b></>Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					String sdt = fmt.format(new java.util.Date());
					out.print(sdt); %></font>
			
		</td></tr>
		</table>
	</td></tr>
	<tr><td colspan="10">
		<table  border="0" width="100%" >
		<tr>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>Sr.No</b></font></td>
			<td align="center" bgcolor="#2696B8" colspan="2"> <font color="white" size="2"><b> VehRegNo</b></font></td>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>The Date</b></font></td>
			<td align="center" bgcolor="#2696B8"> <font color="white" size="2"><b>The Time</b></font></td>
			<td align="center" bgcolor="#2696B8" colspan="5"> <font color="white" size="2" ><b>Location</b></font> </td>
		</tr>
		<%
				int i=1;
				int totos1=0,totos2=0,toter=0,toton=0,totgap1=0,totgap2=0;
				if(pagefr.equals("check"))
				{
					if (pagefrom.equals("OS1"))
					{	
						sql1="select * from t_os1 where ownername like '"+owner+"' and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("OS2"))
					{
						sql1="select * from t_os2 where ownername like '"+owner+"' and  (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("ON"))
					{
						sql1="select * from t_on where ownername like '"+owner+"'   and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("ER"))
					{
						sql1="select * from t_er where ownername like '"+owner+"'  and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("SIGap1"))
					{
						sql1="select vehregno,TheDate2 as TheDate,TheTime2 as TheTime,location from t_sigap where ownername like '"+owner+"'  and (TheDate2 between '"+fromdate+"' and '"+todate+"') and IDType=1 ";
					}
					else
					{
						sql1="select vehregno,TheDate2 as TheDate,TheTime2 as TheTime,location from t_sigap where ownername like '"+owner+"'  and (TheDate2 between '"+fromdate+"' and '"+todate+"') and IDType=2 ";
					}
				}
				else
				{
					if (pagefrom.equals("OS1"))
					{	
						sql1="select * from t_os1 where ownername like '"+owner+"' and vehregno='"+vehregno1+"'  and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("OS2"))
					{
						sql1="select * from t_os2 where  ownername like '"+owner+"' and vehregno='"+vehregno1+"' and  (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("ON"))
					{
						sql1="select * from t_on where ownername like '"+owner+"' and vehregno='"+vehregno1+"'  and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("ER"))
					{
						sql1="select * from t_er where  ownername like '"+owner+"' and vehregno='"+vehregno1+"'  and (TheDate between '"+fromdate+"' and '"+todate+"') ";
					}
					else if(pagefrom.equals("SIGap1"))
					{
						sql1="select vehregno,TheDate2 as TheDate,TheTime2 as TheTime,location from t_sigap where ownername like '"+owner+"' and vehregno='"+vehregno1+"' and (TheDate2 between '"+fromdate+"' and '"+todate+"') and IDType=1 ";
					}
					else
					{
						sql1="select vehregno,TheDate2 as TheDate,TheTime2 as TheTime,location from t_sigap where ownername like '"+owner+"' and vehregno='"+vehregno1+"' and (TheDate2 between '"+fromdate+"' and '"+todate+"') and IDType=2 ";
					}
				}
				rs1=stmt1.executeQuery(sql1);
				//out.println(sql1);
				while(rs1.next())
				{
					String vehregno=rs1.getString("vehregno");
					String TheDate=rs1.getString("TheDate");
					String TheTime=rs1.getString("TheTime");
					String location=rs1.getString("Location");
		%>
		<tr bgcolor="#f5f5f5">
			<td align="center"><font size="2"><%=i %></font></td>
			<td align="center" colspan="2"><font size="2"><%=vehregno%></font></td>
			<td align="center"><font size="2">'<%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(TheDate))%></font></td>
			<td align="center"><font size="2">'<%=new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("hh:mm:ss").parse(TheTime))%></font></td>
			<td align="center" colspan="5"><font size="2"><%=location%></font></td>
		</tr>
<%
			i++;
			}
}
catch(Exception e)
{
	out.println("Exception----->"+e); 
}
finally
{
	con1.close();
}
%>	
	</td></tr>	
	</table>
	</form>
<%@ include file="footerhtml.jsp" %>