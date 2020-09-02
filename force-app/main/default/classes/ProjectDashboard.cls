public class ProjectDashboard{
    public Project__c project{get;set;}
    public String dashboardDateAs{get;set;}
    public String timelineStartYear{get;set;}
    public String timelineEndYear{get;set;}
    public String projectSentence{get;set;}
    public Map<String, List<Project_Team_Member__c>> ProjectTeams{get;set;}
    public Map<String, List<Other_Participant__c>> otherParticipants{get;set;}
    public Map<String, Goals__c> goals{get;set;}
    public Map<String, List<Objective__c>> objetives{get;set;}
    //public List<Stakeholder_Interest_Matrix__c> engageStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> engageStakeholders{get;set;}
    //public List<Stakeholder_Interest_Matrix__c> partnerStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> partnerStakeholders{get;set;}
    //public List<Stakeholder_Interest_Matrix__c> monitorStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> monitorStakeholders{get;set;}
    //public List<Stakeholder_Interest_Matrix__c> empowerStakeholders{get;set;}
    public List<Stakeholder_Analysis__c> empowerStakeholders{get;set;}
    public List<Milestones__c> milestones{get;set;}
    public Boolean HasGate{get;set;}
    public ProjectDashboard(Project__c project){
        this.project = project;
        if(project.Dashboard_Date_As__c!=null) dashboardDateAs = dateFormatted(project.Dashboard_Date_As__c);
        if(project.Dashboard_Timeline_Start_Date__c!=null) timelineStartYear = String.valueOf(project.Dashboard_Timeline_Start_Date__c.Year());
        if(project.Dashboard_Timeline_End_Date__c!=null) timelineEndYear = String.valueOf(project.Dashboard_Timeline_End_Date__c.Year());
        projectSentence = 'Major Project Jurisdictions: ';
        ProjectTeams = new Map<String, List<Project_Team_Member__c>>();
        otherParticipants = new Map<String, List<Other_Participant__c>>();
        goals = new Map<String, Goals__c>();
        objetives = new Map<String, List<Objective__c>>();
        milestones = new List<Milestones__c>();
        engageStakeholders = new List<Stakeholder_Analysis__c>();
        partnerStakeholders = new List<Stakeholder_Analysis__c>();
        monitorStakeholders = new List<Stakeholder_Analysis__c>();
        empowerStakeholders = new List<Stakeholder_Analysis__c>();
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
            //return dt.Year()+' - '+quarter+'Q';
            return 'Q'+quarter+' '+dt.Year();
        }
        return '';
    }
}