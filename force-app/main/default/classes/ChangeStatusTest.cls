@isTest
public class ChangeStatusTest {

    static testMethod void ChangeStatusTest(){
        
        Test.startTest();
        
        Contact con = new Contact(lastname='mori', email='mmori@cloudcreations.com');
        insert con;
        
        Task t1 = new Task(Subject='test 1', status='open', EH_S_Contact__c=con.Id, Priority = 'Normal', Engagement_Required__c=false, Record_Custom_Activity__c=false);
        
        insert t1;
        
        t1.Engagement_required__c = true;
        t1.status='completed';
        
        update t1;
        
        Activity__c act2 = [SELECT name FROM Activity__c WHERE related_object__c = :t1.Id LIMIT 1];
        
        System.assertEquals(t1.Subject,act2.name);
        Test.stopTest();
    }
}