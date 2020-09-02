@isTest
public class RelatedMultipleRecordsControllerTest {
    
    private static Project__c project;
  	private static Triggers__c t;
    static{
        SmartFactory.FillAllFields = true;
        project=(Project__c)SmartFactory.createSObject('Project__c');
        project.Background_Description__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Coalition_Strategy__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Digital_Strategy__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Empower__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Engage__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Executive_Summary__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.External_Helpful_Strengths__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.External_Harmful_Weaknesses__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Goals_and_Objectives__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.In_Scope__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Internal_Helpful_Strengths__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Internal_Harmful_Weaknesses__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Monitor__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Out_of_Scope__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Partner__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Philanthropy__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Plan_Appendix__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Strategies__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
        project.Timeline_Schedule__c='<img alt="User-added image" src="https://cs52.salesforce.com/servlet/servlet.ImageServer?id=0155B0000008zfOQAQ&amp;oid=00D5B000000CrUqUAK" style="height: 351px; width: 500px;">';
       	project.Dashboard_Timeline_Start_Date__c=System.now().date().addDays(-7);
        project.Dashboard_Timeline_End_Date__c=System.now().date();
        t = new Triggers__c();
        t.Execute__c = false;
        insert t;
        insert project;
    }
    
    static testMethod void unitTest(){
        Communication_Log__c comm = New Communication_Log__c();
        comm.Master_Communication_Log__c=null;
        comm.NotUpdateRecord__c=true;
        comm.Brief_Desscription__c = 'Test';
        insert comm;
        
        Communication_Log__c commChild = New Communication_Log__c();
        commChild.Master_Communication_Log__c=comm.Id;
        commChild.NotUpdateRecord__c=true;
        commChild.Brief_Desscription__c = 'Test';
        insert commChild;
        
        PageReference pageRef = Page.VFP_RelatedMultipleRecords;
        pageRef.getParameters().put('newid', comm.Id);
        pageRef.getParameters().put('master', null);
        Test.setCurrentPage(pageRef);
        
        
        //newid=a0R2C000000ZTeU&recordOrigin=a0R2C000000ZTeU&master=00205
        
        
        
        Account acc = new Account(Name = 'AccTest');
		insert acc;
        
        Contact cont = new Contact(LastName = 'Sanchez', FirstName='Miguel', email='miguelsa@gmail.com', phone='93939393');
        insert cont;
       
        Activity__c act = new Activity__c(Name='ActTest');
        insert act;
       
        Project__c proj = new Project__c(Name='PrjTest');
        insert proj;
        
        RelatedMultipleRecordsController contrl = new RelatedMultipleRecordsController();
        
        contrl.selectclickAcc();
        contrl.selectclickAcc();
    	contrl.selectclickCon();
        contrl.selectclickAct();
        contrl.selectclickProj();
        contrl.unselectclickAcc();
        contrl.unselectclickCon();
        contrl.unselectclickAct();
        contrl.unselectclickProj();
        contrl.getunSelectedValuesAcc();
        contrl.getSelectedValuesAcc();
        contrl.getunSelectedValuesCon();
        contrl.getSelectedValuesCon();
        contrl.getunSelectedValuesAct();
        contrl.getSelectedValuesAct();
        contrl.getunSelectedValuesProj();
        contrl.getSelectedValuesProj();
        contrl.findAcc();
        contrl.findCon();
        contrl.findAct();
        contrl.findProj();
        contrl.done();
        contrl.cancel();
    }
    
    static testMethod void unitTest02(){
        Communication_Log__c comm = New Communication_Log__c();
        comm.Master_Communication_Log__c=null;
        comm.NotUpdateRecord__c=true;
        comm.Brief_Desscription__c = 'Test';
        insert comm;
        
        Communication_Log__c commChild = New Communication_Log__c();
        commChild.Master_Communication_Log__c=comm.Id;
        commChild.NotUpdateRecord__c=true;
        commChild.Brief_Desscription__c = 'Test';
        insert commChild;
        
        PageReference pageRef = Page.VFP_RelatedMultipleRecords;
        pageRef.getParameters().put('newid', commChild.Id);
        pageRef.getParameters().put('master', comm.Id);
        Test.setCurrentPage(pageRef);
        
        
        //newid=a0R2C000000ZTeU&recordOrigin=a0R2C000000ZTeU&master=00205
        
        
        
        Account acc = new Account(Name = 'AccTest');
		insert acc;
        
        Contact cont = new Contact(LastName = 'Sanchez', FirstName='Miguel', email='miguelsa@gmail.com', phone='93939393');
        insert cont;
       
        Activity__c act = new Activity__c(Name='ActTest');
        insert act;
       
        Project__c proj = new Project__c(Name='PrjTest');
        insert proj;
        
        RelatedMultipleRecordsController contrl = new RelatedMultipleRecordsController();
        
        contrl.selectclickAcc();
        contrl.selectclickAcc();
    	contrl.selectclickCon();
        contrl.selectclickAct();
        contrl.selectclickProj();
        contrl.unselectclickAcc();
        contrl.unselectclickCon();
        contrl.unselectclickAct();
        contrl.unselectclickProj();
        contrl.getunSelectedValuesAcc();
        contrl.getSelectedValuesAcc();
        contrl.getunSelectedValuesCon();
        contrl.getSelectedValuesCon();
        contrl.getunSelectedValuesAct();
        contrl.getSelectedValuesAct();
        contrl.getunSelectedValuesProj();
        contrl.getSelectedValuesProj();
        contrl.findAcc();
        contrl.findCon();
        contrl.findAct();
        contrl.findProj();
        contrl.done();
        contrl.cancel();
    }
    
    static testMethod void unitTest03(){
        Communication_Log__c comm = New Communication_Log__c();
        comm.Master_Communication_Log__c=null;
        comm.NotUpdateRecord__c=true;
        comm.Brief_Desscription__c = 'Test';
        insert comm;
        
        Communication_Log__c commChild = New Communication_Log__c();
        commChild.Master_Communication_Log__c=comm.Id;
        commChild.NotUpdateRecord__c=true;
        commChild.Brief_Desscription__c = 'Test';
        insert commChild;
        
        PageReference pageRef = Page.VFP_RelatedMultipleRecords;
        pageRef.getParameters().put('recordOrigin', comm.Id);
        pageRef.getParameters().put('master', null);
        Test.setCurrentPage(pageRef);
        
        
        //newid=a0R2C000000ZTeU&recordOrigin=a0R2C000000ZTeU&master=00205
        
        
        
        Account acc = new Account(Name = 'AccTest');
		insert acc;
        
        Contact cont = new Contact(LastName = 'Sanchez', FirstName='Miguel', email='miguelsa@gmail.com', phone='93939393');
        insert cont;
       
        Activity__c act = new Activity__c(Name='ActTest');
        insert act;
       
        Project__c proj = new Project__c(Name='PrjTest');
        insert proj;
        
        RelatedMultipleRecordsController contrl = new RelatedMultipleRecordsController();
        
        contrl.selectclickAcc();
        contrl.selectclickAcc();
    	contrl.selectclickCon();
        contrl.selectclickAct();
        contrl.selectclickProj();
        contrl.unselectclickAcc();
        contrl.unselectclickCon();
        contrl.unselectclickAct();
        contrl.unselectclickProj();
        contrl.getunSelectedValuesAcc();
        contrl.getSelectedValuesAcc();
        contrl.getunSelectedValuesCon();
        contrl.getSelectedValuesCon();
        contrl.getunSelectedValuesAct();
        contrl.getSelectedValuesAct();
        contrl.getunSelectedValuesProj();
        contrl.getSelectedValuesProj();
        contrl.findAcc();
        contrl.findCon();
        contrl.findAct();
        contrl.findProj();
        contrl.done();
        contrl.cancel();
    }
}