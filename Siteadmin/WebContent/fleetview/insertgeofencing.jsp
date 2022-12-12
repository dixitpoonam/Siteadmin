<%@ include file="conn.jsp" %>
<%!
Statement st,st1,st2,stquery;
String trnas,vehcode,thedate,thetime,loccode,locname,loctype,latitude,longitude,geofencetype,add,lat,lon;
String sql;Connection conn;
%>
<%
String rfname=session.getAttribute("username").toString(); 	
trnas=request.getParameter("trans");
	vehcode=request.getParameter("vehicle");
	thedate=request.getParameter("thedate");
	thetime=request.getParameter("thetime");
	loccode=request.getParameter("locationcode");
	locname=request.getParameter("location");
	loctype=request.getParameter("loctype");
	lat=request.getParameter("lat");
	lon=request.getParameter("lon");
	geofencetype=request.getParameter("geofencetype");
	add=request.getParameter("add");
	String today;
	today=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
	//out.print(add);
	try
	{
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		stquery=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();
		if(geofencetype.equals("datetime"))
		{
			sql="select * from t_veh"+vehcode+" where TheFieldDataDate='"+thedate+"' and TheFieldDataTime >='"+thetime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime limit 2";
			System.out.println("@@@@@@ "+sql);
			ResultSet rst=st.executeQuery(sql);
			if(rst.next())
			{
				latitude=rst.getString("LatinDec");
				longitude=rst.getString("LonginDec");
				System.out.println("latitude "+latitude);
				System.out.println("longitude "+longitude);
			}
		}
		else{
			
			latitude=lat;
			longitude=lon;
		}
		String str="Select * from t_warehousedata where Owner='"+trnas+"' and WareHouseCode='"+loccode+"' OR WareHouse='"+locname+"'";
		ResultSet rsget=st2.executeQuery(str);
		System.out.println("@@@@@@ "+str);
		if(rsget.next())
		{
			response.sendRedirect("geofencelocation.jsp?duplicate=yes&trans="+trnas+"&loccode="+loccode+"&locname="+locname);
		}
		else
			{
				sql="insert into t_warehousedata (WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,EntBy,UpdatedDate,vehicleindepot) values ('"+loccode+"','"+locname+"','"+trnas+"','"+latitude+"','"+longitude+"','"+loctype+"','"+rfname+"','"+today+"','"+add+"')";
				st1.executeUpdate(sql);
				System.out.println("@@@@@@ "+sql);
				if(add.equals("Yes"))
				{
					sql="insert into t_waypoints (Name,Discription,Lat,Lon,OwnerName) values ('"+locname+"','"+locname+"','"+latitude+"','"+longitude+"','"+trnas+"')";
					
					String abcd1=sql.replace("'","#");
	        		abcd1=abcd1.replace(",","$");
	        		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
					st1.executeUpdate(sql);
					System.out.println("@@@@@@ "+sql);
				}
			}
			response.sendRedirect("geofencelocation.jsp?res=success");
			
	}catch(Exception e)
	{
		out.print("Exception ---->"+e);
	}	
	finally
	{
        st.close();
        st1.close();
        st2.close();
		conn.close();
	}
%>
<%@ include file="footerhtml.jsp" %>