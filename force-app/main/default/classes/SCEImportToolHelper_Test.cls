@isTest
public  class SCEImportToolHelper_Test {
    static testMethod void SCEImportToolHelperBatch_Test(){

        Map<String, Set<String>> MapOrigin = new Map<String, Set<String>>();
        Set<String> StringAux = new Set<String>();
        List<String> keys = new List<String>();

        StringAux.add('397070000000000');
        keys.add('487092241040289');
        MapOrigin.put('487092241040289',StringAux);

        Test.startTest();
        Database.executeBatch(new SCEImportToolHelperBatch(MapOrigin,keys),1);
        Test.stopTest();
    
    }
}