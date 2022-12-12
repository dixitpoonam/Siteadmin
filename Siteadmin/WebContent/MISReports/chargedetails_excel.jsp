<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
                        <% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename="VoicecallandGprs_detail_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>
<table border="1" cellspacing="2" cellpadding="2" width="100%">
 
                      <%!

Statement st=null, st1=null, st2=null;
String sql=null, sql1=null, sql2=null,data1=null,data=null;


%>
<%

try{
        
	
	st=conn2.createStatement();
	st1=conn2.createStatement();
       
%>
         
                      <%
String dd=request.getQueryString();
if(dd==null)
{
%>
<tr><td>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please enter the Mobile No. to display the Charge Details Report</b></center>
</td><tr>
</table>
</td></tr>
                       <%
}
else
{
data=request.getParameter("data");
data1=request.getParameter("data1");


%>
   
<tr><td align="right">       <div align=""> <b><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></b></div></td></tr> 
<tr><td align="center">      <div align="center"><font color="brown" size="3">Call Charge Details for Mobile No&nbsp;<%=data1%></font></div></td></tr>
<tr><td>                        
			<%
                          sql="select TDate,TTime,CallNo,Duration,Amount,Pulse,PSTNAmt,TAmt,Comments1,ChargedforCustomer,Status from t_chargedetailsamt where TMonth='"+data+"'and MobNo='"+data1+"'";
                        ResultSet rst=st.executeQuery(sql);
                        int i=1;
                    

                        
%>
<br>
			<table width="100%" border="1" align="center" class="sortable" > 
                        <tr><th class="hed" bgcolor="black" colspan="12"><font color="white"> Voice Call Details</font></th></tr>
                        <tr>
                            <th class="hed" bgcolor="lightgrey"><font color="black"> Sr.</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Call Date</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Call Time</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> CallNo</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Duration</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Amount</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Pulse</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> PSTNAmt</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> TAmt</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Comments</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Charged For Customer</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Status</font></th>
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
                        <tr><th class="hed" bgcolor="black" colspan="12"><font color="white">G.P.R.S Details</font></th></tr>
                        <tr>
                            <th class="hed" bgcolor="lightgrey"><font color="black"> Sr.</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Call Date</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Call Time</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> CallNo</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Duration</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Amount</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Pulse</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> PSTNAmt</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> TAmt</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Comments</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Charged For Customer</font></th>
                        <th class="hed"bgcolor="lightgrey"><font color="black"> Status</font></th>
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
                        
</td></tr>			

<br>			
                        <% 
                          }
                           catch(Exception e)
                           {
	                     out.print("Exception -->" +e);
                            }
                           finally
                           {
	                    conn2.close();
	                    
                            }
                         %>	


 </table>
 <br>
     
