trigger CreateCircuitEverbridge on Circuit__c (after insert, after update) {
    if(ApexUtil.isTriggerInvoked==false){
        set<Id> setGroupId = new set<Id>();
        for(Circuit__c c : trigger.new){
            setGroupId.add(c.Id);
        }
        EverBridgeConnector.insertGroup(setGroupId);
    }
}