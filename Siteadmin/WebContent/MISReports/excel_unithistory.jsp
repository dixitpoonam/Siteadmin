<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
                        <% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename="UnitHistory_detail_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="conn.jsp" %>

<table border="1" cellspacing="2" cellpadding="2" width="100%">
 
         
                        <%
String dd=request.getQueryString();
if(dd==null)
{
%>
<tr><td>
<table class="stats">
<tr><td>
<center class='bodyText'><b>Please enter the Unit ID to display the Unit History Report</b></center>
</td><tr>
</table>
</td></tr>
                        <%
}
else
{
data1=request.getParameter("data1");

}
%>
   
                        <%!

Statement st=null, st1=null, st2=null,st3=null,st4=null;
String sql="", sql1="", sql2="",sql3="",data1="",data2="";
Connection conn,conn1;
%>
                        <%
try{
	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
        st2=conn1.createStatement();
        st3=conn.createStatement();
        st4=conn1.createStatement();
                        %>
<tr><td align="right">       <div align=""> <b><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></b></div></td></tr> 
<tr><td align="center">     <div align="center"><font color="brown" size="3">Unit History Report for Unit ID=&nbsp;<%=data1%></font></div></td></tr>                    
<tr><td align="center"> <br>                       
			 <%
                          sql="select * from t_unitmasterhistory where UnitID='"+data1+"'";
                        ResultSet rst1=st.executeQuery(sql);
                        int i=1;
                    

                        
%>

			<table width="100%" border="1" align="center" class="sortable">
                            <tr><th class="hed" colspan="13" bgcolor="black"><font color="white"> Unit History</font></th></tr>
			<tr>
                            <td class="hed"bgcolor="lightgrey"><font color="black"> Sr.</font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Date </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Unit ID </font></td>
                           <td class="hed"bgcolor="lightgrey"><font color="black">Sim No </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Mobile No </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Installation Type </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">WMSN </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Module </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">GPS </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black"> Unit Type </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Software Version </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Peripherals </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Status </font></td> 
                           
                                                   
                       
                        </tr>
                       	

                         <% while(rst1.next())
                         {
                        %>	
			<tr>
                            <td class="bodyText"><div align="left"><%=i%></div></td>
			<%
                        try{
                            %>
                            <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("EntDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                        
                            <td class="bodyText"><div align="left"><%=rst1.getString("UnitID")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("SimNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("MobNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("InstType")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("WMSN")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("Module")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("GPS")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("typeunit")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("SwVer")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("Peripherals")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst1.getString("Status")%></div></td>
                           
			<%
                          i++;
                          }
                        
                         %>
                         </tr>
                        </table>
</td></tr>			
<tr><td><br>
                        <br>
                         <%
                          sql1="select * from t_unitreplacement where NewUnitID='"+data1+"'";
                        ResultSet rst2=st1.executeQuery(sql1);
                        int j=1;
                    

                       
%>

			<table width="100%" border="1" align="center" class="sortable">
                            <tr><th class="hed" colspan="20" bgcolor="black"><font color="white">New Unit Installations</font></th></tr>
			<tr>
                            
                            <td class="hed"bgcolor="lightgrey"><font color="black"> Sr.</font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Date </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Installation Time </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Vehical No. </font></td> 
                           <td class="hed"bgcolor="lightgrey"><font color="black"> Transporter </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Installation type </font></td>
                            <td class="hed"bgcolor="lightgrey"><font color="black">Old Unit ID </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">New Unit ID </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Installation By </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Installation Place </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black"> Entry By </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Sim No. </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Mobile No. </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Type Unit </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Voice Call No.1 </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Voice Call No.2 </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Old Unit Damaged </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">New Unit Run On</font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Old Unit With </font></td> 
                            <td class="hed"bgcolor="lightgrey"><font color="black">Entry Date </font></td> 
                            
                                       
                        </tr>
                       	

                         <% while(rst2.next())
                         {
                            %>	
			<tr>
                            <td class="bodyText"><div align="left"><%=j%></div></td>
			 <%
                        try{
                            %>
                            <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst2.getDate("InstDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                            <td class="bodyText"><div align="left"><%=rst2.getString("InstTime")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("VehRegNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("OwnerName")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("InstType")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("OldUnitID")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("NewUnitID")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("InstBy")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("InstPlace")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("EntBy")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("SimNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("MobNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("TypeUnit")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("VoiceCallNo1")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("VoiceCallNo2")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("OldUnitDamaged")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("NewUnitRunOn")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst2.getString("OldUnitWith")%></div></td>
                        
                         <%
                        try{
                            %>
                            <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst2.getDate("EntDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                               
			</tr>	
			<%
                          j++;
                          }
                        
                         %>
                        </table>
</td></tr>			
<tr><td><br>
			<!-- body part come here -->
                      <%
                          sql2="select * from t_unitreceived where UnitID="+data1+"";
                        ResultSet rst3=st2.executeQuery(sql2);
                        int k=1;
                        
                            
                         %>


                        <table width="100%" border="1" align="center" class="sortable">
                        <tr><th class="hed" colspan="14" bgcolor="black"><font color="white">Units Received</font></th></tr>
			<tr>
			 <td class="hed"bgcolor="lightgrey"><font color="black">Sr.</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Date</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Time</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Receive From.</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Courier</font></td>
                          <td class="hed"bgcolor="lightgrey"><font color="black">Courier DC No</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Unit Type</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Unit ID</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Transporter</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Location</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Faulty</font></td>
                          <td class="hed"bgcolor="lightgrey"><font color="black">Technician Name</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">Entred By</font></td>
                         <td class="hed"bgcolor="lightgrey"><font color="black">DC_NO</font></td>
                       
			
                       	</tr>
  
                         <% while(rst3.next())
                         {
                        %>	
			<tr>
                        <td class="bodyText"><div align="left"><%=k%></div></td>
                        
                         <%
                        try{
                            %>
                        <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst3.getDate("Rdate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                        <td class="bodyText"><div align="left"><%=rst3.getString("Rtime")%></div></td>
                  	<td class="bodyText"><div align="left"><%=rst3.getString("ReceiveFrom")%></div></td>
			<td class="bodyText"><div align="left"><%=rst3.getString("Courier")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("CourierDCNo")%></div></td>
			<td class="bodyText"><div align="left"><%=rst3.getString("Utype")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("UnitID")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("Transporter")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("Location")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("Faulty")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("TechName")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("EntBy")%></div></td>
                        <td class="bodyText"><div align="left"><%=rst3.getString("DC_NO")%></div></td>
                      	</tr>	
			<%
                          k++;
                          }
                         
                         %>
                      
			</table>
</td></tr>			
<tr><td><br>
			<%
                          sql3="select * from t_unitmasterhistory where UnitId='"+data1+"' order by DispDate asc";
                        ResultSet rst4=st3.executeQuery(sql3);
                        int n=1;
                        
                        %>
 <table width="100%" border="1" align="center" class="sortable">
     <tr><th class="hed" colspan="12" bgcolor="black"><font color="white">Units Dispatched</font></th></tr>
			<tr>
			<td class="hed"bgcolor="lightgrey"><font color="black"> Sr.</font></td>
                        <td class="hed"bgcolor="lightgrey"><font color="black">Unit ID </font></td>
                        <td class="hed"bgcolor="lightgrey"><font color="black">Dispatch Date </font></td>
                        <td class="hed"bgcolor="lightgrey"><font color="black">Dispatch Address </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Order No </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Mode of Dispatch </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black"> Dispatch Name </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Courier Date </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Chalan No. </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Dispatch Id </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">User </font></td> 
                        <td class="hed"bgcolor="lightgrey"><font color="black">Entry By </font></td> 
                        
                        </tr>
                       	
                         
                          <% while(rst4.next())
                         {
                        %>	
			<tr>
                          <td class="bodyText"><div align="left"><%=n%></div></td>   
                         <td class="bodyText"><div align="left"><%=rst4.getString("UnitID")%></div></td>
                        
                                               
                         <%
                        try{
                            %>
                            <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst4.getDate("DispDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                            <td class="bodyText"><div align="left"><%=rst4.getString("DisAdd")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getInt("OrderNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getString("ModeofDispatch")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getString("DisName")%></div></td>
                        
                         <%
                        try{
                            %>
                            <td class="bodyText"><div align="left"><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst4.getDate("CourierDate"))%></div></td>
                     
                        <%
                        }catch(Exception e)
                           {
	                    out.print("-");
                        }
                                %>
                        
                            <td class="bodyText"><div align="left"><%=rst4.getString("ChalanNo")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getInt("DispId")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getString("User")%></div></td>
                            <td class="bodyText"><div align="left"><%=rst4.getString("EntBy")%></div></td>
                         
			</tr>	
			<%
                          n++;
                          }

			%>
			</table>

<br>			
                        <% 
                          }
                           catch(Exception e)
                           {
	                     out.print("Exception -->" +e);
                            }
                           finally
                           {
	                    conn.close();
	                    conn1.close();
                            }
                         %>	

</td></tr>
 </table>

     
