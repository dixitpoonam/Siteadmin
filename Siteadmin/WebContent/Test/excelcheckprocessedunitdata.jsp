<%@ page language="java" contentType="application/vnd.ms-excel; charset=gb2312"  import="java.sql.*" import="java.util.*" import=" java.text.*"  pageEncoding="UTF-8"%>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());
String filename=showdatex+"ProcessedUnitData_.xls";
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
String sql="", unitid="",thedate="",thedate1="",thedate2="", vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",calstatus="";
int count=0;
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	
	%>
	<table border="0" width="100%" align="center" class="sortable">
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		String lim1=request.getParameter("limit");
		
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="16" class="hed" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
		</th>
		</tr>
		
		<%
		boolean flag=false;
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			flag=true;
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
			sql="Select count(*) from t_fuelleveldata1 where vehregno like '"+VehicleRegNumber+"'";//checking if calibrated
			rst2=st1.executeQuery(sql);
			if(rst2.next())
			{
				calstatus = "Calibrated";
				count=rst2.getInt(1);
			}
			else
			{
				calstatus = "Not Calibrated";
			}
			%>
			<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4"><%=VehicleRegNumber %></td>
			<td colspan="4"><%=vehcode %></td>
			<td colspan="4"><%=OwnerName %></td>
			<td colspan="3"><%=calstatus %></td>
			</tr>
			</table>
			</td>
			</tr>
		<%}
		else
		{%>
		<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="3">NA</td>
			</tr>
			</table>
			</td>
			</tr>
		<%	
		}
		%>
		
		<tr>
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">StoredDateTime</td>
		<td class="hed" align="center">StampTime</td>
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Location </td>
		<td class="hed" align="center">Speed</td>
		<td class="hed" align="center">Data Valid</td>
		<td class="hed" align="center">Fuel Level</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Unit Distance</td>
		<td class="hed" align="center">Latitude</td>
		<td class="hed" align="center">Longitude</td>
		<td class="hed" align="center">Sen 1</td>
		<td class="hed" align="center">Sen 2</td>
		<td class="hed" align="center">Sen 3</td>
		<td class="hed" align="center">Calibration Ltr. Value</td>
		<td class="hed" align="center">Calibration Ltr. Default Value</td>
		</tr>
		<%
		if(flag)
		{
		sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+thedate1+"' order by TheFieldDataTime desc ";
		}
		else
		{
			sql="select * from t_veh0 where TheFieldDataDate='"+thedate1+"' and unitid='"+unitid+"' order by TheFieldDataTime desc ";
		}
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
			String caliberationval="0",defaultCaliberationval="0"; 
			int sen3=0;
			try{
				
				sen3=rst.getInt("Sen3");
			
			}catch(Exception e){ sen3=0;}
			
			if(calstatus.equalsIgnoreCase("Calibrated"))
			{
				if(sen3==0)
				{
					caliberationval="0";
					defaultCaliberationval="0";
				}
				else if(count<=20 && count>0)
				{
					sql="select Ltr from t_fuelleveldatanew where vehregno= 'Default' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						defaultCaliberationval=rst3.getString("Ltr");
					}
					
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
				else
				{
					defaultCaliberationval="0";
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
			}
			else
			{
				caliberationval="N/A";
				defaultCaliberationval="N/A";
			}
			
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<td class="bodyText" align="center"><%=rst.getDate("TheFieldDataStoredDate")+" "+rst.getTime("TheFieldDataStoredTime") %></td>
			<td class="bodyText" align="center"><%=rst.getTime("TheFieldDataTime") %></td>
			<td class="bodyText" align="left"><%=rst.getString("TheFiledTextFileName") %></td>
			<td class="bodyText" align="right"><%=rst.getString("TheFieldSubject") %></td>
			<td class="bodyText" align="left"><%=rst.getString("Speed") %></td>
			<td class="bodyText" align="left"><%=rst.getString("DataValid") %></td>
			<td class="bodyText" align="left"><%=rst.getString("FuelLevel") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Distance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("CDistance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LatinDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LonginDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen1") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen2") %></td>
			<td class="bodyText" align="center"><%=sen3 %></td>
			<td class="bodyText" align="center"><%=caliberationval %></td>
			<td class="bodyText" align="center"><%=defaultCaliberationval %></td>
			</tr>
		<%
		i++;
		}
		%>
		  </table>
		<%
	}%>
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
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

