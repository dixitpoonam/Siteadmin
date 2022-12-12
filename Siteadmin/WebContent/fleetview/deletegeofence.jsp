<%@ include file="conn.jsp" %>

<%!
Connection con1;
Statement st1;
Statement st2;
Statement st3;
Statement st4;
Statement st5;
Statement st6;
Statement stquery;
%>
<%
String rfname=session.getAttribute("username").toString(); 	
String name=request.getParameter("name");//warehouse
String code=request.getParameter("code");//warehouse code
String type=request.getParameter("loctype");
String owner=request.getParameter("trans");

String tmpwareHouseCode="-",tmpwareHouse="-",tmpowner="-",tmpwtype="-",tmpTransporter="-",tmplocation=null,tmpentby="-",tmptodaydate="-",tempvehdepot="-";
	double tmplat=0.00,tmpSLatitude=0.00,tmpELatitude=0.00,tmpSLongitude=0.00,tmpELongitude=0.00,tmplon=0.00;
	String today;
	 int i=1;
    String lat="0",lon="0";
    String sql1="", sql2="",sql3="",sql4="",sql5="",sql6="";
    boolean flag1=false;
    try 
	{
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		 st1=con1.createStatement();
		 st2=con1.createStatement();
		 st3=con1.createStatement();
		 st4=con1.createStatement();
		 st5=con1.createStatement();
		 st6=con1.createStatement();
		 stquery=con1.createStatement();
		
		ResultSet rs1=null, rs2=null,rs3=null,rs4=null;
		
		if((name==null)||(name=="")||(code==null)||(code==""))
		{
			flag1 = false;
				response.sendRedirect("deletegeofencing.jsp?Msg=No&name="+name+"&code="+code+"&type="+type+"&trans="+owner);
		}	
		else{
			flag1 = true;
			sql1="Select * from t_warehousedata where WareHouseCode='"+code+"' and WareHouse= '"+name+"' and WType='"+type+"' and Owner like '"+owner+"'";
			rs1 = st1.executeQuery(sql1);
			  System.out.println("$$$$$$$$$$ "+sql1);
			while(rs1.next())
			{
				tmpwareHouseCode=rs1.getString("WareHouseCode");
				tmpwareHouse=rs1.getString("WareHouse");
				tmpowner=rs1.getString("Owner");
				tmpwtype=rs1.getString("WType");
				tmpTransporter=rs1.getString("Transporter");
				tmplat=rs1.getDouble("Latitude");
				tmpSLatitude=rs1.getDouble("SLatitude");
				tmpELatitude=rs1.getDouble("ELatitude");
				tmpSLongitude=rs1.getDouble("SLongitude");
				tmpELongitude=rs1.getDouble("ELongitude");
				tmplon=rs1.getDouble("Longitude");
				tmplocation=rs1.getString("Location");
				tmpentby=rs1.getString("EntBy");
				tmptodaydate=rs1.getString("UpdatedDate");
				tempvehdepot=rs1.getString("VehicleInDepot");
			}
			
			sql1="insert into t_warehousedatahistory(WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,Location,EntBy,UpdatedDate,VehicleInDepot) values('"+tmpwareHouseCode+"','"+tmpwareHouse+"','"+tmpowner+"','"+tmpTransporter+"','"+tmplat+"','"+tmpSLatitude+"','"+tmpELatitude+"','"+tmplon+"','"+tmpSLongitude+"','"+tmpELongitude+"','"+tmpwtype+"',"+tmplocation+",'"+tmpentby+"','"+tmptodaydate+"','"+tempvehdepot+"')";
			
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			
			st1.executeUpdate(sql1);
			System.out.println("%%%%%%%%% "+sql1);
			
			sql1="delete from t_warehousedata where Owner like '"+owner+"' and  WareHouse='"+name+"' and WareHouseCode='"+code+"' limit 1";
		
			sql2="select * from db_gps.t_warehousedata where (WareHouseCode='"+code+"' and WareHouse= '"+name+"' and WType='"+type+"'  and Owner like '"+owner+"')";
			rs2=st2.executeQuery(sql2);
			System.out.println("^^^^^^^^^^ "+sql2);
			if(rs2.next())
			{
				lat=rs2.getString("Latitude");
				lon=rs2.getString("Longitude");
			}
			
			sql3="select * from db_gps.t_waypoints where Name='"+name+"' and Lat like "+lat+" and Lon like "+lon+" and Ownername='"+owner+"' ";
			rs3=st3.executeQuery(sql3);
			System.out.println("************ "+sql3);
			if(rs3.next())
			{
				sql4="delete from  db_gps.t_waypoints where OwnerName like '"+owner+"' and  Name='"+name+"' and Lat like "+lat+" and Lon like "+lon+" ";
			    st4.executeUpdate(sql4);
			    
			    String abcd2=sql4.replace("'","#");
				abcd2=abcd2.replace(",","$");
				stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd2+"')");
			}
			
			String abcd1=sql1.replace("'","#");
			abcd1=abcd1.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
			
			st1.executeUpdate(sql1);
			response.sendRedirect("deletegeofencing.jsp?Msg=Yes");
			
		}
	//	System.out.println("Hii");
    	//response.sendRedirect("displayGeofencedNames.jsp?Msg=Yes");
	}catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Exception--------->"+e);
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