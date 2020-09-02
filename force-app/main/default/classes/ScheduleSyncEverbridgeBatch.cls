global class ScheduleSyncEverbridgeBatch implements Schedulable{
    global void execute(SchedulableContext sc){
        SyncEverbridgeBatch vsb = new SyncEverbridgeBatch();
        database.executeBatch(vsb,1);
    }
}