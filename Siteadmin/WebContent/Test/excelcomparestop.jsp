<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"CompareResult_.xls";
  response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<%!

Statement st, st1;
Connection conn;
int limit;
%>
<%
ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="",vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",calstatus="";
int count=0;
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	String thedate11="",thedate12="",thedate13="";

	boolean flag=true;

	%>
	<table border="0" width="100%" align="center" class="sortable">
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		//System.out.println("unitid" +unitid);
		thedate=request.getParameter("data");
		//System.out.println("thedate" +thedate);

		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		//System.out.println("thedate1" +thedate1);

		thedate2 = request.getParameter("data1");
		//System.out.println("thedate2" +thedate2);

		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate2));
		
		//System.out.println("thedate3" +thedate3);

		%>
		
		
		
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="16" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
		 </th>
		</tr>
		
		<%
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		//System.out.println("Vehicle details Table" +sql);
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
		}
		%>
		
		<tr>
		<td colspan="">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Unit ID</td>
		<td class="hed" align="center">Vehicle Code</td>
		<td class="hed" align="center">Vehicle No</td>
		<td class="hed" align="center">Date </td>
		<td class="hed" align="center">Time</td>
				<td class="hed" align="center">Speed</td>
		
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Location</td>
		
		</tr>
		<%
		try{
		String sqlck="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('ST','SP') and TheFieldDataDateTime >='"+thedate1+" 00:00:00' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime  ";
		
		System.out.println("Main Query" +sqlck);

		ResultSet rst=st1.executeQuery(sqlck);
		int i=1;
		while(rst.next())
		{
			
			thedate11=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TheFieldDataDate"));

		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<td class="bodyText" align="center"><%=unitid%></td>
			<td class="bodyText" align="center"><%=vehcode%></td>
			<td class="bodyText" align="left"><%=VehicleRegNumber%></td>
			<td class="bodyText" align="right"><%=thedate11 %></td>
			<td class="bodyText" align="right"><%=rst.getTime("TheFieldDataTime") %></td>
					    <td class="bodyText" align="right"><%=rst.getString("Speed") %></td>
			
			<td class="bodyText" align="left"><%=rst.getString("TheFiledTextFileName") %></td>
			<td class="bodyText" align="left"><%=rst.getString("TheFieldSubject") %></td>
			
		
			</tr>
		<%
		i++;
		}
		%>
		 
		  
		  
		
		
		
		<%
		
		 String fromdate = thedate1;
		 String fromtime = "00:00:00";
		 String sqlnew="select * from t_veh"+vehcode+" where TheFieldDataDateTime <='"+fromdate+" "+fromtime+"' and TheFiledTextFileName in ('SI','OF','ON','ST','SP') order by TheFieldDataDateTime desc limit 1";
		 ResultSet rstnew=st.executeQuery(sqlnew);
		 if(rstnew.next())
		 {
		 	fromdate=rstnew.getString("TheFieldDataDate");
		 	fromtime=rstnew.getString("TheFieldDataTime");
		 	System.out.println("fromdate---->"+fromdate+"fromtime-->"+fromtime);
		 	
		 }
		
		String sqlckstop="select * from t_veh"+vehcode+" where TheFiledTextFileName in ('SI','OF','ON','ST','SP') and TheFieldDataDateTime >='"+fromdate+" "+fromtime+"' and TheFieldDataDateTime <= '"+thedate3+" 23:59:59' order by TheFieldDataDateTime  ";
		
		System.out.println("Main Current Query" +sqlckstop);

		ResultSet rstop=st1.executeQuery(sqlckstop);
		int k=1;
		int x=0;

		if(rstop.first())
		{
			
		}
		
		while(rstop.next())
		{
			if(rstop.getString("TheFiledTextFileName").equals("SI") || rstop.getString("TheFiledTextFileName").equals("ST") || rstop.getString("TheFiledTextFileName").equals("SP"))
			{			
			if(rstop.getInt("Speed")==0)
			{
				if(flag==true)
				{				
					flag=false;
					x=1;
					thedate12=new SimpleDateFormat("dd-MMM-yyyy").format(rstop.getDate("TheFieldDataDate"));

		%>
			<tr>
			<td class="bodyText" align="center"><%=k++ %></td>
			<td class="bodyText" align="center"><%=unitid%></td>
			<td class="bodyText" align="center"><%=vehcode%></td>
			<td class="bodyText" align="center"><%=VehicleRegNumber%></td>
			<td class="bodyText" align="right"><%=thedate12 %></td>
			<td class="bodyText" align="right"><%=rstop.getTime("TheFieldDataTime") %></td>
		    <td class="bodyText" align="right"><%=rstop.getString("Speed") %></td>
			<td class="bodyText" align="left"><%="Stop"%> </td>
			<td class="bodyText" align="left"><%=rstop.getString("TheFieldSubject") %></td>
			
		
			</tr>
			
		<%
		
		
		}
				
			}
			else if(rstop.getInt("Speed")>0 && x==1)				
			{
				
				flag=true;
				thedate13=new SimpleDateFormat("dd-MMM-yyyy").format(rstop.getDate("TheFieldDataDate"));				
		%>
		<tr>
		    <td class="bodyText" align="center"><%=k++ %></td>
			<td class="bodyText" align="center"><%=unitid%></td>
			<td class="bodyText" align="center"><%=vehcode%></td>
			<td class="bodyText" align="center"><%=VehicleRegNumber%></td>
			<td class="bodyText" align="right"><%=thedate13 %></td>
			<td class="bodyText" align="right"><%=rstop.getTime("TheFieldDataTime") %></td>
			<td class="bodyText" align="right"><%=rstop.getString("Speed") %></td>			
			<td class="bodyText" align="left"><%="Start"%></td>
			<td class="bodyText" align="left"><%=rstop.getString("TheFieldSubject") %></td>
			
		
			</tr>
		<%x++;}
			}
			else
			{
				if(rstop.getString("TheFiledTextFileName").equals("OF"))
				{
					java.util.Date dt1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstop.getString("TheFieldDataDate")+" "+rstop.getString("TheFieldDataTime"));
					if(rstop.next())
					{
						if(rstop.getString("TheFiledTextFileName").equals("ON"))
						{
							java.util.Date dt2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rstop.getString("TheFieldDataDate")+" "+rstop.getString("TheFieldDataTime"));							
							long hrs=00,mins=00;
							long mils1=dt1.getTime();
							long mils2=dt2.getTime();
							long mils3=mils2-mils1;
							mils3=mils3/1000/60;						
							if(mils3 > 20)
							{
								if(rstop.next())
								{
									if(rstop.getString("TheFiledTextFileName").equals("SI") || rstop.getString("TheFiledTextFileName").equals("ST") || rstop.getString("TheFiledTextFileName").equals("SP"))
									{
										if(rst1.getInt("Speed")==0)
										{
										    if(flag==true)
										     {
										         flag=false;	 
										         x=1;
										         %>
										         <tr>
			<td class="bodyText" align="center"><%=k++ %></td>
			<td class="bodyText" align="center"><%=unitid%></td>
			<td class="bodyText" align="center"><%=vehcode%></td>
			<td class="bodyText" align="center"><%=VehicleRegNumber%></td>
			<td class="bodyText" align="right"><%=thedate12 %></td>
			<td class="bodyText" align="right"><%=rstop.getTime("TheFieldDataTime") %></td>
		    <td class="bodyText" align="right"><%=rstop.getString("Speed") %></td>
			<td class="bodyText" align="left"><%="Stop"%></td>
			<td class="bodyText" align="left"><%=rstop.getString("TheFieldSubject") %></td>
			
		
			</tr>
										         <%
										     }
										}
									}
								}
							}
							
						}
					}
					
					rstop.previous();
				}
			}
		}
		}catch(Exception e){
			
			e.printStackTrace();
		}
		%>
		
		
		
		 </table>
		  </td>
		  </tr>
		
	 
		  
		  </table>
		  
	
		</td>
		</tr>
		</table>
		
		<%
	}%>
	
	<%
	
}catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try{
	conn.close();
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

