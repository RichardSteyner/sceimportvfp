trigger EverbridgeContactTrigger on Contact (before insert, before update){
    if(ApexUtil.isTriggerInvoked==false){
        for(Contact cont : trigger.new){
     		cont.IsSendEverbridge__c = true; 
        }
        /*Set<String> setIdContact = new Set<String>();
        for(Contact c : trigger.new){
            setIdContact.add(c.Id);
        }
        EverBridgeConnector.insertContactgroup(setIdContact);*/
    }
}