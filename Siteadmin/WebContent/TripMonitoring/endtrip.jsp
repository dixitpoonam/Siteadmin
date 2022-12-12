<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="conn.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<html>
<head>
<script language="javascript">
function validate()
{
	var time=document.tripend.endtime1.value;
	var comment=document.getElementById("comment").value;
	var othercomment=document.getElementById("othercomment").value;
	othercomment=othercomment.replace(/^\s+|\s+$/g,"");//trim
	if(time=="Select")
	{
		alert("Please enter Arrival Time");
		return false;
	}

	if(comment=="select" || othercomment=="" || othercomment.lenght==0)
	{
		alert("Please enter a comment");
		return false;
	}
	return datevaildate();
}

function datevaildate()
{
	var stdate=document.tripend.stdate.value;
	var enddate=document.tripend.calender1.value;

	var sttime=document.tripend.sttime.value;
	var endtime1=document.tripend.endtime1.value;
	var endtime2=document.tripend.endtime2.value;
	

	var dm1,dd1,dy1,dm2,dd2,dy2;
	var stm1, stm2;

	dy1=stdate.substring(0,4);
	dm1=stdate.substring(5,7);
	dd1=stdate.substring(8,10);

	dy2=enddate.substring(0,4);
	dm2=enddate.substring(5,7);
	dd2=enddate.substring(8,10);

	stm1=sttime.substring(0,2);
	stm2=sttime.substring(3,5);
	
	if(dy2<dy1)
	{
		alert("Trip End date cannot be less than Trip Start date (year)");
		return false;
	}
	
	if(dy2==dy1)
	{
		  if(dm2<dm1)
		  {
			alert("Trip End date cannot be less than Trip Start date (month)");
			return false;
                  }
	}

	if(dy2==dy1 && dm2==dm1)
	{
		if(dd2<dd1)
		{
			alert("Trip End date cannot be less than Trip Start date (day)");
			return false;
		}
	}

	if(dy2==dy1 && dm2==dm1 && dd2==dd1)
	{
		if(endtime1<stm1)
		{
			alert("Trip End time cannot be less than Trip Start time. Trip Start Time is "+sttime);
			return false;
		}
	
		if(endtime1==stm1)
		{
			if(endtime2<stm2)
			{
				alert("Trip End time cannot be less than Trip Start time. Trip Start Time is "+sttime);
				return false;
			}
		}
		
	}
	
	return true;
}

function showlocation(dropdown, vehcode, vehno)
{
	var vv=dropdown.selectedIndex;
        var SelValue = dropdown.options[vv].value;
	
	var hrs=document.tripend.endtime1.value;
	var mins=document.tripend.endtime2.value;
	var seldte=document.tripend.calender1.value;
	
	 var ajaxRequest;  // The variable that makes Ajax possible!

    try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	        }  
                catch (e)
                {
		        // Internet Explorer Browsers
		        try
                        {
			   ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		        } 
                        catch (e)
                        {
			   try
                           {
			       ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			   } 
                           catch (e)
                           {
			      // Something went wrong
			      alert("Your browser broke!");
			      return false;
			   }
		        }
                }

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                         document.getElementById("loc").innerHTML=reslt;
                         
		     } 
         	  }
             var queryString = "?hrs="+hrs+"&mins="+mins+"&vehcode="+vehcode+"&seldte="+seldte+"&vehno="+vehno;
	     ajaxRequest.open("GET", "Ajaxgetlocation.jsp" + queryString, true);
	     ajaxRequest.send(null); 
}

function closed(cal)
{
	
	cal.hide();
	var hrs=document.tripend.endtime1.value;
	var mins=document.tripend.endtime2.value;
	var seldte=document.tripend.calender1.value;
	var vehcode=document.getElementById("vehcode").value;
	var vehno=document.getElementById("vehregno").value;
	 var ajaxRequest;  // The variable that makes Ajax possible!

    try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	        }  
                catch (e)
                {
		        // Internet Explorer Browsers
		        try
                        {
			   ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		        } 
                        catch (e)
                        {
			   try
                           {
			       ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			   } 
                           catch (e)
                           {
			      // Something went wrong
			      alert("Your browser broke!");
			      return false;
			   }
		        }
                }

             // Create a function that will receive data sent from the server
           	  ajaxRequest.onreadystatechange = function()
                   {
    	 	  if(ajaxRequest.readyState == 4)
                      {
                         var reslt=ajaxRequest.responseText;
                         //alert(reslt);
                         document.getElementById("loc").innerHTML=reslt;
                         
		     } 
         	  }
             var queryString = "?hrs="+hrs+"&mins="+mins+"&vehcode="+vehcode+"&seldte="+seldte+"&vehno="+vehno;
            // alert(queryString);
	     ajaxRequest.open("GET", "Ajaxgetlocation.jsp" + queryString, true);
	     ajaxRequest.send(null); 
	
}
</script>
</head>

<head>
<title>Transworld Admin Module</title>
<STYLE>A:link {
	TEXT-DECORATION: none
}
A:visited {
	TEXT-DECORATION: none
}
</STYLE>
<link href="../css/css.css" rel="StyleSheet" type="text/css">
<!--<script src="../elabel.js" type="text/javascript"></script>
--><style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>
<script src="js/searchhi.js" type="text/javascript"></script>
</head>

<body background="images/green_grad_bot.jpg" onload="focusChild();">
<%!Connection conn,conn1; %>
<form name="tripend" action="" method="post" onSubmit="return validate();">
<% 
String vehcode="", vehreg="", stplace="", endplace="", stdate="", sttime="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";
String finalCatagory="-";
double stlat=0, stlong=0, endlat=0, endlong=0;
int oscount=0,account=0,dccount=0,distance=0,stopcount=0, stkm=0, endkm=0, totkm=0;
try {

	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);



Statement stquery=conn.createStatement(),stmt1=conn.createStatement(), stmt2=conn.createStatement(), stmt3=conn.createStatement(),stmt4=conn.createStatement(),dbCustCompStmt4=conn1.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="";

String location="", latitu="", longi="";
String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");
java.util.Date d=new java.util.Date();
String rfname="";//,rlname="";
String dte=new SimpleDateFormat("yyyy-MM-dd").format(d);
int hours=(d.getHours());
int minutes=(d.getMinutes());

	String loginuser=session.getAttribute("username").toString();
	String tripid=request.getParameter("tripid");
	String enddate=request.getParameter("calender1");
	String endhrs=request.getParameter("endtime1");
	String endmin=request.getParameter("endtime2");
	String comment=request.getParameter("comment");
	String othercomment=request.getParameter("othercomment");
	
	comment=comment+","+othercomment;
	String endtime=endhrs+":"+endmin+":00";	
	rfname=session.getAttribute("username").toString(); 

	
 	java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   	Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   	String nwfrmtdte=formatter.format(datefrmdb);

	java.util.Date datefrmdb1=new java.util.Date();
	Format formatter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   	String nwfrmtdte1=formatter1.format(datefrmdb1);

	String sql12="select * from t_completedjourney where TripId='"+tripid+"' ";
	ResultSet rs12=stmt1.executeQuery(sql12);
	if(rs12.next())
	{ %>
		<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="maroon"> <B>Trip End information for this Trip has already been entered. </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh the Open Trip Report page to reflect the changes. </font> </td>
			</tr>	
			</table>
<%	}
	else
	{

%>

<table border="1" width="100%" class="stats">
     <tr>
			<td colspan="2" align="center"> <font size="3" color="maroon"> <B> Trip End Information of <%=vehno%> </B> </font> </td>
     </tr>		
     <tr>
			<td> <font size="2" color="maroon"> Arrival Date </font> </td>
			<td> <input type="text" id="calender1" name="calender1" size="15" value="<%=nwfrmtdte%>" readonly="readonly"  />
			 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <input type="button" name="trigger1" id="trigger1" value="Date" />
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 onClose    : closed,
                 button      : "trigger1"       // ID of the button
               	 
                     
                    
             }
                           );
             </script>
             <input type="hidden" id="vehregno" name="vehregno" value="<%=vehno%>"/>
              <input type="hidden" id="vehcode" name="vehcode" value="<%=vehiclecode%>"/>
	</td>
	</tr>
     <tr>
	<td> <font color="maroon" size="2"> Arrival Time </font> </td>
	<td> <font color="maroon" size="2">
	            HH : </font> <select name="endtime1" onChange="showlocation(this, <%=vehiclecode%>, '<%=vehno%>');">
                   <option value="Select">Select</option>
                   <option value="00" <% if(00==hours) { %> selected="selected" <% } %> >00</option>
                   <option value="01" <% if(01==hours) { %> selected="selected" <% } %>>01</option>
                   <option value="02" <% if(02==hours) { %> selected="selected" <% } %>>02</option>
                   <option value="03" <% if(03==hours) { %> selected="selected" <% } %>>03</option>
                   <option value="04" <% if(04==hours) { %> selected="selected" <% } %>>04</option>
                   <option value="05" <% if(05==hours) { %> selected="selected" <% } %>>05</option>
                   <option value="06" <% if(06==hours) { %> selected="selected" <% } %>>06</option>
                   <option value="07" <% if(07==hours) { %> selected="selected" <% } %>>07</option>
                   <option value="08" <% if(8==hours) { %> selected="selected" <% } %>>08</option>
                   <option value="09" <% if(9==hours) { %> selected="selected" <% } %>>09</option>
                   <option value="10" <% if(10==hours) { %> selected="selected" <% } %>>10</option>
                   <option value="11" <% if(11==hours) { %> selected="selected" <% } %>>11</option> 
                   <option value="12" <% if(12==hours) { %> selected="selected" <% } %>>12</option>
                   <option value="13" <% if(13==hours) { %> selected="selected" <% } %>>13</option>
                   <option value="14" <% if(14==hours) { %> selected="selected" <% } %>>14</option>
                   <option value="15" <% if(15==hours) { %> selected="selected" <% } %>>15</option>
                   <option value="16" <% if(16==hours) { %> selected="selected" <% } %>>16</option>
                   <option value="17" <% if(17==hours) { %> selected="selected" <% } %>>17</option>
                   <option value="18" <% if(18==hours) { %> selected="selected" <% } %>>18</option>
                   <option value="19" <% if(19==hours) { %> selected="selected" <% } %>>19</option>
                   <option value="20" <% if(20==hours) { %> selected="selected" <% } %>>20</option>
                   <option value="21" <% if(21==hours) { %> selected="selected" <% } %>>21</option> 
                   <option value="22" <% if(22==hours) { %> selected="selected" <% } %>>22</option>
                   <option value="23" <% if(23==hours) { %> selected="selected" <% } %>>23</option>
            	 </select>  <font color="maroon" size="2">
        		MM :</font> <select name="endtime2" onChange="showlocation(this,<%=vehiclecode%>,'<%=vehno%>');">
        			  <option value="00" <% if(minutes > 00 & minutes < 05) { %> selected="selected" <% } %>>00</option>
        	          <option value="10" <% if(minutes > 05 & minutes < 15) { %> selected="selected" <% } %>>10</option>
        	          <option value="20" <% if(minutes > 15 & minutes < 25) { %> selected="selected" <% } %>>20</option>
        	          <option value="30" <% if(minutes > 25 & minutes < 35) { %> selected="selected" <% } %>>30</option>
        	          <option value="40" <% if(minutes > 35 & minutes < 45) { %> selected="selected" <% } %>>40</option> 
        	          <option value="50" <% if(minutes > 45) { %> selected="selected" <% } %>>50</option>
        	          
        	    </select> &nbsp;&nbsp;&nbsp;
                 
	</td>
     </tr>
     <tr>
     <td>Comments</td>
     <td>
     <select id="comment" name="comment">
     <option value="select">Select</option>
     <%
     String commentsSql="Select Comment from t_commentlist where Listname='endtrip' order by Comment";
     ResultSet commRst=dbCustCompStmt4.executeQuery(commentsSql);
     while(commRst.next())
     {
     %>
     <option value="<%=commRst.getString("Comment") %>"><%=commRst.getString("Comment") %></option>
     <%} %>
     </select> 
     
     </td>
     </tr>
     <tr>
     <td>Other Comments</td>
     <td><textarea rows="2" cols="20" name="othercomment" id="othercomment"></textarea> </td>
     </tr>
     <tr>
     	
     <td colspan="2" align="center"> <input type="submit" name="submit" value="Submit" /> </td> 
     </tr>
</table>

<%
	sql10="select * from t_onlinedata where VehicleCode='"+vehiclecode+"' ";
	rs10=stmt1.executeQuery(sql10);
	if(rs10.next())
	{
		location=rs10.getString("Location");
		latitu=rs10.getString("LatitudePosition");
		longi=rs10.getString("LongitudePosition");
	}
	
	
%>

<div id="loc">
<table border="0" width="100%">
     <tr>
	<td colspan="2" align="left"> <font color="maroon" size="2"> Location at selected time is: 
	<a href="shownewmap.jsp?lat=<%=latitu %>&long=<%=longi %>&discription=<%=location %>" onclick="popWin=open('shownewmap.jsp?lat=<%=latitu %>&long=<%=longi %>&discription=<%=location %>', 'myWin','width=500, height=500'); popWin.focus(); return false"><%=location %></a>
	</font> 
	 </td>
     </tr>		
</table>
</div>
<table border="0" width="100%">
     <tr>
	<td colspan="2" align="center"><a href="javascript:window.close();">Close </a> </td>
     </tr>		
</table>


<%
//System.out.println("shoaib");
String ss6="select Category from t_alljddata where TripId='"+tripid+"'";
ResultSet rs6=stmt1.executeQuery(ss6);
if(rs6.next())
{
	 String category = rs6.getString("Category");
	if(category.equalsIgnoreCase("Primary"))
	{
	finalCatagory="Primary";
	
	}else if(category.equals("BPL")||(category.equals("Tanker")))
	{
	finalCatagory="Tanker";
	}
	else
	{
	finalCatagory="Secondary";
	}
}	
		String sql="";
		sql1="select * from t_startedjourney where TripId='"+tripid+"' ";
		rs1=stmt1.executeQuery(sql1);
		if(rs1.next())
		{
			vehcode=rs1.getString("Vehid");
			vehreg=rs1.getString("VehRegNo");
			stplace=rs1.getString("StartPlace");
			endplace=rs1.getString("EndPlace");
			stdate=rs1.getString("StartDate");
			sttime=rs1.getString("StartTime");
			driverid=rs1.getString("DriverCode");
			drivername=rs1.getString("DriverName");
			stcode=rs1.getString("StartCode");
			endcode=rs1.getString("EndCode");
			gpname=rs1.getString("GPName");
			ownername=rs1.getString("OwnerName");
			
		}
		try{
			sql11="select * from t_defaultvals where OwnerName='"+ownername+"'";
			ResultSet rst1=stmt1.executeQuery(sql11);

			if(rst1.next())
			{	
				sql11="select * from t_defaultvals where OwnerName='"+ownername+"'";
			}
			else
			{
				sql11="select * from t_defaultvals where OwnerName='Default'";
				
			}
			ResultSet rst11=stmt2.executeQuery(sql11);
			//System.out.println("Stop 11  "+sql11);
			if(rst11.next())
			{
			session.setAttribute("stop11",rst11.getString("ST"));
			}
			}catch(Exception ex)
			{
				System.out.println("Exception"+ex);
				session.setAttribute("stop11","0");
			}
		} 

		if((sttime==null) || (sttime.equals("")))
		{
			sttime="00:00:00";	
		}
%>
	<input type="hidden" name="stdate" value="<%=stdate%>" />
	<input type="hidden" name="sttime" value="<%=sttime%>" />
<%
	if(enddate==null)
	{
	}
	else
	{		
		//boolean flag=false;
		String Stamp="";
		oscount=0; 
		account=0; 
		dccount=0;
		int  ndcount=0, stcount=0;
		double osdur=0;
		sql11="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1 ";
		//sql11="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime) >=concat('"+stdate+"', '"+sttime+"') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs11=stmt1.executeQuery(sql11);
		 if(rs11.next())
		 {
			stkm=rs11.getInt("Distance");	 
		 }
		 
		 sql13="select * from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by concat(TheFieldDataDate,TheFieldDataTime) desc limit 1 ";
		 //sql13="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		 rs13=stmt1.executeQuery(sql13);
		 if(rs13.next())
		 {
			endkm=rs13.getInt("Distance");	 
		 }
		 
		 totkm=endkm-stkm;	
		 
		 sql14="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and LonginDec>0 and TheFiledTextFileName in ('AC','DC','OS') order by concat(TheFieldDataDate,TheFieldDataTime) desc";
		 rs14=stmt1.executeQuery(sql14);
		 while(rs14.next())
		 {
			 Stamp=rs14.getString("TheFiledTextFileName");
			 
			 if (Stamp.equals("OS"))
			 {
				 oscount++;
				 osdur=osdur+rs14.getDouble("Distance");
			 }
			 else if (Stamp.equals("AC"))
			 {
			 	if (rs14.getInt("Distance")>5)
			 	{
			 		account++;
			 	}
			 }
			 else if (Stamp.equals("DC"))
			 {
					if (rs14.getInt("Distance")<120)
					{
						dccount++;	
					}
			 }		
		 }
		//System.out.println("549");
		 try{
		 sql15="select count(*) as cnt from t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) between '"+stdate+" "+sttime+"' and '"+enddate+" "+endtime+"'";
		 rs15=stmt2.executeQuery(sql15);
		 if(rs15.next())
		 {
			 ndcount=rs15.getInt("cnt");
		 }
		 }catch(Exception ex){System.out.println("exception "+ex);}
		 /*************************************code for stops**************************************** */

		//System.out.println("560");
		// System.out.println("Stop 11---->  "+session.getAttribute("stop11"));
	 	 sql16="select  *, (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+" "+endtime+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
		
		 rs16= stmt1.executeQuery(sql16);
		 //System.out.print("\nsql16="+sql16);
		 while(rs16.next())
		 {
		 	sql17="select  *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFieldDataDate='"+rs16.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+Double.parseDouble(rs16.getString("time1"))+" and abs(LatinDec - "+rs16.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
		 	//System.out.print("\n"+sql17);
		 	rs17= stmt3.executeQuery(sql17);
		 	if(rs17.next())
		 	{
		 		if(rs17.getDouble("time2")-rs16.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
		 		{
		 			stcount++;
		 		}
		 	}
		 }	
		// System.out.println("578");
		 /* ************************************************************************* */
		 
		 /* **********************Calculating Rating********************* */
		 	double rating=0;
		 	if(totkm>0)
		 	{
		 		rating=(account/totkm)*100 + (dccount/totkm)*100 +((osdur/10)/totkm)*100;
		 	}
		 
		 /* ************************************************************************* */
			sql18="select * from t_completedjourney where VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+tripid+"' ";
		    //System.out.println("Selectsql::>>"+sql18);  
			rs18=stmt4.executeQuery(sql18);
			if(rs18.next())
			{
				String tripid1=rs18.getString("TripId");
				String vehcode1=rs18.getString("VehId");
				String vehregno=rs18.getString("VehRegNo");
				String startplace=rs18.getString("StartPlace");
				String startdate=rs18.getString("StartDate");
				String starttime=rs18.getString("StartTime");
				String endplace1=rs18.getString("EndPlace");
				String enddate1=rs18.getString("EndDate");
				String endtime1=rs18.getString("EndTime");
				String driverid1=rs18.getString("DriverId");
				String drivername1=rs18.getString("DriverName");
				String ownername1=rs18.getString("OwnerName");
				String gpname1=rs18.getString("GPName");
				String jdcode=rs18.getString("JDCode");
				sql2="update t_completedjourney SET JDCode='"+jdcode+"',VehId='"+vehcode+"', VehRegNo='"+vehregno+"',StartPlace='"+startplace+"',StartDate='"+startdate+"',StartTime='"+starttime+"',EndPlace='"+endplace+"',EndDate='"+enddate1+"',EndTime='"+endtime1+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"',OwnerName='"+ownername+"',GPName='"+gpname+"',Comment1='"+comment+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"'";
				//sql2="update t_completedjourney SET JDCode='"+tripid+"',VehId='"+vehcode+"', VehRegNo='"+vehreg+"',StartPlace='"+stplace+"',StartDate='"+stdate+"',StartTime='"+sttime+"',EndPlace='"+endplace+"',EndDate='"+enddate+"',EndTime='"+endtime+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"',OwnerName='"+user+"',GPName='"+user+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and StartPlace='"+startplace+"' and StartDate='"+startdate+"' and StartTime='"+starttime+"' and EndPlace='"+endplace+"' DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"'";
				//System.out.println("Updatesql::>>>"+sql2);
				stmt4.executeUpdate(sql2);
				String abcd=sql2.replace("'","#");
				abcd=abcd.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			}
			else
			{
				//sql2="insert into t_completedjourney (TripId,JDCode, VehId, VehRegNo, StartPlace, StartDate, StartTime, EndPlace, EndDate, EndTime, JourneyStatus, DriverId, DriverName, OwnerName, GPName) values ('"+tripid+"','"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stdate+"', '"+sttime+"', '"+endplace+"', '"+enddate+"', '"+endtime+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+user+"', '"+user+"') ";   
	         	  //out.print(sql2);
			   // stmt1.executeUpdate(sql2);
			
		
			sql2="insert into t_completedjourney (TripId, VehId, VehRegNo, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, JourneyStatus, DriverId, DriverName, OwnerName, GPName, JDCode, RACount, RDCOunt, OSCOunt, NDCount, StopDuration, OSDuration, TripRating,Comment1,TripCategory) values ('"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stcode+"', '"+stdate+" "+sttime+"', '"+sttime+"', '"+endplace+"', '"+endcode+"', '"+enddate+" "+endtime+"', '"+endtime+"', '"+stkm+"', '"+endkm+"', '"+totkm+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+ownername+"', '"+gpname+"', '"+tripid+"', '"+account+"', '"+dccount+"', '"+oscount+"', '"+ndcount+"', '"+stcount+"', '"+osdur+"', '"+rating+"','"+comment+"','"+finalCatagory+"') ";   
	        //System.out.print("Insertsql::>>>"+sql2);
			stmt1.executeUpdate(sql2);
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			}  
			  sql3="update t_startedjourney set JStatus='Completed',EndedBy='"+rfname+"' where TripID='"+tripid+"' ";
			//  System.out.println("Updatesql2::>>>"+sql3);
			   stmt1.executeUpdate(sql3); 
			   String abcd1=sql3.replace("'","#");
				abcd1=abcd1.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");

			 sql4="select * from t_warehousedata where WareHouseCode='"+stcode+"' and Owner='"+ownername+"' ";
			//out.print(sql4);
      			 rs4=stmt1.executeQuery(sql4);
        		 if(rs4.next())
        		 {
		
        		 }
				 else
     			{
        		      sql5="select * from t_veh"+vehcode+" where TheFieldDataDate='"+stdate+"' and TheFieldDataTime<='"+sttime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
				//out.print(sql5);
        		     rs5=stmt1.executeQuery(sql5);
        		      if(rs5.next())
        		      { 
        		          stlat=rs5.getDouble("LatinDec");
        		          stlong=rs5.getDouble("LonginDec");

				  sql6="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('-', '"+stplace+"', '"+ownername+"', '"+ownername+"', '"+stlat+"', '"+stlat+"', '"+stlat+"', '"+stlong+"', '"+stlong+"', '"+stlong+"', 'WH',  GeomFromText('POINT("+stlat+" "+stlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
				//System.out.println("sql6="+sql6);
              
        		 stmt1.executeUpdate(sql6); 
				String abcd=sql6.replace("'","#");
				abcd=abcd.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
        		         
        		      } 
        		}

             
			 sql7="select * from t_warehousedata where WareHouseCode='"+endcode+"' and Owner='"+ownername+"' ";
    	
        		 rs7=stmt1.executeQuery(sql7);
        		 if(rs7.next())
        		 {
				//out.print("in if");
        		 }
			 else
        		 {
        		      sql8="select * from t_veh"+vehcode+" where TheFieldDataDate='"+enddate+"' and TheFieldDataTime<='"+endtime+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
        		      rs8=stmt1.executeQuery(sql8);
        		      if(rs8.next())
        		      { 
        		          endlat=rs8.getDouble("LatinDec");
        		          endlong=rs8.getDouble("LonginDec"); 
		
				sql9="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('"+endplace+"', '"+endplace+"', '"+ownername+"', '"+ownername+"', '"+endlat+"', '"+endlat+"', '"+endlat+"', '"+endlong+"', '"+endlong+"', '"+endlong+"', 'WH', GeomFromText('POINT("+endlat+" "+endlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
              	//.out.println("sql9="+sql9);	
        		    stmt1.executeUpdate(sql9); 
				String abcd=sql9.replace("'","#");
				abcd=abcd.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
        		 
        		      }
          
        		 }
%>   
		
		
			<table border="0" width="100%">
			<tr>
				<td align="center"> <font color="maroon"> <B>Successfully Done </B> </font> </td>
			</tr>
			<tr>
				<td align="center"> <font color="maroon"> <B> Note: </B> Please refresh the Open Trip Report page to reflect the changes. </font> </td>
			</tr>	
			</table>

<%
		
	//} //close of outer else
} //close of MAIN ELSE


   } catch(Exception e) { out.println("Exception----->" +e); 
   }
finally
{
	try{
conn.close();
conn1.close();
	}
	catch(Exception ex)
	{}
} 
  
%>

</form>
</body>
</html>

	
