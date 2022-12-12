<%@ include file="conn.jsp" %>
<%
String UserName,sql,TypeOfUser;
Statement st,st1,st2;
%>
<%!
Connection conn;
%>
<%

try
	{ 
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	UserName=request.getParameter("UserName");
	sql="select TypeOfUser from t_security where TypeValue='"+UserName+"'";
	ResultSet rst=st.executeQuery(sql);
	if(rst.next())
	{
		TypeOfUser=rst.getString("TypeOfUser");
		if(TypeOfUser.equals("GROUP"))
		{
			sql="select transporter as Vehregno, vehCode as vehcode from t_group where GPName='"+UserName+"' order by transporter";
		}
		else
		{
			sql="select VehicleRegNumber as Vehregno, vehicleCode as vehcode from t_vehicledetails where OwnerName='"+UserName+"' and Status <> 'Deleted' order by VehicleRegNumber";
		}
		ResultSet rst1=st1.executeQuery(sql);
		%>
		<select name="vehicle" id="vehicle">		
		<option value="Select">Select</option>
		<%
		while(rst1.next())
		{
		%>
		<option value="<%=rst1.getString("vehcode")%>"><%=rst1.getString("Vehregno")%></option>
		<%
		}
		%>
		</select>			
		<%
	}
	else
	{
		String sql1="select transporter as Vehregno, vehCode as vehcode from t_group where GPName='"+UserName+"' order by transporter";
		ResultSet rst11=st2.executeQuery(sql1);
		%>
		<select name="vehicle" id="vehicle">		
		<option value="Select">Select</option>
		<%
		while(rst11.next())
		{
		%>
		<option value="<%=rst11.getString("vehcode")%>"><%=rst11.getString("Vehregno")%></option>
		<%
		}
		%>
		</select>			
		<%
	}

}catch(Exception e)
{
	out.print("Exception--->"+e);
}
finally
{
	conn.close();
}

%>
