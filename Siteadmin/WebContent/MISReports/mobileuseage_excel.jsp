<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
                        <% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename="Mobile_Useage_detail_report.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%! 
Connection conn2;
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
<center class='bodyText'><b>Please enter the Mobile No. to display the Mobile Useage  Report</b></center>
</td><tr>
</table>
</td></tr>
                        <%
}
else
{
data1=request.getParameter("data");

}
%>
   
                       <%!

Statement st=null, st1=null, st2=null;
String sql=null, sql1=null, sql2=null,data1=null;

NumberFormat nf= NumberFormat.getNumberInstance();
%>
<%
double MonthlyCharge=0,CallCharges=0,ValueASCharge=0,RoamingCharge=0,Total=0,OneTimeCharge=0,taxcolsum=0;

double taxsum=0,Totalcol=0,totaltax=0,Tax=0,amount=0;
try{
        nf.setMaximumFractionDigits(2);
        nf.setMinimumFractionDigits(2);
        Class.forName(MM_dbConn_DRIVER);
    	conn2=	DriverManager.getConnection(MM_dbConn_STRING2,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn2.createStatement();
	st1=conn2.createStatement();
       
%>
<tr><td align="right">       <div align=""> <b><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%></b></div></td></tr> 
<tr><td align="center">      <div align="center"><font color="brown" size="3">Mobile Usage Report for Mobile No&nbsp;<%=data1%></font></div></td></tr>
<tr><td>                        
			<%
                          sql="select AccNo,TMonth,Mobno,OneTimeCharge,MonthlyCharge,CallCharges,ValueASCharge,RoamingCharge,Tax,Total from t_subsummarydet where MobNo='"+data1+"'";
                        ResultSet rst=st.executeQuery(sql);
                        int i=1;
                    

                        
%>
<br>
			<table width="100%" border="1" align="center" class="sortable" > 
			<tr>
                            <th class="hed" bgcolor="black"><font color="white"> Sr.</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> Month</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> Mobno</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> OneTimeCharge</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> MonthlyCharge</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> CallCharges</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> ValueASCharge</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> RoamingCharge</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> Tax</font></th>
                        <th class="hed"bgcolor="black"><font color="white"> Total</font></th>
			</tr>
                        
                          <% while(rst.next())
                         {
                              
                        %>	
                        <tr>
			<td> <%=i%></td>
                        <td class="bodyText"><div align="left"><%=rst.getString("TMonth")%></div></td>
			<td class="bodyText"><div align="left"><%=rst.getString("MobNo")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("OneTimeCharge")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("MonthlyCharge")%></div></td>
                        <td class="bodyText"><div align="right"><%=rst.getString("CallCharges")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("ValueASCharge")%></div></td>
			<td class="bodyText"><div align="right"><%=rst.getString("RoamingCharge")%></div></td>
			
                        
                            <%  if(rst.getInt("Tax")==0)
                                  {
                                
                                taxcolsum=rst.getDouble("OneTimeCharge")+rst.getDouble("MonthlyCharge")+rst.getDouble("CallCharges")+rst.getDouble("ValueASCharge")+rst.getDouble("RoamingCharge")+rst.getDouble("Tax")+rst.getDouble("Total");
                                taxsum=taxcolsum*0.1236;
                                totaltax+=taxsum;
                              String taxsum1=nf.format(taxsum);
                              %><td class="bodyText"><div align="right"><%=taxsum1%></div></td>
                              
                        
                            <%}else{%><td class="bodyText"><div align="right"><%=rst.getString("Tax")%></div></td> <%}%>
                            
                            
                            <%  if(rst.getInt("Total")==0)
                                  {
                               
                                Totalcol=taxcolsum+taxsum;
                                amount+=Totalcol;
                                 String Totalcol1=nf.format(Totalcol); 
                                
                                    
                              %><td class="bodyText"><div align="right"><%=Totalcol1%></div></td>
                              
                        
                            <%}else{%><td class="bodyText"><div align="right"><%=rst.getString("Total")%></div></td> <%}%>
                            
			<%
                           i++;
                          }
                        
                         %>
                 
			</tr>
                        <tr>
                            <td class="hed" bgcolor="lightgrey"><div align="left">Total</div></td>
                            <td class="bodyText"bgcolor="lightgrey"><div align="left">-</div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="left">-</div></td>
                             
                             <%
                             
                               sql1="select sum(OneTimeCharge) 'ototal' ,sum(MonthlyCharge) 'mtotal',sum(CallCharges) 'ctotal',sum(ValueASCharge) 'vtotal',sum(RoamingCharge) 'rtotal',sum(Tax) 'tatotal',sum(Total) 'ttotal' from t_subsummarydet   where MobNo='"+data1+"'";
                         ResultSet rst1=st1.executeQuery(sql1);
                         while (rst1.next())
                             {
                              OneTimeCharge=rst1.getDouble("ototal");
                              MonthlyCharge=rst1.getDouble("mtotal");
                              CallCharges=rst1.getDouble("ctotal");
                              ValueASCharge=rst1.getDouble("vtotal");
                              RoamingCharge=rst1.getDouble("rtotal");
                              Tax=rst1.getDouble("tatotal");
                              Total=rst1.getDouble("ttotal");
                             }
                         Tax+=totaltax;
                         Total+=amount;
                         String MonthlyCharge1=nf.format(MonthlyCharge);
                         String OneTimeCharge1=nf.format(OneTimeCharge);
                         String CallCharges1=nf.format(CallCharges);
                         String ValueASCharge1=nf.format(ValueASCharge);
                         String RoamingCharge1=nf.format(RoamingCharge);
                         String Tax1=nf.format(Tax);
                         String Total1=nf.format(Total);
                             %>
                            
                             <td class="bodyText"bgcolor="lightgrey" ><div align="right" ><%=OneTimeCharge1%></div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=MonthlyCharge1%></div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=CallCharges1%></div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=ValueASCharge1%></div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=RoamingCharge1%></div></td>
                             <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=Tax1%></div></td>
                         <td class="bodyText"bgcolor="lightgrey"><div align="right"><%=Total1%></div></td>
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
     
