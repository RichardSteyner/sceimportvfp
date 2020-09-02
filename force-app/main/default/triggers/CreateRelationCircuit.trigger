trigger CreateRelationCircuit on Circuit_Relationship__c (after insert, after update){
    Set<Id> setCircuitRelationIds = new Set<Id>();
    Set<Id> setCommIds = new Set<Id>();
    if(ApexUtil.isTriggerInvoked==false) {
        for (Circuit_Relationship__c cr : trigger.new) {
            if (trigger.isUpdate) {
                if (cr.Community__c != trigger.oldMap.get(cr.Id).Community__c) { setCommIds.add(trigger.oldMap.get(cr.Id).Community__c); setCommIds.add(cr.County__c); }
                if (setCommIds.size() > 0) { EverBridgeConnector.DeleteRelation(cr.Circuit__c, setCommIds); }
            }
            setCircuitRelationIds.add(cr.Id);
        }
        EverBridgeConnector.insertRelationCircuit(setCircuitRelationIds);
    }
}