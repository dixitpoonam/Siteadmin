<%@ page import="java.sql.*" %>
<%@page import="java.util.Date.*"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>  
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.*" %> 
   <%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
   <%@ page import = "java.io.FileNotFoundException"%>
   <%@ page import = "java.io.FileOutputStream"%>
   <%@ page import = "java.io.IOException"%>
   <%@ page import="javax.activation.*" %>  
   <%@ page import="java.io.FileInputStream" %>
   <%@ page import="java.math.BigDecimal" %>
   <%@ page import="java.sql.Connection" %>
   <%@ page import="java.sql.DriverManager" %>
   <%@ page import="java.sql.ResultSet" %>
   <%@ page import="java.sql.Statement" %>
   <%@ page import="java.text.SimpleDateFormat" %>
   <%@ page import="java.util.ArrayList" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.StringTokenizer" %>
 
<%
String file1="";
int saveflag=1;
File savedFile;
String[] filepath =new String[10];
String[] filename =new String[10];
int  count2 = 0, filecount = 0;;
int count=1;
String savefilestring="";
String uploadedBy = "";


int count1=0;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
System.out.println("\n\n ismultipart-->>"+isMultipart);
        if (!isMultipart) {
        System.out.println("\n\nin multipart..");
        } else {
                System.out.println("\n\n in else with  multipart..");
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;
                try {
                        items = upload.parseRequest(request);
                //      System.out.print("\n\n items==>"+items);
                } catch (FileUploadException e) {
                        e.printStackTrace();
                }
                Iterator itr = items.iterator();
                
                
                while (itr.hasNext()) {
                    FileItem item = (FileItem) itr.next();
                    if(item.isFormField()) 
                    {
		                    	String name1 = item.getFieldName();
		                        System.out.print("\n name==>"+name1);
		                        String value = item.getString();
		                        System.out.print("\n value==>"+value);
		                        if(name1.equals("uploadedby")) 
		                        {
		                        		uploadedBy = value;
		                                System.out.print("\n title==>"+uploadedBy);		                             
		                               
		                        }
                    } else {
                                   try {

                                         String itemName = item.getName();
                                         System.out.print("\n\nitemName==>"+itemName);
                                         	file1=itemName;
                                          if(itemName.equalsIgnoreCase(""))
                                          {
                                          }
                                        else
                                         {
                                         
                                     		// savedFile = new File("/home/sumedh/Desktop/Task_List/"+itemName);  
                                     		savedFile = new File("/home/javaprg/TaskList/"+itemName);  
                                         
                                         					System.out.print("\n\nsavedFile==>"+savedFile);
                                                            item.write(savedFile);
                                                            filepath[filecount]=""+savedFile;
                                                            
                                                            filename[filecount]=itemName;
                                                            filecount++;
                                                            if(saveflag==1)
                                                            {
                                                             savefilestring=""+savedFile;
                                                             saveflag++;
                                                            }
                                                            else
                                                            savefilestring=savefilestring+","+savedFile;
                                                             //out.print("successfully saved the file");
                                                            //File file = new File(savedFile);
                                                            String screenshot=savedFile.getAbsolutePath();
                                                   // System.out.println("\n\nscreenshot--->>>"+screenshot);
                                                            }
                                                    
                                                    
                                    } catch (Exception e) {
                                            e.printStackTrace();
                                    }
                    }
            }
	
 }
   //=============================excel reading code========================
try{	   
	   
	   
        		//get connection
        	 	Connection conne = null;
				 Statement st = null;
				 Statement st1 = null;
				 Statement st2 = null;
				 Statement st3 = null;
				 Statement st4 = null;
				 String userid= "";
				
        		try {
						String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
						String MM_dbConn_USERNAME = "fleetview";
						String MM_dbConn_PASSWORD = "1@flv";
					//	String MM_dbConn_GPS = "jdbc:mysql://192.168.2.55/dotprojectfortesting";  
						String MM_dbConn_GPS = "jdbc:mysql://115.112.36.134/dotproject"; 
			
						Class.forName(MM_dbConn_DRIVER);
						conne = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
						st=conne.createStatement();
						st1=conne.createStatement();
						st2=conne.createStatement();
						st3=conne.createStatement();
						st4=conne.createStatement();
						System.out.println("===========connection created=============");
					
					} catch (Exception e) {
						System.out.print("GetConnection Exception ---->" + e);
					}
					
					
					//select the taskowner and task creator
					String query = "select user_id from dotproject.users where user_username = '"+uploadedBy+"'";
					//String query = "select user_id from dotprojectfortesting.users where user_username = '"+uploadedBy+"'";
					System.out.println("The query is :"+query);
     				ResultSet rs3 = st3.executeQuery(query);
     				if(rs3.next())
      				{
					 	userid = rs3.getString("user_id");
      				}
     				System.out.println("The userId is :"+userid);
					
					//read excel file
				//	String fname = "/home/sumedh/Desktop/Task_List/"+file1;
					String fname = "/home/javaprg/TaskList/"+file1;
					System.out.println("The filename is :"+file1);
					System.out.println("The filepath is :"+fname);
			        List sheetData = new ArrayList();			 
			        FileInputStream fis = null;
			        try {
			            
			            fis = new FileInputStream(fname);			 
			            HSSFWorkbook workbook = new HSSFWorkbook(fis);			            
			            HSSFSheet sheet = workbook.getSheetAt(0);
			            Iterator rows = sheet.rowIterator();
			            while (rows.hasNext()) {
			                HSSFRow row = (HSSFRow) rows.next();
			                Iterator cells = row.cellIterator();
			 
			                List data = new ArrayList();
			                while (cells.hasNext()) {
			                    HSSFCell cell = (HSSFCell) cells.next();
			                    data.add(cell);
			                    
			                }
			 
			                sheetData.add(data);
			            }
			        } catch (IOException e) {
			            e.printStackTrace();
			        } finally {
			            if (fis != null) {
			                fis.close();
			            }
			        }
			        //show excel data=====
			        //	System.out.println("The >>>>>>>>>>>>is :");
			        
			        int cnt=0;
       		// Iterates the data and print it out to the console.	
			        for (int i = 1; i < sheetData.size(); i++) {
			        	//cnt++;
			        	String row="";
			            List list = (List) sheetData.get(i);
			           
			            try{
			            	//System.out.println( "IN ntry   ");
			            for (int j = 0; j < list.size(); j++) {
			                HSSFCell cell = (HSSFCell) list.get(j);
			                
			               // System.out.println( "The cell type is :"+cell.getCellType());	
			                
			                if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC) 
			                {
			                	//System.out.println( "IN IFFFFFFFFF    ");	
			                	if(HSSFDateUtil.isCellDateFormatted(cell)){  
			                	//	System.out.print( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue()) );
			                	//	System.out.println( "hibhihihihih>>>>"+cell.getDateCellValue());
			                		if(row.equals("")){
			                			//System.out.println( "IN another iff ");
			                		row=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue());
			                		}else{
			                			row=row+"$"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cell.getDateCellValue());
			                		}
			                    }else{
			                    //	System.out.println( "INanothsr    ELS SSSSSSS ");
			                    	System.out.print(new BigDecimal(cell.getNumericCellValue()).toString());
			                    	if(row.equals("")){
			                    	row=new BigDecimal(cell.getNumericCellValue()).toString();
			                    	}else{
			                    		row=row+"$"+new BigDecimal(cell.getNumericCellValue()).toString();
			                    	}
			                    }
			               
			                }
			                
			                else{  
			                	//System.out.println( "IN mainn     ELS SSSSSSS ");
			                	    System.out.print(cell.toString());
			                	    if(row.equals("")){
			                	    row=cell.toString();
			                	    }else{
			                	    	 row=row+"$"+cell.toString();
			                	    }
			                }
			                 
			             
			            }
			            }catch(Exception ioe){
			            	System.out.println("The exception is :"+ioe);
			            	ioe.printStackTrace();
			            }
			            //code for row
			            System.out.println("\nThe row is >>  "+row);
			          		
			            	//Insert Row into database
							String frmDate = "", toDate = "", user = "", project = "",task = "", assignTo = "", status = "", comletionDate = "";
							String task_duration = "";
							int countFeild=0;
						try
						{
							
							
							StringTokenizer stringTokenizer = new StringTokenizer(row,"$");
							System.out.println("The total no. of tokens generated :  " + stringTokenizer.countTokens());
							countFeild  = stringTokenizer.countTokens();
							
							if(stringTokenizer.countTokens() == 8)
							{		
								frmDate = stringTokenizer.nextToken();
								toDate = stringTokenizer.nextToken();
								user = stringTokenizer.nextToken();
								project = stringTokenizer.nextToken();
								task = stringTokenizer.nextToken();
								assignTo = stringTokenizer.nextToken();
								status = stringTokenizer.nextToken();
								comletionDate = stringTokenizer.nextToken();		//optional field
								
							}else if(stringTokenizer.countTokens() == 7)
							{
								frmDate = stringTokenizer.nextToken();
								toDate = stringTokenizer.nextToken();
								user = stringTokenizer.nextToken();
								project = stringTokenizer.nextToken();
								task = stringTokenizer.nextToken();
								assignTo = stringTokenizer.nextToken();
								status = stringTokenizer.nextToken();
							}else
							{
								//do nothing
							}
						
							//Trim the  white space						
							frmDate = frmDate.trim();
							toDate = toDate.trim();
							user = user.trim();
							project = project.trim();
							task = task.trim();
							assignTo = assignTo.trim();
							status = status.trim();
							comletionDate = comletionDate.trim();
						
							
							if(task.contains("'") || task.contains("\"") || task.contains(",") || task.contains("."))
							{
								task=task.replace("'", " ");
								task=task.replace("\"", " ");
								task=task.replace(".", "");
								task=task.replace(",", "");
							}
							
						
							System.out.println("The from date is :**"+frmDate);
							System.out.println("The toDate date is **:"+toDate);
							System.out.println("The user is :**"+user);
							System.out.println("The project is :**"+project);
							System.out.println("The task is :**"+task);
							System.out.println("The assignTo is :**"+assignTo);
							System.out.println("The status is :**"+status);
							System.out.println("The comletionDate is :**"+comletionDate);
													
							
							//Get the  max  task Id
							String taskID = "", task_percent_complete = "";
							String maxid = "Select max(task_id) as maxID from dotproject.tasks";
						//	String maxid = "Select max(task_id) as maxID from dotprojectfortesting.tasks";
							ResultSet rs = st1.executeQuery(maxid);
							if(rs.next())
							{
								taskID = rs.getString("maxID");
							}
							int newtaskid = Integer.parseInt(taskID) + 1;
							System.out.println("The Max taskId  is :"+taskID);
							System.out.println("The new taskId  is :"+newtaskid);
							
							
							//task_percent_complete
							if(status.equals("Done") || status.equalsIgnoreCase("Done") || status == "done" || status == "Done") 
							{
								task_percent_complete = "100";
							}
							else
							{
								
								task_percent_complete = "0";
							}
							
							//calculate the task duration
							String sql4 = "select hour(timediff('"+frmDate+"','"+toDate+"')) as taskduration";
							ResultSet rsd = st4.executeQuery(sql4);
							if(rsd.next())
							{
								
								task_duration = rsd.getString("taskduration");
							}
							
						try{	
							if(countFeild == 8)
							{							
								cnt++;
								String sql ="insert into dotproject.tasks(task_id,task_name,task_parent,task_project,task_owner,task_start_date,task_duration,task_end_date,task_description,task_creator,task_percent_complete,task_completion_date_time)values('"+newtaskid+"','"+task+"','"+newtaskid+"','"+project+"','"+userid+"','"+frmDate+"','"+task_duration+"','"+toDate+"','"+task+"','"+userid+"','"+task_percent_complete+"','"+comletionDate+"')";	
							//	String sql ="insert into dotprojectfortesting.tasks(task_id,task_name,task_parent,task_project,task_owner,task_start_date,task_duration,task_end_date,task_description,task_creator,task_percent_complete,task_completion_date_time)values('"+newtaskid+"','"+task+"','"+newtaskid+"','"+project+"','"+userid+"','"+frmDate+"','"+task_duration+"','"+toDate+"','"+task+"','"+userid+"','"+task_percent_complete+"','"+comletionDate+"')";	
	
								System.out.println("The query is :"+sql);
								st.execute(sql);
								
								int user1 = Integer.parseInt(user);
								//insert into user_tasks
								String sql1 ="Insert into dotproject.user_tasks (user_id,task_id) values ('"+user1+"','"+newtaskid+"') ";
								//String sql1 ="Insert into dotprojectfortesting.user_tasks (user_id,task_id) values ('"+user1+"','"+newtaskid+"') ";
	
								System.out.println("The query is :"+sql1);
								st2.executeUpdate(sql1);					
							}
							else if(countFeild == 7)
							{
								cnt++;
								String sql ="insert into dotproject.tasks(task_id,task_name,task_parent,task_project,task_owner,task_start_date,task_duration,task_end_date,task_description,task_creator,task_percent_complete)values('"+newtaskid+"','"+task+"','"+newtaskid+"','"+project+"','"+userid+"','"+frmDate+"','"+task_duration+"','"+toDate+"','"+task+"','"+userid+"','"+task_percent_complete+"')";	
							//	String sql ="insert into dotprojectfortesting.tasks(task_id,task_name,task_parent,task_project,task_owner,task_start_date,task_duration,task_end_date,task_description,task_creator,task_percent_complete)values('"+newtaskid+"','"+task+"','"+newtaskid+"','"+project+"','"+userid+"','"+frmDate+"','"+task_duration+"','"+toDate+"','"+task+"','"+userid+"','"+task_percent_complete+"')";	
		
								System.out.println("The query is :"+sql);
								st.execute(sql);
									
								int user1 = Integer.parseInt(user);
								//insert into user_tasks
								String sql1 ="Insert into dotproject.user_tasks (user_id,task_id) values ('"+user1+"','"+newtaskid+"') ";
								//String sql1 ="Insert into dotprojectfortesting.user_tasks (user_id,task_id) values ('"+user1+"','"+newtaskid+"') ";
		
								System.out.println("The query is :"+sql1);
								st2.executeUpdate(sql1);
							}
							else
							{
								//do nothing
							}
							
						}catch(Exception e){
							System.out.println("Exception "+e);
							e.printStackTrace();
						}
					}catch (Exception e) 
					{					
						System.out.println("exceptionnnn===>>"+e);
					}
															 
				}//end of for loop of show excel data
				
				System.out.println("The total number of records in the excel sheet :"+cnt);
				
				
				//move the excel file in other folder
			
				/*File f = new File("/home/sumedh/Desktop/Task_List/"+file1);					
				if(f.renameTo(new File("/home/sumedh/Desktop/Moved_Files/" + file1)))
				{							
					System.out.println("File is moved successful!");
				}*/
					
			   File f = new File("/home/javaprg/TaskList/"+file1);				
				if(f.renameTo(new File("/home/javaprg/TaskListDestination/" + file1)))
				{							
					System.out.println("File is moved successful!");
				}
  
        //=======================================================================   
        response.sendRedirect("uploadTask.jsp?msg=1");
}catch(Exception e){
	System.out.println("Th exception is >>>>>"+e);
	
}
%>

