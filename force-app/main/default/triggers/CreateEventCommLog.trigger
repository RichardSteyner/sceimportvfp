trigger CreateEventCommLog on Communication_Log__c (after insert, after update) {
    List<Event>lstEvents = new List<Event>();
    Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
    if(Trigger.isInsert){
        
        Map<String, Id> mapRecordType = new Map<String, Id>();
    
        for (RecordType rt : [SELECT Id, Name FROM RecordType WHERE SobjectType = :'Activity__c' AND Name = :'Contributions']) {
            mapRecordType.put(rt.Name, rt.Id);
        }
    
        Set<Id> setRelatedActIds = new Set<Id>();
        for (Communication_Log__c cl : Trigger.new) {
            setRelatedActIds.add(cl.Activity__c);
        }
    
        Map<String, String> mapRecordTypes = new Map<String, String>();
        for (Activity__c act : [SELECT Id, RecordTypeId FROM Activity__c WHERE Id IN:setRelatedActIds]) {
            mapRecordTypes.put(act.Id, act.RecordTypeId);
        }
    
        for (Communication_Log__c cl : Trigger.new) {
            //if(mapRecordTypes.get(cl.Activity__c) == mapRecordType.get('Contributions')){
            //if(cl.Activity__c!=null){
            if(cl.addToMasterCalendar__c == true){
                Event ev = new Event();
                ev.Subject = cl.Event_Subject__c;
                if (cl.Event_Start_date_time__c != null) {
                    ev.StartDateTime = cl.Event_Start_date_time__c;
                } else {
                    ev.StartDateTime = System.now();
                }
                if (cl.Event_End_date_time__c != null) {
                    ev.EndDateTime = cl.Event_End_date_time__c;
                } else {
                    ev.EndDateTime = System.now();
                }
                ev.Description = cl.Title__c;
                ev.WhatId = cl.Id;
                ev.Meeting_Type__c = cl.Meeting_Type__c;
                if(isSandbox){
                    ev.OwnerId = '0231F000001D1Rz';
                }else{
                    ev.OwnerId = '02361000002zyjd';
                }
                
                /*if(ev.Meeting_Type__c=='Internal'){
                    ev.OwnerId = '0231F000001Vq49';
                }else if(ev.Meeting_Type__c=='External'){
                    ev.OwnerId = '0231F000001Vq4E';
                }*/
                //ev.WhatId = cl.Activity__c;
        
                //ev.OwnerId = UserInfo.getUserId();
                //ev.Description = act.Description__c;
                //ev.Meeting_Type__c = act.Meeting_Type__c;
                //ev.WhoId = act.Contact_Name__c;
                //ev.WhatId = act.Account__c;
                //ev.Organization__c = act.Account__c;
                
                //}
                //}
                lstEvents.add(ev);
            }
            
        }
    
        
    }else{
        if(Trigger.isUpdate){
            Set<Id> setev = new Set<Id>();
            for(Communication_Log__c cl : Trigger.New){
                setev.add(cl.Id);
            }
            List<Event> lstEv = [select id,whatid from Event where whatid IN : setev];
            List<Event> deleteEv  = new List<Event>();
            for(Communication_Log__c cl : Trigger.New){
                if(!cl.addToMasterCalendar__c){
                    for(Event evt : lstEv){
                        if(cl.Id == evt.WhatId){
                            deleteEv.add(evt);
                        }
                    }
                }else{
                    Boolean flag = false;
                    for(Event evt : lstEv){
                        if(cl.Id == evt.WhatId){
                            flag = true;
                        }
                    }
                    system.debug('>>>>Add MAster Calendar>>>');
                    if(!flag){
                        Event ev = new Event();
                        ev.Subject = cl.Event_Subject__c;
                        if (cl.Event_Start_date_time__c != null) {
                            ev.StartDateTime = cl.Event_Start_date_time__c;
                        } else {
                            ev.StartDateTime = System.now();
                        }
                        if (cl.Event_End_date_time__c != null) {
                            ev.EndDateTime = cl.Event_End_date_time__c;
                        } else {
                            ev.EndDateTime = System.now();
                        }
                        ev.Description = cl.Title__c;
                        ev.WhatId = cl.Id;
                        ev.Meeting_Type__c = cl.Meeting_Type__c;
                        
                        if(isSandbox){
                            ev.OwnerId = '0231F000001D1Rz';
                        }else{
                            ev.OwnerId = '02361000002zyjd';
                        }
                        lstEvents.add(ev);
                        system.debug('>>>>Added>>>'+ev);
                    }
                    
               	}
                
            }
            if(deleteEv.size()>0){
                delete deleteEv;
            }
            
        }
    }
    
    if (lstEvents.size() > 0) {
        try {
            insert lstEvents;
            System.debug('########### Trigger - LstEvents : ' + lstEvents);
        } catch (DmlException e) {
            System.debug('Trigger debug createAppointment | DmlException caught: \n' + e.getMessage());
        } catch (SObjectException e) {
            System.debug('Trigger debug createAppointment | SObjectException caught: \n' + e.getMessage());
        } catch (Exception e) {
            System.debug('Trigger debug createAppointment | Exception caught: \n' + e.getMessage());
        }
    }
}