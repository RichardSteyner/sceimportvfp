trigger Event_CreateNewActivity_c on Event (before insert, after insert, before update) {
    List<Activity__c> listActivity_c = new List<Activity__c>();
    /*if (Trigger.isInsert) {
        for (Event e : Trigger.new) {
            if(e.Record_Custom_Activity__c==false) {
                if(e.Engagement_Required__c==true) {
                    listActivity_c.add(new Activity__c(Name=e.subject, Related_Object__c=e.Id));
                }
                if (Trigger.isBefore) {
                    e.Record_Custom_Activity__c=true;
                }
            }
        }
    }*/
    
    if (Trigger.isUpdate) {
        for (Event e : Trigger.new) {
            if(e.Record_Custom_Activity__c==false && e.Engagement_Required__c==true) {
                e.Record_Custom_Activity__c=true;
                listActivity_c.add(new Activity__c(Name=e.subject, Related_Object__c=e.Id, Description__c=e.description));
            }
        }
    }
    
    if(listActivity_c.size()>0) {
        insert listActivity_c;
    }
}