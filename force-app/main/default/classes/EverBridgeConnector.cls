public class EverBridgeConnector {
    
    @future(callout=true)
    public static void insertGroup(Set<Id> setGroupIds){
        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId= EverbridgeParam.OrganizationId__c;
        List<Circuit__c> lstCircuits = [SELECT Id, Name, Inactive__c,External_ID__c FROM Circuit__c WHERE Id IN: setGroupIds];
        for(Circuit__c c : lstCircuits){
            if(c.Inactive__c==false){
                HTTP hc = new HTTP();
                HTTPRequest rc = new HTTPRequest();
                rc.setEndpoint('https://api.everbridge.net/rest/groups/'+OrganizationId);
                Blob headerValuec = Blob.valueOf(Username + ':' + Password);
                String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                rc.setHeader('Authorization', authorizationHeaderc);
                rc.setMethod('POST');
                rc.setTimeout(120000);
                rc.setHeader('Content-Type', 'application/json');
                rc.setHeader('Accept','application/json');
                Map<String,Object> mapData = new Map<String,Object>();
                mapData.put('name',c.Name);
                String bodyc = JSON.serialize(mapData);
                rc.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                System.debug('***********!Test.isRunningTest(): ' + !Test.isRunningTest()); 
                if(!Test.isRunningTest()){ respc = hc.send(rc);
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
                            c.External_ID__c = parser.getText();
                        }
                    }
                }
            }else{
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
                        System.debug('**********respc: ' + respc);
                        System.debug('**********respc.getbody:: ' + respc.getBody());
                    }else{
                        respc.setStatusCode(200);
                    	respc.setBody('{"message":"OK","id":7978064961082018,"baseUri":"https://api.everbridge.net/rest/groups/1332612387832192/","instanceUri":"https://api.everbridge.net/rest/groups/1332612387832192/7978064961082018"}');
                    }
                    if(respc.getStatusCode()==200){
                        c.External_ID__c = '';
                    }
                }
            }
        }
        System.debug('********lstCircuits: ' + lstCircuits);
        ApexUtil.isTriggerInvoked = true;
        Update lstCircuits;
        ApexUtil.isTriggerInvoked = false;
    }

    @future(callout=true)
    public static void DeleteRelation(Id CircleId, set<Id> SetAccountIds){
        System.debug('**********SetAccountIds: ' + SetAccountIds);
        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId= EverbridgeParam.OrganizationId__c;
        List<Circuit__c> lstCircuits = [SELECT Id, External_ID__c FROM Circuit__c WHERE Id =: CircleId];

        List<String> lstContact = new List<String>();
        for(Contact cont : [SELECT ExternalID__c FROM Contact WHERE AccountId IN: setAccountIds]){
            lstContact.add(cont.ExternalID__c);
        }

        System.debug('**********lstContact: ' + lstContact);
        HTTP hc = new HTTP();
        HTTPRequest rc = new HTTPRequest();
        rc.setEndpoint('https://api.everbridge.net/rest/groups/'+organizationId+'/contacts?groupId='+lstCircuits.get(0).External_ID__c);
        //rc.setEndpoint('https://api.everbridge.net/rest/groups/'+organizationId+'/'+lstCircuits.get(0).External_ID__c);
        Blob headerValuec = Blob.valueOf(Username + ':' + Password);
        String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
        rc.setHeader('Authorization', authorizationHeaderc);
        rc.setMethod('DELETE');
        rc.setTimeout(120000);
        rc.setHeader('Content-Type', 'application/json');
        rc.setHeader('Accept','application/json');
        String bodyc = JSON.serialize(lstContact);
        rc.setBody(bodyc);
        HTTPResponse respc = new HTTPResponse();
        if(!Test.isRunningTest()){
			respc = hc.send(rc);   
        }else{
            respc.setStatusCode(200);
			respc.setBody('{"message":"OK","code":100}');
        }
        System.debug('************bodyc: ' + bodyc);
        System.debug('********respc.getbody: ' + respc.getBody());
        System.debug('********respc.getStatus: ' + respc.getStatusCode());
    }

    @future(callout=true)
    public static void insertRelationCircuit(Set<Id> SetRelationCircuits){
        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId= EverbridgeParam.OrganizationId__c;
        Map<String, Set<String>> mapCircuitRelation = new Map<String, Set<String>>();
        set<Id> setAccount = new set<Id>();
        Map<Id,String> mapCounty = new Map<Id,String>();
        Map<Id,Id> MapCountyCircuitR = new Map<Id,Id>();
        Map<String,Id> MapGetCircuitRelId = new Map<String,Id>();

        List<Circuit_Relationship__c> lstCircuitRelationships = [SELECT Id, Name, Circuit__r.External_ID__c, County__c, Circuit__r.Inactive__c, Community__r.Organization_County__c, Community__c FROM Circuit_Relationship__c WHERE Id IN: SetRelationCircuits];
        for(Circuit_Relationship__c CR : lstCircuitRelationships){
            if(CR.Circuit__r.External_ID__c!=null && CR.Circuit__r.External_ID__c!='' && CR.Circuit__r.Inactive__c==false){
                if(cr.Community__r.Organization_County__c!=null && cr.Community__r.Organization_County__c!=''){
                    mapCounty.put(CR.Id, cr.Community__r.Organization_County__c + ' County');
                }else if(cr.County__c!=null){
                    setAccount.add(cr.County__c);
                }
                if(cr.Community__c!=null) setAccount.add(cr.Community__c);
            }
        }

        for(Account acc : [SELECT Id, Name FROM Account WHERE Name IN: mapCounty.values()]){
            setAccount.add(acc.Id);
            for(String mc : mapCounty.keySet()){
                if(mapCounty.get(mc)==acc.Name){
                    MapCountyCircuitR.put(mc,acc.Id);
                }
            }
        }

        List<Contact> lstContacts = [SELECT Id, LastName, FirstName, AccountId, ExternalID__c FROM Contact WHERE Active_Former__c = 'Active' AND PSPS__c=true AND AccountId IN: setAccount and ExternalID__c<>null];
        List<AccountContactRelation> lstContactsRelation = [SELECT Id, Contact.LastName, Contact.FirstName, Contact.AccountId, Contact.ExternalID__c FROM AccountContactRelation WHERE Contact.Active_Former__c = 'Active' AND Contact.PSPS__c=true AND AccountId IN: setAccount and Contact.ExternalID__c<>null];
        Set<String> lstContact;
        for(Circuit_Relationship__c CR : lstCircuitRelationships){
            if(mapCounty.get(CR.Id)!=null){
            }else{ if(cr.County__c==null) CR.County__c = null; }
            lstContact = new Set<String>();
            for(Contact c : lstContacts){
                if(c.ExternalID__c!=null && c.ExternalID__c!='') lstContact.add(c.ExternalID__c);
            }
            for(AccountContactRelation acr : lstContactsRelation){
                if(acr.Contact.ExternalID__c!=null && acr.Contact.ExternalID__c!='') lstContact.add(acr.Contact.ExternalID__c);
            }

            if(lstContact.size()>0){
                mapCircuitRelation.put(CR.Circuit__r.External_ID__c, lstContact);
            }
            for(String key :  MapCountyCircuitR.keySet()){
                if(CR.Id == key){
                    CR.County__c = MapCountyCircuitR.get(key);
                }
            }
            MapGetCircuitRelId.put(CR.Circuit__r.External_ID__c, CR.Id);
        }

        List<Circuit_Relationship__c> lstCRSUpd = new List<Circuit_Relationship__c>();
        for(String key : mapCircuitRelation.keySet()){
            HTTP hc = new HTTP();
            HTTPRequest rc = new HTTPRequest();
            rc.setEndpoint('https://api.everbridge.net/rest/groups/'+organizationId+'/contacts?groupId='+key);
            Blob headerValuec = Blob.valueOf(Username + ':' + Password);
            String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
            rc.setHeader('Authorization', authorizationHeaderc);
            rc.setMethod('POST');
            rc.setTimeout(120000);
            rc.setHeader('Content-Type', 'application/json');
            rc.setHeader('Accept','application/json');

            if(mapCircuitRelation.get(key)!=null){
                System.debug('***********mapCircuitRelation.get(key): ' + mapCircuitRelation.get(key));
                String bodyc = JSON.serialize(mapCircuitRelation.get(key));
                rc.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                if(!Test.isRunningTest()){ respc = hc.send(rc);   
                }else{
                    respc.setStatusCode(200);
                    respc.setBody('{"message":"OK","code":100,"data":["{\"id\":\"7969268868117429\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7986861054133049\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7978064961145732\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7973666914593957\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7978064961145605\",\"externalId\":\"\",\"result\":\"success\"}","{\"id\":\"7973666914586564\",\"externalId\":\"\",\"result\":\"success\"}"]}');
                }
                System.debug('**************respc.getbody(): ' + respc.getBody());
                System.debug('**************respc.resp: ' + respc);
                /*if(respc.getStatusCode() == 200){
                }else{
                    Circuit_Relationship__c CRS = new Circuit_Relationship__c();
                    JSONParser parser = JSON.createParser(respc.getBody());
                    while (parser.nextToken() != null){
                        System.debug('**********parser.getText(): ' + parser.getText());
                        if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'message')) {
                            parser.nextToken();
                            CRS.Id = MapGetCircuitRelId.get(key);
                            CRS.MessageError__c = parser.getText();
                            lstCRSUpd.add(CRS);
                        }
                    }
                }*/
            }
        }
        //update lstCRSUpd;

        ApexUtil.isTriggerInvoked=true;
        Update lstCircuitRelationships;
        ApexUtil.isTriggerInvoked=false;
    }
}