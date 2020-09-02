global class SCEDeleteToolBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
   
    global Database.QueryLocator start(Database.BatchableContext BC){
        system.debug('##start SCEDeleteToolBatch');
        return Database.getQueryLocator('SELECT Id, Name, External_ID__c FROM Circuit__c');
    }
    
    global void execute(Database.BatchableContext BC, List<Circuit__c> scope){
        system.debug('##execute SCEDeleteToolBatch');
        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId= EverbridgeParam.OrganizationId__c;
        
        Set<String> circuitIds = new Set<String>();
        for(Circuit__c  c : scope){
            circuitIds.add(c.id);
            if(c.External_ID__c!=null && c.External_ID__c!=''){
                HTTP hc = new HTTP();
                HTTPRequest rc = new HTTPRequest();
                rc.setEndpoint('https://api.everbridge.net/rest/groups/'+OrganizationId+'/'+c.External_ID__c);
                Blob headerValuec = Blob.valueOf(Username + ':' + Password);
                String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                rc.setHeader('Authorization', authorizationHeaderc);
                rc.setMethod('DELETE');
                rc.setTimeout(120000);
                rc.setHeader('Content-Type', 'application/json');
                rc.setHeader('Accept','application/json');
                Map<String,Object> mapData = new Map<String,Object>();
                mapData.put('name',c.Name);
                String bodyc = JSON.serialize(mapData);
                rc.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                if(!Test.isRunningTest()){ respc = hc.send(rc);
                }else{
                    respc.setStatusCode(200);
                    respc.setBody('{"message":"OK","id":7978064961082018,"baseUri":"https://api.everbridge.net/rest/groups/1332612387832192/","instanceUri":"https://api.everbridge.net/rest/groups/1332612387832192/7978064961082018"}');
                }
            }
        }
        
        delete [SELECT Id FROM Circuit_Relationship__c WHERE Circuit__c IN: circuitIds];
        delete scope;
    }
    
    global void finish(Database.BatchableContext BC){
        system.debug('##finish SCEDeleteToolBatch');
    }
}