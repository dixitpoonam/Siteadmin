<%@ include file="headerhtml.jsp" %>
<script language="javascript">
 			function validate()
  			{
                           var v1=document.unit.data.value;
                           var validChar='0123456789';   // legal chars
                           var   strlen=v1.length;       // test string length
                          
                           if(strlen==0||strlen>20)
                               {
                                   alert("Invalid Unit ID length" );
                                   return false;
                               }
                               
                               v1=v1.toUpperCase(); // case insensitive
                                                             

                           for(var ic=0;ic<strlen;ic++) //now scan for illegal characters
                                {
                                    
                                    if(validChar.indexOf(v1.charAt(ic))<0)
                                        {		
                                            alert("please enter a valid Unit ID!");
                                            return false;
                                        }
                                } // end scanning
                           return true;       
                        }
  				
		

</script>
<%!
Statement st=null, st1=null, st2=null;
String sql=null, sql1=null, sql2=null,data1=null,data=null;
Connection conn2;

%>

<%

try{
        
	
	Class.forName(MM_dbConn_DRIVER);
	conn2=	DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn2.createStatement();
	st1=conn2.createStatement();
       
%>
<table width="100%" align="center" class="sortable">
                    <tr>
                                <td align="center" class="sorttable_nosort"><font color="block" size="2" >Mobile Number Usage Details</font></td>
                            </tr>
                           <tr>
                                <td>
                                     <table border="0" width="100%">
			<form name="unit" method="get" action="" onsubmit="return validate();" >
			<tr bgcolor="#87CEFA">
                            <td>Enter Mobile Number </td>
                            <td>
                                 <input type="text" id="data" name="data" class="formElement"  size="20"  />
                                
                            </td>
  			<td >
				<input type="submit" name="submit" id="submit" value="submit" class="formElement" />
			</td>
		</tr>
		</form>
		</table>



<%
String dd=request.getQueryString();
if(dd==null)
{
%>

<table class="stats">
<tr><td>
<center class='bodyText'><b>Please enter the Mobile number to display the Charge Detail Report</b></center>
</td><tr>
</table>


<%
}
else
{
data=request.getParameter("data");
data1=request.getParameter("data1");

%>



</td></tr>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Mobile Usage Details for &nbsp;<%=data1%></font></div>
			<div align="right">
			
			<a href="chargedetails_excel.jsp?data=<%=data%>&data1=<%=data1%>" title="Export to Excel">
			<img src="../images/excel.jpg" width="15px" height="15px"></a>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
			</div>
			</td>
			</tr>
			</table>

    <%
                          sql="select TDate,TTime,CallNo,Duration,Amount,Pulse,PSTNAmt,TAmt,Comments1,ChargedforCustomer,Status from t_chargedetailsamt where TMonth='"+data+"'and MobNo='"+data1+"'";
                        ResultSet rst=st.executeQuery(sql);
                        int i=1;
                    

                        
%>
                           <table width="100%" border="1" align="center" class="sortable" > 
			<tr >
                        <th class="sorttable_nosort" colspan="12" bgcolor="#2696B8"> Voice Call Details</th>
                        </tr>
                        <tr>
			<td class="hed"> Sr.</td>
			<td class="hed"> Call Date</td>
			<td class="hed"> Call Time</td>
			<td class="hed"> CallNo</td>
			<td class="hed"> Duration</td>
			<td class="hed"> Amount</td>
			<td class="hed"> Pulse</td>
			<td class="hed"> PSTNAmt</td>
                        <td class="hed"> TAmt</td>
                        <td class="hed"> Comments</td>
                        <td class="hed"> Charged For Customer</td>
                        <td class="hed"> Status</td>
			</tr>
                        
                          <% while(rst.next())
                         {
                              
                        %>	
                        <tr>
			<td> <%=i%></td>
                        
                         <%
                        try{
                            %>
                        <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst.getDate("TDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                                               
			<td class="bodyText"><div align="left"><%=rst.getString("TTime")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("CallNo")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("Duration")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst.getString("Amount")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("Pulse")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("PSTNAmt")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("TAmt")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst.getString("Comments1")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst.getString("ChargedforCustomer")%></div></td> 
                        <td class="bodyText"><div align="right"><%=rst.getString("Status")%></div></td>                            
			<%
                           i++;
                          }
                        
                         %>
                 
			</tr>
                       
                        
			</table>
                        <br>
                                                    <%
                          sql1="select TDate,TTime,CallNo,Duration,Amount,Pulse,PSTNAmt,TAmt,Comment,ChargedforCustomer,Status from t_chargedetailsnew where TMonth='"+data+"'and MobNo='"+data1+"' and Duration>=20000";
                        ResultSet rst1=st.executeQuery(sql1);
                        int j=1;
                    

                        
%>
                           <table width="100%" border="1" align="center" class="sortable" > 
			<tr >
                        <th class="sorttable_nosort" colspan="12" bgcolor="#2696B8"> G.P.R.S Details</th>
                        </tr>
                        <tr>
			<td class="hed"> Sr.</td>
			<td class="hed"> Call Date</td>
			<td class="hed"> Call Time</td>
			<td class="hed"> CallNo</td>
			<td class="hed"> Duration</td>
			<td class="hed"> Amount</td>
			<td class="hed"> Pulse</td>
			<td class="hed"> PSTNAmt</td>
                        <td class="hed"> TAmt</td>
                        <td class="hed"> Comments</td>
                        <td class="hed"> Charged For Customer</td>
                        <td class="hed"> Status</td>
			</tr>
                        
                          <% while(rst1.next())
                         {
                              
                        %>	
                        <tr>
			<td> <%=j%></td>
                        
                         <%
                        try{
                            %>
                        <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                                               
			<td class="bodyText"><div align="left"><%=rst1.getString("TTime")%></div></td>
			<td class="bodyText"><div align="right"><%=rst1.getString("CallNo")%></div></td>
			<td class="bodyText"><div align="right"><%=rst1.getString("Duration")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst1.getString("Amount")%></div></td>
			<td class="bodyText"><div align="right"><%=rst1.getString("Pulse")%></div></td>
			<td class="bodyText"><div align="right"><%=rst1.getString("PSTNAmt")%></div></td>
			<td class="bodyText"><div align="right"><%=rst1.getString("TAmt")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst1.getString("Comment")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst1.getString("ChargedforCustomer")%></div></td> 
                        <td class="bodyText"><div align="right"><%=rst1.getString("Status")%></div></td>                            
			<%
                           j++;
                          }
                        }
                         %>
                 
			</tr>
                       
                        
			</table>
			</td>


<% 
                          }
                           catch(Exception e)
                           {
	                     out.print("Exception -->" +e);
                            }finally{
                            	conn2.close();
                            }
			
%>


<%@ include file="footerhtml.jsp" %>
