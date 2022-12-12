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
Connection conn,conn1;
%>
<%
Statement st,st1,st2,st3,st4;
String data,data1;
String sql,sql1,sql2,sql3,sql4;

try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
        st2=conn1.createStatement();
        st3=conn.createStatement();
        st4=conn.createStatement();
    
%>
<table width="100%" align="center" class="sortable">
                    <tr>
                                <td align="center" class="sorttable_nosort"><font color="block" size="2" >Unit History Details</font></td>
                            </tr>
                           <tr>
                                <td>
                                     <table border="0" width="100%">
			<form name="unit" method="get" action="" onsubmit="return validate();" >
			<tr bgcolor="#87CEFA">
                            <td>Unit ID </td>
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
<center class='bodyText'><b>Please enter the Unit ID to display the Unit History Report</b></center>
</td><tr>
</table>


<%
}
else
{
data1=request.getParameter("data");


%>



</td></tr>
			<tr>
			<td  class="sorttable_nosort">
			<div id="report_heding"><font color="brown" size="3">Unit History Report for Unit ID&nbsp;<%=data1%></font></div>
			<div align="right">
			
			<a href="excel_unithistory.jsp?data1=<%=data1%>" title="Export to Excel">
			<img src="../images/excel.jpg" width="15px" height="15px"></a>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
			</div>
			</td>
			</tr>
			</table>


<%
                          sql="select * from t_unitmasterhistory where UnitID='"+data1+"' order by EntDate asc";
                        ResultSet rst1=st.executeQuery(sql);
                        int i=1;
                    

                        
%>

			<table width="100%" border="1" align="center" class="sortable">
			<tr><th class="hed" colspan="13" bgcolor="#2696B8"> Unit History</th></tr>
			<tr>
			<td class="hed"> Sr.</td>
			<td class="hed"> Date</td>
                        <td class="hed"> Unit ID</td>
			<td class="hed"> Sim No</td>
			<td class="hed"> Mobile No</td>
			<td class="hed"> InstallationType</td>
			<td class="hed"> WMSN</td>
                        <td class="hed"> Module</td>
                        <td class="hed"> GPS</td>
                        <td class="hed"> Unit Type</td>
                        <td class="hed"> Software Version</td>
                        <td class="hed"> Peripherals</td>
                        <td class="hed"> Status</td>
                        
                       
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
                       </tr>
                        <%
                          i++;
                          }
                        
                         %>
                     
                        </table>
			

                        <br>
                         <%
                          sql1="select * from t_unitreplacement where NewUnitID='"+data1+"'order by EntDate asc";
                        ResultSet rst2=st1.executeQuery(sql1);
                        int j=1;
                    

                       
%>

			<table width="100%" border="1" align="center" class="sortable" >
			<tr><th class="hed" colspan="20" bgcolor="#2696B8">New Unit Installations</th></tr>
			<tr>
			<td class="hed"> Sr.</td>
			<td class="hed"> Date</td>
                        <td class="hed"> Installation Time</td>
                        <td class="hed">Vehical No.</td>
			<td class="hed"> Transporter</td>
			<td class="hed"> Installation type</td>
			<td class="hed"> Old Unit ID</td>
			<td class="hed"> New Unit ID</td>
                       	<td class="hed"> Installation By</td>
                        <td class="hed"> Installation Place</td>
			<td class="hed"> Entry By</td>
			<td class="hed"> Sim No.</td>
                        <td class="hed"> Mobile No.</td>
                        <td class="hed">Type Unit </td>
                        <td class="hed"> Voice Call No.1 </td>
			<td class="hed"> Voice Call No.2</td>
                        <td class="hed"> Old Unit Damaged</td>
			<td class="hed"> New Unit Run On</td>
                        <td class="hed"> Old Unit With</td>
			<td class="hed">Entry Date </td>
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
			

                        <br>

			<!-- body part come here -->
                      <%
                          sql2="select * from t_unitreceived where UnitID="+data1+" order by Rdate asc";
                        ResultSet rst3=st2.executeQuery(sql2);
                        int k=1;
                        
                            
                         %>


                        <table width="100%" border="1" align="center" class="sortable">
			<tr><th class="hed" colspan="14" bgcolor="#2696B8">Units Received</th></tr>
			<tr>
			<td class="hed"> Sr.</td>
			<td class="hed"> Date</td>
                        <td class="hed"> Time</td>
                        <td class="hed"> Receive From </td>
			<td class="hed"> Courier</td>
                        <td class="hed"> Courier DC No</td>
			<td class="hed"> Unit Type </td>
			<td class="hed"> Unit ID</td>
                        <td class="hed"> Transporter</td>
                        <td class="hed"> Location</td>
                        <td class="hed"> Faulty</td>
                        <td class="hed"> Technician Name</td>
                        <td class="hed"> Entred By</td>
                        <td class="hed"> DC_NO</td>
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
			
                        <br>
			<%
                          sql3="select * from t_unitmasterhistory where UnitId='"+data1+"' order by DispDate asc";
                        ResultSet rst4=st3.executeQuery(sql3);
                        int n=1;
                        
                        %>
 <table width="100%" border="1" align="center" class="sortable">
<tr><th class="hed" colspan="12" bgcolor="#2696B8">Units Dispatched</th></tr>
			<tr>
			<td class="hed"> Sr.</td>
                        <td class="hed"> Dispatch Date</td>
                        <td class="hed"> Unit ID</td>
                        <td class="hed"> Dispatch Address</td>
                        <td class="hed"> Order No</td>
                        <td class="hed"> Mode of Dispatch</td>
                        <td class="hed"> Dispatch Name</td>
                        <td class="hed"> Courier Date</td>
                        <td class="hed"> Chalan No.</td>
                        <td class="hed"> Dispatch Id</td>
                        <td class="hed"> User</td>
                        <td class="hed"> Entry By</td>
                       
                        </tr>
                       	
                         
                          <% while(rst4.next())
                         {
                        %>	
			<tr>
                        <td class="bodyText"><div align="left"><%=n%></div></td>
			
                    
                                               
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
                        
                        <td class="bodyText"><div align="left"><%=rst4.getString("UnitID")%></div></td>     
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
                         }       
			%>
                        
			</table>

<% 
                          }
                           catch(Exception e)
                           {
	                     out.print("Exception -->" +e);
                            }finally{
                            	conn.close();
                            	conn1.close();
                            }

%>

<%@ include file="footerhtml.jsp" %>
