@isTest
public class UpdateChildCommunicationLogTest {
    @isTest static void unitTest() {
        Communication_Log__c comm = New Communication_Log__c();
        comm.Master_Communication_Log__c=null;
        comm.NotUpdateRecord__c=true;
        insert comm;
        Communication_Log__c commChild1 = New Communication_Log__c();
        commChild1.Master_Communication_Log__c=comm.Id;
        commChild1.NotUpdateRecord__c=false;
        insert commChild1;
        Communication_Log__c commChild2 = New Communication_Log__c();
        commChild2.Master_Communication_Log__c=comm.Id;
        commChild2.NotUpdateRecord__c=false;
        insert commChild2;
        comm.Notes__c='test';
        update comm;
        commChild2.Notes__c='modif test';
        update commChild2;
        comm.Communication_Log_Type__c='CPUC Reporting';
        try {
            update comm;
        }
        catch (Exception e){}
        comm.Communication_Log_Type__c='CPUC Reporting';
        comm.Complaint_Briefing__c='test';
        comm.Official_Comments__c='test';
        comm.Official_Follow_up__c='test';
        comm.NotUpdateRecord__c=false;
        update comm;
    }
}