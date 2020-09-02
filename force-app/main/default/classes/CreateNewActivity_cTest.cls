@isTest
public class CreateNewActivity_cTest {

    static testMethod void CreateNewActivity_cTest(){
        
        Test.startTest();
        
        Task t1 = new Task(Subject='test 1', status='open', Priority = 'Normal', Engagement_Required__c=false, Record_Custom_Activity__c=false);
        
        insert t1;
        
        t1.Engagement_Required__c=true;
        
        update t1;
        
        Activity__c act2 = [SELECT name FROM Activity__c WHERE related_object__c = :t1.Id LIMIT 1];
        
        System.assertEquals(t1.Subject,act2.name);
        Test.stopTest();
    }
}