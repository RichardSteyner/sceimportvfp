trigger MilestonesValidation on Milestones__c (before insert, before update){
    Map<Id, Map<String, Map<String, Integer>>> existingMilestoneMap = new Map<Id, Map<String, Map<String, Integer>>>();
    Map<Id, Integer> DashboardMonthsMap = new Map<Id, Integer>();
    List<String> months = new String[]{'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'};
    for(Milestones__c milestone:Trigger.new){
        if(milestone.Key_Milestone__c == true && (milestone.Type_of_Milestone__c=='Other' || milestone.Type_of_Milestone__c=='LPA')){
            existingMilestoneMap.put(milestone.Milestone_and_Project__c, new Map<String, Map<String, Integer>>());
            existingMilestoneMap.get(milestone.Milestone_and_Project__c).put('Other',new Map<String, Integer>());
            existingMilestoneMap.get(milestone.Milestone_and_Project__c).put('LPA',new Map<String, Integer>());
            DashboardMonthsMap.put(milestone.Milestone_and_Project__c, 0);
        }
    }
    for(Milestones__c milestone:[select id, Milestone_and_Project__c, Type_of_Milestone__c, Est_Completion_Date__c, Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c, Milestone_and_Project__r.Dashboard_Timeline_End_Date__c 
                                from Milestones__c where Milestone_and_Project__c=:existingMilestoneMap.keyset() and Key_Milestone__c=true and (Type_of_Milestone__c='Other' or Type_of_Milestone__c='LPA') order by Est_Completion_Date__c]){
        if(existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())==null){
            existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).put(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month(), 1);
        }   
        else{
            existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).put(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month(), existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month()) + 1);
        }
        if(milestone.Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c != null && milestone.Milestone_and_Project__r.Dashboard_Timeline_End_Date__c != null){
            DashboardMonthsMap.put(milestone.Milestone_and_Project__c, milestone.Milestone_and_Project__r.Dashboard_Timeline_Start_Date__c.monthsbetween(milestone.Milestone_and_Project__r.Dashboard_Timeline_End_Date__c));
        }
    }
    if(Trigger.isInsert){
        for(Milestones__c milestone:Trigger.new){
            if(milestone.Key_Milestone__c == true && (milestone.Type_of_Milestone__c=='Other' || milestone.Type_of_Milestone__c=='LPA')){
                if(DashboardMonthsMap.get(milestone.Milestone_and_Project__c)<=12 && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())>1) milestone.addError('You have placed over 2 '+milestone.Type_of_Milestone__c+' milestones in '+months[milestone.Est_Completion_Date__c.Month() - 1]+' '+milestone.Est_Completion_Date__c.Year()+' to be displayed on the Dashboard. Please remove a milestone from being a "Key Milestone" in order to display this milestone');
                if(DashboardMonthsMap.get(milestone.Milestone_and_Project__c)>12 && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())>0) milestone.addError('You have placed over 1 '+milestone.Type_of_Milestone__c+' milestone in '+months[milestone.Est_Completion_Date__c.Month() - 1]+' '+milestone.Est_Completion_Date__c.Year()+' to be displayed on the Dashboard. Please remove a milestone from being a "Key Milestone" in order to display this milestone');
            }
        }
    }
    if(Trigger.isUpdate){
        for(Milestones__c milestone:Trigger.new){
            if((milestone.Key_Milestone__c !=Trigger.oldMap.get(milestone.id).Key_Milestone__c || milestone.Type_of_Milestone__c !=Trigger.oldMap.get(milestone.id).Type_of_Milestone__c || milestone.Est_Completion_Date__c.Month() !=Trigger.oldMap.get(milestone.id).Est_Completion_Date__c.Month() || milestone.Est_Completion_Date__c.Year() !=Trigger.oldMap.get(milestone.id).Est_Completion_Date__c.Year()) && milestone.Key_Milestone__c == true && (milestone.Type_of_Milestone__c=='Other' || milestone.Type_of_Milestone__c=='LPA')){
                if(DashboardMonthsMap.get(milestone.Milestone_and_Project__c)<=12 && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())!=null && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())>1) milestone.addError('You have placed over 2 '+milestone.Type_of_Milestone__c+' milestones in '+months[milestone.Est_Completion_Date__c.Month() - 1]+' '+milestone.Est_Completion_Date__c.Year()+' to be displayed on the Dashboard. Please remove a milestone from being a "Key Milestone" in order to display this milestone');
                if(DashboardMonthsMap.get(milestone.Milestone_and_Project__c)>12 && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())!=null && existingMilestoneMap.get(milestone.Milestone_and_Project__c).get(milestone.Type_of_Milestone__c).get(milestone.Est_Completion_Date__c.Year()+'-'+milestone.Est_Completion_Date__c.Month())>0) milestone.addError('You have placed over 1 '+milestone.Type_of_Milestone__c+' milestone in '+months[milestone.Est_Completion_Date__c.Month() - 1]+' '+milestone.Est_Completion_Date__c.Year()+' to be displayed on the Dashboard. Please remove a milestone from being a "Key Milestone" in order to display this milestone');
            }
        }
    }
}