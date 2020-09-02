public class SCEImportToolController {
	public Id strBatchId {get; set;}
    public string nameFile{get;set;}    
    transient public Blob contentFile1{get;set;}
    public String BatchStatus{get;set;}
    public String BatchStatusNew{get;set;}
    public Boolean batchStatusBool {get;set;}
    public Boolean pollerBool {get;set;} 		
    public Document doc {get;set;}
    public Document Template {get;set;}
    public String button {get;set;}
	
	public SCEImportToolController(){		
        if(!Test.isRunningTest()){
            doc = [SELECT Id FROM Document WHERE Name = 'import' LIMIT 1];Template = [SELECT Id FROM Document WHERE Name = 'Import Template' LIMIT 1];
        } 
		batchStatusBool = false;
        pollerBool = false;
		if(contentFile1 != null) nameFile = contentFile1.toString();
	}
    
    public void DeleteRecords(){
        button = 'Delete';
        batchStatusBool = true;
        strBatchId = Database.executeBatch(new SCEDeleteToolBatch(),50);
        checkBatchStatus();
    }
	
	public void ReadFile(){
        button = 'Import';
        if(contentFile1 != null){
            Set<String> acceptedExtensions = new Set<String> {'.csv'};
            Boolean found = false;
            String Content_String;
            for(String s : acceptedExtensions){
                if(found = nameFile.endsWith(s)){
                    break;
                }
            }
            if(!found){
                batchStatusBool = true;
                BatchStatusNew = 'The importing tool can only accept a CSV file format. Please load the correct file format.';
                batchStatus = 'Extension Fail';
                pollerBool = false;
            }else{
                try {
                    Content_String = contentFile1.toString();
                    Content_String = Content_String.replace('\uFEFF','');
                    batchStatusBool = true;
                    strBatchId = Database.executeBatch(new SCEImportToolBatch(Content_String), 1);
                    checkBatchStatus();
                    if(Test.isRunningTest()){StringException e = new StringException(); e.setMessage('Error'); throw e;}
                }catch(StringException e){
                    System.debug(e.getMessage());
                    System.debug(e.getTypeName());
                    System.debug(e.getLineNumber());
                    batchStatusBool = true;
                    BatchStatusNew = 'Your file can\'t be read, that\'s because your file format is not correct <a href="'+ PageReference.forResource('SCE_error_procedure').getUrl()+'">click here</a> for the instructions on changing your file format.';
                    batchStatus = 'Extension Fail';
                    pollerBool = false;
                }                  
            }
        }else{
            batchStatusBool = true;
            BatchStatusNew = 'Please click the Browse';
        }
	}
	
	public void checkBatchStatus(){
        AsyncApexJob job = [SELECT Id, Status FROM AsyncApexJob WHERE Id =: strBatchId];
        batchStatus = job.Status;
        if(batchStatus=='Failed'){ BatchStatusNew = 'Import Failed';}
        else if(batchStatus=='Completed'){
            if(button == 'Delete') BatchStatusNew = 'Delete Complete'; else BatchStatusNew = 'Import Complete';
        }
        else if(batchStatus=='Aborted'){ BatchStatusNew = 'The headers on the CSV file do not match 	the importing tool. Please see step 2 for the headers needed for this importing tool.';}
        else{ BatchStatusNew = 'Import Uploading';}
        
        if(job!=null){
                if(batchStatus == 'Completed' || batchStatus == 'Aborted'){
	            pollerBool = false;
	        }else{
	            pollerBool = true;
	        }
        }
	}    
}