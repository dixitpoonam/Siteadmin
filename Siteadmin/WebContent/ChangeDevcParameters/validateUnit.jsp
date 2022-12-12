<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
    import="java.sql.Connection" import="java.sql.DriverManager" import="java.util.*"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
<%@ include file="headerhtml.jsp" %>
<%! 
Statement st,st1;
String sql;
String ss1="";
Format frt1=new SimpleDateFormat("yyyy-MM-dd");
java.util.Date today=new java.util.Date();
String tdt=frt1.format(today);

%>
<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	out.println("-----On Validate-------");
	st=conn.createStatement();
	st1=conn.createStatement();
}
catch(Exception e)
{
	out.print("Connection Exception---->"+e);
}
try
{
	String uid=request.getParameter("uid");
	String codeVer="";
	String todaysDate=tdt+" 23:59:59";
	String sqlGetVersion="select CodeVersion from t_ftpdump where UnitID='"+uid+"' and Filedatetime<='"+todaysDate+"' order by Filedatetime desc limit 1";
	out.println("sqlGetVersion");
	ResultSet rsGetVersion=st.executeQuery(sqlGetVersion);
	if(rsGetVersion.next())
	{
		codeVer=rsGetVersion.getString("CodeVersion");
	}
	else
	{
		String sqlFrmUnitMaster="select SwVer from t_unitmasterhistory where UnitID='"+uid+"' and concat(EntDate,' ',EntTime)<='"+todaysDate+"' order by EntDate desc, EntTime desc limit 1";
		out.println("sqlFrmUnitMaster");
		ResultSet rsFrmUnitMaster=st1.executeQuery(sqlFrmUnitMaster);
		if(rsFrmUnitMaster.next())
		{
			codeVer=rsFrmUnitMaster.getString("SwVer");
		}
	}
	//AVL_VER_4.9.9_3S 	AVL_VER_4.9.9_4S 	AVL_VER_4.9.9_5S  AVL_VER_5.04S
	out.println("Version--->>"+codeVer);
	boolean flg=false;
	String[] version={"AVL_VER_4.9.9_3S", "AVL_VER_4.9.9_4S", "AVL_VER_4.9.9_5S", "AVL_VER_5.04S"}; 
	for(int i=0;i<4;i++)
	{
		if(codeVer.equals(version[i]))
		{
			flg=true;
			break;
		}
	}
	out.println("Flag-------->>"+flg);
	if(flg==true)
	{
		%>
        <jsp:forward page="createDota.jsp">
        <jsp:param name="flag" value="Y"/>
        <jsp:param name="version" value="<%=codeVer%>"/>
        </jsp:forward>
        <% 
	}
	else
	{
		%>
        <jsp:forward page="updateDota.jsp">
        <jsp:param name="flag" value="N"/>
        </jsp:forward>
        <%
	}
	

}
catch(Exception e)
{
	out.print("Exception---->"+e);
}finally{
	conn.close();
}
%>