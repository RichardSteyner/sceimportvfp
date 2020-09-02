public class ProjectPlanDocument {
    public Project__c Project{get;set;}
    public List<Tactics_Deliverables__c> TactDelivarables{get;set;}
    public List<Milestones__c> Milestones{get;set;}
    public List<Project_Team_Member__c> ProjectTeamMembers{get;set;}
    public List<Other_Participant__c> OtherParticipants{get;set;}
    public List<Stakeholder_Analysis__c> StakeholderAnalysis{get;set;}
    public String GreenCircleUrl{get;set;}
    public String RedCircleUrl{get;set;}
    public String YellowCircleUrl{get;set;}
    public List<Risks_and_Issues__c> RisksIssues{get;set;}
    
    public ProjectPlanDocument() {
        Project=[select Name, Lastmodifieddate, Owner.Name, Owner_Manager__c, primary_project_summary__c, project_summary__c, executive_summary__c, background_description__c, swot_analysis_table_title__c,
                internal_helpful_strengths__c, internal_harmful_weaknesses__c, external_helpful_strengths__c, external_harmful_weaknesses__c, in_scope__c, out_of_scope__c, goals_and_objectives__c, strategies__c, 
                digital_strategy__c, philanthropy__c, Coalition_Strategy__c, timeline_schedule__c, partner__c, city_council__c, Engage__c, Empower__c, Monitor__c, sensitive_land_users__c, county_board_of_supervisors__c, 
                sensitive_property_owners__c, state_Legislation__c, state_legislature__c, visual_impact__c, federal_legislature__c, community_character__c, federal_legislation__c, media__c, Previous_Controversy__c, 
                clarity_of_project_need_topublic__c, political_issue__c, grassroots_community_opposition__c, Plan_Appendix__c, Special_Interest_Groups__c from Project__c where id=:ApexPages.currentPage().getParameters().get('id')];
		if(Project.Background_Description__c!=null && Project.Background_Description__c.contains('<img')){
			system.debug('Background_Description__c');
    		String [] images = Project.Background_Description__c.split('</img>');
        	Integer Matches=Project.Background_Description__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Background_Description__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Background_Description__c = Project.Background_Description__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Background_Description__c = Project.Background_Description__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }

        		}
        	}
    	}
    	
		if(Project.Coalition_Strategy__c!=null && Project.Coalition_Strategy__c.contains('<img')){
			system.debug('Coalition_Strategy__c');
    		String [] images = Project.Coalition_Strategy__c.split('</img>');
        	Integer Matches=Project.Coalition_Strategy__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Coalition_Strategy__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Digital_Strategy__c!=null && Project.Digital_Strategy__c.contains('<img')){
			system.debug('Digital_Strategy__c');
    		String [] images = Project.Digital_Strategy__c.split('</img>');
        	Integer Matches=Project.Digital_Strategy__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Digital_Strategy__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Digital_Strategy__c = Project.Digital_Strategy__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Digital_Strategy__c = Project.Digital_Strategy__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Empower__c!=null && Project.Empower__c.contains('<img')){
			system.debug('Empower__c');
    		String [] images = Project.Empower__c.split('</img>');
        	Integer Matches=Project.Empower__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Empower__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Empower__c = Project.Empower__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Empower__c = Project.Empower__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Engage__c!=null && Project.Engage__c.contains('<img')){
			system.debug('Engage__c');
    		String [] images = Project.Engage__c.split('</img>');
        	Integer Matches=Project.Engage__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Engage__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Engage__c = Project.Engage__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Engage__c = Project.Engage__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
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
    	
		if(Project.External_Helpful_Strengths__c!=null && Project.External_Helpful_Strengths__c.contains('<img')){
			system.debug('External_Helpful_Strengths__c');
    		String [] images = Project.External_Helpful_Strengths__c.split('</img>');
        	Integer Matches=Project.External_Helpful_Strengths__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.External_Helpful_Strengths__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.External_Harmful_Weaknesses__c!=null && Project.External_Harmful_Weaknesses__c.contains('<img')){
			system.debug('External_Harmful_Weaknesses__c');
    		String [] images = Project.External_Harmful_Weaknesses__c.split('</img>');
        	Integer Matches=Project.External_Harmful_Weaknesses__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.External_Harmful_Weaknesses__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Goals_and_Objectives__c!=null && Project.Goals_and_Objectives__c.contains('<img')){
			system.debug('Goals_and_Objectives__c');
    		String [] images = Project.Goals_and_Objectives__c.split('</img>');
        	Integer Matches=Project.Goals_and_Objectives__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Goals_and_Objectives__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.In_Scope__c!=null && Project.In_Scope__c.contains('<img')){
			system.debug('In_Scope__c');
    		String [] images = Project.In_Scope__c.split('</img>');
        	Integer Matches=Project.In_Scope__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.In_Scope__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.In_Scope__c = Project.In_Scope__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.In_Scope__c = Project.In_Scope__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Internal_Helpful_Strengths__c!=null && Project.Internal_Helpful_Strengths__c.contains('<img')){
			system.debug('Internal_Helpful_Strengths__c');
    		String [] images = Project.Internal_Helpful_Strengths__c.split('</img>');
        	Integer Matches=Project.Internal_Helpful_Strengths__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Internal_Helpful_Strengths__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Internal_Harmful_Weaknesses__c!=null && Project.Internal_Harmful_Weaknesses__c.contains('<img')){
			system.debug('Internal_Harmful_Weaknesses__c');
    		String [] images = Project.Internal_Harmful_Weaknesses__c.split('</img>');
        	Integer Matches=Project.Internal_Harmful_Weaknesses__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Internal_Harmful_Weaknesses__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Monitor__c!=null && Project.Monitor__c.contains('<img')){
			system.debug('Monitor__c');
    		String [] images = Project.Monitor__c.split('</img>');
        	Integer Matches=Project.Monitor__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Monitor__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Monitor__c = Project.Monitor__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Monitor__c = Project.Monitor__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Out_of_Scope__c!=null && Project.Out_of_Scope__c.contains('<img')){
			system.debug('Out_of_Scope__c');
    		String [] images = Project.Out_of_Scope__c.split('</img>');
        	Integer Matches=Project.Out_of_Scope__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Out_of_Scope__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Out_of_Scope__c = Project.Out_of_Scope__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Out_of_Scope__c = Project.Out_of_Scope__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Partner__c!=null && Project.Partner__c.contains('<img')){
			system.debug('Partner__c');
    		String [] images = Project.Partner__c.split('</img>');
        	Integer Matches=Project.Partner__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Partner__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Partner__c = Project.Partner__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Partner__c = Project.Partner__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Philanthropy__c!=null && Project.Philanthropy__c.contains('<img')){
			system.debug('Philanthropy__c');
    		String [] images = Project.Philanthropy__c.split('</img>');
        	Integer Matches=Project.Philanthropy__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Philanthropy__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Philanthropy__c = Project.Philanthropy__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Philanthropy__c = Project.Philanthropy__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Plan_Appendix__c!=null && Project.Plan_Appendix__c.contains('<img')){
			system.debug('Plan_Appendix__c');
    		String [] images = Project.Plan_Appendix__c.split('</img>');
        	Integer Matches=Project.Plan_Appendix__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Plan_Appendix__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Plan_Appendix__c = Project.Plan_Appendix__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Plan_Appendix__c = Project.Plan_Appendix__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Strategies__c!=null && Project.Strategies__c.contains('<img')){
			system.debug('Strategies__c');
    		String [] images = Project.Strategies__c.split('</img>');
        	Integer Matches=Project.Strategies__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Strategies__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Strategies__c = Project.Strategies__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Strategies__c = Project.Strategies__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}
    	
		if(Project.Timeline_Schedule__c!=null && Project.Timeline_Schedule__c.contains('<img')){
			system.debug('Timeline_Schedule__c');
    		String [] images = Project.Timeline_Schedule__c.split('</img>');
        	Integer Matches=Project.Timeline_Schedule__c.countMatches('<img');
        	for(Integer i=0 ;i < Matches;i++){
        		if(images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		            System.debug('BG Image: '+Project.Timeline_Schedule__c);
            		String heightImgStyle=images.get(i).substringBetween('style="height: ','px;');
            		String widthImgStyle=images.get(i).substringBetween('style="height: '+heightImgStyle+'px; width: ','px;');
                    if(String.isEmpty(heightImgStyle)){
    		            Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.replace('<img', '<img width="450" height="330"');
                        
            		}
                    else{
                        if(Integer.valueOf(widthImgStyle)>450){
                            Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.replace('style="height: '+heightImgStyle+'px; width: '+widthImgStyle+'px;"', 'width="450" height="'+String.valueOf(450*Integer.valueOf(heightImgStyle)/Integer.valueOf(widthImgStyle))+'"');
                            
                        }                        
                    }
        		}
        	}
    	}

        TactDelivarables=[Select id, Name, Tactic_or_Deliverable__c, Short_Description__c, Contact__r.name, Completed__c, Status__c 
                          from Tactics_Deliverables__c where Project__c=:Project.id];
                          
        Milestones=[select Name, Milestone_Description__c, Responsible_Person__r.LastName, Responsible_Person__r.FirstName, CreatedDate, Est_Completion_Date__c, Actual_Completion_Date__c, 
                    Milestone_Percent_Completed__c, Milestone_Status__c from Milestones__c where Milestone_and_Project__c=:Project.id];
        
        ProjectTeamMembers=[select Contact__r.LastName, Contact__r.FirstName, Member_Role__c, Project_Assignment__c, Time_commitment_to_LPA_team_Q1__c, Time_commitment_to_LPA_team_Q2__c,
                            Time_commitment_to_LPA_team_Q3__c, Time_commitment_to_LPA_team_Q4__c from Project_Team_Member__c where Project__c=:Project.id];

        OtherParticipants=[select Participant_Name__r.LastName, Participant_Name__r.FirstName, Role__c, Project_Role__c from Other_Participant__c where Project__c=:Project.id];
        
        StakeholderAnalysis=[select Stakeholder_Organization__r.name, Stakeholder_Summary_Category__c, Stakeholder_Contact__r.FirstName, Stakeholder_Contact__r.LastName, Background__c, SCE_Relationship_Contact__r.FirstName,
                            SCE_Relationship_Contact__r.LastName from Stakeholder_Analysis__c where Project__c=:Project.id];
    
        List<Document> Circle=[select id from document where name='circle-green' or name='circle-red' or name='circle-yellow'];
        system.debug('#### ' + Circle);
        GreenCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[0].id+'&oid='+UserInfo.getOrganizationId();
        RedCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[1].id+'&oid='+UserInfo.getOrganizationId();
        YellowCircleUrl='https://'+ApexPages.currentPage().getHeaders().get('X-Salesforce-Forwarded-To')+'/servlet/servlet.ImageServer?id='+Circle[2].id+'&oid='+UserInfo.getOrganizationId();
        RisksIssues=[select Name, Risk_or_Issue__c, Risk_Issue_Assigned_To__r.LastName, Risk_Issue_Assigned_To__r.FirstName, Risk_Issue_Description__c, Risk_Issue_Status__c, 
                    Mitigation_Measure_s__c from Risks_and_Issues__c where Project__c=:Project.id];
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