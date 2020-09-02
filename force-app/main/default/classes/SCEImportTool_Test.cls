@isTest
public class SCEImportTool_Test {
    
    static testMethod void SCEImportToolController_Test(){
        //String dataCsv = 'Circuit,County,Community,Incorporated City,Unincorporated County,Unincorporated Area Desc,Downstream Circuits,Count \r\n ACRES,ORANGE COUNTY,ORANGE CO UNINCO,,ORANGE CO UNINCO,Canyon Acres ; Top of The World,,100\r\n';
        String dataCsv = 'Circuit,County,Community,Incorporated City,Unincorporated County,Unincorporated Area Desc,Downstream Circuits,Congressional District,Ca Assembly District,Ca Senate District,Count\r\n';
        Test.startTest();
        SCEImportToolController controller = new SCEImportToolController();
        Document d = controller.doc;
        d = controller.Template;
        controller.contentFile1 = Blob.valueOf(dataCsv);
        controller.nameFile = 'Test.csv';
        controller.ReadFile();
        controller.DeleteRecords();

        controller = new SCEImportToolController();
        controller.contentFile1 = Blob.valueOf('Circuits\r\n');
        controller.nameFile = 'Test.csv';
        controller.ReadFile();

        controller = new SCEImportToolController();
        controller.contentFile1 = Blob.valueOf('Circuit\r\n');
        controller.nameFile = 'Test.csvs';
        controller.ReadFile();

        controller = new SCEImportToolController();
        controller.contentFile1 = null;
        controller.ReadFile();
        Test.stopTest();
    }
    
    static testMethod void SCEImportToolBatch_Test(){
        String dataCsv = 'ABACUS,SAN BERNARDINO COUNTY,HIGHLAND,HIGHLAND,,,,,,,100\r\n';
        String dataCsv2 = 'ABACUS,,HIGHLAND,HIGHLAND,,,,,,,100\r\n';
        String dataCsv3 = 'ABACUS.,,HIGHLAND,HIGHLAND,,,,,,,100\r\n';
        String dataCsv4 = 'ABACUS,,HIGHLAND,HIGHLAND,,,Cal-Electric-Victor No.2 starts from Aqueduct sub and follows the path of the Penstock 12 kV box loop (section downstream of RAR 0013).  The idle line crosses Los Flores road and ends within the vicinity of highway 173 ; Back end of the Cal-Electric-Victor No.2Â  line ends toward the southern most portion of the Penstock 12kV near Los Flores Road and highway 173 sadasdasdasdasd,,,,100\r\n';
        String dataCsv5 = 'ABACUS.,,HIGHLAND,HIGHLAND,,,,,,,\r\n';
        Test.startTest();
        Database.executeBatch(new SCEImportToolBatch(dataCsv),1);
        Database.executeBatch(new SCEImportToolBatch(dataCsv2),1);
        Database.executeBatch(new SCEImportToolBatch(dataCsv3),1);
        Database.executeBatch(new SCEImportToolBatch(dataCsv4),1);
        Database.executeBatch(new SCEImportToolBatch(dataCsv5),1);
        Test.stopTest();

        System.Debug('**************** VERIFICATION SECTION ****************');
        System.Debug('**************** DATA CSV ****************');
        System.debug(dataCsv);

        System.Debug('**************** RECORD IN Circuit__c ****************');
        System.debug([SELECT Id,Name FROM Circuit__c]);
        
        System.Debug('**************** RECORD IN Circuit_Relationship__c ****************');
        System.debug([SELECT Id,Circuit__c,Circuit_Name__c,County__c,Community__c,Incorporated_City__c,Unincorporated_Area_Desc__c,Unincorporated_County__c,Downstream_Circuits__c,Congressional_District__c,Ca_Assembly_District__c,Ca_Senate_District__c FROM Circuit_Relationship__c]);
    
    }
    static testMethod void SCEDeleteToolBatch_Test(){
        Circuit__c c = new Circuit__c(Name = 'CircuitTest',External_ID__c='test');
        insert c;
        Test.startTest();
        Database.executeBatch(new SCEDeleteToolBatch(),1);
        Test.stopTest();
    }
}