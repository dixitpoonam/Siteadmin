<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.*" %>
<%@ page import="java.sql.PreparedStatement"  %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.DriverManager" %>
    
    <%!
	Connection conn;
	
	%>
<%!
public int nullIntconv(String str)
{   
    int conv=0;
    if(str==null)
    {
        str="0";
    }
    else if((str.trim()).equals("null"))
    {
        str="0";
    }
    else if(str.equals(""))
    {
        str="0";
    }
    try{
        conv=Integer.parseInt(str);
    }
    catch(Exception e)
    {
    }
    return conv;
}
%>

<script type="text/javascript">
function gotoExcel(elemId, frmFldId)  
{  
	      
          var obj = document.getElementById(elemId);
          var oFld = document.getElementById(frmFldId);
          oFld.value = obj.innerHTML;
          document.activeFleetviewUsers.action ="excel.jsp";
          document.forms["activeFleetviewUsers"].submit();
}
</script>

<%
Statement st = null;
Statement st1 = null;
Statement st2 = null;


		Connection conn = null;
		
		String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME = "fleetview";
		String MM_dbConn_PASSWORD = "1@flv";
		String MM_dbConn_GPS = "jdbc:mysql://localhost";            

		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();	
		
		ResultSet rsPagination = null;
	    ResultSet rsRowCnt = null;
	    
	    PreparedStatement psPagination=null;
	    PreparedStatement psRowCnt=null;
	    
	    int iShowRows=20;  // Number of records show on per page
	    int iTotalSearchRecords=10;  // Number of pages index shown
	    
	    int iTotalRows=nullIntconv(request.getParameter("iTotalRows"));
	    int iTotalPages=nullIntconv(request.getParameter("iTotalPages"));
	    int iPageNo=nullIntconv(request.getParameter("iPageNo"));
	    int cPageNo=nullIntconv(request.getParameter("cPageNo"));
	    
	    int iStartResultNo=0;
	    int iEndResultNo=0;

	    if(iPageNo==0)
	    {
	        iPageNo=0;
	    }
	    else{
	        iPageNo=Math.abs((iPageNo-1)*iShowRows);
	    }
		System.out.println("===========connection created=============");


		int counter=0;	
%>

<form name="ActiveFleetViewUsers" method="get"  onsubmit="return confirmSubmit()" action="">
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="3"><b><i>Active FleetView Users</i></b></font></td></tr>
<tr>
<td>
</table>
</form>

<form id="activeFleetviewUsers" name="activeFleetviewUsers" method="post" >
<%
         final String exportFileName="active_fleetview_users_report.xls";  
%>
<table width="80%" border="0" align="center">
		<tr>
			<td>
			 				<input type="hidden" id="tableHTML" name="tableHTML" value="" /> 
			 				<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  
							<div style="text-align: right"><a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('table1','tableHTML');">
                           <img src="/siteadmin/images/excel.jpg" width="15px" height="15px" style="border-style: none"></img></a></div>
        	</td>
		</tr>
		
		</table>

<div style="width:100%;" align="center" id="table1" >
<table border="0" width="80%" align="center">
<tr>
<th bgcolor="#f5f5f5"><font size="2">Sr No</font></th>
<th bgcolor="#f5f5f5"><font size="2">User</font></th>
<th bgcolor="#f5f5f5"><font size="2">Full Name</font></th>
<th bgcolor="#f5f5f5"><font size="2">Type of User</font></th>
<th bgcolor="#f5f5f5"><font size="2">Type value</font></th>
<th bgcolor="#f5f5f5"><font size="2">Active Status</font></th>
<th bgcolor="#f5f5f5"><font size="2">Expiry Date</font></th>
<th bgcolor="#f5f5f5"><font size="2">Last Accessed Time</font></th>
<th bgcolor="#f5f5f5"><font size="2">IP</font></th>
</tr>
<%
try{
int count =0;
count = iPageNo;
String sqlPagination = "select SQL_CALC_FOUND_ROWS * from db_gps.t_security where ActiveStatus = 'Yes' limit "+iPageNo+","+iShowRows+"";
psPagination=conn.prepareStatement(sqlPagination);
rsPagination=psPagination.executeQuery();
System.out.println("The query is :"+sqlPagination);

////this will count total number of rows
String sqlRowCnt="SELECT FOUND_ROWS() as cnt";
psRowCnt=conn.prepareStatement(sqlRowCnt);
rsRowCnt=psRowCnt.executeQuery();

if(rsRowCnt.next())
 {
    iTotalRows=rsRowCnt.getInt("cnt");
 }

while(rsPagination.next()) {
	
		String Username=rsPagination.getString("Username");
		String FullName=rsPagination.getString("FullName");
		String TypeofUser=rsPagination.getString("TypeofUser");
		String TypeValue=rsPagination.getString("TypeValue");
		String ActiveStatus=rsPagination.getString("ActiveStatus");
		String ExpiryDate=rsPagination.getString("ExpiryDate");
		
		if(ExpiryDate=="-" || ExpiryDate.equals("-")) {
			ExpiryDate = "-";
		}else{
			ExpiryDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ExpiryDate));
		}

		String laseAccess="-",RecordDate="-",RecordTime="-",frmTime="-",UserIP="-";
		String sqlovers ="select * from db_gps.t_loguseractivity where Comments ='"+Username+"'";
		ResultSet rsovers=st1.executeQuery(sqlovers);
		System.out.println("The query is ==>>"+sqlovers);
		if(rsovers.next()){
			RecordDate = rsovers.getString("RecordDate");
			RecordTime  = rsovers.getString("RecordTime");
			laseAccess =RecordDate+" "+RecordTime;
			UserIP = rsovers.getString("UserIP");
			
		}//end of if
		
		if(laseAccess=="-" || laseAccess.equals("-")) {
			laseAccess = "-";
		}else{
			laseAccess = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(laseAccess));
		}
		
		%>
		<tr>
		<td bgcolor="#f5f5f5" align="right"><%= ++count%> </td>
		<td bgcolor="#f5f5f5" align="left"><%= Username%></td>
		<td bgcolor="#f5f5f5" align="left"><%= FullName%></td>
		<td bgcolor="#f5f5f5" align="left"><%= TypeofUser %></td>
		<td bgcolor="#f5f5f5" align="left"><%= TypeValue%></td>
		<td bgcolor="#f5f5f5" align="left"><%= ActiveStatus%></td>
		<td bgcolor="#f5f5f5" align="right"><%= ExpiryDate%></td>
		<td bgcolor="#f5f5f5" align="right"><%= laseAccess%></td>
		<td bgcolor="#f5f5f5" align="right"><%= UserIP%></td>
		</tr>
		<%
		
}//end of while
	

//// calculate next record start record  and end record 
      try{
          if(iTotalRows<(iPageNo+iShowRows))
          {
              iEndResultNo=iTotalRows;
          }
          else
          {
              iEndResultNo=(iPageNo+iShowRows);
          }
         
          iStartResultNo=(iPageNo+1);
          iTotalPages=((int)(Math.ceil((double)iTotalRows/iShowRows)));
      
      }
      catch(Exception e)
      {
          e.printStackTrace();
      }



}catch(Exception e) {
	System.out.println("The Exception is ==>>"+e);
}
%>
</table><br>
</div>
</form>
<div align="center" style="width: 100%;">
<table width="80%">
		<tr>
		 <td colspan="3" align ="left"><a href="ActiveFleetViewUsers.jsp">First Page</a></td> 
   <td colspan="3" align ="center">
<div>
<%
        //// index of pages 
        
        int i=0;
        int cPage=0;
        if(iTotalRows!=0)
        {
        cPage=((int)(Math.ceil((double)iEndResultNo/(iTotalSearchRecords*iShowRows))));
        
        int prePageNo=(cPage*iTotalSearchRecords)-((iTotalSearchRecords-1)+iTotalSearchRecords);
        if((cPage*iTotalSearchRecords)-(iTotalSearchRecords)>0)
        {
         %>
          <a href="ActiveFleetViewUsers.jsp?iPageNo=<%=prePageNo%>&cPageNo=<%=prePageNo%>"> << Previous</a>
         <%
        }
        
        for(i=((cPage*iTotalSearchRecords)-(iTotalSearchRecords-1));i<=(cPage*iTotalSearchRecords);i++)
        {
          if(i==((iPageNo/iShowRows)+1))
          {
          %>
           <a href="ActiveFleetViewUsers.jsp?iPageNo=<%=i%>" style="cursor:pointer;color: red"><b><%=i%></b></a>
          <%
          }
          else if(i<=iTotalPages)
          {
          %>
           <a href="ActiveFleetViewUsers.jsp?iPageNo=<%=i%>"><%=i%></a>
          <% 
          }
        }
        if(iTotalPages>iTotalSearchRecords && i<iTotalPages)
        {
         %>
         <a href="ActiveFleetViewUsers.jsp?iPageNo=<%=i%>&cPageNo=<%=i%>"> Next</a> 
         <%
        }
        }
      %>
<b>Rows <%=iStartResultNo%> - <%=iEndResultNo%>   Total Result  <%=iTotalRows%> </b>
</div>
</td>
   <td colspan="3" align ="right"><a href="ActiveFleetViewUsers.jsp?iPageNo=<%=iTotalPages%>">Last Page</a></td> 
   
		</tr>		
		</table><br></br>
		</div>

<%
    try{
         if(psPagination!=null){
             psPagination.close();
         }
         if(rsPagination!=null){
             rsPagination.close();
         }
         
         if(psRowCnt!=null){
             psRowCnt.close();
         }
         if(rsRowCnt!=null){
             rsRowCnt.close();
         }
         
         if(conn!=null){
          conn.close();
         }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
%>