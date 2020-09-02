trigger CreateNewActivity_c on Task (before insert, after insert, before update) {
    List<Activity__c> listActivity_c = new List<Activity__c>();
    /*if (Trigger.isInsert) {
        for (Task t : Trigger.new) {
            if(t.Record_Custom_Activity__c==false) {
                if (Trigger.isAfter) {
                    if(t.Engagement_Required__c==true) {
                        listActivity_c.add(new Activity__c(Name=t.subject, Related_Object__c=t.Id));
                    }
                }
                if (Trigger.isBefore) {
                    t.Record_Custom_Activity__c=true;
                }
            }
        }
    }*/
    
    if (Trigger.isUpdate) {
        for (Task t : Trigger.new) {
            if(t.Record_Custom_Activity__c==false && t.Engagement_Required__c==true) {
                t.Record_Custom_Activity__c=true;
                listActivity_c.add(new Activity__c(Name=t.subject, Related_Object__c=t.Id, Description__c=t.Description));
            }
        }
    }
    
    if(listActivity_c.size()>0) {
        insert listActivity_c;
    }
}