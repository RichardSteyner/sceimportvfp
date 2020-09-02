trigger TeamMemberValidation on Project_Team_Member__c (before insert, before update){
    Set<Id> involvedProjectIds = new Set<Id>();
    Map<Id, Set<String>> existingOrderMap = new Map<Id, Set<String>>();
    for(Project_Team_Member__c teamMember:Trigger.new){
        if(teamMember.Project_Team_Member_Order__c != null){
            involvedProjectIds.add(teamMember.Project__c);
            existingOrderMap.put(teamMember.Project__c, new Set<String>());
        }
    }
    for(Project_Team_Member__c teamMember:[select id, Project__c, Project_Team_Member_Order__c from Project_Team_Member__c 
                                          where Project__c=:involvedProjectIds and Project_Team_Member_Order__c != null]){
        existingOrderMap.get(teamMember.Project__c).add(teamMember.Project_Team_Member_Order__c);                                                 
    }
    if(Trigger.isInsert){
        for(Project_Team_Member__c teamMember:Trigger.new){
            if(teamMember.Project_Team_Member_Order__c != null && existingOrderMap.get(teamMember.Project__c)!=null && existingOrderMap.get(teamMember.Project__c).contains(teamMember.Project_Team_Member_Order__c)) teamMember.addError('You have placed two contacts in the "Project Team Members" related list and assigned them the same order number. Please clear one of the Project Team Members from having the "Project Team Member Order" assigned.');
        }
    }
    if(Trigger.isUpdate){
        for(Project_Team_Member__c teamMember:Trigger.new){
            if(teamMember.Project_Team_Member_Order__c!=Trigger.oldMap.get(teamMember.id).Project_Team_Member_Order__c){
                if(teamMember.Project_Team_Member_Order__c != null && existingOrderMap.get(teamMember.Project__c)!=null && existingOrderMap.get(teamMember.Project__c).contains(teamMember.Project_Team_Member_Order__c)) teamMember.addError('You have placed two contacts in the "Project Team Members" related list and assigned them the same order number. Please clear one of the Project Team Members from having the "Project Team Member Order" assigned.');
            }
        }
    }
}