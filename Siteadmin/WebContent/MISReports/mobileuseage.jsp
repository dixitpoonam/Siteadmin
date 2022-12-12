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
Connection conn2;
%>
<%
Statement st,st1,st2,st3,st4;
String data,data1;
String sql,sql1,sql2,sql3,sql4;
NumberFormat nf= NumberFormat.getNumberInstance();

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
<center class='bodyText'><b>Please enter the Mobile number to display the Mobile Usage Report</b></center>
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
			<div id="report_heding"><font color="brown" size="3">Mobile Usage Details for &nbsp;<%=data1%></font></div>
			<div align="right">
			
			<a href="mobileuseage_excel.jsp?data=<%=data1%>" title="Export to Excel">
			<img src="../images/excel.jpg" width="15px" height="15px"></a>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date())%>
			</div>
			</td>
			</tr>
			</table>

 <%
                          sql="select AccNo,TMonth,Mobno,OneTimeCharge,MonthlyCharge,CallCharges,ValueASCharge,RoamingCharge,Tax,Total from t_subsummarydet where MobNo='"+data1+"'";
                        ResultSet rst=st.executeQuery(sql);
                        int i=1;
                    

                        
%>
                           <table width="100%" border="1" align="center" class="stats" > 
			<tr bgcolor="#2696B8" >
			<th class="hed"> Sr.</th>
			<th class="hed"> Month</th>
			<th class="hed"> Mobno</th>
			<th class="hed"> OneTimeCharge</th>
			<th class="hed"> MonthlyCharge</th>
			<th class="hed"> CallCharges</th>
			<th class="hed"> ValueASCharge</th>
			<th class="hed"> RoamingCharge</th>
                        <th class="hed"> Tax</th>
                        <th class="hed"> Total</th>
			</tr>
                        
                          <% while(rst.next())
                         {
                              
                        %>	
                        <tr>
			<td> <%=i%></td>
                        <td class="bodyText"><div align="left"><a href="chargedetails.jsp?data=<%=rst.getString("TMonth")%>&data1=<%=data1%>"><%=rst.getString("TMonth")%></a></div></td>
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
                            <td class="hed"><div align="left">Total</div></td>
                            <td class="hed"><div align="left">-</div></td>
                             <td class="hed"><div align="left">-</div></td>
                             
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
                             
                             <td class="hed" ><div align="right" ><%=OneTimeCharge1%></div></td>
                             <td class="hed"><div align="right"><%=MonthlyCharge1%></div></td>
                             <td class="hed"><div align="right"><%=CallCharges1%></div></td>
                             <td class="hed"><div align="right"><%=ValueASCharge1%></div></td>
                             <td class="hed"><div align="right"><%=RoamingCharge1%></div></td>
                             <td class="hed"><div align="right"><%=Tax1%></div></td>
                             <td class="hed"><div align="right"><%=Total1%></div></td>
                        </tr>
                        
			</table>
			
			</td>


<% }
                          }
                           catch(Exception e)
                           {
	                     out.print("Exception -->" +e);
                            }finally{
                            	conn2.close();
                            }

%>

<%@ include file="footerhtml.jsp" %>
