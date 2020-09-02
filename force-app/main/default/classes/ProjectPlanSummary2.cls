public class ProjectPlanSummary2 {
    
    public Project__c Project{get;set;}
    public List<Goals__c> listGoals {get;set;}
    public List<Objective__c> listObjetives {get;set;}
    public List<Milestones__c> listMilestones {get;set;}
    public List<String> listStakeholder1 {get;set;}
    public List<String> listStakeholder2 {get;set;}
    public List<String> listStakeholder3 {get;set;}
    public List<String> listStakeholder4 {get;set;}
    public String GreenCircleUrl{get;set;}
    public String RedCircleUrl{get;set;}
    public String YellowCircleUrl{get;set;}
    public List<Risks_and_Issues__c> listRisks {get;set;}
    public List<Project_Team_Member__c> listProjectTeam {get;set;}
    public List<Other_Participant__c> listOtherParticipant {get;set;}
    public List<Engagement_Techniques__c> listEngagementTechnique {get;set;}

    public ProjectPlanSummary2() {
        Project=[select Id, Name, Lastmodifieddate, Owner.Name, Owner.Title, Owner_Manager__c, primary_project_summary__c, project_summary__c, executive_summary__c, background_description__c, swot_analysis_table_title__c,
                internal_helpful_strengths__c, internal_harmful_weaknesses__c, external_helpful_strengths__c, external_harmful_weaknesses__c, in_scope__c, out_of_scope__c, goals_and_objectives__c, strategies__c, 
                digital_strategy__c, philanthropy__c, Coalition_Strategy__c, timeline_schedule__c, partner__c, city_council__c, Engage__c, Empower__c, Monitor__c, sensitive_land_users__c, county_board_of_supervisors__c, 
                sensitive_property_owners__c, state_Legislation__c, state_legislature__c, visual_impact__c, federal_legislature__c, community_character__c, federal_legislation__c, media__c, Previous_Controversy__c, 
                clarity_of_project_need_topublic__c, political_issue__c, grassroots_community_opposition__c, Plan_Appendix__c, Special_Interest_Groups__c,Current_Situation__c,Internal_External_Challenges__c,
                Legal_Proceedings__c
                from Project__c where id=:ApexPages.currentPage().getParameters().get('id')];
        
        List<Document> Circle=[select id from document where name='circle-green' or name='circle-red' or name='circle-yellow'];
        GreenCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[0].id+'&oid='+UserInfo.getOrganizationId();
        RedCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[1].id+'&oid='+UserInfo.getOrganizationId();
        YellowCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[2].id+'&oid='+UserInfo.getOrganizationId();
        
        listGoals = new List<Goals__c>();
        listObjetives = new List<Objective__c>();
        listMilestones = new List<Milestones__c>();
        List<Milestones__c> listMilestonesTemp = new List<Milestones__c>();
        listStakeholder1 = new List<String>();
        listStakeholder2 = new List<String>();
        listStakeholder3 = new List<String>();
        listStakeholder4 = new List<String>();
        listRisks = new List<Risks_and_Issues__c>();
        listProjectTeam = new List<Project_Team_Member__c>();
        listOtherParticipant = new List<Other_Participant__c>();
        listEngagementTechnique = new List<Engagement_Techniques__c>();
            
        if(Project != null){
            listGoals = [Select Name,Short_Description__c From Goals__c WHERE Project_Plan__c=: Project.Id ORDER BY Project_Plan_Dashboard_Placement__c ASC, CreatedDate DESC];
            listObjetives = [Select Name,Short_Description__c From Objective__c WHERE Project_Plan__c=: Project.Id ORDER BY Project_Plan_Dashboard_Placement__c ASC, CreatedDate DESC];
            listEngagementTechnique = [Select Name, Use_With_Stakeholders__c, Project_Phase__c  From Engagement_Techniques__c WHERE Project_Plan__c=: Project.Id ORDER BY CreatedDate DESC];
            listMilestones = [Select Milestone_Description__c,Type_of_Milestone__c,Est_Completion_Date__c,Milestone_Status__c From Milestones__c WHERE Milestone_and_Project__c=: Project.Id ORDER BY Key_Milestone__c ASC, CreatedDate DESC];
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='Not Started') listMilestonesTemp.add(mil);
            }
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='On Target') listMilestonesTemp.add(mil);
            }
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='On Hold (LPA)') listMilestonesTemp.add(mil);
            }
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='On HOld (other OU)') listMilestonesTemp.add(mil);
            }
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='Completed') listMilestonesTemp.add(mil);
            }
            for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c=='Not Needed') listMilestonesTemp.add(mil);
            }
            /*for(Milestones__c mil : listMilestones){
                if(mil.Milestone_Status__c!='Not Needed' && mil.Milestone_Status__c!='Not Started' && mil.Milestone_Status__c!='On Target' && mil.Milestone_Status__c!='On Hold (LPA)' &&
                   mil.Milestone_Status__c!='On HOld (other OU)' && mil.Milestone_Status__c!='Completed' && mil.Milestone_Status__c!='Not Needed') listMilestonesTemp.add(mil);
            }*/
			listMilestones.clear();
			listMilestones.addAll(listMilestonesTemp);
            
            if(Project.Plan_Appendix__c!=null){
                Project.Plan_Appendix__c = Project.Plan_Appendix__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.External_Harmful_Weaknesses__c!=null){
                Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.External_Helpful_Strengths__c!=null){
                Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Internal_Harmful_Weaknesses__c!=null){
                Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Internal_Helpful_Strengths__c!=null){
                Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Internal_External_Challenges__c!=null){
                Project.Internal_External_Challenges__c = Project.Internal_External_Challenges__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Current_Situation__c!=null){
                Project.Current_Situation__c = Project.Current_Situation__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.strategies__c!=null){
                Project.strategies__c = Project.strategies__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Internal_External_Challenges__c!=null){
                Project.Internal_External_Challenges__c = Project.Internal_External_Challenges__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.background_description__c!=null){
                Project.background_description__c = Project.background_description__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Executive_Summary__c!=null){
                Project.Executive_Summary__c = Project.Executive_Summary__c.replaceAll('font-family','').replaceAll('font-size','');
            }
            if(Project.Executive_Summary__c!=null && Project.Executive_Summary__c.contains('<img')){
                system.debug('Executive_Summary__c');
                String [] images = Project.Executive_Summary__c.split('</img>');
                Integer Matches=Project.Executive_Summary__c.countMatches('<img');
                for(Integer i=0 ;i < Matches;i++){
                    if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
                        System.debug('BG Image: '+Project.Executive_Summary__c);
                        String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
                        String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                        if(String.isEmpty(heightImgStyle)){
                            Project.Executive_Summary__c = Project.Executive_Summary__c.replace('<img', '<img width="450" height="330"');
                            
                        }
                        else{
                            if(Integer.valueOf(widthImgStyle)>450){
                                Project.Executive_Summary__c = Project.Executive_Summary__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                                
                            }                        
                        }
                    }
                }
            }
            
            String sa1;
            String sa2;
            List<Stakeholder_Analysis__c> listStakeholderTemp = new List<Stakeholder_Analysis__c>();
            listStakeholderTemp = [Select SCE_Relationship_Contact__r.Firstname, SCE_Relationship_Contact__r.LastName,Stakeholder_Contact__r.FirstName, Stakeholder_Contact__r.LastName,Stakeholder_Organization__r.Name From Stakeholder_Analysis__c WHERE Project__c=: Project.Id and Stakeholder_Summary_Category__c='Partner'];            
            for(Stakeholder_Analysis__c sa : listStakeholderTemp){
                sa1='';
                sa2='';
                system.debug('##sa: '+sa);
                if(sa.Stakeholder_Organization__r.Name != null){
                    sa1 = sa.Stakeholder_Organization__r.Name;
                    sa2 = sa.Stakeholder_Organization__r.Name;
                }
                if(sa.SCE_Relationship_Contact__r.LastName != null){
                    if(sa.SCE_Relationship_Contact__r.Firstname != null){
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                    }else{
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.LastName; else sa1 = sa.SCE_Relationship_Contact__r.LastName;
                    }
                    listStakeholder1.add(sa1);
                }
                if(sa.Stakeholder_Contact__r.LastName != null){
                    if(sa.Stakeholder_Contact__r.Firstname != null){
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                    }else{
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.LastName; else sa2 = sa.Stakeholder_Contact__r.LastName;
                    }
                    listStakeholder1.add(sa2);
                }
            }
            
            List<Stakeholder_Analysis__c> listStakeholderTemp2 = new List<Stakeholder_Analysis__c>();
            listStakeholderTemp2 = [Select SCE_Relationship_Contact__r.Firstname, SCE_Relationship_Contact__r.LastName,Stakeholder_Contact__r.FirstName, Stakeholder_Contact__r.LastName,Stakeholder_Organization__r.Name From Stakeholder_Analysis__c WHERE Project__c=: Project.Id and Stakeholder_Summary_Category__c='Engage'];
            for(Stakeholder_Analysis__c sa : listStakeholderTemp2){
                sa1='';
                sa2='';
                if(sa.Stakeholder_Organization__r.Name != null){
                    sa1 = sa.Stakeholder_Organization__r.Name;
                    sa2 = sa.Stakeholder_Organization__r.Name;
                }
                if(sa.SCE_Relationship_Contact__r.LastName != null){
                    if(sa.SCE_Relationship_Contact__r.Firstname != null){
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                    }else{
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.LastName; else sa1 = sa.SCE_Relationship_Contact__r.LastName;
                    }
                    listStakeholder2.add(sa1);
                }
                if(sa.Stakeholder_Contact__r.LastName != null){
                    if(sa.Stakeholder_Contact__r.Firstname != null){
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                    }else{
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.LastName; else sa2 = sa.Stakeholder_Contact__r.LastName;
                    }
                    listStakeholder2.add(sa2);
                }
            }
            
            List<Stakeholder_Analysis__c> listStakeholderTemp3 = new List<Stakeholder_Analysis__c>();
            listStakeholderTemp3 = [Select SCE_Relationship_Contact__r.Firstname, SCE_Relationship_Contact__r.LastName,Stakeholder_Contact__r.FirstName, Stakeholder_Contact__r.LastName,Stakeholder_Organization__r.Name From Stakeholder_Analysis__c WHERE Project__c=: Project.Id and Stakeholder_Summary_Category__c='Empower'];
            for(Stakeholder_Analysis__c sa : listStakeholderTemp3){
                sa1='';
                sa2='';
                if(sa.Stakeholder_Organization__r.Name != null){
                    sa1 = sa.Stakeholder_Organization__r.Name;
                    sa2 = sa.Stakeholder_Organization__r.Name;
                }
                if(sa.SCE_Relationship_Contact__r.LastName != null){
                    if(sa.SCE_Relationship_Contact__r.Firstname != null){
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                    }else{
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.LastName;
                    }
                    listStakeholder3.add(sa1);
                }
                if(sa.Stakeholder_Contact__r.LastName != null){
                    if(sa.Stakeholder_Contact__r.Firstname != null){
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                    }else{
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.LastName;
                    }
                    listStakeholder3.add(sa2);
                }
            }
            
            List<Stakeholder_Analysis__c> listStakeholderTemp4 = new List<Stakeholder_Analysis__c>();
            listStakeholderTemp4 = [Select SCE_Relationship_Contact__r.Firstname, SCE_Relationship_Contact__r.LastName,Stakeholder_Contact__r.FirstName, Stakeholder_Contact__r.LastName,Stakeholder_Organization__r.Name From Stakeholder_Analysis__c WHERE Project__c=: Project.Id and Stakeholder_Summary_Category__c='Monitor'];
            for(Stakeholder_Analysis__c sa : listStakeholderTemp4){
                sa1='';
                sa2='';
                if(sa.Stakeholder_Organization__r.Name != null){
                    sa1 = sa.Stakeholder_Organization__r.Name;
                    sa2 = sa.Stakeholder_Organization__r.Name;
                }
                if(sa.SCE_Relationship_Contact__r.LastName != null){
                    if(sa.SCE_Relationship_Contact__r.Firstname != null){
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.Firstname + ' ' + sa.SCE_Relationship_Contact__r.LastName;
                    }else{
                        if(sa1!='') sa1 = sa1 + ' - ' + sa.SCE_Relationship_Contact__r.LastName;
                        else sa1 = sa.SCE_Relationship_Contact__r.LastName;
                    }
                    listStakeholder4.add(sa1);
                }
                if(sa.Stakeholder_Contact__r.LastName != null){
                    if(sa.Stakeholder_Contact__r.Firstname != null){
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.Firstname + ' ' + sa.Stakeholder_Contact__r.LastName;
                    }else{
                        if(sa2!='') sa2 = sa2 + ' - ' + sa.Stakeholder_Contact__r.LastName;
                        else sa2 = sa.Stakeholder_Contact__r.LastName;
                    }
                    listStakeholder4.add(sa2);
                }
            }
            
            listRisks = [Select Name,Risk_Issue_Assigned_To__r.LastName, Risk_Issue_Description__c, Mitigation_Measure_s__c, Risk_Issue_Status__c,Risk_or_Issue__c 
                         From Risks_and_Issues__c WHERE Project__c=: Project.Id ORDER BY CreatedDate ASC];
            
            listProjectTeam = [Select Contact__r.FirstName, Contact__r.LastName,Member_Role__c,Project_Assignment__c,Year__c,Time_commitment_to_LPA_team_Q1__c,
                               Time_commitment_to_LPA_team_Q2__c, Time_commitment_to_LPA_team_Q3__c, Time_commitment_to_LPA_team_Q4__c
                               From Project_Team_Member__c WHERE Project__c=: Project.Id ORDER BY Project_Team_Member_Order__c ASC, CreatedDate ASC];

            listOtherParticipant = [Select Contact_Title__c, Full_Name__c, Project_Other_Partner_Order__c, Project_Role__c, Role__c
                         From Other_Participant__c WHERE Project__c=: Project.Id ORDER BY CreatedDate DESC];

        }
        
    }
    
    public String getPrintView(){
        return
        '<!--[if gte mso 9]>' +
            '<xml>' +
            '<w:WordDocument>' +
            '<w:View>Print</w:View>' +
            '<w:Zoom>100</w:Zoom>' +
            '<w:DoNotOptimizeForBrowser/>' +
            '</w:WordDocument>' +
            '</xml>' +
        '<![endif]>';
    }
}