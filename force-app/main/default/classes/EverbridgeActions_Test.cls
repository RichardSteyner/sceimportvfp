@isTest
public class EverbridgeActions_Test {
    
    static testMethod void EverbridgeActions_Test(){
        Account acc = new Account(Name='Clark County');
        insert acc;
        
        Account accCounty = new Account(Name='Test Acc County', Organization_County__c='Clark');
        insert accCounty;
        
        ApexUtil.isTriggerInvoked = true;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.Id, ExternalID__c = '12345',PSPS__c=true,Active_Former__c='Active');
        insert con;
        
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='7995657147126190');
        insert c;
        
        Circuit_Relationship__c cr = new Circuit_Relationship__c(Circuit__c=c.Id,County__c=acc.Id,Community__c=accCounty.Id);
        insert cr;
        
        Circuit_Relationship__c cr2 = new Circuit_Relationship__c(Circuit__c=c.Id,County__c=acc.Id,Community__c=accCounty.Id);
        insert cr2;
        
        Test.startTest();
        EverbridgeActions.deleteCircuitRelationship(cr.Id);
        Test.stopTest();
    }
}