<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
 

<%!
Connection con1;
%>
<%
try {
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING3,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
          
    Class.forName(MM_dbConn_DRIVER);
	
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    Statement stmt1=con1.createStatement(),stmt2=con1.createStatement(),stmt3=con1.createStatement(),stmt4=con1.createStatement(),stmt5=con1.createStatement(),stmt6=con1.createStatement(),stmt7=con1.createStatement();
    ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
    
    Date dt=new Date();
    String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);

    String user=session.getAttribute("username").toString();
    String sql1=""; 
   String cntr=request.getParameter("cntr");
  int cntrint=Integer.parseInt(cntr);
  System.out.println(cntrint);
  String btn=request.getParameter("btnchk");
  String TripID=request.getParameter("RID");
  String status="";
  if(btn.equalsIgnoreCase("Active"))
	  status="1";
  else if(btn.equalsIgnoreCase("Deactive"))
	  status="0";
  
	  
  // ---------- get the tripid's through StringTokenizer that are selected 
   Boolean flag=false;
  StringTokenizer strtoken=new StringTokenizer(TripID,",");
		
  while(strtoken.hasMoreElements())
  {
	 
 
 /* String[] uncntchk;

  String[] x = new String[cntrint];
  String[] trip = new String[cntrint];
  Boolean flag=false;
for(int i=1; i<cntrint; i++) 
  {
          x[i] = request.getParameter("chk"+i );

		 if(x[i]==null)
          {

          }
          else
          {*/
		
		String trip=strtoken.nextToken();
		
		
		String str="Update t_kmltrip set status='"+status+"',Datetime='"+datetime+"',EntBy='"+user+"' where tripid='"+trip+"'";
		int cnt=stmt1.executeUpdate(str);
		if(cnt!=0)
			flag=true;
		
		String tripid="",startpalce="",endplace="",Datetime="",EntBy="",kmlfilename="";
		Double Distance=0.0;
		String str1="Select * from t_kmltrip where tripid='"+trip+"'";
		rs1=stmt2.executeQuery(str1);
		while(rs1.next())
		{
			tripid=rs1.getString("tripid");
			startpalce=rs1.getString("startpalce");
			endplace=rs1.getString("endplace");
			Distance=rs1.getDouble("Distance");
			Datetime=rs1.getString("Datetime");
			EntBy=rs1.getString("EntBy");
			kmlfilename=rs1.getString("kmlfilename");
		}
		String str2="Insert into t_kmltriphistory(tripid,startpalce,endplace,Distance,status,kmlfilename,Datetime,EntBy) values('"+tripid+"','"+startpalce+"','"+endplace+"','"+Distance+"','"+status+"','"+kmlfilename+"','"+datetime+"','"+user+"')";
		stmt3.executeUpdate(str2);
		
         }
 
response.sendRedirect("KMLReports.jsp?flag="+flag);
}catch(Exception e)
{
	e.printStackTrace();
}finally{
	con1.close();
}
%>