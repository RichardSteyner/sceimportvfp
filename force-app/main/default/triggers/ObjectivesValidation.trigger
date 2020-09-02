trigger ObjectivesValidation on Objective__c (before insert, before update){
    Map<Id, Map<String, String>> existingKeyObjetivesMap = new Map<Id, Map<String, String>>();
    for(Objective__c objetive:Trigger.new){
        if(objetive.Key_Objective__c == true) existingKeyObjetivesMap.put(objetive.Project_Plan__c, new Map<String, String>());
    }
    for(Objective__c objetive:[select id, Project_Plan__c, Project_Plan_Dashboard_Placement__c from Objective__c 
                              where Project_Plan__c=:existingKeyObjetivesMap.keyset() and Key_Objective__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
        existingKeyObjetivesMap.get(objetive.Project_Plan__c).put(objetive.Project_Plan_Dashboard_Placement__c, objetive.id);                                       
    }
    if(Trigger.isInsert){
        for(Objective__c objetive:Trigger.new){
            if(objetive.Key_Objective__c == true && objetive.Project_Plan_Dashboard_Placement__c != null){
                if(existingKeyObjetivesMap.get(objetive.Project_Plan__c).size()>2) objetive.addError('You have placed over 3 Objectives to be displayed on the Dashboard. Please remove an objective from being a "Key Objective" in order to display this objective');
                if(existingKeyObjetivesMap.get(objetive.Project_Plan__c).containsKey(objetive.Project_Plan_Dashboard_Placement__c)) objetive.addError('This Project Plan Dashboard Placement has already been assigned.');
                if(String.isNotBlank(objetive.Short_Description__c) && objetive.Short_Description__c.length()>245) objetive.addError('The Short Description cannot exceed 245 characters.');
            }
        }
    }
    if(Trigger.isUpdate){
        for(Objective__c objetive:Trigger.new){
            if((objetive.Key_Objective__c!=Trigger.oldMap.get(objetive.id).Key_Objective__c || objetive.Project_Plan_Dashboard_Placement__c!=Trigger.oldMap.get(objetive.id).Project_Plan_Dashboard_Placement__c) && objetive.Key_Objective__c==true && objetive.Project_Plan_Dashboard_Placement__c!=null){
                if(existingKeyObjetivesMap.get(objetive.Project_Plan__c).size()>2) objetive.addError('You have placed over 3 Objectives to be displayed on the Dashboard. Please remove an objective from being a "Key Objective" in order to display this objective');
                if(existingKeyObjetivesMap.get(objetive.Project_Plan__c).containsKey(objetive.Project_Plan_Dashboard_Placement__c)) objetive.addError('This Project Plan Dashboard Placement has already been assigned.');
            }
            if(String.isNotBlank(objetive.Short_Description__c) && objetive.Short_Description__c.length()>245) objetive.addError('The Short Description cannot exceed 245 characters.');
        }
    }
}