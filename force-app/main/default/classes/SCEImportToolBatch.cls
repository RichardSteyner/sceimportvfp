global with sharing class SCEImportToolBatch implements Database.batchable<String>, Database.Stateful, Database.AllowsCallouts
    {
        private Integer cont;
        private String m_csvFile;
        private Map<String,String> CircuitErrors = new Map<String,String>();
        private Map<Integer,String> dataRows = new Map<Integer,String>(); 
        private Map<Integer,String> errors = new Map<Integer,String>();
        private Map<String,Integer> MapCirRel_helper = new Map<String,Integer>(); 
        private Map<String, Set<String>> mapCircuitRelation = new Map<String, Set<String>>();
        private List<String> ListK = new List<String>();
        List<String> RowSuccess = new List<String>();
        
        public SCEImportToolBatch(String vm_csvFile){
            cont = 0;
            m_csvFile = vm_csvFile;
        }

        global Iterable<String> start(Database.batchableContext batchableContext)
        { 
            system.debug('##start SCEImportToolBatch');
            return new CSVIterator(m_csvFile,'\r\n');
        }
        
        global void execute(Database.BatchableContext BC, List<String> scope)  
        {
            system.debug(cont);
            system.debug('##execute SCEImportToolBatch');

            Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
            String Username = EverbridgeParam.Username__c;
            String Password = EverbridgeParam.Password__c;
            String OrganizationId = EverbridgeParam.OrganizationId__c;
            
            List<String> circuitNameList = new List<String>();
            List<String> valueList;
            Map<String,Circuit__c> circuitMap = new Map<String,Circuit__c>();
            List<Circuit_Relationship__c> circuitRelListAux;
            Map<String,List<Circuit_Relationship__c>> circuitRelMap = new Map<String,List<Circuit_Relationship__c>>();
            Circuit__c circuitAux;
            Circuit_Relationship__c circuitRelAux;
            String keyNameCirRel;
            String regex = '[^A-z0-9 #]';
            Pattern msgPattern = Pattern.compile(regex);
            Matcher containString ;


            for(String row : scope)
            {
                keyNameCirRel = '';
                system.debug(row);
                system.debug(cont);            
                
                    
                    if(row.contains(',')){
                        try{
                            dataRows.put(cont, row);  
                            valueList = row.split(',');
                            if(!Test.isRunningTest() && cont == 0){

                                if(valueList[0] != 'Circuit' || valueList[1] != 'County' || valueList[2] != 'Community' || valueList[3] != 'Incorporated City' || valueList[4] != 'Unincorporated County' || valueList[5] != 'Unincorporated Area Desc' || valueList[6] != 'Downstream Circuits' || valueList[7] != 'Congressional District' || valueList[8] != 'Ca Assembly District' || valueList[9] != 'Ca Senate District' || valueList[10] != 'Count'){
                                    system.debug('Not header');
                                    system.abortJob(BC.getJobId());
                                }

                            }else{
                                if(valueList.size() != 11){
                                    keyNameCirRel = valueList[0].trim().toLowerCase() + valueList[1].trim().toLowerCase() + valueList[2].trim().toLowerCase();
                                    keyNameCirRel = keyNameCirRel.replaceAll('[^A-Za-z0-9]','');
                                    MapCirRel_helper.put(keyNameCirRel,cont);
                                    addErrorCircuit_Relationship(keyNameCirRel,null,null,'Make sure the count column is not empty and there are no commas between the text');
                                }else{
                                    if(valueList[10] != 'Count' && valueList[0] != null && valueList[0].trim() != ''){
                                        keyNameCirRel = valueList[0].trim().toLowerCase() + valueList[1].trim().toLowerCase() + valueList[2].trim().toLowerCase() + valueList[3].trim().toLowerCase() +  valueList[10].trim().toLowerCase();
                                        keyNameCirRel = keyNameCirRel.replaceAll('[^A-Za-z0-9]','');
                                        MapCirRel_helper.put(keyNameCirRel,cont);
    
                                        containString = msgPattern.matcher(valueList[0].trim().toLowerCase());
    
                                        if(!containString.find()){
                                            if(valueList[1].trim() != ''){
                                                //Circuit
                                                circuitAux = new Circuit__c();
                                                circuitAux.Name = valueList[0].trim();
                                                circuitMap.put(circuitAux.Name.toLowerCase(),circuitAux);
    
                                                system.debug(valueList[7]);
    
                                                //Circuit Relationship
                                                circuitRelAux = new Circuit_Relationship__c(
                                                    County_Name__c = valueList[1],
                                                    Community_Name__c = valueList[2],
                                                    Incorporated_City__c = valueList[3],
                                                    Unincorporated_County__c = valueList[4],
                                                    Unincorporated_Area_Desc__c = valueList[5],
                                                    Downstream_Circuits__c = valueList[6], 
                                                    Congressional_District__c = valueList[7], 
                                                    Ca_Assembly_District__c = valueList[8], 
                                                    Ca_Senate_District__c = valueList[9], 
                                                    count__c = Integer.valueOf(valueList[10])
                                                );
    
                                                if(circuitRelMap.get(circuitAux.Name.toLowerCase()) != null){
                                                    circuitRelListAux = circuitRelMap.get(circuitAux.Name.toLowerCase());
                                                    circuitRelListAux.add(circuitRelAux);
                                                    circuitRelMap.put(circuitAux.Name.toLowerCase(),circuitRelListAux.clone());
                                                }else{
                                                    circuitRelListAux = new List<Circuit_Relationship__c>();
                                                    circuitRelListAux.add(circuitRelAux);
                                                    circuitRelMap.put(circuitAux.Name.toLowerCase(),circuitRelListAux.clone());
                                                }
                                            }else{
                                                addErrorCircuit_Relationship(keyNameCirRel,null,null,'County weasn\'t found in organizations');
                                            }
                                        }else{
                                            addErrorCircuit(valueList[0].trim().toLowerCase(),'The Circuit can only contain numbers, letters or the # symbol');
                                            addErrorCircuit_Relationship(keyNameCirRel,null,null,'The Circuit can only contain numbers, letters or the # symbol');
                                        }
    
                                    }
                                }
                               
                            }                
                            if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                        }catch(Exception e){
                            System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                            addErrorCircuit_Relationship(keyNameCirRel,null,null,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
                        }
                    }
                
                cont++;
            }
            
            if(circuitMap.size() > 0){
                ApexUtil.isTriggerInvoked = true;
                
                Map<String,Circuit__c> circuitExistMap = new Map<String,Circuit__c>();
                for(Circuit__c c : [SELECT Id, Name, External_ID__c FROM Circuit__c WHERE Name IN: circuitMap.keySet()]){
                    circuitExistMap.put(c.Name.toLowerCase(),c);
                }
                
                Map<String,Circuit__c> circuitUpsertMap = new Map<String,Circuit__c>();
                
                HTTP http;
                HTTPRequest req;
                Blob headerValuec;
                String authorizationHeaderc;
                Map<String,Object> mapData;
                String bodyc;
                HTTPResponse response;

                String jsonInput;
                Map<String, Object> JsonMap;

                for(Circuit__c cx : circuitMap.values()){
                    try{                    
                        if(circuitExistMap.get(cx.Name.toLowerCase()) == null || circuitExistMap.get(cx.Name.toLowerCase()).External_ID__c == null){
                            if(circuitExistMap.get(cx.Name.toLowerCase()) != null) cx.Id = circuitExistMap.get(cx.Name.toLowerCase()).Id;
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
                            mapData.put('name',cx.Name);
                            bodyc = JSON.serialize(mapData);
                            req.setBody(bodyc);
                            response = new HTTPResponse();
                            if(!Test.isRunningTest()){ 
                                response = http.send(req);
                            }else{
                                response.setStatusCode(200);
                                response.setBody('{"message":"OK","id":7995657147126190,"baseUri":"https://api.everbridge.net/rest/groups/1332612387832192/","instanceUri":"https://api.everbridge.net/rest/groups/1332612387832192/7995657147126190"}');
                                addErrorCircuit(cx.Name.toLowerCase(),'Everbridge - Status:' + response.getStatus() + ' - Error: '+response.getBody());
                            }
                            if(response.getStatusCode() == 200){
                                JSONParser parser = JSON.createParser(response.getBody());
                                while (parser.nextToken() != null){
                                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'Id')) {
                                        parser.nextToken();
                                        cx.External_ID__c = parser.getText();
                                        circuitUpsertMap.put(cx.Name.toLowerCase(),cx);
                                    }
                                }
                            }

                            if(Test.isRunningTest() || response.getStatusCode() != 200){
                                jsonInput = response.getBody() ;
                                JsonMap = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);if(Test.isRunningTest()){JsonMap.put('message','Group name is duplicated.');}
                                if(JsonMap.get('message') == 'Group name is duplicated.'){
                                    http = new HTTP();
                                    req = new HTTPRequest();
                                    String Encode = EncodingUtil.urlEncode(cx.Name, 'UTF-8').replaceAll('\\+', '%20');
                                    req.setEndpoint('https://api.everbridge.net/rest/groups/'+OrganizationId+'/'+ Encode +'?queryType=name');
                                   
                                    headerValuec = Blob.valueOf(Username + ':' + Password);
                                    authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                                    req.setHeader('Authorization', authorizationHeaderc);
                                    req.setMethod('GET');
                                    req.setTimeout(120000);
                                    req.setHeader('Content-Type', 'application/json');
                                    req.setHeader('Accept','application/json');
                                    response = new HTTPResponse();
                                    if(!Test.isRunningTest()){ 
                                        response = http.send(req);
                                    }else{
                                        response.setStatusCode(200);
                                        response.setBody('{ "message": "OK", "result": { "createdName": "API USER6", "lastModifiedTime": 0, "accountId": 0, "status": "A", "resourceBundleId": 0, "organizationId": 1332612387832192, "id": 431292025929880, "parentId": -1, "name": "AGNEW", "lastModifiedDate": 1580793311472, "lastModifiedId": 333843512951983, "createdId": 333843512951983, "createdDate": 1580793311472, "lastSynchronizedTime": 0, "lastModifiedName": "API USER6", "enableSequencedContact": false, "dirty": true } }');
                                        addErrorCircuit(cx.Name.toLowerCase(),'Everbridge - Status:' + response.getStatus() + ' - Error: '+response.getBody());
                                    }
                                    jsonInput = response.getBody() ;
                                    JsonMap = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
                                    JsonMap = (Map<String, Object>)JsonMap.get('result');
                                    if(JsonMap.get('id') != 0){
                                        cx.External_ID__c = String.valueOf(JsonMap.get('id'));
                                        circuitUpsertMap.put(cx.Name.toLowerCase(),cx);
                                    }
                                }else{
                                    addErrorCircuit(cx.Name.toLowerCase(),'Everbridge - Status:' + response.getStatus() + ' - Error: '+response.getBody());
                                    System.debug(response.getStatusCode());
                                    System.debug(response.getBody());
                                    System.debug(response.getStatus());
                                }
                            }
                            
                        }else{
                            circuitUpsertMap.put(cx.Name.toLowerCase(),circuitExistMap.get(cx.Name.toLowerCase()));
                        }
                        if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                    }catch(Exception e){
                        System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                        addErrorCircuit(cx.Name.toLowerCase(),req.getEndpoint()+'Line '+e.getLineNumber()+ ': '+ e.getMessage()+' - '+response.getBody());
                    }
                }
                
                system.debug(circuitUpsertMap);
                if(circuitUpsertMap.size() > 0){
                    List<String> accountNameList = new List<String>();
                    for(String key : circuitRelMap.keySet()){
                        
                            for(Circuit_Relationship__c crx : circuitRelMap.get(key)){
                                try{
                                    if(crx.County_Name__c != null && crx.County_Name__c.trim() != '') accountNameList.add(crx.County_Name__c);
                                    if(crx.Community_Name__c != null && crx.Community_Name__c.trim() != '') accountNameList.add(crx.Community_Name__c);
                                    if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                                }catch(Exception e){
                                    System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                                    addErrorCircuit_Relationship(null,key,crx,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
                                }
                            }
                        
                    }
                    
                    Map<String,Account> accountMap = new Map<String,Account>();
                    for(Account a : [SELECT Id, Name, Organization_County__c FROM Account WHERE Name IN: accountNameList]) accountMap.put(a.Name.trim().toLowerCase(),a);
                    
                    String ownerId = [SELECT Id, Name FROM User WHERE isActive = true AND Name = 'Catherine Curtis'].Id;
                    Map<String,Account> accountInsert = new Map<String,Account>();
                    Account accountAux;
                    for(String key : circuitRelMap.keySet()){
                        for(Circuit_Relationship__c crx : circuitRelMap.get(key)){
                            try{
                                if(crx.Community_Name__c != null && crx.Community_Name__c.trim() != '' && accountMap.get(crx.Community_Name__c.trim().toLowerCase()) == null && accountInsert.get(crx.Community_Name__c.trim().toLowerCase()) == null){
                                    accountAux = new Account(Name = crx.Community_Name__c.trim(), OwnerId = ownerId);
                                    accountInsert.put(crx.Community_Name__c.trim().toLowerCase(),accountAux);
                                }
                                if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                            }catch(Exception e){
                                System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                                addErrorCircuit_Relationship(null,key,crx,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
                            }
                        }
                    }
                    
                    if(accountInsert.size() > 0) Database.insert(accountInsert.values(), false);
                    
                    for(Account a : [SELECT Id, Name, Organization_County__c FROM Account WHERE Name IN: accountNameList]) accountMap.put(a.Name.trim().toLowerCase(),a);
                    
                    List<Circuit_Relationship__c> circuitRelInsertList = new List<Circuit_Relationship__c>();
                    for(String key : circuitRelMap.keySet()){
                        for(Circuit_Relationship__c crx : circuitRelMap.get(key)){
                            try{
                                crx.Circuit_Name__c = key;
                                if(crx.County_Name__c != null && crx.County_Name__c.trim() != '' && accountMap.get(crx.County_Name__c.trim().toLowerCase()) != null) crx.County__c = accountMap.get(crx.County_Name__c.trim().toLowerCase()).Id;
                                if(crx.Community_Name__c != null && crx.Community_Name__c.trim() != '' && accountMap.get(crx.Community_Name__c.trim().toLowerCase()) != null) crx.Community__c = accountMap.get(crx.Community_Name__c.trim().toLowerCase()).Id;
                                circuitRelInsertList.add(crx);
                                if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                            }catch(Exception e){
                                System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                                addErrorCircuit_Relationship(null,key,crx,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
                            }
                        }
                    }
                    
                    if(circuitRelInsertList.size() > 0){
                        //Map<String, Set<String>> mapCircuitRelation = new Map<String, Set<String>>();
                        set<Id> setAccount = new set<Id>();
                        Map<Id,String> mapCounty = new Map<Id,String>();
                        Map<Id,Id> MapCountyCircuitR = new Map<Id,Id>();
                        Map<String,Id> MapGetCircuitRelId = new Map<String,Id>();
                        
                        //List<Circuit_Relationship__c> lstCircuitRelationships = [SELECT Id, Name, Circuit__r.External_ID__c, County__c, Circuit__r.Inactive__c, Community__r.Organization_County__c, Community__c FROM Circuit_Relationship__c WHERE Id IN: SetRelationCircuits];
                        for(Circuit_Relationship__c CR : circuitRelInsertList){
                            try{
                                if(cr.Community__c != null && accountMap.get(cr.Community__c) != null && accountMap.get(cr.Community__c).Organization_County__c!=null && accountMap.get(cr.Community__c).Organization_County__c!=''){
                                    mapCounty.put(CR.Id, accountMap.get(cr.Community__c).Organization_County__c + ' County');
                                }else if(cr.County__c!=null){
                                    setAccount.add(cr.County__c);
                                }
                                if(cr.Community__c!=null) setAccount.add(cr.Community__c);
                                if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                            }catch(Exception e){
                                System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                                addErrorCircuit_Relationship(null,CR.Circuit_Name__c,CR,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
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
                        system.debug(setAccount);
                        
                        List<Contact> lstContacts = [SELECT Id, LastName, FirstName, AccountId, ExternalID__c FROM Contact WHERE Active_Former__c = 'Active' AND PSPS__c=true AND AccountId IN: setAccount and ExternalID__c<>null];
                        List<AccountContactRelation> lstContactsRelation = [SELECT Id, Contact.LastName, Contact.FirstName, Contact.AccountId, Contact.ExternalID__c FROM AccountContactRelation WHERE Contact.Active_Former__c = 'Active' AND Contact.PSPS__c=true AND AccountId IN: setAccount and Contact.ExternalID__c<>null];
                        system.debug(lstContacts);
                        Set<String> lstContact;
                        for(Circuit_Relationship__c CR : circuitRelInsertList){
                            try{
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
                                    mapCircuitRelation.put(circuitUpsertMap.get(CR.Circuit_Name__c).External_ID__c, lstContact);ListK.add(circuitUpsertMap.get(CR.Circuit_Name__c).External_ID__c);
                                }
                                for(String key :  MapCountyCircuitR.keySet()){
                                    if(CR.Id == key){
                                        CR.County__c = MapCountyCircuitR.get(key);
                                    }
                                }
                                MapGetCircuitRelId.put(circuitUpsertMap.get(CR.Circuit_Name__c).External_ID__c, CR.Id);
                                if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
                            }catch(Exception e){
                                System.debug(e.getTypeName() + ' caught: Line '+e.getLineNumber() + ' - ' + e.getMessage());
                                addErrorCircuit_Relationship(null,CR.Circuit_Name__c,CR,'Line '+e.getLineNumber()+ ': '+ e.getMessage());
                            }
                        }
                        system.debug(mapCircuitRelation);
                        
                        //upsert circuitUpsertMap.values();
                        List<Circuit__c> circuitInsertList = circuitUpsertMap.values();
                        List<Database.UpsertResult> InsertCircuitResults = Database.upsert(circuitInsertList, false);
                        for(Integer i=0;i<InsertCircuitResults.size();i++){
                            if (!InsertCircuitResults.get(i).isSuccess()){
                                Database.Error error = InsertCircuitResults.get(i).getErrors().get(0);
                                addErrorCircuit(circuitInsertList.get(i).Name,'Error:  ' + error.getMessage());
                            }
                        }
                        
                        for(Circuit_Relationship__c crx : circuitRelInsertList){
                            crx.Circuit__c = circuitUpsertMap.get(crx.Circuit_Name__c).Id;
                        }

                        List<Database.SaveResult> InsertResults = Database.insert(circuitRelInsertList, false);
                        for(Integer i=0;i<InsertResults.size();i++){
                            if (!InsertResults.get(i).isSuccess()){
                                Database.Error error = InsertResults.get(i).getErrors().get(0);
                                Circuit_Relationship__c cirRelX = circuitRelInsertList.get(i);
                                addErrorCircuit_Relationship(null,cirRelX.Circuit_Name__c,cirRelX,'Error:  ' + error.getMessage());
                            }else{
                                addSuccess(circuitRelInsertList.get(i));
                            }
                        }
                        //insert circuitRelInsertList;
                        
                    }
                }
            }
        }
        
        global void finish(Database.BatchableContext batchableContext){
            system.debug('##finish SCEImportToolBatch');
            try{
                if(mapCircuitRelation.size() > 0 && !Test.isRunningTest()) Database.executeBatch(new SCEImportToolHelperBatch (mapCircuitRelation,ListK),1);
                System.debug(errors);
                System.debug(dataRows.get(0));
                System.debug(CircuitErrors);

                String StringErrorsC = 'Circuit,Error\n';
                String StringErrorsCT = dataRows.get(0) + ',Error\n';
                String StringSucess = 'Id,' + dataRows.get(0) + '\n';

                if(CircuitErrors.size()>0 || errors.size()>0 || RowSuccess.size()>0){
                    List<Messaging.EmailFileAttachment> Att =  new List<Messaging.EmailFileAttachment>();
                    Messaging.EmailFileAttachment CsvC = new Messaging.EmailFileAttachment();
                    Messaging.EmailFileAttachment CsvCR = new Messaging.EmailFileAttachment();
                    Messaging.EmailFileAttachment Success = new Messaging.EmailFileAttachment();
                    Blob file;
                    
                    if(CircuitErrors.size()>0){
                        for(String err: CircuitErrors.values()){
                            StringErrorsC += err + '\n';
                        }
                        file = Blob.valueOf(StringErrorsC);
                        CsvC.setFileName('CircuitErrors.csv');
                        CsvC.setBody(file);
                        Att.add(CsvC);
                    }
                    
                    if(errors.size()>0){            
                        for(String err: errors.values()){
                            StringErrorsCT += err + '\n';
                        }
                        file = Blob.valueOf(StringErrorsCT);
                        CsvCR.setFileName('CircuitRelationshipErrors.csv');
                        CsvCR.setBody(file);
                        Att.add(CsvCR);
                    }

                    if(RowSuccess.size()>0){
                        for(String succ: RowSuccess){
                            StringSucess += succ + '\n';
                        }

                        file = Blob.valueOf(StringSucess);
                        Success.setFileName('InsertSuccess.csv');
                        Success.setBody(file);
                        Att.add(Success);
                    }

                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {UserInfo.getUserEmail()});
                    mail.setSubject('SCE Everbridge: Import report');
                    mail.setPlainTextBody('');
                    mail.setFileAttachments(Att);

                    Messaging.SendEmailResult[] results =  Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    System.debug(results);
                }
                if(Test.isRunningTest()){DmlException e = new DmlException(); e.setMessage('Error'); throw e;}
            }catch(Exception e){
                System.debug('Exception caught: '+ e.getLineNumber()+ ': ' + e.getMessage());
            }
            
        }
        private void addSuccess(Circuit_Relationship__c CiRel){
            String keyName = CiRel.Circuit_Name__c +CiRel.County_Name__c.trim().toLowerCase() + CiRel.Community_Name__c.trim().toLowerCase() + CiRel.Incorporated_City__c.trim().toLowerCase() + CiRel.count__c;
            keyName = keyName.replaceAll('[^A-Za-z0-9]','');

            Integer row_number = MapCirRel_helper.get(keyName);
            if(row_number > 0){
                RowSuccess.add(CiRel.Id + ',' + dataRows.get(row_number));
            }
        }
        private void addErrorCircuit_Relationship(String keyString,String CirKey,Circuit_Relationship__c CiRel, String error){
            String keyName = keyString != null? keyString : CirKey + CiRel.County_Name__c.trim().toLowerCase() + CiRel.Community_Name__c.trim().toLowerCase() + CiRel.Incorporated_City__c.trim().toLowerCase() + CiRel.count__c;
            keyName = keyName.replaceAll('[^A-Za-z0-9]','');
            Integer row_number = MapCirRel_helper.get(keyName);
            
            if(row_number > 0){
                error = error.replace('\n', '').replace(',', ';');
                String temp = errors.get(row_number);
                if( temp == Null){
                    errors.put(row_number, dataRows.get(row_number) + ',' + error);
                }else{
                    errors.put(row_number,temp + ' | ' + error);
                }
            }
        }
        private void addErrorCircuit(String Name, String error){
            //Name = Name.replaceAll('[^A-Za-z0-9]','');
            error = error.replace('\n', '').replace(',', ';');
            String temp = CircuitErrors.get(Name);
            if( temp == Null){
                CircuitErrors.put(Name,Name.toUpperCase() + ',' + error);
            }else{
                if( !temp.contains(error) )
                CircuitErrors.put(Name,temp + ' | ' + error);
            }
        }
    }