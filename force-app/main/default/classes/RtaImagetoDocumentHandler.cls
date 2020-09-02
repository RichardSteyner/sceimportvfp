public class RtaImagetoDocumentHandler {

	@future(callout=true)
	public static void saveAsDocument(Set<String> ids){
		List<Project__c> projects = [SELECT Id, Name, Background_Description__c, Coalition_Strategy__c, Digital_Strategy__c, 
		Empower__c, Engage__c, Executive_Summary__c, External_Helpful_Strengths__c, External_Harmful_Weaknesses__c, 
		Goals_and_Objectives__c, In_Scope__c, Internal_Helpful_Strengths__c, Internal_Harmful_Weaknesses__c, Measurement__c, 
		Monitor__c, Out_of_Scope__c, Partner__c, Philanthropy__c, Plan_Appendix__c, Strategies__c, SWOT_Analysis__c, Timeline_Schedule__c FROM Project__c WHERE Id IN: ids];		
		Map<String, Blob> mapImages;
		Map<String, Document> mapDocuments;
		for(Project__c Project : projects){
			mapImages = new Map<String, Blob>();
			if(Project.Background_Description__c!=null && Project.Background_Description__c.contains('<img')){
				system.debug('Background_Description__c');
        		Project.Background_Description__c = Project.Background_Description__c.unescapeHtml4();
        		String [] images = Project.Background_Description__c.split('</img>');
            	Integer Matches=Project.Background_Description__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
			if(Project.Coalition_Strategy__c!=null && Project.Coalition_Strategy__c.contains('<img')){
				system.debug('Coalition_Strategy__c');
        		Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.unescapeHtml4();
        		String [] images = Project.Coalition_Strategy__c.split('</img>');
            	Integer Matches=Project.Coalition_Strategy__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
			if(Project.Digital_Strategy__c!=null && Project.Digital_Strategy__c.contains('<img')){
				system.debug('Digital_Strategy__c');
        		Project.Digital_Strategy__c = Project.Digital_Strategy__c.unescapeHtml4();
        		String [] images = Project.Digital_Strategy__c.split('</img>');
            	Integer Matches=Project.Digital_Strategy__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Empower__c!=null && Project.Empower__c.contains('<img')){
        		system.debug('Empower__c');
        		Project.Empower__c = Project.Empower__c.unescapeHtml4();
        		String [] images = Project.Empower__c.split('</img>');
            	Integer Matches=Project.Empower__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Engage__c!=null && Project.Engage__c.contains('<img')){
        		system.debug('Engage__c');
        		Project.Engage__c = Project.Engage__c.unescapeHtml4();
        		String [] images = Project.Engage__c.split('</img>');
            	Integer Matches=Project.Engage__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Executive_Summary__c!=null && Project.Executive_Summary__c.contains('<img')){
        		system.debug('Executive_Summary__c');
        		Project.Executive_Summary__c = Project.Executive_Summary__c.unescapeHtml4();
        		String [] images = Project.Executive_Summary__c.split('</img>');
            	Integer Matches=Project.Executive_Summary__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.External_Helpful_Strengths__c!=null && Project.External_Helpful_Strengths__c.contains('<img')){
        		system.debug('External_Helpful_Strengths__c');
        		Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.External_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.External_Helpful_Strengths__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.External_Harmful_Weaknesses__c!=null && Project.External_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('External_Harmful_Weaknesses__c');
        		Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.External_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.External_Harmful_Weaknesses__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Goals_and_Objectives__c!=null && Project.Goals_and_Objectives__c.contains('<img')){
        		system.debug('Goals_and_Objectives__c');
        		Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.unescapeHtml4();
        		String [] images = Project.Goals_and_Objectives__c.split('</img>');
            	Integer Matches=Project.Goals_and_Objectives__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.In_Scope__c!=null && Project.In_Scope__c.contains('<img')){
        		system.debug('In_Scope__c');
        		Project.In_Scope__c = Project.In_Scope__c.unescapeHtml4();
        		String [] images = Project.In_Scope__c.split('</img>');
            	Integer Matches=Project.In_Scope__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Internal_Helpful_Strengths__c!=null && Project.Internal_Helpful_Strengths__c.contains('<img')){
        		system.debug('Internal_Helpful_Strengths__c');
        		Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.Internal_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.Internal_Helpful_Strengths__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Internal_Harmful_Weaknesses__c!=null && Project.Internal_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('Internal_Harmful_Weaknesses__c');
        		Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.Internal_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.Internal_Harmful_Weaknesses__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	/*if(Project.Measurement__c!=null && Project.Measurement__c.contains('<img')){
        		system.debug('Measurement__c');
        		Project.Measurement__c = Project.Measurement__c.unescapeHtml4();
        		String [] images = Project.Measurement__c.split('</img>');
            	Integer Matches=Project.Measurement__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}*/
        	if(Project.Monitor__c!=null && Project.Monitor__c.contains('<img')){
        		system.debug('Monitor__c');
        		Project.Monitor__c = Project.Monitor__c.unescapeHtml4();
        		String [] images = Project.Monitor__c.split('</img>');
            	Integer Matches=Project.Monitor__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Out_of_Scope__c!=null && Project.Out_of_Scope__c.contains('<img')){
        		system.debug('Out_of_Scope__c');
        		Project.Out_of_Scope__c = Project.Out_of_Scope__c.unescapeHtml4();
        		String [] images = Project.Out_of_Scope__c.split('</img>');
            	Integer Matches=Project.Out_of_Scope__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Partner__c!=null && Project.Partner__c.contains('<img')){
        		system.debug('Partner__c');
        		Project.Partner__c = Project.Partner__c.unescapeHtml4();
        		String [] images = Project.Partner__c.split('</img>');
            	Integer Matches=Project.Partner__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Philanthropy__c!=null && Project.Philanthropy__c.contains('<img')){
        		system.debug('Philanthropy__c');
        		Project.Philanthropy__c = Project.Philanthropy__c.unescapeHtml4();
        		String [] images = Project.Philanthropy__c.split('</img>');
            	Integer Matches=Project.Philanthropy__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Plan_Appendix__c!=null && Project.Plan_Appendix__c.contains('<img')){
        		system.debug('Plan_Appendix__c');
        		Project.Plan_Appendix__c = Project.Plan_Appendix__c.unescapeHtml4();
        		String [] images = Project.Plan_Appendix__c.split('</img>');
            	Integer Matches=Project.Plan_Appendix__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	if(Project.Strategies__c!=null && Project.Strategies__c.contains('<img')){
        		system.debug('Strategies__c');
        		Project.Strategies__c = Project.Strategies__c.unescapeHtml4();
        		String [] images = Project.Strategies__c.split('</img>');
            	Integer Matches=Project.Strategies__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
        	/*if(Project.SWOT_Analysis__c!=null && Project.SWOT_Analysis__c.contains('<img')){
        		system.debug('SWOT_Analysis__c');
        		Project.SWOT_Analysis__c = Project.SWOT_Analysis__c.unescapeHtml4();
        		String [] images = Project.SWOT_Analysis__c.split('</img>');
            	Integer Matches=Project.SWOT_Analysis__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}*/
        	if(Project.Timeline_Schedule__c!=null && Project.Timeline_Schedule__c.contains('<img')){
        		system.debug('Timeline_Schedule__c');
        		Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.unescapeHtml4();
        		String [] images = Project.Timeline_Schedule__c.split('</img>');
            	Integer Matches=Project.Timeline_Schedule__c.countMatches('<img');            	
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
		                String rtaUrl=images.get(i).substringBetween('src="','"');
		                PageReference pageRef = new PageReference(rtaUrl);
		                Blob b;
						if (!Test.isRunningTest()){
				        	b = pageRef.getContent();
						}
						else{
						    b = Blob.valueof('Blob');
						}        
		                mapImages.put(rtaUrl, b);
            		}
            	}
        	}
		}
		for(Project__c Project : projects){
			mapDocuments = new Map<String, Document>();
			if(Project.Background_Description__c!=null && Project.Background_Description__c.contains('<img')){
				system.debug('Background_Description__c');
        		Project.Background_Description__c = Project.Background_Description__c.unescapeHtml4();
        		String [] images = Project.Background_Description__c.split('</img>');
            	Integer Matches=Project.Background_Description__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
			if(Project.Coalition_Strategy__c!=null && Project.Coalition_Strategy__c.contains('<img')){
				system.debug('Coalition_Strategy__c');
        		Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.unescapeHtml4();
        		String [] images = Project.Coalition_Strategy__c.split('</img>');
            	Integer Matches=Project.Coalition_Strategy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
			if(Project.Digital_Strategy__c!=null && Project.Digital_Strategy__c.contains('<img')){
				system.debug('Digital_Strategy__c');
        		Project.Digital_Strategy__c = Project.Digital_Strategy__c.unescapeHtml4();
        		String [] images = Project.Digital_Strategy__c.split('</img>');
            	Integer Matches=Project.Digital_Strategy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Empower__c!=null && Project.Empower__c.contains('<img')){
        		system.debug('Empower__c');
        		Project.Empower__c = Project.Empower__c.unescapeHtml4();
        		String [] images = Project.Empower__c.split('</img>');
            	Integer Matches=Project.Empower__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Engage__c!=null && Project.Engage__c.contains('<img')){
        		system.debug('Engage__c');
        		Project.Engage__c = Project.Engage__c.unescapeHtml4();
        		String [] images = Project.Engage__c.split('</img>');
            	Integer Matches=Project.Engage__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Executive_Summary__c!=null && Project.Executive_Summary__c.contains('<img')){
        		system.debug('Executive_Summary__c');
        		Project.Executive_Summary__c = Project.Executive_Summary__c.unescapeHtml4();
        		String [] images = Project.Executive_Summary__c.split('</img>');
            	Integer Matches=Project.Executive_Summary__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.External_Helpful_Strengths__c!=null && Project.External_Helpful_Strengths__c.contains('<img')){
        		system.debug('External_Helpful_Strengths__c');
        		Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.External_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.External_Helpful_Strengths__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.External_Harmful_Weaknesses__c!=null && Project.External_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('External_Harmful_Weaknesses__c');
        		Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.External_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.External_Harmful_Weaknesses__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Goals_and_Objectives__c!=null && Project.Goals_and_Objectives__c.contains('<img')){
        		system.debug('Goals_and_Objectives__c');
        		Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.unescapeHtml4();
        		String [] images = Project.Goals_and_Objectives__c.split('</img>');
            	Integer Matches=Project.Goals_and_Objectives__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.In_Scope__c!=null && Project.In_Scope__c.contains('<img')){
        		system.debug('In_Scope__c');
        		Project.In_Scope__c = Project.In_Scope__c.unescapeHtml4();
        		String [] images = Project.In_Scope__c.split('</img>');
            	Integer Matches=Project.In_Scope__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Internal_Helpful_Strengths__c!=null && Project.Internal_Helpful_Strengths__c.contains('<img')){
        		system.debug('Internal_Helpful_Strengths__c');
        		Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.Internal_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.Internal_Helpful_Strengths__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Internal_Harmful_Weaknesses__c!=null && Project.Internal_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('Internal_Harmful_Weaknesses__c');
        		Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.Internal_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.Internal_Harmful_Weaknesses__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	/*if(Project.Measurement__c!=null && Project.Measurement__c.contains('<img')){
        		system.debug('Measurement__c');
        		Project.Measurement__c = Project.Measurement__c.unescapeHtml4();
        		String [] images = Project.Measurement__c.split('</img>');
            	Integer Matches=Project.Measurement__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}*/
        	if(Project.Monitor__c!=null && Project.Monitor__c.contains('<img')){
        		system.debug('Monitor__c');
        		Project.Monitor__c = Project.Monitor__c.unescapeHtml4();
        		String [] images = Project.Monitor__c.split('</img>');
            	Integer Matches=Project.Monitor__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Out_of_Scope__c!=null && Project.Out_of_Scope__c.contains('<img')){
        		system.debug('Out_of_Scope__c');
        		Project.Out_of_Scope__c = Project.Out_of_Scope__c.unescapeHtml4();
        		String [] images = Project.Out_of_Scope__c.split('</img>');
            	Integer Matches=Project.Out_of_Scope__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Partner__c!=null && Project.Partner__c.contains('<img')){
        		system.debug('Partner__c');
        		Project.Partner__c = Project.Partner__c.unescapeHtml4();
        		String [] images = Project.Partner__c.split('</img>');
            	Integer Matches=Project.Partner__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Philanthropy__c!=null && Project.Philanthropy__c.contains('<img')){
        		system.debug('Philanthropy__c');
        		Project.Philanthropy__c = Project.Philanthropy__c.unescapeHtml4();
        		String [] images = Project.Philanthropy__c.split('</img>');
            	Integer Matches=Project.Philanthropy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Plan_Appendix__c!=null && Project.Plan_Appendix__c.contains('<img')){
        		system.debug('Plan_Appendix__c');
        		Project.Plan_Appendix__c = Project.Plan_Appendix__c.unescapeHtml4();
        		String [] images = Project.Plan_Appendix__c.split('</img>');
            	Integer Matches=Project.Plan_Appendix__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	if(Project.Strategies__c!=null && Project.Strategies__c.contains('<img')){
        		system.debug('Strategies__c');
        		Project.Strategies__c = Project.Strategies__c.unescapeHtml4();
        		String [] images = Project.Strategies__c.split('</img>');
            	Integer Matches=Project.Strategies__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
        	/*if(Project.SWOT_Analysis__c!=null && Project.SWOT_Analysis__c.contains('<img')){
        		system.debug('SWOT_Analysis__c');
        		Project.SWOT_Analysis__c = Project.SWOT_Analysis__c.unescapeHtml4();
        		String [] images = Project.SWOT_Analysis__c.split('</img>');
            	Integer Matches=Project.SWOT_Analysis__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}*/
        	if(Project.Timeline_Schedule__c!=null && Project.Timeline_Schedule__c.contains('<img')){
        		system.debug('Timeline_Schedule__c');
        		Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.unescapeHtml4();
        		String [] images = Project.Timeline_Schedule__c.split('</img>');
            	Integer Matches=Project.Timeline_Schedule__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
	            		Document doc = new Document();
		                doc.Name = Project.Name + ' Executive Summary' + i;
		                doc.Type = 'jpg';
		                doc.FolderId = '00l61000000tKssAAE';
		                doc.IsPublic=true;
		                doc.Body = mapImages.get(rtaUrl);
		                mapDocuments.put(rtaUrl,doc);
            		}
            	}
        	}
		}
		List<Document> documents = new List<Document>();
		
		documents = mapDocuments.values();
		
		insert documents;
		
		for(Project__c Project : projects){
			if(Project.Background_Description__c!=null && Project.Background_Description__c.contains('<img')){
				system.debug('Background_Description__c');
        		Project.Background_Description__c = Project.Background_Description__c.unescapeHtml4();
        		String [] images = Project.Background_Description__c.split('</img>');
            	Integer Matches=Project.Background_Description__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Background_Description__c = Project.Background_Description__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
			if(Project.Coalition_Strategy__c!=null && Project.Coalition_Strategy__c.contains('<img')){
				system.debug('Coalition_Strategy__c');
        		Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.unescapeHtml4();
        		String [] images = Project.Coalition_Strategy__c.split('</img>');
            	Integer Matches=Project.Coalition_Strategy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Coalition_Strategy__c = Project.Coalition_Strategy__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
			if(Project.Digital_Strategy__c!=null && Project.Digital_Strategy__c.contains('<img')){
				system.debug('Digital_Strategy__c');
        		Project.Digital_Strategy__c = Project.Digital_Strategy__c.unescapeHtml4();
        		String [] images = Project.Digital_Strategy__c.split('</img>');
            	Integer Matches=Project.Digital_Strategy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Digital_Strategy__c = Project.Digital_Strategy__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Empower__c!=null && Project.Empower__c.contains('<img')){
        		system.debug('Empower__c');
        		Project.Empower__c = Project.Empower__c.unescapeHtml4();
        		String [] images = Project.Empower__c.split('</img>');
            	Integer Matches=Project.Empower__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Empower__c = Project.Empower__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Engage__c!=null && Project.Engage__c.contains('<img')){
        		system.debug('Engage__c');
        		Project.Engage__c = Project.Engage__c.unescapeHtml4();
        		String [] images = Project.Engage__c.split('</img>');
            	Integer Matches=Project.Engage__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Engage__c = Project.Engage__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Executive_Summary__c!=null && Project.Executive_Summary__c.contains('<img')){
        		system.debug('Executive_Summary__c');
        		Project.Executive_Summary__c = Project.Executive_Summary__c.unescapeHtml4();
        		String [] images = Project.Executive_Summary__c.split('</img>');
            	Integer Matches=Project.Executive_Summary__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Executive_Summary__c = Project.Executive_Summary__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.External_Helpful_Strengths__c!=null && Project.External_Helpful_Strengths__c.contains('<img')){
        		system.debug('External_Helpful_Strengths__c');
        		Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.External_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.External_Helpful_Strengths__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.External_Helpful_Strengths__c = Project.External_Helpful_Strengths__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.External_Harmful_Weaknesses__c!=null && Project.External_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('External_Harmful_Weaknesses__c');
        		Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.External_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.External_Harmful_Weaknesses__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.External_Harmful_Weaknesses__c = Project.External_Harmful_Weaknesses__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Goals_and_Objectives__c!=null && Project.Goals_and_Objectives__c.contains('<img')){
        		system.debug('Goals_and_Objectives__c');
        		Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.unescapeHtml4();
        		String [] images = Project.Goals_and_Objectives__c.split('</img>');
            	Integer Matches=Project.Goals_and_Objectives__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Goals_and_Objectives__c = Project.Goals_and_Objectives__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.In_Scope__c!=null && Project.In_Scope__c.contains('<img')){
        		system.debug('In_Scope__c');
        		Project.In_Scope__c = Project.In_Scope__c.unescapeHtml4();
        		String [] images = Project.In_Scope__c.split('</img>');
            	Integer Matches=Project.In_Scope__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.In_Scope__c = Project.In_Scope__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Internal_Helpful_Strengths__c!=null && Project.Internal_Helpful_Strengths__c.contains('<img')){
        		system.debug('Internal_Helpful_Strengths__c');
        		Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.unescapeHtml4();
        		String [] images = Project.Internal_Helpful_Strengths__c.split('</img>');
            	Integer Matches=Project.Internal_Helpful_Strengths__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Internal_Helpful_Strengths__c = Project.Internal_Helpful_Strengths__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Internal_Harmful_Weaknesses__c!=null && Project.Internal_Harmful_Weaknesses__c.contains('<img')){
        		system.debug('Internal_Harmful_Weaknesses__c');
        		Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.unescapeHtml4();
        		String [] images = Project.Internal_Harmful_Weaknesses__c.split('</img>');
            	Integer Matches=Project.Internal_Harmful_Weaknesses__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Internal_Harmful_Weaknesses__c = Project.Internal_Harmful_Weaknesses__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	/*if(Project.Measurement__c!=null && Project.Measurement__c.contains('<img')){
        		system.debug('Measurement__c');
        		Project.Measurement__c = Project.Measurement__c.unescapeHtml4();
        		String [] images = Project.Measurement__c.split('</img>');
            	Integer Matches=Project.Measurement__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
						String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Measurement__c = Project.Measurement__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}*/
        	if(Project.Monitor__c!=null && Project.Monitor__c.contains('<img')){
        		system.debug('Monitor__c');
        		Project.Monitor__c = Project.Monitor__c.unescapeHtml4();
        		String [] images = Project.Monitor__c.split('</img>');
            	Integer Matches=Project.Monitor__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Monitor__c = Project.Monitor__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Out_of_Scope__c!=null && Project.Out_of_Scope__c.contains('<img')){
        		system.debug('Out_of_Scope__c');
        		Project.Out_of_Scope__c = Project.Out_of_Scope__c.unescapeHtml4();
        		String [] images = Project.Out_of_Scope__c.split('</img>');
            	Integer Matches=Project.Out_of_Scope__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Out_of_Scope__c = Project.Out_of_Scope__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Partner__c!=null && Project.Partner__c.contains('<img')){
        		system.debug('Partner__c');
        		Project.Partner__c = Project.Partner__c.unescapeHtml4();
        		String [] images = Project.Partner__c.split('</img>');
            	Integer Matches=Project.Partner__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Partner__c = Project.Partner__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Philanthropy__c!=null && Project.Philanthropy__c.contains('<img')){
        		system.debug('Philanthropy__c');
        		Project.Philanthropy__c = Project.Philanthropy__c.unescapeHtml4();
        		String [] images = Project.Philanthropy__c.split('</img>');
            	Integer Matches=Project.Philanthropy__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Philanthropy__c = Project.Philanthropy__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Plan_Appendix__c!=null && Project.Plan_Appendix__c.contains('<img')){
        		system.debug('Plan_Appendix__c');
        		Project.Plan_Appendix__c = Project.Plan_Appendix__c.unescapeHtml4();
        		String [] images = Project.Plan_Appendix__c.split('</img>');
            	Integer Matches=Project.Plan_Appendix__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Plan_Appendix__c = Project.Plan_Appendix__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	if(Project.Strategies__c!=null && Project.Strategies__c.contains('<img')){
        		system.debug('Strategies__c');
        		Project.Strategies__c = Project.Strategies__c.unescapeHtml4();
        		String [] images = Project.Strategies__c.split('</img>');
            	Integer Matches=Project.Strategies__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
						Project.Strategies__c = Project.Strategies__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
        	/*if(Project.SWOT_Analysis__c!=null && Project.SWOT_Analysis__c.contains('<img')){
        		system.debug('SWOT_Analysis__c');
        		Project.SWOT_Analysis__c = Project.SWOT_Analysis__c.unescapeHtml4();
        		String [] images = Project.SWOT_Analysis__c.split('</img>');
            	Integer Matches=Project.SWOT_Analysis__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.SWOT_Analysis__c = Project.SWOT_Analysis__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}*/
        	if(Project.Timeline_Schedule__c!=null && Project.Timeline_Schedule__c.contains('<img')){
        		system.debug('Timeline_Schedule__c');
        		Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.unescapeHtml4();
        		String [] images = Project.Timeline_Schedule__c.split('</img>');
            	Integer Matches=Project.Timeline_Schedule__c.countMatches('<img');
            	for(Integer i=0 ;i < Matches;i++){
            		if(!images.get(i).contains('/servlet/servlet.ImageServer?id=')){
	            		String rtaUrl=images.get(i).substringBetween('src="','"');
			            String DocImageUrl=URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+mapDocuments.get(rtaUrl).Id+'&oid='+UserInfo.getOrganizationId();
			            Project.Timeline_Schedule__c = Project.Timeline_Schedule__c.replace(rtaUrl, DocImageUrl);
            		}
            	}
        	}
		}
		Triggers__c t = Triggers__c.getOrgDefaults();
		t.Execute__c = false;
		update t;
		upsert projects;
	}
}