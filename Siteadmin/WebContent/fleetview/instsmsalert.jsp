<%@ include file="headerhtml.jsp" %>
<%!
Statement st;
String trans,delayperiod,mobno,conname,sql;
String [] numbers,names;Connection conn;
%>
<%


Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
st=conn.createStatement();
trans=request.getParameter("trans");
delayperiod=request.getParameter("delayperiod");
mobno=request.getParameter("mobno");
conname=request.getParameter("contactname");

 numbers = mobno.split("\\,");
 names = conname.split("\\,");
     for (int x=0; x<numbers.length; x++)
     {
         sql="insert into t_contactinfo (Transporter,Mobile1,Name1,Status,DelayPeriod) values ('"+trans+"','"+numbers[x]+"','"+names[x]+"','Yes','"+delayperiod+"')";
      	out.print(sql);   
     }


}catch(Exception e)
{
	out.print("Exception ---> "+e);
}finally{
	conn.close();
}
%>
<%@ include file="footerhtml.jsp" %>