global with sharing class SCEImportToolHelperBatch implements Database.batchable<String>, Database.AllowsCallouts
{
    private Map<String, Set<String>> MapOrigin = new Map<String, Set<String>>();
    private List<String> keys = new List<String>();

    public SCEImportToolHelperBatch(Map<String, Set<String>> data, List<String> dataKey) {
        MapOrigin = data;
        keys = dataKey;
    }

    global Iterable<String> start(Database.batchableContext batchableContext)
    { 
        system.debug('##start SCEImportToolHelperBatch');
        system.debug(MapOrigin);
        
        return keys;
    }

    global void execute(Database.BatchableContext BC, List<String> scope) {
        system.debug('##execute SCEImportToolHelperBatch');

        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId = EverbridgeParam.OrganizationId__c;

        Blob headerValuec;
        String authorizationHeaderc;
        String bodyc;

        for(String key : scope){
            HTTP hc = new HTTP();
            HTTPRequest rc = new HTTPRequest();
            rc.setEndpoint('https://api.everbridge.net/rest/groups/'+organizationId+'/contacts?groupId='+key);
            headerValuec = Blob.valueOf(Username + ':' + Password);
            authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
            rc.setHeader('Authorization', authorizationHeaderc);
            rc.setMethod('POST');
            rc.setTimeout(120000);
            rc.setHeader('Content-Type', 'application/json');
            rc.setHeader('Accept','application/json');
            
            if(MapOrigin.get(key)!=null){
                System.debug('***********MapOrigin.get(key): ' + MapOrigin.get(key));
                bodyc = JSON.serialize(MapOrigin.get(key));
                System.debug(bodyc);
                rc.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                if(!Test.isRunningTest()){ 
                    respc = hc.send(rc);   
                    System.debug(respc.getBody());
                }else{
                    respc.setStatusCode(200);
                    respc.setBody('{"message":"OK","code":100,"data":["{\"id\":\"7969268868117429\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7986861054133049\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7978064961145732\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7973666914593957\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7978064961145605\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7973666914586564\",\"externalId\":\"\",\"result\":\"success\"}"]}');
                }
            }
        }

    }

    global void finish(Database.BatchableContext batchableContext){
        system.debug('##finish SCEImportToolHelperBatch');
    }
}