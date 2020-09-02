@isTest
public class EverBridgeTest {
    
    static testMethod void testEverBridgeConnectorinsertGroup(){
        //class EverBridgeConnector insertGroup
        Test.startTest();
        Circuit__c c = new Circuit__c(Name = 'CircuitTest');
        insert c;
        Test.stopTest();
		Circuit__c cActual = [Select External_ID__c From Circuit__c WHERE Id=:c.Id];
        system.assertEquals('7995657147126190', cActual.External_ID__c);
    }
    
    static testMethod void testEverBridgeConnectorinsertGroup2(){
        //class EverBridgeConnector insertGroup
        ApexUtil.isTriggerInvoked = true;
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='7995657147126190');
        insert c;
        ApexUtil.isTriggerInvoked = false;
        Test.startTest();
        c.Inactive__c = true;
        update c;
        Test.stopTest();
    }
    
    static testMethod void testEverBridgeConnectorinsertRelationCircuit(){
        //class EverBridgeConnector insertRelationCircuit
        Account acc = new Account(Name='Clark County');
        insert acc;
        
        Account accCounty = new Account(Name='Test Acc County', Organization_County__c='Clark');
        insert accCounty;
        
        ApexUtil.isTriggerInvoked = true;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.Id, ExternalID__c = '12345');
        insert con;
        
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='7995657147126190');
        insert c;
        ApexUtil.isTriggerInvoked = false;
        
        Test.startTest();
        Circuit_Relationship__c cr = new Circuit_Relationship__c(Circuit__c=c.Id,County__c=acc.Id,Community__c=accCounty.Id);
        insert cr;
        Test.stopTest();
		//Circuit__c cActual = [Select External_ID__c From Circuit__c WHERE Id=:c.Id];
        //system.assertEquals('7995657147126190', cActual.External_ID__c);
    }
    
    static testMethod void testEverBridgeConnectorDeleteRelation(){
        //class EverBridgeConnector DeleteRelation
        Account acc = new Account(Name='Clark County');
        insert acc;
        
        Account accCounty = new Account(Name='Test Acc County', Organization_County__c='Clark');
        insert accCounty;
        
        Account accCounty2 = new Account(Name='Test Acc County', Organization_County__c='Fresno');
        insert accCounty2;
        
        ApexUtil.isTriggerInvoked = true;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.Id, ExternalID__c = '12345');
        insert con;
        
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='7995657147126190');
        insert c;
        ApexUtil.isTriggerInvoked = false;
        
        Circuit_Relationship__c cr = new Circuit_Relationship__c(Circuit__c=c.Id,County__c=acc.Id,Community__c=accCounty.Id);
        insert cr;
        
        Test.startTest();
        cr.Community__c = accCounty2.Id;
        update cr;
        Test.stopTest();
		//Circuit__c cActual = [Select External_ID__c From Circuit__c WHERE Id=:c.Id];
        //system.assertEquals('7995657147126190', cActual.External_ID__c);
    }
    
    static testMethod void testUpdateRelationiCircuitBatch(){
        //class UpdateRelationiCircuitBatch
        Account acc = new Account(Name='Clark County');
        insert acc;
        
        Account accCounty = new Account(Name='Test Acc County', Organization_County__c='Clark');
        insert accCounty;
        
        Account accCounty2 = new Account(Name='Test Acc County', Organization_County__c='Fresno');
        insert accCounty2;
        
        ApexUtil.isTriggerInvoked = true;
        Contact con = new Contact(LastName='Test Contact',AccountId=acc.Id, ExternalID__c = '12345');
        insert con;
        
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='7995657147126190');
        insert c;
        ApexUtil.isTriggerInvoked = false;
        
        Circuit_Relationship__c cr = new Circuit_Relationship__c(Circuit__c=c.Id,County__c=acc.Id,Community__c=accCounty.Id);
        insert cr;
        
        List<Circuit_Relationship__c> lst = new List<Circuit_Relationship__c>();
        lst.add(cr);
        
        Test.startTest();
        Database.executeBatch(new UpdateRelationiCircuitBatch(lst),1);
        Test.stopTest();
    }
}