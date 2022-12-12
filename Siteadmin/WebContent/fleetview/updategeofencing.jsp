<%@ include file="conn.jsp" %>

<%!
Connection con1;
Statement st1;
Statement st2;
Statement st3;
Statement st4;
Statement st5;
Statement st6;
Statement st7;
Statement stquery;
%>

<%
String rfname=session.getAttribute("username").toString(); 	
String name=request.getParameter("name");//warehouse
String code=request.getParameter("code");//warehouse code
String name1=request.getParameter("name1");//warehouse
String code1=request.getParameter("code1");//warehouse code
String type=request.getParameter("loctype");
String type1=request.getParameter("type1");
String owner=request.getParameter("trans");
String depot=request.getParameter("add");
String lati=request.getParameter("lati");
String lati1=request.getParameter("lati1");
String longi=request.getParameter("longi");
String longi1=request.getParameter("longi1");
String lat="0",lon="0";
System.out.println("rfname "+rfname);
System.out.println("name "+name);
System.out.println("name1 "+name1);
System.out.println("code "+code);
System.out.println("code1 "+code1);
System.out.println("type "+type);
System.out.println("type1 "+type1);
System.out.println("owner "+owner);
System.out.println("depot "+depot);


String tmpwareHouseCode="-",tmpwareHouse="-",tmpowner="-",tmpwtype="-",tmpTransporter="-",tmplocation=null,tmpentby="-",tmptodaydate="-",tempvehdepot="-";
double tmplat=0.00,tmpSLatitude=0.00,tmpELatitude=0.00,tmpSLongitude=0.00,tmpELongitude=0.00,tmplon=0.00;
boolean flag=false;
String today;
String sql1="", sql2="",sql3="",sql4="",sql5="",sql6="";

try 
{
	today=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	//System.out.println("today---->"+today); 
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	 st1=con1.createStatement();
	 st2=con1.createStatement();
	 st3=con1.createStatement();
	 st4=con1.createStatement();
	 st5=con1.createStatement();
	 st6=con1.createStatement();
	 st7=con1.createStatement();
	 stquery=con1.createStatement();
	ResultSet rs1=null, rs2=null,rs3=null,rs=null,rs4=null;
	
	sql1="Select * from t_warehousedata where WareHouseCode='"+code+"' and WareHouse= '"+name+"' and WType='"+type+"' and vehicleindepot='"+depot+"' and Owner like '"+owner+"' and Latitude like '"+lati+"' and Longitude like '"+longi+"' ";
	System.out.println("@@@@@@ "+sql1);
	rs=st1.executeQuery(sql1);
	if(rs.next())
	{
		flag=false;
		System.out.println("###########");
		response.sendRedirect("EditGeofence.jsp?Msg=1&name="+name1+"&code="+code1+"&type="+type1+"&trans="+owner+"&lati="+lati+"&longi="+longi);
		}
	else
	{
		if(code1.equalsIgnoreCase(code))
		{
			System.out.println("$$$$$$$$$$$$");
			flag=true;
		}
		else
		{
		 sql2="Select * from t_warehousedata where WareHouseCode='"+code+"' and Owner= '"+owner+"'";
		 System.out.println("@@@@@@ "+sql2);
		 rs1=st1.executeQuery(sql2);
		 if(rs1.next())
		 {
			 System.out.println("&&&&&&&&&&&&");
			 flag=false;
			 response.sendRedirect("EditGeofence.jsp?Msg=2&name="+name1+"&code="+code1+"&type="+type1+"&trans="+owner+"&lati="+lati+"&longi="+longi);
		 }
		 else
		 {
			 System.out.println("***********");
			 flag=true;
		 }
		}
		System.out.println(flag);
		if(flag==true)
		{
			sql2="Select * from t_warehousedata where WareHouseCode='"+code1+"' and WareHouse= '"+name1+"' and WType='"+type1+"' and Owner like '"+owner+"'";
			System.out.println("@@@@@@ "+sql2);
			rs2=st2.executeQuery(sql2);
			
			if(rs2.next())
			{
				tmpwareHouseCode=rs2.getString("WareHouseCode");
				tmpwareHouse=rs2.getString("WareHouse");
				tmpowner=rs2.getString("Owner");
				tmpwtype=rs2.getString("WType");
				tmpTransporter=rs2.getString("Transporter");
				tmplat=rs2.getDouble("Latitude");
				tmpSLatitude=rs2.getDouble("SLatitude");
				tmpELatitude=rs2.getDouble("ELatitude");
				tmpSLongitude=rs2.getDouble("SLongitude");
				tmpELongitude=rs2.getDouble("ELongitude");
				tmplon=rs2.getDouble("Longitude");
				tmplocation=rs2.getString("Location");
				tmpentby=rs2.getString("EntBy");
				tmptodaydate=rs2.getString("UpdatedDate");
				//temprad=rs2.getString("Radius");
				tempvehdepot=rs2.getString("VehicleInDepot");
			}
			
			sql2="insert into t_warehousedatahistory(WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,Location,EntBy,VehicleInDepot,UpdatedDate) values('"+tmpwareHouseCode+"','"+tmpwareHouse+"','"+tmpowner+"','"+tmpTransporter+"','"+tmplat+"','"+tmpSLatitude+"','"+tmpELatitude+"','"+tmplon+"','"+tmpSLongitude+"','"+tmpELongitude+"','"+tmpwtype+"',"+tmplocation+",'"+tmpentby+"','"+tempvehdepot+"','"+tmptodaydate+"')";
			System.out.println("@@@@@@ "+sql2);
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			
			st2.executeUpdate(sql2);
			
			sql2="update t_warehousedata set WareHouseCode='"+code+"', WareHouse='"+name+"',WType='"+type+"', EntBy='"+rfname+"',VehicleInDepot='"+depot+"',Latitude='"+lati+"',Longitude='"+longi+"',UpdatedDate='"+today+"'  where Owner like '"+owner+"' and  WareHouse='"+name1+"' and WareHouseCode='"+code1+"' and WType='"+type1+"' ";
		
			/*sql3="select * from db_gps.t_warehousedata where (WareHouseCode='"+code1+"' and WareHouse= '"+name1+"' and WType='"+type1+"' and  Owner like '"+owner+"')";
			System.out.println("@@@@@@ "+sql3);
			rs3=st3.executeQuery(sql3);
			if(rs3.next())
			{
				lat=rs3.getString("Latitude");
				lon=rs3.getString("Longitude");
			}
			*/
			sql3="select * from db_gps.t_waypoints where Name='"+name1+"' and Lat like '"+lati1+"' and Lon like '"+longi1+"' and OwnerName like '"+owner+"' ";
			System.out.println("@@@@@@ "+sql3);
			String abcd1=sql3.replace("'","#");
			abcd1=abcd1.replace(",","$");
			rs3=st3.executeQuery(sql3);
			if(rs3.next())
			{
				if(depot.equalsIgnoreCase("Yes"))
				{
					//System.out.println("108 Hii");
					sql4="update db_gps.t_waypoints set Name='"+name+"',Discription='"+name+"',Lat='"+lati+"',Lon='"+longi+"'  where OwnerName like '"+owner+"' and  Name='"+name1+"' and Lat like '"+lat+"' and Lon  like '"+lon+"' ";
					System.out.println(" 122 sql4---->"+sql4);
					String abc=sql4.replace("'","#");
					st4.executeUpdate(sql4);
				}
				else if(depot.equalsIgnoreCase("No"))
				{
					//System.out.println("108 Hii");
					sql4="delete from  db_gps.t_waypoints where OwnerName like '"+owner+"' and  Name='"+name1+"' and Lat like '"+lati1+"' and Lon like '"+longi1+"' ";
					System.out.println(" 129 sql4---->"+sql4); 
					String ab=sql4.replace("'","#");
					st4.executeUpdate(sql4);
				}
			}
			else
			{
				if(depot.equalsIgnoreCase("Yes"))
				{
					sql4="insert into db_gps.t_waypoints(Name,Discription,Lat,Lon,OwnerName) values ('"+name+"','"+name+"','"+lati+"','"+longi+"','"+owner+"')";
					System.out.println("138 sql4---->"+sql4);  
					st4.executeUpdate(sql4);
				}	
			}
			String abcd2=sql4.replace("'","#");
			abcd2=abcd2.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
		
		
			
			if(lati1==lati || longi1==longi){
				
			}
			else
			{
				System.out.println(">>>>INside If clause");	
			String sqcode = "select * from db_gps.t_startedjourney where ConsideredLatLon = 'shiptocode' and Ship_To = '"+code1+"' and JStatus in ('Running','tobeclosed') order by StartDate";
			ResultSet rscode = st5.executeQuery(sqcode);
			
			while(rscode.next())
			{
				String sqlatlon = "update  db_gps.t_startedjourney set EndLat = '"+lati+"', EndLong = '"+longi+"' where  endcode = '"+code1+"' and StartDate='"+rscode.getString("StartDate")+"' and Starttime='"+rscode.getString("Starttime")+"' and TripId = '"+rscode.getString("TripId")+"'";
				 st7.executeUpdate(sqlatlon);
				  abcd2=sqlatlon.replace("'","#");
					abcd2=abcd2.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
			}
			
			
			String sqcode1 = "select * from db_gps.t_startedjourney where ConsideredLatLon = 'endcode' and endcode = '"+code1+"' and JStatus in ('Running','tobeclosed') order by StartDate";
			ResultSet rscode1 = st6.executeQuery(sqcode1);
			
			while(rscode1.next())
			{
				String sqlatlon = "update  db_gps.t_startedjourney set EndLat = '"+lati+"', EndLong = '"+longi+"' where  endcode = '"+code1+"' and StartDate='"+rscode1.getString("StartDate")+"' and Starttime='"+rscode1.getString("Starttime")+"' and TripId = '"+rscode1.getString("TripId")+"'";
				 st7.executeUpdate(sqlatlon);
				//System.out.println(sqlatlon);
				 abcd2=sqlatlon.replace("'","#");
					abcd2=abcd2.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
			}
			
			}
			
			
		}
		System.out.println("@@@@@@ "+sql2);
		st2.executeUpdate(sql2);
		response.sendRedirect("EditGeofence.jsp?Msg=3");
		return;
	}
	
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception----------> "+e);
}
finally
{
	try{
		 st1.close();
         st2.close();
         st3.close();
         st4.close();
         st5.close();
         st6.close();
         stquery.close();
		con1.close();
	}
	catch(Exception e)
	{
		
	}

}
%>

