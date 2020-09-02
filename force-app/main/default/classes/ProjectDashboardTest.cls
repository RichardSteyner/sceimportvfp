@isTest
public class ProjectDashboardTest {
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
    	project.Dashboard_Date_As__c=Date.valueOf('2017-01-18');
    	project.Dashboard_Timeline_Start_Date__c=Date.valueOf('2016-01-01');
    	project.Dashboard_Timeline_End_Date__c=Date.valueOf('2017-12-31');
    	t = new Triggers__c();
		t.Execute__c = false;
		insert t;
        insert project;
        Related_Project_Jurisdictions__c projectJurisdictions=(Related_Project_Jurisdictions__c)SmartFactory.createSObject('Related_Project_Jurisdictions__c');
        projectJurisdictions.Project_Plan__c=project.id;
        projectJurisdictions.Major_Project_Jurisdiction__c=true;
        insert projectJurisdictions;
        Project_Team_Member__c projectTeamMember=(Project_Team_Member__c)SmartFactory.createSObject('Project_Team_Member__c');
        projectTeamMember.Project__c=project.id;
        insert projectTeamMember;
        Other_Participant__c otherParticipant=(Other_Participant__c)SmartFactory.createSObject('Other_Participant__c');
        otherParticipant.Project__c=project.id;
        insert otherParticipant;
        Goals__c goal=(Goals__c)SmartFactory.createSObject('Goals__c');
        goal.Project_Plan__c=project.id;
        goal.Key_Goal__c=true;
        goal.Project_Plan_Dashboard_Placement__c='3';
        insert goal;
        Objective__c objective=(Objective__c)SmartFactory.createSObject('Objective__c');
        objective.Project_Plan__c=project.id;
        objective.Key_Objective__c=true;
        insert objective;
        Milestones__c milestone=(Milestones__c)SmartFactory.createSObject('Milestones__c');
        milestone.Milestone_and_Project__c=project.id;
        milestone.Key_Milestone__c=true;
        milestone.Type_of_Milestone__c='Other';
        milestone.Gate__c='1';
    	milestone.Est_Completion_Date__c=Date.valueOf('2016-02-01');
        insert milestone;
        Stakeholder_Analysis__c stakeAnalysis01=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        stakeAnalysis01.Project__c=project.id;
        stakeAnalysis01.Stakeholder_Summary_Category__c='Engage';
        insert stakeAnalysis01;
        Stakeholder_Analysis__c stakeAnalysis02=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        stakeAnalysis02.Project__c=project.id;
        stakeAnalysis02.Stakeholder_Summary_Category__c='Partner';
        insert stakeAnalysis02;
        Stakeholder_Analysis__c stakeAnalysis03=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        stakeAnalysis03.Project__c=project.id;
        stakeAnalysis03.Stakeholder_Summary_Category__c='Monitor';
        insert stakeAnalysis03;
        Stakeholder_Analysis__c stakeAnalysis04=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        stakeAnalysis04.Project__c=project.id;
        stakeAnalysis04.Stakeholder_Summary_Category__c='Empower';
        insert stakeAnalysis04;
        Risks_and_Issues__c risksIssues=(Risks_and_Issues__c)SmartFactory.createSObject('Risks_and_Issues__c');
        risksIssues.Project__c=project.id;
        insert risksIssues;
        Folder folder=[select id, name from folder where name='Shared Documents'];
        Document logo1=new Document();
        logo1.name='Logo';
        logo1.DeveloperName='dbLogo1';
        logo1.FolderId=folder.id;
        logo1.IsPublic=true;
        insert logo1;
        Document logo2=new Document();
        logo2.name='DashboardLogo';
        logo2.DeveloperName='dbLogo2';
        logo2.FolderId=folder.id;
        logo2.IsPublic=true;
        insert logo2;
        Document UnderConstruction=new Document();
        UnderConstruction.name='Under-construction';
        UnderConstruction.DeveloperName='DashboardUnderConstruction';
        UnderConstruction.FolderId=folder.id;
        UnderConstruction.IsPublic=true;
        insert UnderConstruction;
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
        Document nA=new Document();
        nA.name='N/A';
        nA.DeveloperName='DashboardNA';
        nA.FolderId=folder.id;
        nA.IsPublic=true;
        insert nA;
    }
    @isTest static void ProjectDashboardControllerTest(){
        PageReference currentPage =  Page.ProjectDashboard;
		Test.setCurrentPage(currentPage);
		ApexPages.currentPage().getParameters().put('id', project.id);
		ApexPages.StandardController projectStandardController = new ApexPages.StandardController(project);
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
			ProjectDashboardController projectDashboard=new ProjectDashboardController(projectStandardController);
            //System.AssertNotEquals(null, projectDashboard.getPrintView(), 'Expected to get code');
			Test.stopTest();
     	}
    }    
    @isTest static void ProjectDashboardsControllerTest(){
        PageReference currentPage =  Page.ProjectDashboard;
		Test.setCurrentPage(currentPage);
		ApexPages.currentPage().getParameters().put('id', project.id);
		List<Project__c> projects = new List<Project__c>();
		projects.add(project);
		ApexPages.StandardSetController projectStandardSetController = new ApexPages.StandardSetController(projects);
		projectStandardSetController.setSelected(projects);
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
			ProjectDashboardsController projectDashboards=new ProjectDashboardsController(projectStandardSetController);
            //System.AssertNotEquals(null, projectDashboard.getPrintView(), 'Expected to get code');
			Test.stopTest();
     	}
    }    
    @isTest static void ProjectPlanValidationTest(){
        SmartFactory.FillAllFields = true;
        Project__c newProject=(Project__c)SmartFactory.createSObject('Project__c');
    	newProject.Dashboard_Date_As__c=Date.valueOf('2017-01-18');
    	newProject.Dashboard_Timeline_Start_Date__c=Date.valueOf('2016-01-01');
    	newProject.Dashboard_Timeline_End_Date__c=Date.valueOf('2017-12-31');
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert newProject;
    	    project.Dashboard_Timeline_Start_Date__c=Date.valueOf('2015-12-31');
    	    update project;
    	    project.Dashboard_Timeline_End_Date__c=Date.valueOf('2018-01-01');
    	    update project;
			Test.stopTest();
     	}
    }    
    @isTest static void OtherParticipantValidationTest(){
        SmartFactory.FillAllFields = true;
        Other_Participant__c otherParticipant=(Other_Participant__c)SmartFactory.createSObject('Other_Participant__c');
        otherParticipant.Project__c=project.id;
        otherParticipant.Project_Other_Partner_Order__c='8';
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert otherParticipant;
            otherParticipant.Project_Other_Partner_Order__c='2';
            update otherParticipant;
    		Test.stopTest();
     	}
    }    
    @isTest static void GoalsValidationTest(){
        SmartFactory.FillAllFields = true;
        Goals__c goal=(Goals__c)SmartFactory.createSObject('Goals__c');
        goal.Project_Plan__c=project.id;
        goal.Key_Goal__c=true;
        goal.Project_Plan_Dashboard_Placement__c='1';
        Goals__c goal2=(Goals__c)SmartFactory.createSObject('Goals__c');
        goal2.Project_Plan__c=project.id;
        goal2.Key_Goal__c=false;
        goal2.Project_Plan_Dashboard_Placement__c='2';
        insert goal2;
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert goal;
            goal2.Key_Goal__c=true;
            update goal2;
    		Test.stopTest();
     	}
    }    
    @isTest static void ObjectivesValidationTest(){
        SmartFactory.FillAllFields = true;
        Objective__c objective=(Objective__c)SmartFactory.createSObject('Objective__c');
        objective.Project_Plan__c=project.id;
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert objective;
            objective.Key_Objective__c=false;
            update objective;
    		Test.stopTest();
     	}
    }    
    @isTest static void TeamMemberValidationTest(){
        SmartFactory.FillAllFields = true;
        Project_Team_Member__c teamMember=(Project_Team_Member__c)SmartFactory.createSObject('Project_Team_Member__c');
        teamMember.Project__c=project.id;
        teamMember.Project_Team_Member_Order__c='8';
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert teamMember;
            teamMember.Project_Team_Member_Order__c='7';
            update teamMember;
    		Test.stopTest();
     	}
    }    
    @isTest static void StakeholderInterestMatrixValidationAnalystTest(){
        SmartFactory.FillAllFields = true;
        Stakeholder_Analysis__c stakeAnalysis01=(Stakeholder_Analysis__c)SmartFactory.createSObject('Stakeholder_Analysis__c');
        stakeAnalysis01.Project__c=project.id;
        stakeAnalysis01.Stakeholder_Summary_Category__c='Engage';
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert stakeAnalysis01;
            stakeAnalysis01.Stakeholder_Summary_Category__c='Monitor';
            update stakeAnalysis01;
    		Test.stopTest();
     	}
    }    
    @isTest static void MilestonesValidationTest(){
        SmartFactory.FillAllFields = true;
        Milestones__c milestone=(Milestones__c)SmartFactory.createSObject('Milestones__c');
        milestone.Milestone_and_Project__c=project.id;
        milestone.Key_Milestone__c=true;
        milestone.Type_of_Milestone__c='Other';
        milestone.Gate__c='1';
    	milestone.Est_Completion_Date__c=Date.valueOf('2016-03-10');
		System.runAs(new User(Id = UserInfo.getUserId())){        
			Test.startTest();
            insert milestone;
        	project.Dashboard_Timeline_Start_Date__c=Date.valueOf('2016-01-01');
        	project.Dashboard_Timeline_End_Date__c=Date.valueOf('2016-12-31');
        	update project;
            Milestones__c milestone02=(Milestones__c)SmartFactory.createSObject('Milestones__c');
            milestone02.Milestone_and_Project__c=project.id;
            milestone02.Key_Milestone__c=true;
            milestone02.Type_of_Milestone__c='LPA';
        	milestone02.Est_Completion_Date__c=Date.valueOf('2016-04-10');
            insert milestone02;
            milestone02.Key_Milestone__c=false;
            update milestone02;
            milestone02.Key_Milestone__c=true;
            update milestone02;
    		Test.stopTest();
     	}
    }    
}