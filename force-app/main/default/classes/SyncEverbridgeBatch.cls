global  class SyncEverbridgeBatch implements Database.Batchable<sObject>, Database.Stateful,Database.AllowsCallouts {
    global List<Circuit_Relationship__c> lstCircuitRelationShip = new List<Circuit_Relationship__c>();
    global Boolean nextBatch;
    global SyncEverbridgeBatch(){ nextBatch = true;}
    global SyncEverbridgeBatch(Boolean vnextBatch){ nextBatch = vnextBatch; }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id FROM Contact WHERE IsSendEverbridge__c=true');
    }
    global void execute(Database.BatchableContext BC, List<Contact> scope){
    	Everbridge_parameters__c EverbridgeParam = Everbridge_parameters__c.getInstance();
		String Username = EverbridgeParam.Username__c;
    	String Password = EverbridgeParam.Password__c;
    	String OrganizationId = EverbridgeParam.OrganizationId__c;
        List<Contact> lstContacts = new List<Contact>();
    	for(Contact c : scope){
            Contact con = [SELECT Id, AccountId, firstName, LastName, middlename, MailingStreet, MailingCity, MailingCountry,MailingState,MailingPostalCode,
                account.name,account.Organization_County__c, account.BillingCity, Email, Phone, MobilePhone, Title, Ext__c, Active_Former__c, ExternalID__c,
                Emergency_Contact__c, SCE_Alert__c, Rotating_Outage_Contact__c, PSPS__c, Role_s_In_Organization__c,Sync_with_Everbridge__c, IsSendEverbridge__c FROM Contact WHERE Id =: c.Id];
            //Boolean flag = false;
            //}else if(con.Active_Former__c=='Former'){
            if(con.ExternalID__c != null && ((con.SCE_Alert__c == false && con.PSPS__c == false) || con.Active_Former__c=='Former')){
                HTTP hc = new HTTP();
                HTTPRequest rc = new HTTPRequest();
                rc.setEndpoint('https://api.everbridge.net/rest/contacts/'+OrganizationId+'/'+con.ExternalID__c);
                Blob headerValuec = Blob.valueOf(Username + ':' + Password);
                String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);
                
                rc.setHeader('Authorization', authorizationHeaderc);
                rc.setMethod('DELETE');
                rc.setTimeout(120000);
                rc.setHeader('Content-Type', 'application/json');
                rc.setHeader('Accept','application/json');
                HTTPResponse respc;
                if(!Test.isRunningTest()){
                    respc = hc.send(rc);
                    if(respc.getStatusCode() == 200) {
                        con.ExternalID__c = '';
                    }
                }
                con.IsSendEverbridge__c = false;
                lstContacts.add(con);
            }else if(con.Active_Former__c=='Active'){
                /*if(con.Sync_with_Everbridge__c){
                    flag = true;
                }else if(con.SCE_Alert__c==true || con.PSPS__c==true){
                    flag = true;
                }*/
                if(con.Sync_with_Everbridge__c || con.SCE_Alert__c || con.PSPS__c){
                    HTTP hc = new HTTP();
                    HTTPRequest rc = new HTTPRequest();
                    rc.setEndpoint('https://api.everbridge.net/rest/contacts/'+OrganizationId);
                    Blob headerValuec = Blob.valueOf(Username + ':' + Password);
                    String authorizationHeaderc = 'Basic ' + EncodingUtil.base64Encode(headerValuec);

                    rc.setHeader('Authorization', authorizationHeaderc);
                    rc.setMethod('POST');
                    rc.setTimeout(120000);
                    rc.setHeader('Content-Type', 'application/json');
                    rc.setHeader('Accept','application/json');

                    Map<String,Object> MapParameters = new Map<String,Object>();
                    Map<String,Object> MapPage = new Map<String,Object>();
                    List<Map<String,Object>> LstData = new List<Map<String,Object>>();
                    Map<String,Object> MapFieldsc = new Map<String,Object>();
                    List<Map<String,Object>> LstPath = new List<Map<String,Object>>();
                    List<Map<String,Object>> ListcontactAttributes = new List<Map<String,Object>>();
                    List<Map<String,Object>> ListAddress = new List<Map<String,Object>>();

                    Map<String,Object> MapPhone = new Map<String,Object>();
                    MapFieldsc.put('lastName',con.LastName);
                    if(con.MiddleName!=null && con.MiddleName!=''){
                        MapFieldsc.put('middleInitial', con.MiddleName.subString(0,1));
                    }
                    MapFieldsc.put('firstName',con.FirstName);

                    Map<String,Object> mapStreet = new Map<String,Object>();

                    mapStreet.put('streetAddress',(con.MailingStreet!=null ? con.MailingStreet : '.'));
                    mapStreet.put('locationName','Work Address');
                    mapStreet.put('country', 'US');
                    mapStreet.put('state', con.MailingState);
                    mapStreet.put('postalCode', con.MailingPostalCode);
                    ListAddress.add(mapStreet);

                    MapFieldsc.put('address', ListAddress);
                    //MapFieldsc.put('recordTypeId','8105604014933294');
                    if(con.Account.Name =='Southern California Edison'){
                        MapFieldsc.put('recordTypeId','1332612387832180');
                    }else{
                        MapFieldsc.put('recordTypeId','8105604014933389');
                    }

                    MapFieldsc.put('externalId',con.Email);
                    //"locationName" : "Work Address"

                    Map<String,Object> map01 = new Map<String,Object>();
                    Map<String,Object> map02 = new Map<String,Object>();
                    Map<String,Object> map03 = new Map<String,Object>();
                    Map<String,Object> map04 = new Map<String,Object>();
                    if(con.email!=null && con.email != ''){
                        map01.put('value', con.email);
                        //map01.put('pathId', '241901148045318'); //Email Address 1
                        map01.put('pathId', '241901148045316');
                        map01.put('waitTime', 0);
                        map01.put('skipValidation', false);
                    }
                    if(map01.size()>0)
                        lstPath.add(map01);


                    if(con.Phone!=null && con.Phone!=''){
                        map02.put('value', con.Phone);
                        //map02.put('pathId', '219910915489800'); //Office phone
                        map02.put('pathId', '241901148045314');
                        map02.put('waitTime', 0);
                        map02.put('countryCode', 'US');
                        map02.put('skipValidation', true);
                        if(con.Ext__c!=null && con.Ext__c!=''){
                            map02.put('phoneExt', con.Ext__c);
                        }
                    }

                    if(con.MobilePhone!=null && con.MobilePhone!=''){
                        //Mobile (Text-SMS)
                        map03.put('value', con.MobilePhone);
                        //map03.put('pathId', '241901148045315');  //
                        //map03.put('pathId', '241901148045320');
                        map03.put('pathId', '241901148045324');
                        map03.put('waitTime', 0);
                        map03.put('countryCode', 'US');
                        map03.put('skipValidation', true);
                        
                        //SMS Blkbry TXT Ph#
                        map04.put('value', con.MobilePhone);
                        map04.put('pathId', '241901148045315');
                        map04.put('waitTime', 0);
                        map04.put('countryCode', 'US');
                        map04.put('skipValidation', true);
                    }

                    if(map03.size()>0) LstPath.add(map03);
                    if(map04.size()>0) LstPath.add(map04);

                    if(map02.size()>0)
                        lstPath.add(map02);

                    if(lstPath.size()>0)
                        MapFieldsc.put('paths', lstPath);

                    set<String> setOrganization = new set<String>();
                    map<String,Object> mapOrganization = new Map<String,Object>();
                    if(con.account.name !=null && con.account.name!=''){
                        setOrganization.add(con.account.name);
                        mapOrganization.put('values', setOrganization);
                        //mapOrganization.put('orgAttrId', '8096807921909932'); //Organization
                        mapOrganization.put('orgAttrId', '444206992591263');
                        mapOrganization.put('name','Organization');
                        if(mapOrganization.size()>0)
                            ListcontactAttributes.add(mapOrganization);
                    }

                    set<String> setJobTitle = new set<String>();
                    map<String,Object> mapJobTitle = new Map<String,Object>();
                    if(con.Title !=null && con.title!=''){
                        setJobTitle.add(con.title);
                        mapJobTitle.put('values', setJobTitle);
                        //mapJobTitle.put('orgAttrId', '8096807921909930');  //  Job Title
                        mapJobTitle.put('orgAttrId', '3083034899254189');
                        mapJobTitle.put('name','Job Title');
                        if(mapJobTitle.size()>0)
                            ListcontactAttributes.add(mapJobTitle);
                    }

                    set<String> setEmergencyContact = new set<String>();
                    map<String,Object> mapEmergencyContact = new Map<String,Object>();
                    if(con.Emergency_Contact__c !=null){
                        if(con.Emergency_Contact__c==true)setEmergencyContact.add('Yes');else setEmergencyContact.add('No');
                        mapEmergencyContact.put('values', setEmergencyContact);
                        mapEmergencyContact.put('orgAttrId', '8096807921911259');   // Emergency Contact
                        mapEmergencyContact.put('name','Emergency Contact');
                        if(mapEmergencyContact.size()>0)
                            ListcontactAttributes.add(mapEmergencyContact);
                    }

                    set<String> setSCEAlerts = new set<String>();
                    map<String,Object> mapSCEAlerts = new Map<String,Object>();
                    if(con.SCE_Alert__c !=null){
                        if(con.SCE_Alert__c==true)setSCEAlerts.add('Yes');else setSCEAlerts.add('No');
                        mapSCEAlerts.put('values', setSCEAlerts);
                        //mapSCEAlerts.put('orgAttrId', '8096807921909934');   //SCE Alerts
                        mapSCEAlerts.put('orgAttrId', '444206992591264');
                        mapSCEAlerts.put('name','SCE Alerts');
                        if(mapSCEAlerts.size()>0)
                            ListcontactAttributes.add(mapSCEAlerts);
                    }



                    set<String> setRotatingOutage = new set<String>();
                    map<String,Object> mapRotatingOutage = new Map<String,Object>();
                    if(con.Rotating_Outage_Contact__c !=null){
                        if(con.Rotating_Outage_Contact__c==true)setRotatingOutage.add('Yes');else setRotatingOutage.add('No');
                        mapRotatingOutage.put('values', setRotatingOutage);
                        //mapRotatingOutage.put('orgAttrId', '8096807921909935');  //Rotating Outage Contact
                        mapRotatingOutage.put('orgAttrId', '444206992591265');
                        mapRotatingOutage.put('name','Rotating Outage Contact');
                        if(mapRotatingOutage.size()>0)
                            ListcontactAttributes.add(mapRotatingOutage);
                    }

                    set<String> setOutagePSPS = new set<String>();
                    map<String,Object> mapOutagePSPS = new Map<String,Object>();
                    if(con.PSPS__c !=null){
                        if(con.PSPS__c==true)setOutagePSPS.add('Yes');else setOutagePSPS.add('No');
                        mapOutagePSPS.put('values', setOutagePSPS);
                        //mapOutagePSPS.put('orgAttrId', '8105604014933137'); // Outage/PSPS   8096807921911257
                        mapOutagePSPS.put('orgAttrId', '8096807921911260');
                        mapOutagePSPS.put('name','Outage/PSPS');
                        if(mapOutagePSPS.size()>0)
                            ListcontactAttributes.add(mapOutagePSPS);
                    }

                 /*   set<String> setRolOrganization = new set<String>();
                    map<String,Object> mapRolOrganization = new Map<String,Object>();
                    if(con.Role_s_In_Organization__c !=null && con.Role_s_In_Organization__c!=''){
                        String Cad = con.Role_s_In_Organization__c;
                        Cad = Cad.replace(';', ',');
                        setRolOrganization.add(Cad);
                        mapRolOrganization.put('values', setRolOrganization);
                        //mapRolOrganization.put('orgAttrId', '8105604014933132');  //Role in Organization   8096807921911258
                        mapRolOrganization.put('orgAttrId', '8096807921911258');
                        mapRolOrganization.put('name','Role in Organization');
                        if(mapRolOrganization.size()>0)
                            ListcontactAttributes.add(mapRolOrganization);
                    }*/

                    set<String> setOrganizationCounty = new set<String>();
                    map<String,Object> mapOrganizationCounty = new Map<String,Object>();
                    if(con.account.Organization_County__c !=null){
                        setOrganizationCounty.add(con.account.Organization_County__c);
                        mapOrganizationCounty.put('values', setOrganizationCounty);
                        mapOrganizationCounty.put('orgAttrId', '8096807921911330');
                        mapOrganizationCounty.put('name','County');
                        if(mapOrganizationCounty.size()>0)
                            ListcontactAttributes.add(mapOrganizationCounty);
                    }

                    if(ListcontactAttributes.size()>0)
                        MapFieldsc.put('contactAttributes', ListcontactAttributes);

                    String bodyc = JSON.serialize(MapFieldsc);
                    System.debug('*************bodyc: '+ bodyc);
                    rc.setBody(bodyc);
                    HTTPResponse respc;
                    if(!Test.isRunningTest()){
                        respc = hc.send(rc);
                        if(respc.getStatusCode() == 200){
                            JSONParser parser = JSON.createParser(respc.getBody());
                            while (parser.nextToken() != null){
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'Id')) {
                                    parser.nextToken();
                                    con.ExternalID__c = parser.getText();
                                    con.MessageError__c = '';
                                    con.IsSendEverbridge__c = false;
                                    lstContacts.add(con);
                                }
                            }
                            lstCircuitRelationShip = [SELECT Id, Name, Circuit__r.Name,Circuit__r.External_ID__c, Circuit__r.Inactive__c,
                                    Community__r.Organization_County__c, Community__c, Community__r.name, County__r.name, County__c FROM Circuit_Relationship__c WHERE County__c =: con.AccountId or Community__c=:con.AccountId];
                        }else{
                            JSONParser parser = JSON.createParser(respc.getBody());
                            while (parser.nextToken() != null){
                                System.debug('**********parser.getText(): ' + parser.getText());
                                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&(parser.getText() == 'message')) {
                                    parser.nextToken();
                                    con.MessageError__c = parser.getText();
                                    con.IsSendEverbridge__c = false;
                                    lstContacts.add(con);
                                }
                            }
                        }
                    }
                }else{
                    con.IsSendEverbridge__c = false;
                    lstContacts.add(con);
                }
            }
        }
        ApexUtil.isTriggerInvoked = true;
        Update lstContacts;
        ApexUtil.isTriggerInvoked = false;

    }
    global void finish(Database.BatchableContext BC){
		if(lstCircuitRelationShip.size()>0 && nextBatch){
            Database.executeBatch(New UpdateRelationiCircuitBatch(lstCircuitRelationShip),1);
        }
    }
}