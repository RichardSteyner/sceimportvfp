trigger StakeholderInterestMatrixValidationAnalyst on Stakeholder_Analysis__c (before insert, before update){
    Set<Id> involvedProjectIds = new Set<Id>();
    Set<String> involvedTypes = new Set<String>();
    Map<Id, Map<String, list<String>>> existingSIMatrixMap = new Map<Id, Map<String, list<String>>>();
    for(Stakeholder_Analysis__c Sim:Trigger.new){
        if(Sim.Stakeholder_Summary_Category__c != null){
            involvedProjectIds.add(Sim.Project__c);
            involvedTypes.add(Sim.Stakeholder_Summary_Category__c);
            existingSIMatrixMap.put(Sim.Project__c, new Map<String, list<String>>());
        }
    }
    for(Stakeholder_Analysis__c Sim:Trigger.new){
        if(Sim.Stakeholder_Summary_Category__c != null) existingSIMatrixMap.get(Sim.Project__c).put(Sim.Stakeholder_Summary_Category__c, new List<String>());
    }
    for(Stakeholder_Analysis__c Sim:[select id, Stakeholder_Summary_Category__c, Project__c from Stakeholder_Analysis__c where Project__c=:involvedProjectIds and Stakeholder_Summary_Category__c=:involvedTypes]){
        existingSIMatrixMap.get(Sim.Project__c).get(Sim.Stakeholder_Summary_Category__c).add(Sim.Stakeholder_Summary_Category__c);                                                 
    }
    if(Trigger.isInsert){
        for(Stakeholder_Analysis__c Sim:Trigger.new){
            if(Sim.Stakeholder_Summary_Category__c != null && existingSIMatrixMap.get(Sim.Project__c)!=null && existingSIMatrixMap.get(Sim.Project__c).get(Sim.Stakeholder_Summary_Category__c)!=null && existingSIMatrixMap.get(Sim.Project__c).get(Sim.Stakeholder_Summary_Category__c).size()>7) Sim.addError('You have exceeded the maximum number of records for the type '+Sim.Stakeholder_Summary_Category__c);
        }
    }
    if(Trigger.isUpdate){
        for(Stakeholder_Analysis__c Sim:Trigger.new){
            //if((Sim.Stakeholder_Summary_Category__c!=Trigger.oldMap.get(Sim.id).Stakeholder_Summary_Category__c && Sim.Key_Interest__c==true) || (Sim.Key_Interest__c!=Trigger.oldMap.get(Sim.id).Key_Interest__c && Sim.Key_Interest__c==true)){
            if(Sim.Stakeholder_Summary_Category__c!=Trigger.oldMap.get(Sim.id).Stakeholder_Summary_Category__c){
                if(Sim.Stakeholder_Summary_Category__c != null && existingSIMatrixMap.get(Sim.Project__c)!=null && existingSIMatrixMap.get(Sim.Project__c).get(Sim.Stakeholder_Summary_Category__c)!=null && existingSIMatrixMap.get(Sim.Project__c).get(Sim.Stakeholder_Summary_Category__c).size()>7) Sim.addError('You have exceeded the maximum number of records for the type '+Sim.Stakeholder_Summary_Category__c);
            }
        }
    }
}