trigger RtaImagetoDocument on Project__c (after insert, after update) {
    if(Triggers__c.getOrgDefaults().Execute__c){
        Set<String> ids = new Set<String>();    
        for(Project__c Project:trigger.new){
            ids.add(Project.Id);
        }    
        RtaImagetoDocumentHandler.saveAsDocument(ids);
    }
    else{
        Triggers__c t = Triggers__c.getOrgDefaults();
        t.Execute__c = true;
        update t;
    }
}