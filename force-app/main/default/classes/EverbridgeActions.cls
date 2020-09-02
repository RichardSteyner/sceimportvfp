global class EverbridgeActions {
    
    webservice static string deleteCircuitRelationship(String circuitRelationshipId){
        try{ 
            Circuit_Relationship__c circuitRelationship = [SELECT Id, Circuit__c, Circuit__r.Name, Circuit__r.External_ID__c, Circuit__r.Inactive__c, County__c, Community__c FROM Circuit_Relationship__c WHERE Id =: circuitRelationshipId];
            
            if(circuitRelationship.Circuit__r.External_ID__c != null && circuitRelationship.Circuit__r.Inactive__c == false){
                Map<Id,String> countyMap = new Map<Id,String>();
                Set<String> accountIds = new Set<String>();
                for(Circuit_Relationship__c cr : [SELECT Id, Name, Circuit__r.External_ID__c, County__c, Circuit__r.Inactive__c, Community__r.Organization_County__c, Community__c FROM Circuit_Relationship__c WHERE Circuit__c =: circuitRelationship.Circuit__c AND Id <>: circuitRelationship.Id]){
                    if(cr.Community__c != null) accountIds.add(cr.Community__c);
                    if(cr.Community__r.Organization_County__c!=null && cr.Community__r.Organization_County__c!=''){
                        countyMap.put(cr.Id, cr.Community__r.Organization_County__c + ' County');
                    }else if(cr.County__c!=null){
                        accountIds.add(cr.County__c);
                    }
                }
               
                for(Account acc : [SELECT Id, Name FROM Account WHERE Name IN: countyMap.values()]) accountIds.add(acc.Id);
                
                Set<String> contactExternalIds = new Set<String>();
                for(Contact c : [SELECT Id, LastName, FirstName, AccountId, ExternalID__c FROM Contact WHERE Active_Former__c = 'Active' AND PSPS__c=true AND AccountId IN: accountIds and ExternalID__c<>null]){
                    if(c.ExternalID__c!=null && c.ExternalID__c!='') contactExternalIds.add(c.ExternalID__c);
                }
                for(AccountContactRelation acr : [SELECT Id, Contact.LastName, Contact.FirstName, Contact.AccountId, Contact.ExternalID__c FROM AccountContactRelation WHERE Contact.Active_Former__c = 'Active' AND Contact.PSPS__c=true AND AccountId IN: accountIds and Contact.ExternalID__c<>null]){
                    if(acr.Contact.ExternalID__c!=null && acr.Contact.ExternalID__c!='') contactExternalIds.add(acr.Contact.ExternalID__c);
                }
                
                Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
                String Username = EverbridgeParam.Username__c;
                String Password = EverbridgeParam.Password__c;
                String OrganizationId= EverbridgeParam.OrganizationId__c;
                
                String circuitNewExternal;
                
                system.debug(contactExternalIds);
                //DELETE GROUP
                HTTP http = new HTTP();
                HTTPRequest req = new HTTPRequest();
                req.setEndpoint('https://api.everbridge.net/rest/groups/'+OrganizationId+'/'+circuitRelationship.Circuit__r.External_ID__c);
                Blob headerValuec = Blob.valueOf(Username + ':' + Password);
                String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                req.setHeader('Authorization', authorizationHeaderc);
                req.setMethod('DELETE');
                req.setTimeout(120000);
                req.setHeader('Content-Type', 'application/json');
                req.setHeader('Accept','application/json');
                Map<String,Object> mapData = new Map<String,Object>();
                mapData.put('name',circuitRelationship.Circuit__r.Name);
                String bodyc = JSON.serialize(mapData);
                req.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                if(!Test.isRunningTest()){ 
                    respc = http.send(req);
                }else{
                    respc.setStatusCode(200);
                    respc.setBody('{"message":"OK","id":7978064961082018,"baseUri":"https://api.everbridge.net/rest/groups/1332612387832192/","instanceUri":"https://api.everbridge.net/rest/groups/1332612387832192/7978064961082018"}');
                }
                
                //CREATE GROUP
                http = new HTTP();
                req = new HTTPRequest();
                req.setEndpoint('https://api.everbridge.net/rest/groups/'+OrganizationId);
                headerValuec = Blob.valueOf(Username + ':' + Password);
                authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                req.setHeader('Authorization', authorizationHeaderc);
                req.setMethod('POST');
                req.setTimeout(120000);
                req.setHeader('Content-Type', 'application/json');
                req.setHeader('Accept','application/json');
                mapData = new Map<String,Object>();
                mapData.put('name',circuitRelationship.Circuit__r.Name);
                bodyc = JSON.serialize(mapData);
                req.setBody(bodyc);
                respc = new HTTPResponse();
                System.debug('***********!Test.isRunningTest(): ' + !Test.isRunningTest()); 
                if(!Test.isRunningTest()){ respc = http.send(req);
                }else{
                    respc.setStatusCode(200);
                    respc.setBody('{"message":"OK","id":7995657147126190,"baseUri":"https://api.everbridge.net/rest/groups/1332612387832192/","instanceUri":"https://api.everbridge.net/rest/groups/1332612387832192/7995657147126190"}');
                }
                System.debug('*************respc.getBody(): ' + respc.getBody());
                if(respc.getStatusCode() == 200){
                    JSONParser parser = JSON.createParser(respc.getBody());
                    while (parser.nextToken() != null){
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'Id')) {
                            parser.nextToken();
                            circuitNewExternal = parser.getText();
                        }
                    }
                }
                
                system.debug(contactExternalIds);
                if(circuitNewExternal != null){
                    if(contactExternalIds.size() > 0){
                        http = new HTTP();
                        req = new HTTPRequest();
                        req.setEndpoint('https://api.everbridge.net/rest/groups/'+organizationId+'/contacts?groupId='+circuitNewExternal);
                        headerValuec = Blob.valueOf(Username + ':' + Password);
                        authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                        req.setHeader('Authorization', authorizationHeaderc);
                        req.setMethod('POST');
                        req.setTimeout(120000);
                        req.setHeader('Content-Type', 'application/json');
                        req.setHeader('Accept','application/json');
                        bodyc = JSON.serialize(contactExternalIds);
                        system.debug(bodyc);
                        req.setBody(bodyc);
                        HTTPResponse response = new HTTPResponse();
                        if(!Test.isRunningTest()){ 
                            response = http.send(req);
                        }else{
                            response.setStatusCode(200);
                            response.setBody('{"message":"OK","code":100}');
                        }
                        system.debug(response.getStatus());
                        system.debug(response.getStatusCode());
                        system.debug(response.getBody());
                    }
                    ApexUtil.isTriggerInvoked = true;
                    delete circuitRelationship;
                    update new Circuit__c(Id=circuitRelationship.Circuit__c,External_ID__c=circuitNewExternal);
                }
            }
        }catch(DMLException e){ 
            system.debug('##e: '+e); 
            return e.getMessage(); 
        }
        return 'Done';
    }
}