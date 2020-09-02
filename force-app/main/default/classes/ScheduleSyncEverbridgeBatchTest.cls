@isTest
public class ScheduleSyncEverbridgeBatchTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2030';
    static testMethod void ScheduleContTaskBatchTest(){
        Test.startTest();
        System.schedule('TransactionScheduler',CRON_EXP,new ScheduleSyncEverbridgeBatch());
        Test.stopTest();
    }
}