<%@ include file="headConn.jsp"%>

<%
Connection con1 = null;
%>
<%
try 
{
System.out.println("\n>>>>>$$$$$$$$$$$$$>>>In AjaxContractDelete.jsp>>>>>>>>>>>>>>>>");	
Statement stmt1 = conn.createStatement();
Statement stmt2 = conn.createStatement();
Statement stmt3 = conn.createStatement();
Statement stmt4 = conn.createStatement();



String SqlDeleteMaster="",SqlClaimDet="",sql="",sql1="";
String cmnycode="",empid="",salutation="-",empname="-",deptid="",empemail="",designtion="",fstname="",mddlnm="",lastname="",twempid="",empcntctno="",date_brth="",maart_stts="",DateOfAnniversary="",KidsDetails="",Child1Sex="",Child2Sex="",Child1Name="",Child2Name="",Child1DOB="",Child2DOB="",AddressEmp="",SalaryDetails="",BasicSalarary="",TDS="",	NetPay="",Allowance="",Allowance1="",Allowance2="",Allowance3="",Allowance4="",deduction="",deduction1="",deduction2="",deduction3="",deduction4="",PreviousPay="",AccNo="",BankName="",BankBranch="",IFSC="",PanNo="",	PolicyNo="",NameOfClaimCompany="", 	ExpiryDateClaim="", 	ClaimAmount="", 	ContactImeediate="",ContactNoImmediate="",AddressContact="",RelationShip="",EnterBy="", 	EnteredDateTime="", 	ModifiedBy="",EditDateTime="",DateofJoining="",ContractDate="",ContractExpDate="",MediclaimFileName="", 	ContractFileName="",Status="",Status1="";

String id=request.getParameter("id");
System.out.println(">>>>>>>>id:"+id);


if(request.getParameter("action").equals("delete"))
{	
	 String SqlUpdate="UPDATE t_employee SET Status ='Deactive' WHERE EmpID='"+id+"' limit 1 ";
	System.out.println(">>>>>>>>SqlDeleteMaster:"+SqlUpdate);
	stmt1.executeUpdate(SqlUpdate);
	
	String SqlUpdate1="UPDATE t_leaveadmin SET Status ='No' WHERE EmpID='"+id+"' limit 1 ";
	stmt2.executeUpdate(SqlUpdate1);
	System.out.println(">>>>>>>>SqlDeleteMaster11:"+SqlUpdate1);
	
	
	/*
	
	String SqlUpdate2="select * from t_employee where EmpID='"+id+"'";
	stmt3.executeQuery(SqlUpdate2);
	ResultSet sqlupdat=stmt3.executeQuery(SqlUpdate2);
	System.out.println(">>>>>>>>SqlUpdate2:"+SqlUpdate2);
	if(sqlupdat.next())
	{
		cmnycode=sqlupdat.getString("CompanyCode");
		empid=sqlupdat.getString("EmpID");
		salutation=sqlupdat.getString("Salutation");
		empname=sqlupdat.getString("EmpName");
		deptid=sqlupdat.getString("DeptID");
		
		
		
		empemail=sqlupdat.getString("Empemail");
		designtion=sqlupdat.getString("designation");
		fstname=sqlupdat.getString("FirstName");
		mddlnm=sqlupdat.getString("MiddleName");
		lastname=sqlupdat.getString("LastName");
		twempid=sqlupdat.getString("TWEmpID");
		
		System.out.println("111");
		empcntctno=sqlupdat.getString("EmpContactNo");
		System.out.println("3333");
		
		//if(sqlupdat.getString("DateOfBirth")!="0000-00-00")
		//{
		
			try{
			date_brth=sqlupdat.getString("DateOfBirth").toString();
		 //	date_brth=sqlupdat.get("DateOfBirth");
			}catch(SQLException sq)
			{
				
				System.out.println("exception sql==>"+sq);	
				date_brth="0000-00-00";
				
			}
			
			//}else{
			
			
			
	//	}
		System.out.println("44444");
		maart_stts=sqlupdat.getString("MarialStatus");
		
		try{
		DateOfAnniversary=sqlupdat.getString("DateOfAnniversary");
		
		}catch(SQLException sq1)
		{
			
			System.out.println("exception sql==>"+sq1);	
			DateOfAnniversary="0000-00-00";
			
		}
		
		System.out.println("22222");
		
				KidsDetails=sqlupdat.getString("KidsDetails");
		Child1Sex=sqlupdat.getString("Child1Sex");
		Child2Sex=sqlupdat.getString("Child2Sex");
		Child1Name=sqlupdat.getString("Child1Name");
		Child2Name=sqlupdat.getString("Child2Name");
		
		try{
		Child1DOB=sqlupdat.getString("Child1DOB");
		Child2DOB=sqlupdat.getString("Child2DOB");
		
		}catch(SQLException sq2)
		{
			
			System.out.println("exception sql=2=>"+sq2);	
			Child1DOB="0000-00-00";
			Child2DOB="0000-00-00";
			
		}
		
		AddressEmp=sqlupdat.getString("AddressEmp");
		
		
		SalaryDetails=sqlupdat.getString("SalaryDetails");
		BasicSalarary=sqlupdat.getString("BasicSalarary");
		TDS=sqlupdat.getString("TDS");
		NetPay=sqlupdat.getString("NetPay");
		Allowance=sqlupdat.getString("Allowance");
		
		System.out.println("@@@@@@@@@222222>");	
		Allowance1=sqlupdat.getString("Allowance1");
		System.out.println("@@@@@@@@@+++++++222222>");
		
		Allowance2=sqlupdat.getString("Allowance2");
		Allowance3=sqlupdat.getString("Allowance3");
		Allowance4=sqlupdat.getString("Allowance4");
		deduction=sqlupdat.getString("deduction");
		deduction1=sqlupdat.getString("deduction1");
		deduction2=sqlupdat.getString("deduction2");
		deduction3=sqlupdat.getString("deduction3");
		deduction4=sqlupdat.getString("deduction4");
		
		try{
		PreviousPay=sqlupdat.getString("PreviousPay");
	
		}catch(SQLException sq3)
		{
			
			System.out.println("exception sql=3=>"+sq3);	
			PreviousPay="0000-00-00";
			
			
		}
		
		AccNo=sqlupdat.getString("AccNo");
		
		
		BankName=sqlupdat.getString("BankName");
		BankBranch=sqlupdat.getString("BankBranch");
		IFSC=sqlupdat.getString("IFSC");
		PanNo=sqlupdat.getString("PanNo");
		PolicyNo=sqlupdat.getString("PolicyNo");
		NameOfClaimCompany=sqlupdat.getString("NameOfClaimCompany");
		try{
		ExpiryDateClaim=sqlupdat.getString("ExpiryDateClaim");
		}catch(SQLException sq4)
		{
			
			System.out.println("exception sql=4=>"+sq4);	
			ExpiryDateClaim="0000-00-00";
			
			
		}
		ClaimAmount=sqlupdat.getString("ClaimAmount");
		ContactImeediate=sqlupdat.getString("ContactImeediate");
		ContactNoImmediate=sqlupdat.getString("ContactNoImmediate");
		AddressContact=sqlupdat.getString("AddressContact");
		RelationShip=sqlupdat.getString("RelationShip");
		EnterBy=sqlupdat.getString("EnterBy");
		
		try{
		EnteredDateTime=sqlupdat.getString("EnteredDateTime");
		}catch(SQLException sq88)
		{
			
			System.out.println("exception sql88=>"+sq88);	
			EnteredDateTime="0000-00-00";
			
			
		}
		ModifiedBy=sqlupdat.getString("ModifiedBy");
	
		try{
		EditDateTime=sqlupdat.getString("EditDateTime");
		}catch(SQLException sq77)
		{
			
			System.out.println("exception sql77=>"+sq77);	
			EditDateTime="0000-00-00";
			
			
		}
		
		
		
		try{
		DateofJoining=sqlupdat.getString("DateofJoining");
		}catch(SQLException sq5)
		{
			
			System.out.println("exception sql=5=>"+sq5);	
			DateofJoining="0000-00-00";
			
			
		}
		
		try{
		ContractDate=sqlupdat.getString("ContractDate");
		}catch(SQLException sq6)
		{
			
			System.out.println("exception sql=6=>"+sq6);	
			ContractDate="0000-00-00";
			
			
		}
		try{
		ContractExpDate=sqlupdat.getString("ContractExpDate");
		
		}catch(SQLException sq7)
		{
			
			System.out.println("exception sql=7=>"+sq7);	
			ContractExpDate="0000-00-00";
			
			
		}
		MediclaimFileName=sqlupdat.getString("MediclaimFileName");
		ContractFileName=sqlupdat.getString("ContractFileName");
		Status=sqlupdat.getString("Status");
		Status1=sqlupdat.getString("Status1");
		System.out.println(">>>>>>inser query>>hstry:111111");
		
		
		}
	
try{
		
		String hstry="insert into db_leaveapplication.t_employeeHistory1 (CompanyCode,EmpID,Salutation,EmpName,DeptID,Empemail,designation,FirstName,MiddleName,LastName,TWEmpID,EmpContactNo,DateOfBirth,MarialStatus,DateOfAnniversary,KidsDetails,Child1Sex,Child2Sex,Child1Name,Child2Name,Child1DOB,Child2DOB,AddressEmp,SalaryDetails,BasicSalarary,TDS,NetPay,Allowance,Allowance1,Allowance2,Allowance3,Allowance4,deduction,deduction1,deduction2,deduction3,deduction4,PreviousPay,AccNo,BankName,BankBranch,IFSC,PanNo,PolicyNo,NameOfClaimCompany,ExpiryDateClaim,ClaimAmount,ContactImeediate,ContactNoImmediate,AddressContact,RelationShip,EnterBy,EnteredDateTime,ModifiedBy,EditDateTime,DateofJoining,ContractDate,ContractExpDate,MediclaimFileName,ContractFileName,Status,Status1) values ('"+cmnycode+"', '"+empid+"','"+salutation+"','"+empname+"','"+deptid+"','"+empemail+"','"+designtion+"','"+fstname+"','"+mddlnm+"','"+lastname+"','"+twempid+"','"+empcntctno+"','"+date_brth+"','"+maart_stts+"','"+DateOfAnniversary+"','"+KidsDetails+"','"+Child1Sex+"','"+Child2Sex+"','"+Child1Name+"','"+Child2Name+"','"+Child1DOB+"','"+Child2DOB+"','"+AddressEmp+"','"+SalaryDetails+"','"+BasicSalarary+"','"+TDS+"','"+NetPay+"','"+Allowance+"','"+Allowance1+"','"+Allowance2+"','"+Allowance3+"','"+Allowance4+"','"+deduction+"','"+deduction1+"','"+deduction2+"','"+deduction3+"','"+deduction4+"','"+PreviousPay+"','"+AccNo+"','"+BankName+"','"+BankBranch+"','"+IFSC+"','"+PanNo+"','"+PolicyNo+"','"+NameOfClaimCompany+"','"+ExpiryDateClaim+"','"+ClaimAmount+"','"+ContactImeediate+"','"+ContactNoImmediate+"','"+AddressContact+"','"+RelationShip+"','"+EnterBy+"','"+EnteredDateTime+"','"+ModifiedBy+"','"+EditDateTime+"','"+DateofJoining+"','"+ContractDate+"','"+ContractExpDate+"','"+MediclaimFileName+"','"+ContractFileName+"','"+Status+"','"+Status1+"')";
		System.out.println(">>>>>>inser query>>hstry:111111"+hstry);
		stmt4.executeUpdate(hstry);
		System.out.println(">>>>>>inser query>>hstry:"+hstry);
	
		}catch(Exception e22)
		{
			System.out.println(">>>>>Exception in >insert query>>"+e22);
			out.print(">>>>>Exception in >insert query>>"+e22);
			
			//out.println(e22+"#");		
		}
	


*/




	out.println("Yes");
	
}

} 
catch (Exception e) {
System.out.println("AjaxContractDelete.jsp error  table > "+e);
out.println("NO");
} finally {
	con1.close();

}

%>