
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%><%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>

<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
 
<%!
private static void deletefile(String file){
    File f1 = new File(file);
    boolean success = f1.delete();
    if (!success){
      System.out.println("Deletion failed.");
      System.exit(0);
    }else{
      System.out.println("File deleted.");
    }
  }
Connection con1;
%>

<%
try {
	String EntBy="-";
	try
	{
	 EntBy=session.getAttribute("username").toString();
	}
	catch(Exception e)
	{
		response.sendRedirect("../index.jsp?err=err2");
		return;
	}
    Class.forName(MM_dbConn_DRIVER);
    con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
    Statement stmt1=con1.createStatement(),stmt2=con1.createStatement(),stmt3=con1.createStatement(),stmt4=con1.createStatement(),stmt5=con1.createStatement(),stmt6=con1.createStatement(),stmt7=con1.createStatement();
    ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
    String sql1=""; 
   String cntr=request.getParameter("len");
   String routeName=request.getParameter("routeName");
  int cntrint=Integer.parseInt(cntr);
  System.out.println(cntrint);
  String[] uncntchk;
String status="0";
  String[] x = new String[cntrint];
  String[] trip = request.getParameterValues("list");
  Boolean flag=false;
for(int i=0; i<trip.length; i++) 
  {
          //x[i] = request.getParameter("list");
		String tripid="",startpalce="",endplace="",Datetime="",kmlfilename="";
		//Date entDate= new Date();
		Datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		String str="Update t_kmltrip set status='"+status+"',Datetime='"+Datetime+"',EntBy='"+EntBy+"' where tripid='"+trip[i]+"'";
		System.out.println("str"+str);
		int cnt=stmt1.executeUpdate(str);
		if(cnt!=0)
			flag=true;
		
	
		Double Distance=0.0;
		String str1="Select * from t_kmltrip where tripid='"+trip[i]+"'";
		System.out.println("str1"+str1);
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
		String str2="Insert into t_kmltriphistory(tripid,startpalce,endplace,Distance,status,kmlfilename,Datetime,EntBy) values('"+tripid+"','"+startpalce+"','"+endplace+"','"+Distance+"','"+status+"','"+kmlfilename+"','"+Datetime+"','"+EntBy+"')";
		System.out.println("str2"+str2);
		stmt3.executeUpdate(str2);
		String file=request.getRealPath("/");
		file=file+"KMLFiles/"+kmlfilename;
		try
         {
			 File f1 = new File(file);
                 flag=f1.delete();
                // System.out.println(flag);
         }
         catch(Exception e)
         {
                 e.printStackTrace();
         }
        }
  
response.sendRedirect("RouteCheck.jsp?flag="+flag+"&owner="+routeName);
}catch(Exception e)
{
	e.printStackTrace();
}

%>