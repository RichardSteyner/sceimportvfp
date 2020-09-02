trigger OtherParticipantValidation on Other_Participant__c (before insert, before update){
    Set<Id> involvedProjectIds = new Set<Id>();
    Map<Id, Set<String>> existingOrderMap = new Map<Id, Set<String>>();
    for(Other_Participant__c otherParticipant:Trigger.new){
        if(otherParticipant.Project_Other_Partner_Order__c != null){
            involvedProjectIds.add(otherParticipant.Project__c);
            existingOrderMap.put(otherParticipant.Project__c, new Set<String>());
        }
    }
    for(Other_Participant__c otherParticipant:[select id, Project__c, Project_Other_Partner_Order__c from Other_Participant__c 
                                              where Project__c=:involvedProjectIds and Project_Other_Partner_Order__c != null]){
        existingOrderMap.get(otherParticipant.Project__c).add(otherParticipant.Project_Other_Partner_Order__c);                                                 
    }
    if(Trigger.isInsert){
        for(Other_Participant__c otherParticipant:Trigger.new){
            if(otherParticipant.Project_Other_Partner_Order__c != null && existingOrderMap.get(otherParticipant.Project__c)!=null && existingOrderMap.get(otherParticipant.Project__c).contains(otherParticipant.Project_Other_Partner_Order__c)){
                otherParticipant.addError('You have placed two contacts in the "Other Participants" related list and assigned them the same order number. '+
                                          'Please clear one of the other participants from having the "Project Other Partner Order" assigned.');
            }
        }
    }
    if(Trigger.isUpdate){
        for(Other_Participant__c otherParticipant:Trigger.new){
            if(OtherParticipant.Project_Other_Partner_Order__c!=Trigger.oldMap.get(OtherParticipant.id).Project_Other_Partner_Order__c){
                if(otherParticipant.Project_Other_Partner_Order__c != null && existingOrderMap.get(otherParticipant.Project__c)!=null && existingOrderMap.get(otherParticipant.Project__c).contains(otherParticipant.Project_Other_Partner_Order__c)){
                    otherParticipant.addError('You have placed two contacts in the "Other Participants" related list and assigned them the same order number. '+
                                              'Please clear one of the other participants from having the "Project Other Partner Order" assigned.');
                }
            }
        }
    }
}