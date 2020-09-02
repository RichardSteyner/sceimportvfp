@isTest
public class ProjectPlanSummary2Test {
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
        project.Dashboard_Timeline_Start_Date__c = system.today();
        project.Dashboard_Timeline_End_Date__c  = system.today().addDays(1);
    	t = new Triggers__c();
		t.Execute__c = false;
		insert t;
        insert project;
        Tactics_Deliverables__c tacDeliver=(Tactics_Deliverables__c)SmartFactory.createSObject('Tactics_Deliverables__c');
        tacDeliver.Project__c=project.id;
        insert tacDeliver;
        Milestones__c milestones=(Milestones__c)SmartFactory.createSObject('Milestones__c');
        milestones.Milestone_and_Project__c=project.id;
        insert milestones;
        Engagement_Techniques__c engagementtechniques=(Engagement_Techniques__c)SmartFactory.createSObject('Engagement_Techniques__c');
        engagementtechniques.Project_Plan__c=project.id;
        insert engagementtechniques;
        Project_Team_Member__c projectTeamMember=(Project_Team_Member__c)SmartFactory.createSObject('Project_Team_Member__c');
        projectTeamMember.Project__c=project.id;
        insert projectTeamMember;
        Other_Participant__c otherParticipant=(Other_Participant__c)SmartFactory.createSObject('Other_Participant__c');
        otherParticipant.Project__c=project.id;
        insert otherParticipant;
        Account a2 = new Account(Name='Southern California Edison');
        insert a2;
        Contact c1 = new Contact(Firstname='Contact First 1',LastName='Contact Last 1', AccountId = a2.id);
        insert c1;
        Contact c2 = new Contact(Firstname='Contact First 2',LastName='Contact Last 2', AccountId = a2.id);
        insert c2;
        Account a1 = new Account(Name='Account 1');
        insert a1;
        Stakeholder_Analysis__c stakeAnalysis=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        //Stakeholder_Analysis__c stakeAnalysis= new Stakeholder_Analysis__c();
        stakeAnalysis.Project__c=project.id;
        stakeAnalysis.Stakeholder_Summary_Category__c = 'Partner';
        stakeAnalysis.SCE_Relationship_Contact__c=c1.id;
        stakeAnalysis.Stakeholder_Contact__c=c2.id;
        stakeAnalysis.Stakeholder_Organization__c=a1.id;
        insert stakeAnalysis;
        Stakeholder_Analysis__c stakeAnalysis2=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        //Stakeholder_Analysis__c stakeAnalysis= new Stakeholder_Analysis__c();
        stakeAnalysis2.Project__c=project.id;
        stakeAnalysis2.Stakeholder_Summary_Category__c = 'Engage';
        stakeAnalysis2.SCE_Relationship_Contact__c=c1.id;
        stakeAnalysis2.Stakeholder_Contact__c=c2.id;
        stakeAnalysis2.Stakeholder_Organization__c=a1.id;
        insert stakeAnalysis2;
        Stakeholder_Analysis__c stakeAnalysis3=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        //Stakeholder_Analysis__c stakeAnalysis= new Stakeholder_Analysis__c();
        stakeAnalysis3.Project__c=project.id;
        stakeAnalysis3.Stakeholder_Summary_Category__c = 'Empower';
        stakeAnalysis3.SCE_Relationship_Contact__c=c1.id;
        stakeAnalysis3.Stakeholder_Contact__c=c2.id;
        stakeAnalysis3.Stakeholder_Organization__c=a1.id;
        insert stakeAnalysis3;
        Stakeholder_Analysis__c stakeAnalysis4=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        //Stakeholder_Analysis__c stakeAnalysis= new Stakeholder_Analysis__c();
        stakeAnalysis4.Project__c=project.id;
        stakeAnalysis4.Stakeholder_Summary_Category__c = 'Monitor';
        stakeAnalysis4.SCE_Relationship_Contact__c=c1.id;
        stakeAnalysis4.Stakeholder_Contact__c=c2.id;
        stakeAnalysis4.Stakeholder_Organization__c=a1.id;
        insert stakeAnalysis4;
        Risks_and_Issues__c risksIssues=(Risks_and_Issues__c)SmartFactory.createSObject('Risks_and_Issues__c');
        risksIssues.Project__c=project.id;
        insert risksIssues;
        Folder folder=[select id, name from folder where name='Shared Documents'];
        Document greenCircle=new Document();
        greenCircle.name='circle-green';
        greenCircle.DeveloperName='greenCircle';
        greenCircle.FolderId=folder.id;
        greenCircle.IsPublic=true;
        insert greenCircle;
        Document redCircle=new Document();
        redCircle.name='circle-red';
        redCircle.DeveloperName='redCircle';
        redCircle.FolderId=folder.id;
        redCircle.IsPublic=true;
        insert redCircle;
        Document yellowCircle=new Document();
        yellowCircle.name='circle-yellow';
        yellowCircle.DeveloperName='yellowCircle';
        yellowCircle.FolderId=folder.id;
        yellowCircle.IsPublic=true;
        insert yellowCircle;
    }
    
    @isTest static void ProjectPlanSummary2(){
        PageReference currentPage =  Page.VFPProjectPlanSummary;
		Test.setCurrentPage(currentPage);
		ApexPages.currentPage().getParameters().put('id', project.id);
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
			ProjectPlanSummary2 pps=new ProjectPlanSummary2();
            System.AssertNotEquals(null, pps.getPrintView(), 'Expected to get code');
			Test.stopTest();
     	}

        
    }    
    
    @isTest static void RtaImagetoDocument(){
        project.Background_Description__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Coalition_Strategy__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Digital_Strategy__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Empower__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Engage__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Executive_Summary__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.External_Helpful_Strengths__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.External_Harmful_Weaknesses__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Goals_and_Objectives__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.In_Scope__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Internal_Helpful_Strengths__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Internal_Harmful_Weaknesses__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Monitor__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Out_of_Scope__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Partner__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Philanthropy__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Plan_Appendix__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Strategies__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Timeline_Schedule__c='<img alt="User-added image" src="https://c.cs52.content.force.com/servlet/rtaImage?eid=a075B0000009RVN&amp;feoid=00N6100000Du7Yn&amp;refid=0EM5B000000012B" style="height: 461px; width: 500px;">';
        project.Dashboard_Timeline_Start_Date__c = system.today();
        project.Dashboard_Timeline_End_Date__c  = system.today().addDays(1);
		System.runAs(new User(Id = UserInfo.getUserId())){
			Test.startTest();
            update project;
			Test.stopTest();
		    
		}
    }    
}