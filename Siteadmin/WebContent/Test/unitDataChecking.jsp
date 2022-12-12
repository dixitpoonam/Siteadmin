<%@ page import="java.util.Date"%>
<%@ include file="headerhtml.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Insert title here</title>
<script type="text/javascript">

function validate()
{
	var iChars = "!@#$%^&*()+=-[]\\\';./{}|\":<>?";
	var units=document.srch.units.value;
	if(units.length < 2)
	{
		alert("Please enter Unit Id / Id's");
		return false;
	}

	for (var i = 0; i < units.length; i++) 
	{
			if (iChars.indexOf(units.charAt(i)) != -1) 
		{
		  	alert ("Special Characters are not allowed");
		  	return false;
			}
		}

}
</script>
</head>
<body><!--
1) last processed date time & location  from all-connected-units 
2)last data received on server today (time)  t_ip/t_mails if no data
the show "No data Received" 
3) last track file date time 
4) GPS status-
check for NG stamp (display date time)t_ip/t_mails check for 'V' at
end of mail body & display "Unstable Unit"

-->
<%!
Connection conn,conn1;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmtAllconnected=null,stmtIP=null,stmtMails=null;
	stmtAllconnected=conn.createStatement();
	stmtIP = conn1.createStatement();
	stmtMails = conn1.createStatement();
	String t_ip= "t_ip", t_mails="t_mails";
%>
<form name="dataCheck" action="" onSubmit="return validate()">
	<table>
		<tr>
			<td colspan="8" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its data.</b> </td>
		</tr>
		<tr>
			
			<td bgcolor="#F5F5F5">Unit ID :</td>
			<td bgcolor="#F5F5F5"><textarea name="unitid" id="unitid" class="stats"> </textarea> 
				<B> Note: </B> Please separate Unit ID's by comma ',' only &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			
			
			<td bgcolor="#F5F5F5"><input type="submit" name="submit" value="submit" class="stats"></td>
	</tr>
	</table>
<%
if(!(null==request.getQueryString()))
{	
	String unitids = request.getParameter("unitid"); 
	//System.out.println(unitids);
%>
	<table width="100%" align="center" class="sortable" border="1">
		<tr rowspan="2">
			<th>Unit Id</th>
			<th>Last Processed Date-Time</th>
			<th>Last Location</th>
			<th>Last Data Received On server</th>
			<th>Last Track File Date-Time</th>
			<th >GPS Status (Date-Time)</th>
		</tr>
<%			

	try{
		Statement stGPS=conn.createStatement(); //gps
		Statement stAVL=conn1.createStatement(); //avlalldata
		String unitType = "";
		String unitId="";//request.getParameter("unitid");
		String theDate=request.getParameter("data");
		String hour = request.getParameter("ftime1");
		String mins = request.getParameter("ftime2"); 
		String theTime = hour+":"+mins+":00";
		
		String theDate1;
	//	System.out.println(t_ip+"--"+t_mails);
		
%>
				<tr>
<%			
			StringTokenizer unitToken = new StringTokenizer(unitids,",");
			while(unitToken.hasMoreTokens()){
				unitId = unitToken.nextToken();
				unitId = unitId.trim();
%>
			<td><%=unitId%></td>
<%
			String processedDtLocSql="SELECT * FROM db_gps.allconnectedunits where unitid='"+unitId+"'";
			ResultSet rsProcessedDtLoc = stGPS.executeQuery(processedDtLocSql);
			if(rsProcessedDtLoc.next())
			{
				try{
				theDate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(rsProcessedDtLoc.getString("TheDate")));
				}
				catch(Exception e){
					theDate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(rsProcessedDtLoc.getString("TheDate")));
				}
				t_ip= t_ip+theDate1.replace("-","_");
				t_mails = t_mails+theDate1.replace("-","_");
%>
				<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsProcessedDtLoc.getString("TheDate")+" "+rsProcessedDtLoc.getString("TheTime"))) %></td>
				<td><%=rsProcessedDtLoc.getString("Location")%></td>
<%
			}
			else{
%>
				<td><%="-"%></td>
				<td><%="-"%></td>
<%
			}
			
			String ipSql="",mailsSql="";
			String mailBody="";
			String unitTypeSql = "SELECT * FROM db_gps.t_unitmaster where unitid ='"+unitId+"'";
		//	System.out.println(unitTypeSql);
			ResultSet rsUnitType = stGPS.executeQuery(unitTypeSql);
			if(rsUnitType.next())
			{
				
				unitType  = rsUnitType.getString("typeunit");
				//System.out.println("unitype=="+unitType.trim());
				if("IP".equals(unitType.trim())){
					ipSql = "SELECT * FROM "+t_ip+" WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
				//	ipSql = "SELECT * FROM "+t_ip+"Processed WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
					ResultSet rsIP = stAVL.executeQuery(ipSql);
					if(rsIP.next()){
						mailBody = rsIP.getString("Body");
						
%>
						<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsIP.getString("MailDate")+" "+rsIP.getString("MailTime"))) %></td>
<%
					}
					else{
						ipSql = "SELECT * FROM "+t_ip+"Processed WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
						rsIP =  stAVL.executeQuery(ipSql);
						if(rsIP.next()){
							mailBody = rsIP.getString("Body");
%>
						<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsIP.getString("MailDate")+" "+rsIP.getString("MailTime"))) %></td>
<%
						}
						else{
%>
						<td><%="-"%></td>
<%
						}
					}
				}
				
				else{
					mailsSql="SELECT * FROM "+t_mails+" WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
				//	mailsSql = "SELECT * FROM "+t_mails+"Processed WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
					//System.out.println("mailsql==>"+mailsSql);
					ResultSet rsMail = stAVL.executeQuery(mailsSql);
					if(rsMail.next()){
						mailBody = rsMail.getString("Body");
					//	System.out.println("mail date==>"+rsMail.getString("MailDate"));
%>
						<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsMail.getString("MailDate")+" "+rsMail.getString("MailTime"))) %></td>
<%
					}
					else{
					//	System.out.println("else mailsqlProcessed==>");
						mailsSql = "SELECT * FROM "+t_mails+"Processed WHERE unitid='"+unitId+"' ORDER BY CONCAT(maildate,mailtime) DESC limit 1";
					//	System.out.println("mailsql==>"+mailsSql);
						rsMail =  stAVL.executeQuery(mailsSql);
						if(rsMail.next()){
							mailBody = rsMail.getString("Body");
%>
						<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsMail.getString("MailDate")+" "+rsMail.getString("MailTime"))) %></td>
<%
						}
						else{
%>
						<td><%="-"%></td>
<%
						}
					}
	
				}
			}
			else{
				%>
				<td><%="-"%></td>
<%
				
			}
	//		System.out.println("ipsql==>"+ipSql);
	//		System.out.println("mailsql==>"+mailsSql);
			String trackFileSql = "SELECT * FROM db_gps.t_ftplastdump WHERE unitid='"+unitId+"'";
	//		System.out.println("travksql==>"+trackFileSql);
			ResultSet rsTrackFile = stGPS.executeQuery(trackFileSql);
			if(rsTrackFile.next()){
%>
				<td><%=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rsTrackFile.getString("StoredDateTime"))) %></td>
<%
			}
			else{
%>
				<td><%="-" %></td>
<%	
			}
			Format dateFormat=new SimpleDateFormat("yyyy-MM-dd");
			Format timeFormat=new SimpleDateFormat("HH:mm:ss");
			int year=0;
			int yearThreeYears = 2009;
			String NGDateTime="", invalidData="";
			String stamp="",lat="",lon="",stampDate="",stampTime="",stampLat="",stampLong="",stampLatDir="",stampLongDir="";
			StringTokenizer mailBodyToken = new StringTokenizer(mailBody,"\n");
	//		System.out.println("mailBody===>"+mailBody);
			
			while(mailBodyToken.hasMoreTokens()){
				String token; //= mailBodyToken.nextToken();
			//	System.out.println("token===>"+mailBodyToken.nextToken());
				token = mailBodyToken.nextToken().replace(",," , ",0,");
				
				StringTokenizer stk= new StringTokenizer(token,","); 
				//System.out.println("==="+stk.countTokens());
				java.util.Date date2=new Date();
				//while(stk.hasMoreTokens()){
				//	System.out.println(stk.nextToken());
				//}
				if(stk.hasMoreElements()){
					stamp=stk.nextElement().toString();
					//System.out.println("==="+stk.nextToken());
					stamp = stamp.replace(" ","");
			//		System.out.println(stamp);
					if("NG".equalsIgnoreCase(stamp)){
						NGDateTime = "NO GPS";
						break;
					}
				}
				
			//	while(stk.hasMoreElements()){
					
					if(stk.hasMoreElements()){
						stampDate = stk.nextElement().toString();
						if(stampDate.length()==6)
						{
							stampDate="20"+stampDate.substring(4,6)+"-"+stampDate.substring(2,4)+"-"+stampDate.substring(0,2);
						}
						boolean flag=false;
						try{
							if(stampDate.length()==10){
								year = Integer.parseInt(stampDate.substring(0,4));
								Integer.parseInt(stampDate.substring(5,7));
								Integer.parseInt(stampDate.substring(8,10));
								java.util.Date checkdate=(Date) dateFormat.parseObject(stampDate);
								java.util.Date today=new Date();
								if(today.getTime() > checkdate.getTime())
								{
									flag=true;
								}
							}
							java.util.Date dt = new Date();
				//			System.out.println(dt);
							String dt1 = new SimpleDateFormat("yyyy-MM-dd").format(dt);
			//				System.out.println(dt1);
							int currentYear = Integer.parseInt(dt1.substring(0,4));
							
							int twoYearsBack = currentYear - 2;
			//				System.out.println(year);
							if(year == twoYearsBack){
								invalidData = "INVALID DATA";
								break;
							}
						}catch(Exception e)
						{
							flag=false;
						}
						
						
					}
					
					if(stk.hasMoreElements()){
						stampTime = stk.nextElement().toString();
						if(stampTime.length()==6)
						{
							stampTime=stampTime.substring(0,2)+":"+stampTime.substring(2,4)+":"+stampTime.substring(4,6);						
						}
						boolean flag=false;
						try{
							if(stampTime.length()==6){
							Integer.parseInt(stampTime.substring(0,2));
							Integer.parseInt(stampTime.substring(2,4));
							Integer.parseInt(stampTime.substring(4,6));
							flag=true;
							}
						}catch(Exception e)
						{
							flag=false;
						}
						
					}
					
					if(stk.hasMoreElements()){
						stampLat = stk.nextElement().toString();
						if("0".equalsIgnoreCase(stampLat)){
							invalidData = "INVALID DATA";
						}
					}
					
					if(stk.hasMoreElements()){
						stampLatDir = stk.nextElement().toString();
					}
					
					if(stk.hasMoreElements()){
						stampLong = stk.nextElement().toString();
						if("0".equalsIgnoreCase(stampLong)){
							invalidData = "INVALID DATA";
						}
					}
					if(stk.hasMoreElements()){
						stampLongDir = stk.nextElement().toString();
					}
			//	}
			}
			
			if("0".equalsIgnoreCase(stampLat) || "0".equalsIgnoreCase(stampLong)){
				invalidData = "\n\n INVALID DATA";	
			}
			else{
				invalidData = "";
			}
	//		System.out.println("gps==>"+NGDateTime+"--"+invalidData);
	if("".equalsIgnoreCase(NGDateTime) && "".equalsIgnoreCase(invalidData)){
		%>
			<td><%="OK"%></td>
<%	
			}else{
%>
			<td><%=NGDateTime+" "+invalidData %></td>
				</tr>
<%
			}
			}
}
	catch(Exception e){
		e.printStackTrace();
	}finally{
    	conn.close();
    	conn1.close();
    }
}

%>		
	</table>
</form>
</body>
</html>