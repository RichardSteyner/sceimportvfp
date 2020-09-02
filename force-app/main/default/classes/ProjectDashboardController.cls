public class ProjectDashboardController {
    public Organization org{get;set;}
    public String logoUrl{get;set;}
    public String underConstructionUrl{get;set;}
    public String dashboardDateAs{get;set;}
    public String timelineStartYear{get;set;}
    public String timelineEndYear{get;set;}
    public String projectSentence{get;set;}
    public Map<String, List<Project_Team_Member__c>> ProjectTeams{get;set;}
    public Map<String, List<Other_Participant__c>> otherParticipants{get;set;}
    public Map<String, Goals__c> goals{get;set;}
    public Map<String, List<Objective__c>> objetives{get;set;}
    public List<Stakeholder_Analysis__c> engageStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> partnerStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> monitorStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> empowerStakeholders{get;set;}
    public String GreenCircleUrl{get;set;}
    public String RedCircleUrl{get;set;}
    public String YellowCircleUrl{get;set;}
    public String NAUrl{get;set;}
    public Boolean HasGate{get;set;}
    public List<Milestones__c> milestones{get;set;}

    public ProjectDashboardController(ApexPages.StandardController stdController) {
        Project__c project = (Project__c)stdController.getRecord();
        Document logo = [Select Id From Document WHERE name='Logo'];
        org = [select id, Division from Organization];
        underConstructionUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+[Select id from document where name='Under-construction'].id+'&oid='+UserInfo.getOrganizationId();
        logoUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+[Select Id From Document WHERE name='DashboardLogo'].id+'&oid='+UserInfo.getOrganizationId();
        dashboardDateAs = '';
        if(project.Dashboard_Date_As__c!=null) dashboardDateAs = dateFormatted(project.Dashboard_Date_As__c);
        if(project.Dashboard_Timeline_Start_Date__c!=null) timelineStartYear = String.valueOf(project.Dashboard_Timeline_Start_Date__c.Year());
        if(project.Dashboard_Timeline_End_Date__c!=null) timelineEndYear = String.valueOf(project.Dashboard_Timeline_End_Date__c.Year());
        List<Document> Circle=[select id from document where name='circle-green' or name='circle-red' or name='circle-yellow' or name='N/A'];
        GreenCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[0].id+'&oid='+UserInfo.getOrganizationId();
        RedCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[1].id+'&oid='+UserInfo.getOrganizationId();
        YellowCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[2].id+'&oid='+UserInfo.getOrganizationId();
        NAUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[3].id+'&oid='+UserInfo.getOrganizationId();
        buildingProjectSentence(project.id);
        buildingProjectTeam(project.id);
        buildingGoalsObjetives(project.id);
        //engageStakeholders = [select id, Short_Description__c from Stakeholder_Interest_Matrix__c where Project_Plan__c=:project.id and Key_Interest__c=true and Type__c='Engage' order by Createddate limit 6];
        engageStakeholders = [select id, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:project.id and Key_Interest__c=true and Stakeholder_Summary_Category__c='Engage' order by Createddate limit 5];
        //partnerStakeholders = [select id, Short_Description__c from Stakeholder_Interest_Matrix__c where Project_Plan__c=:project.id and Key_Interest__c=true and Type__c='Partner' order by Createddate limit 6];
        partnerStakeholders = [select id, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:project.id and Key_Interest__c=true and Stakeholder_Summary_Category__c='Partner' order by Createddate limit 5];
        //monitorStakeholders = [select id, Short_Description__c from Stakeholder_Interest_Matrix__c where Project_Plan__c=:project.id and Key_Interest__c=true and Type__c='Monitor' order by Createddate limit 6];
        monitorStakeholders = [select id, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:project.id and Key_Interest__c=true and Stakeholder_Summary_Category__c='Monitor' order by Createddate limit 5];
        //empowerStakeholders = [select id, Short_Description__c from Stakeholder_Interest_Matrix__c where Project_Plan__c=:project.id and Key_Interest__c=true and Type__c='Empower' order by Createddate limit 6];
        empowerStakeholders = [select id, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:project.id and Key_Interest__c=true and Stakeholder_Summary_Category__c='Empower' order by Createddate limit 5];
        addingMilestones(project.id);
        //Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + Project__c.name+'-ProjectPlan.pdf');
    }
    private String dateFormatted(Date dt){
        if(dt != null){
            String quarter;
            if(dt.month()>9){
                quarter = '4';
            }
            else if(dt.month()>6){
                quarter = '3';
            }
            else if(dt.month()>3){
                quarter = '2';
            }
            else{
                quarter = '1';
            }
            return 'Q'+quarter+' '+dt.Year();
        }
        return '';
    }
    private void buildingProjectSentence(String projectId){
        projectSentence = '';
        List<Related_Project_Jurisdictions__c> projectJurisdictions = [select id, Organization__r.Name from Related_Project_Jurisdictions__c where Project_Plan__c =:projectId and Major_Project_Jurisdiction__c = true order by Organization__r.Name];
        for(Integer i=0;i<projectJurisdictions.size();i++){
            if(i == 0) projectSentence = 'Major Project Jurisdictions: ';
            if(projectJurisdictions.size()==1){
                projectSentence += projectJurisdictions[i].Organization__r.Name;
            }
            else if(projectJurisdictions.size()>1 && projectJurisdictions.size()==i+2){
                projectSentence += projectJurisdictions[i].Organization__r.Name+' and '+projectJurisdictions[i+1].Organization__r.Name;
                break;
            }
            else{
                projectSentence += projectJurisdictions[i].Organization__r.Name+', ';
            }
        }
    }
    private void buildingProjectTeam(String projectId){
        ProjectTeams = new Map<String, List<Project_Team_Member__c>>();
        otherParticipants = new Map<String, List<Other_Participant__c>>();
        for(Integer i=1;i<=8;i++){
            ProjectTeams.put(String.valueOf(i), new List<Project_Team_Member__c>());
            otherParticipants.put(String.valueOf(i), new List<Other_Participant__c>());
        }
        for(Project_Team_Member__c projTeamMember:[select id, Project_Team_Member_Order__c, Contact__r.Name, Contact__r.title, Total_Time__c,Time_commitment_to_LPA_team_Q1__c,Time_commitment_to_LPA_team_Q2__c,Time_commitment_to_LPA_team_Q3__c,Time_commitment_to_LPA_team_Q4__c from Project_Team_Member__c where Project__c=:projectId and Project_Team_Member_Order__c != null]){
            ProjectTeams.get(projTeamMember.Project_Team_Member_Order__c).add(projTeamMember);
        }
        for(Other_Participant__c otherParticipant:[select id, Project_Other_Partner_Order__c, Full_Name__c, Role__c, Contact_Title__c from Other_Participant__c where Project__c=:projectId and Project_Other_Partner_Order__c != null]){
            otherParticipants.get(otherParticipant.Project_Other_Partner_Order__c).add(otherParticipant);
        }
    }
    private void buildingGoalsObjetives(String projectId){
        goals = new Map<String, Goals__c>();
        objetives = new Map<String, List<Objective__c>>();
        for(Integer i=1;i<=8;i++){
            objetives.put(String.valueOf(i), new List<Objective__c>());
        }
        for(Goals__c goal:[select id, Name, Project_Plan_Dashboard_Placement__c, Short_Description__c 
                          from Goals__c where Project_Plan__c=:projectId and Key_Goal__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
            goals.put(goal.Project_Plan_Dashboard_Placement__c, goal);
        }
        for(Objective__c objetive:[select id, Project_Plan_Dashboard_Placement__c, Short_Description__c 
                                  from Objective__c where Project_Plan__c=:projectId and Key_Objective__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
            objetives.get(objetive.Project_Plan_Dashboard_Placement__c).add(objetive);
        }
    }
    private void addingMilestones(String projectId){
        milestones = new List<Milestones__c>();
        for(Milestones__c milestone:[select id, Name, Type_of_Milestone__c, Est_Completion_Date__c, Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c, Milestone_and_Project__r.Dashboard_Timeline_End_Date__c, Gate__c  
                                    from Milestones__c where Milestone_and_Project__c=:projectId and Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c!=null and Milestone_and_Project__r.Dashboard_Timeline_End_Date__c!=null and Key_Milestone__c=true and (Type_of_Milestone__c='Other' or Type_of_Milestone__c='LPA') order by Est_Completion_Date__c]){
            if(milestone.Est_Completion_Date__c>=milestone.Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c &&
              milestone.Est_Completion_Date__c<=milestone.Milestone_and_Project__r.Dashboard_Timeline_End_Date__c){
                milestone.Type_of_Milestone__c = milestone.Type_of_Milestone__c.toLowerCase();
                if(milestone.Gate__c!=null) HasGate = true;
                milestones.add(milestone);
            }
        }
    }
}