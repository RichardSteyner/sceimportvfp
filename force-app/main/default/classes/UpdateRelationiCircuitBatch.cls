global class UpdateRelationiCircuitBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    global List<Circuit_Relationship__c> lstCircuitRelationShip = new List<Circuit_Relationship__c>();
    global UpdateRelationiCircuitBatch(List<Circuit_Relationship__c> lstCircuitRelaShip){
        lstCircuitRelationShip = lstCircuitRelaShip;
    }
    global List<Circuit_Relationship__c> start(Database.BatchableContext BC){
        return lstCircuitRelationShip;
    }
    global void execute(Database.BatchableContext BC, List<Circuit_Relationship__c> scope){
        Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
        String Username = EverbridgeParam.Username__c;
        String Password = EverbridgeParam.Password__c;
        String OrganizationId= EverbridgeParam.OrganizationId__c;

        Map<String,List<String>> CircuitLstContacts = new Map<String,List<String>>();
        Set<String> setAccountIds = new Set<String>();
        Map<String,List<Id>> mapCircuitLstAcc = new Map<String,List<Id>>();
        Set<String> setCircuits = new set<String>();

        for(Circuit_Relationship__c crs : scope){
            setCircuits.add(crs.Circuit__r.External_ID__c);
            setAccountIds.add(crs.Community__c);
            setAccountIds.add(crs.County__c);
        }

        List<Contact> lstContact = [SELECT Id, Name, ExternalID__c, AccountId FROM Contact WHERE Active_Former__c = 'Active' AND PSPS__c=true AND AccountId IN: setAccountIds];
        Map<String,List<String>> mapListContacts = new map<String,List<String>>();
        for(String AccountId : setAccountIds){
            List<String> lstCont = new List<String>();
            for(Contact con : lstContact){
                if(AccountId == con.AccountId){
                    if(con.ExternalID__c != null) lstCont.add(con.ExternalID__c);
                }
            }
            mapListContacts.put(AccountId, lstCont);
        }

        for(String cir : setCircuits){
            List<Id> lstAccount = new List<Id>();
            for(Circuit_Relationship__c crs : scope){
                if(crs.Circuit__r.External_ID__c == cir){
                    lstAccount.add(crs.Community__c);
                    lstAccount.add(crs.County__c);
                }
            }
            mapCircuitLstAcc.put(cir,lstAccount);
        }

        for(String cir : mapCircuitLstAcc.keySet()){
            Set<String> setContacts = new set<String>();
            for(Id AccId : mapCircuitLstAcc.get(cir)){
                if(mapListContacts.containsKey(AccId)){
                    for(String ExtId :  mapListContacts.get(AccId)){
                        setContacts.add(ExtId);
                    }
                }
            }

            List<String> lstContacts = new List<String>();
            for(String ExtCont : setContacts){
                lstContacts.add(ExtCont);
            }
            CircuitLstContacts.put(cir,lstContacts);
        }


        for(String key : CircuitLstContacts.keySet()){
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

            if(CircuitLstContacts.get(key)!=null){
                String bodyc = JSON.serialize(CircuitLstContacts.get(key));
                rc.setBody(bodyc);
                HTTPResponse respc = new HTTPResponse();
                if(!Test.isRunningTest()) respc = hc.send(rc); 
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
}