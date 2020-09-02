trigger UpdateChildCommunicationLog on Communication_Log__c (before update, after update) {
    if(ApexUtil.isTriggerInvoked == false){
        if(Trigger.isBefore) {
            for(Communication_Log__c comm: Trigger.New) {
                if(comm.Communication_Log_Type__c == 'CPUC Reporting') {
                    if(comm.Complaint_Briefing__c==null || comm.Complaint_Briefing__c=='' || comm.Official_Comments__c==null || comm.Official_Comments__c=='' || comm.Official_Follow_up__c==null || comm.Official_Follow_up__c=='') {
                        comm.addError('The "Complaint/Briefing", "Official Comments" and "Official Follow-up" fields are required');
                    }
                }
                comm.NotUpdateRecord__c=false;
            }
        }
    
    	if(Trigger.isAfter){
            Set<Id> idsMaster = new Set<Id>();
            for(Communication_Log__c comm: Trigger.New) {
                if(comm.NotUpdateRecord__c==false) {
                    if(comm.Master_Communication_Log__c!=null) idsMaster.add(comm.Master_Communication_Log__c);
                    else idsMaster.add(comm.Id);
                }
            }

            Map<Id, Communication_Log__c> mapCommUpdate = new Map<Id, Communication_Log__c>();
            for(Communication_Log__c commAux : [SELECT Id, Name, Master_Communication_Log__c, Organization_Name__c, Contact_Name__c, Activity_Name__c, Project_Name__c FROM Communication_Log__c WHERE Master_Communication_Log__c IN : idsMaster OR Id IN : idsMaster]) {
                system.debug('##---Aux: '+commAux.Name);
                for(Communication_Log__c comm: Trigger.New) {
                    system.debug('##commAux.Master_Communication_Log__c: '+commAux.Master_Communication_Log__c);
                    if(commAux.Master_Communication_Log__c==null) {
                        system.debug('##1xx');
                        if(comm.Id!=commAux.Id && commAux.Id==comm.Master_Communication_Log__c) {
                            Communication_Log__c commClone = new Communication_Log__c();
                            commClone=comm.clone();
                            commClone.Id=commAux.Id;
                            commClone.Master_Communication_Log__c=commAux.Master_Communication_Log__c;
                            commClone.Contact_Name__c=commAux.Contact_Name__c;
                            commClone.Activity_Name__c=commAux.Activity_Name__c;
                            commClone.Project_Name__c=commAux.Project_Name__c;
                            commClone.Organization_Name__c=commAux.Organization_Name__c;
                            commClone.NotUpdateRecord__c=true;
                            mapCommUpdate.put(commClone.Id, commClone);
                        }
                    }
                    else {
                        system.debug('##comm.Master_Communication_Log__c: '+comm.Master_Communication_Log__c);
                        system.debug('##commAux.Master_Communication_Log__c: '+commAux.Master_Communication_Log__c);
                        if(comm.Master_Communication_Log__c==null) {
                            system.debug('##2xx');
                            if(comm.Id!=commAux.Id && commAux.Master_Communication_Log__c==comm.Id) {
                                Communication_Log__c commClone = new Communication_Log__c();
                                commClone=comm.clone();
                                commClone.Id=commAux.Id;
                                commClone.Master_Communication_Log__c=comm.Id;
                                commClone.Contact_Name__c=commAux.Contact_Name__c;
                                commClone.Activity_Name__c=commAux.Activity_Name__c;
                                commClone.Project_Name__c=commAux.Project_Name__c;
                                commClone.Organization_Name__c=commAux.Organization_Name__c;
                                commClone.NotUpdateRecord__c=true;
                                mapCommUpdate.put(commClone.Id, commClone);
                            }
                        }
                        else {
                            if(comm.Id!=commAux.Id && commAux.Master_Communication_Log__c==comm.Master_Communication_Log__c) {
                                system.debug('##3xx');
                                Communication_Log__c commClone = new Communication_Log__c();
                                commClone=comm.clone();
                                commClone.Id=commAux.Id;
                                commClone.Master_Communication_Log__c=commAux.Master_Communication_Log__c;
                                commClone.Contact_Name__c=commAux.Contact_Name__c;
                                commClone.Activity_Name__c=commAux.Activity_Name__c;
                                commClone.Project_Name__c=commAux.Project_Name__c;
                                commClone.Organization_Name__c=commAux.Organization_Name__c;
                                commClone.NotUpdateRecord__c=true;
                                mapCommUpdate.put(commClone.Id, commClone);
                            }
                        }
                    }
                }
            }

            if(mapCommUpdate.size()>0){
                ApexUtil.isTriggerInvoked = true;
                update mapCommUpdate.values();
                ApexUtil.isTriggerInvoked = false;
            }
        }
    }
}