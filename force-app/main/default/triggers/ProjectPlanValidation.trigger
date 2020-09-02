trigger ProjectPlanValidation on Project__c (before insert, before update){
    if(Trigger.isInsert){
        for(Project__c project:Trigger.new){
            if(project.Dashboard_Timeline_Start_Date__c != null && project.Dashboard_Timeline_End_Date__c != null){
                if(project.Dashboard_Timeline_Start_Date__c>=project.Dashboard_Timeline_End_Date__c) project.addError('Please the Dashboard Timeline End Date must be greater than the Dashboard Timeline Start Date');
            }
        }
    }
    if(Trigger.isUpdate){
        for(Project__c project:Trigger.new){
            if(project.Dashboard_Timeline_Start_Date__c != null && project.Dashboard_Timeline_End_Date__c != null){
                if(project.Dashboard_Timeline_Start_Date__c!=Trigger.oldMap.get(project.id).Dashboard_Timeline_Start_Date__c){
                    if(project.Dashboard_Timeline_Start_Date__c>=project.Dashboard_Timeline_End_Date__c) project.addError('Please the Dashboard Timeline Start Date must be less than the Dashboard Timeline End Date');
                }
                else if(project.Dashboard_Timeline_End_Date__c!=Trigger.oldMap.get(project.id).Dashboard_Timeline_End_Date__c){
                    if(project.Dashboard_Timeline_End_Date__c<project.Dashboard_Timeline_Start_Date__c) project.addError('Please the Dashboard Timeline End Date must be greater than the Dashboard Timeline Start Date');
                }
            }
        }
    }
    
}