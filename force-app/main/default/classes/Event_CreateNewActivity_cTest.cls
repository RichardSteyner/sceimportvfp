@isTest
public class Event_CreateNewActivity_cTest {

    static testMethod void Event_CreateNewActivity_cTest(){
        
        Test.startTest();
        
        Event t1 = new Event(Subject='test 1', StartDateTime = System.now(), EndDateTime = System.now() , Engagement_Required__c=false, Record_Custom_Activity__c=false);
        
        insert t1;
        
        t1.Engagement_Required__c=true;
        
        update t1;
        
        Activity__c act2 = [SELECT name FROM Activity__c WHERE related_object__c = :t1.Id LIMIT 1];
        
        System.assertEquals(t1.Subject,act2.name);
        Test.stopTest();
    }
}