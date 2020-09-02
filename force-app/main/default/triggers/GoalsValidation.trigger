trigger GoalsValidation on Goals__c (before insert, before update){
    Map<Id, Map<String, String>> existingGoalsMap = new Map<Id, Map<String, String>>();
    for(Goals__c goal:Trigger.new){
        if(goal.Key_Goal__c == true) existingGoalsMap.put(goal.Project_Plan__c, new Map<String, String>());
    }
    for(Goals__c goal:[select id, Project_Plan__c, Project_Plan_Dashboard_Placement__c from Goals__c 
                      where Project_Plan__c=:existingGoalsMap.keyset() and Key_Goal__c=true and Project_Plan_Dashboard_Placement__c != null order by Project_Plan_Dashboard_Placement__c]){
        existingGoalsMap.get(goal.Project_Plan__c).put(goal.Project_Plan_Dashboard_Placement__c, goal.id);                                       
    }
    if(Trigger.isInsert){
        for(Goals__c goal:Trigger.new){
            if(goal.Key_Goal__c == true && goal.Project_Plan_Dashboard_Placement__c != null){
                if(existingGoalsMap.get(goal.Project_Plan__c).size()>2) goal.addError('You have assigned 3 objectives to be a "Key Objective". Remove a Key Objective to add a new "Key Goal".');
                if(existingGoalsMap.get(goal.Project_Plan__c).containsKey(goal.Project_Plan_Dashboard_Placement__c)) goal.addError('This Project Plan Dashboard Placement has already been assigned.');
                if(String.isNotBlank(goal.Short_Description__c) && goal.Short_Description__c.length()>245) goal.addError('The Short Description cannot exceed 245 characters.');
            }
        }
    }
    if(Trigger.isUpdate){
        for(Goals__c goal:Trigger.new){
            if((goal.Key_Goal__c!=Trigger.oldMap.get(goal.id).Key_Goal__c || goal.Project_Plan_Dashboard_Placement__c!=Trigger.oldMap.get(goal.id).Project_Plan_Dashboard_Placement__c) && goal.Key_Goal__c==true && goal.Project_Plan_Dashboard_Placement__c!=null){
                if(existingGoalsMap.get(goal.Project_Plan__c).size()>2) goal.addError('You have assigned 3 objectives to be a "Key Objective". Remove a Key Objective to add a new "Key Goal".');
                if(existingGoalsMap.get(goal.Project_Plan__c).containsKey(goal.Project_Plan_Dashboard_Placement__c)) goal.addError('This Project Plan Dashboard Placement has already been assigned.');
            }
            if(String.isNotBlank(goal.Short_Description__c) && goal.Short_Description__c.length()>245) goal.addError('The Short Description cannot exceed 245 characters.');
        }
    }
}