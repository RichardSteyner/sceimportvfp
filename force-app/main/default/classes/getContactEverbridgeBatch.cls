global class getContactEverbridgeBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, email, ExternalID__c FROM Contact WHERE email!=null');
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        system.debug('***************scope: ' + scope);
        Map<String, Contact> mapContactUpdate = new Map<String,Contact>();
        Map<String, Contact> mapContacts = new Map<String,Contact>();
        for(Contact con : scope){
            mapContacts.put(con.email, con);
        }

        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;

        String OrganizationId= EverbridgeParam.OrganizationId__c;
        HTTP hc = new HTTP();
        HTTPRequest rc = new HTTPRequest();
        rc.setEndpoint('https://api.everbridge.net/rest/contacts/'+OrganizationId);
        Blob headerValuec = Blob.valueOf(Username + ':' + Password);
        String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);

        rc.setHeader('Authorization', authorizationHeaderc);
        rc.setMethod('GET');
        rc.setTimeout(120000);
        rc.setHeader('Content-Type', 'application/json');
        rc.setHeader('Accept','application/json');
        HTTPResponse respc;
        respc = hc.send(rc);
        JSONParser parse;
        String jsonBody = respc.getBody();
        ContactEverBridgeObject.ContactEverBridgeObj oxContent;
        parse = JSON.createParser(jsonBody);
        oxContent = (ContactEverBridgeObject.ContactEverBridgeObj)parse.readValueAs(ContactEverBridgeObject.ContactEverBridgeObj.class);
        for(ContactEverBridgeObject.data cont : oxContent.page.data) {
            if (cont.externalId != null) {
                if(mapContacts.containsKey(cont.ExternalId)){
                    Contact conts = new Contact(Id = mapContacts.get(cont.externalId).Id, ExternalID__c = String.ValueOf(cont.Id));
                    mapContactUpdate.put(cont.ExternalId,conts);
                    System.debug('**************mapContacts: ' + mapContactUpdate);
                }
            }
        }
        System.debug('******mapContacts.size(): ' + mapContactUpdate.size());
        System.debug('******mapContacts: ' + mapContactUpdate);
        ApexUtil.isTriggerInvoked = true;
        Update mapContacts.values();
        ApexUtil.isTriggerInvoked = false;
    }
    global void finish(Database.BatchableContext BC){
		
    }
}