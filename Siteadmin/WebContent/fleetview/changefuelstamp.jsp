<%@ include file="headerhtml.jsp" %>

<%!
Statement st,st1; Connection conn,conn1;
%>

<form name="analyzefueldata" method="get" action="" >
<%
	try{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn1.createStatement();
	java.util.Date tdydte = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = formatter.format(tdydte);
	
	int ftcount=0;
	int maxrid=0;
	String fielddate=request.getParameter("fielddate");
	String fieldtime=request.getParameter("fieldtime");
	String curlevel=request.getParameter("currfuellevel");
	String prevlevel=request.getParameter("prvfuellevel");
	String diff=request.getParameter("diff");
	String loc=request.getParameter("loc");
	String lon=request.getParameter("lon");
	String lat=request.getParameter("latin");
	String vehid=request.getParameter("vehid");
	String vehno=request.getParameter("vehno");
	String seldate1=request.getParameter("seldate1");
	String seldate2=request.getParameter("seldate2");
	String fuellevel=request.getParameter("fuellevel");
	String sql1="select * from t_onlinedata where VehicleCode='"+vehid+"'";
	ResultSet rs1=st.executeQuery(sql1);
	if(rs1.next())
	{
		ftcount=Integer.parseInt(rs1.getString("FTCount"));
		ftcount++;
	}
	String sql2="update t_onlinedata set FTCount='"+ftcount+"' where VehicleCode='"+vehid+"'";
	st.executeUpdate(sql2);
	
	String sql5="update t_veh"+vehid+" set TheFiledTextFileName='FT' where TheFieldDataDate='"+fielddate+"' and TheFieldDataTime='"+fieldtime+"' ";
	st.executeUpdate(sql5);
	
	String sql3="select max(rid)as mrid from t_vehft";
	ResultSet rs2=st1.executeQuery(sql3);
	if(rs2.next())
	{
		maxrid=rs2.getInt("mrid");
		maxrid++;
	}
	String sql4="insert into t_vehft(rid,VehCode,TheDate,TheTime,PrevLevel,CurrLevel,Diff,location,latitude,longitude)values('"+maxrid+"','"+vehid+"','"+fielddate+"','"+fieldtime+"','"+prevlevel+"','"+curlevel+"','"+diff+"','"+loc+"','"+lat+"','"+lon+"')";
	st1.executeUpdate(sql4);
						
	response.sendRedirect("analysealldata.jsp?updated=true&vehcode="+vehid+"&vehno="+vehno+"&date1="+seldate1+"&date2="+seldate2);
	return;
	
	}catch(Exception e)
	{
		out.print("Exception---->"+e);
	}
%>	
</form>
<%@ include file="footerhtml.jsp" %>


