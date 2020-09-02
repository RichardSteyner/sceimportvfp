public class ProjectDashboardsController {
    public List<ProjectDashboard> selectedProjects{get;set;}
    public Map<String, ProjectDashboard> selectedProjectsMap{get;set;}
    public Organization org{get;set;}
    public String logoUrl{get;set;}
    public String underConstructionUrl{get;set;}
    public String GreenCircleUrl{get;set;}
    public String RedCircleUrl{get;set;}
    public String YellowCircleUrl{get;set;}
    public String NAUrl{get;set;}
    public ProjectDashboardsController(ApexPages.StandardSetController standardController){
        selectedProjectsMap = new Map<String, ProjectDashboard>();
        for(Project__c project:[Select id, Name, Dashboard_Date_As__c, Project_Summary_Display__c, Project_Summary__c, Project_Type__c, Other_Project_Type__c, 
                               Primary_Project_Summary__c, LPA_Project_Team_Displayed__c, Goals_Objectives_Displayed__c, Project_Timeline_Displayed__c, Draft__c, 
                               Stakeholder_Environment_Displayed__c, City_Council__c, County_Board_Of_Supervisors__c, State_Legislature__c, State_Legislation__c, 
                               Federal_Legislature__c, Federal_Legislation__c, Legal_Proceedings__c, Sensitive_Land_Users__c, Sensitive_Property_Owners__c, Visual_Impact__c,
                               Special_Interest_Groups__c, Community_Character__c, Media__c, Previous_Controversy__c, Clarity_of_Project_Need_toPublic__c, Political_Issue__c, 
                               Grassroots_Community_Opposition__c, Stakeholder_interest_Matrix_Displayed__c, Dashboard_Timeline_Start_Date__c, Dashboard_Timeline_End_Date__c, 
                               LPA_Project_Start_Date__c, LPA_Est_Completion_Date__c, Corporate_Project_Start_Date__c, Corporate_Project_Est_Completion_Date__c, Owner.Name, Owner.Title 
                               from Project__c where id in:(List<Project__c>)standardController.getSelected()]){
            selectedProjectsMap.put(project.id, new ProjectDashboard(project));
        }
        org = [select id, Division from Organization];
        underConstructionUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+[Select id from document where name='Under-construction'].id+'&oid='+UserInfo.getOrganizationId();
        logoUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+[Select Id From Document WHERE name='DashboardLogo'].id+'&oid='+UserInfo.getOrganizationId();
        List<Document> Circle=[select id from document where name='circle-green' or name='circle-red' or name='circle-yellow' or name='N/A'];
        GreenCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[0].id+'&oid='+UserInfo.getOrganizationId();
        RedCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[1].id+'&oid='+UserInfo.getOrganizationId();
        YellowCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[2].id+'&oid='+UserInfo.getOrganizationId();
        NAUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[3].id+'&oid='+UserInfo.getOrganizationId();
        buildingItems();
        selectedProjects = selectedProjectsMap.values();
    }
    private void buildingItems(){
        for(Related_Project_Jurisdictions__c projectJurisdiction:[select id, Project_Plan__c, Organization__r.Name from Related_Project_Jurisdictions__c where Project_Plan__c =:selectedProjectsMap.keySet() and Major_Project_Jurisdiction__c = true order by Organization__r.Name]){
            selectedProjectsMap.get(projectJurisdiction.Project_Plan__c).projectSentence += projectJurisdiction.Organization__r.Name+', ';
        }
        for(ProjectDashboard projectDB:selectedProjectsMap.values()){
            if(projectDB.projectSentence.countMatches(', ')>0){
                projectDB.projectSentence = projectDB.projectSentence.removeEnd(', ');
                if(projectDB.projectSentence.countMatches(', ')>0){
                    String lastWord = projectDB.projectSentence.substringAfterLast(', ');
                    projectDB.projectSentence = projectDB.projectSentence.removeEnd(', '+lastWord);
                    projectDB.projectSentence += ' and '+lastWord;
                }
            }
            else{
                projectDB.projectSentence = '';
            }
            for(Integer i=1;i<=8;i++){
                projectDB.ProjectTeams.put(String.valueOf(i), new List<Project_Team_Member__c>());
                projectDB.otherParticipants.put(String.valueOf(i), new List<Other_Participant__c>());
                projectDB.objetives.put(String.valueOf(i), new List<Objective__c>());
            }
        }
        for(Project_Team_Member__c projTeamMember:[select id, Project__c, Project_Team_Member_Order__c, Contact__r.Name, Contact__r.title, Total_Time__c,Time_commitment_to_LPA_team_Q1__c,Time_commitment_to_LPA_team_Q2__c,Time_commitment_to_LPA_team_Q3__c,Time_commitment_to_LPA_team_Q4__c from Project_Team_Member__c where Project__c=:selectedProjectsMap.keySet() and Project_Team_Member_Order__c != null]){
            selectedProjectsMap.get(projTeamMember.Project__c).ProjectTeams.get(projTeamMember.Project_Team_Member_Order__c).add(projTeamMember);
        }
        for(Other_Participant__c otherParticipant:[select id, Project__c, Project_Other_Partner_Order__c, Full_Name__c, Role__c, Contact_Title__c from Other_Participant__c where Project__c=:selectedProjectsMap.keySet() and Project_Other_Partner_Order__c != null]){
            selectedProjectsMap.get(otherParticipant.Project__c).otherParticipants.get(otherParticipant.Project_Other_Partner_Order__c).add(otherParticipant);
        }
        for(Goals__c goal:[select id, Name, Project_Plan__c, Project_Plan_Dashboard_Placement__c, Short_Description__c 
                          from Goals__c where Project_Plan__c=:selectedProjectsMap.keySet() and Key_Goal__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
            selectedProjectsMap.get(goal.Project_Plan__c).goals.put(goal.Project_Plan_Dashboard_Placement__c, goal);
        }
        for(Objective__c objetive:[select id, Project_Plan__c, Project_Plan_Dashboard_Placement__c, Short_Description__c 
                                  from Objective__c where Project_Plan__c=:selectedProjectsMap.keySet() and Key_Objective__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
            selectedProjectsMap.get(objetive.Project_Plan__c).objetives.get(objetive.Project_Plan_Dashboard_Placement__c).add(objetive);
        }
        for(Stakeholder_Analysis__c Sim:[select id, Project__c, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:selectedProjectsMap.keySet() and Key_Interest__c=true and Stakeholder_Summary_Category__c='Engage' order by Createddate limit 5]){
            selectedProjectsMap.get(Sim.Project__c).engageStakeholders.add(Sim);
        }
        for(Stakeholder_Analysis__c Sim:[select id, Project__c, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:selectedProjectsMap.keySet() and Key_Interest__c=true and Stakeholder_Summary_Category__c='Partner' order by Createddate limit 5]){
            selectedProjectsMap.get(Sim.Project__c).partnerStakeholders.add(Sim);
        }
        for(Stakeholder_Analysis__c Sim:[select id, Project__c, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:selectedProjectsMap.keySet() and Key_Interest__c=true and Stakeholder_Summary_Category__c='Monitor' order by Createddate limit 5]){
            selectedProjectsMap.get(Sim.Project__c).monitorStakeholders.add(Sim);
        }
        for(Stakeholder_Analysis__c Sim:[select id, Project__c, Stakeholder_Organization__r.Name, Stakeholder_Contact__r.Name, SCE_Relationship_Contact__r.Name, Stakeholder_for_dashboard__c from Stakeholder_Analysis__c where Project__c=:selectedProjectsMap.keySet() and Key_Interest__c=true and Stakeholder_Summary_Category__c='Empower' order by Createddate limit 5]){
            selectedProjectsMap.get(Sim.Project__c).empowerStakeholders.add(Sim);
        }
        for(Milestones__c milestone:[select id, Milestone_and_Project__c, Name, Type_of_Milestone__c, Est_Completion_Date__c, Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c, Milestone_and_Project__r.Dashboard_Timeline_End_Date__c, Gate__c  
                                    from Milestones__c where Milestone_and_Project__c=:selectedProjectsMap.keySet() and Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c!=null and Milestone_and_Project__r.Dashboard_Timeline_End_Date__c!=null and Key_Milestone__c=true and (Type_of_Milestone__c='Other' or Type_of_Milestone__c='LPA') order by Est_Completion_Date__c]){
            if(milestone.Est_Completion_Date__c>=milestone.Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c &&
              milestone.Est_Completion_Date__c<=milestone.Milestone_and_Project__r.Dashboard_Timeline_End_Date__c){
                milestone.Type_of_Milestone__c = milestone.Type_of_Milestone__c.toLowerCase();
                if(milestone.Gate__c!=null) selectedProjectsMap.get(milestone.Milestone_and_Project__c).HasGate = true;
                selectedProjectsMap.get(milestone.Milestone_and_Project__c).milestones.add(milestone);
            }
        }
    }
}