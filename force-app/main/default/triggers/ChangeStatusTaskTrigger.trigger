trigger ChangeStatusTaskTrigger on Task (after update) {
    
    List<Task> listTask = new List<Task>();
    Set<Id> IdContacts = new Set<Id>();
    
    for(Task t : trigger.new){
        if(trigger.isInsert) {
            if(t.Status=='Completed' && t.EH_S_Contact__c!=null){
                listTask.add(t);
                IdContacts.add(t.EH_S_Contact__c);
            }
        }
        if(trigger.isUpdate) {
            if(t.Status=='Completed' && t.EH_S_Contact__c!=null && t.Status!=Trigger.oldMap.get(t.Id).Status){
                listTask.add(t);
                IdContacts.add(t.EH_S_Contact__c);
            }
        }
    }
    
    if(listTask.size()>0){
        String template = 'EH&S Contact task complete email';
        String ide = [select id from EmailTemplate where Name =:template].id;
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        Map<Id, Contact> allContact = new Map<Id, Contact>();
        for(Contact c : [Select Id, Name,Email From Contact where id IN :IdContacts]) {
            allContact.put(c.Id, c);
        }
        
        for(Task t1 : listTask){
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    message.setTemplateId(ide);
                    message.setTargetObjectId(t1.EH_S_Contact__c);
                    //message.setWhatId(t1.Id);
                    message.setToAddresses(new String[] {allContact.get(t1.EH_S_Contact__c).Email});
                    message.saveAsActivity = false;
                    emails.add(message);
                    Messaging.sendEmail(emails);
        }
    }
}