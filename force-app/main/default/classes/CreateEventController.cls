public class CreateEventController {
    public Activity__c act {get; set;}
    public Id ActivityId { get; set;}
    public Event eve {get; set;}
    public CreateEventController(ApexPages.StandardController controller) {
        act =  (Activity__c) controller.getRecord();
        ActivityId = act.Id;
        eve = new Event();
    }

    public PageReference CreateEvent(){
        List<Activity__c> lstActivitys = [SELECT Id,Account__c,Contact_Name__c,Contact_Name__r.Name,Account__r.Name, Type__c, Event_Date__c,Description__c,OwnerId, Owner.Name FROM Activity__c WHERE Id =: ActivityId];
        if(lstActivitys.get(0).Account__r.Name!=null){
            eve.Subject = lstActivitys.get(0).Account__r.Name + ' ' + lstActivitys.get(0).Type__c+' '+ 'Event';
        }else{
            eve.Subject = lstActivitys.get(0).Type__c+' '+ 'Event';
        }

        String StartDate;
        String StartHour;
        String ContactName;
        String EndHour;
        if(lstActivitys.get(0).Event_Date__c!=null){
            Integer month = lstActivitys.get(0).Event_Date__c.month();
            Integer year = lstActivitys.get(0).Event_Date__c.year();
            Integer day = lstActivitys.get(0).Event_Date__c.day();
            StartDate = month+'/'+day+'/'+year;
            Integer hour = System.now().hour();
            Integer hour2 = System.now().hour();

            Datetime CurrencyHourStart = System.now().Addhours(1);
            Datetime CurrencyHourEnd = System.now().Addhours(2);

            String myHourStart = CurrencyHourStart.format('h:m a');
            String myHourEnd = CurrencyHourEnd.format('h:m a');

            String HoraStart = myHourStart.substring(0,myHourStart.indexOf(':'));
            String meridiaStart = myHourStart.right(2);

            String HoraEnd = myHourEnd.substring(0,myHourEnd.indexOf(':'));
            String meridiaEnd = myHourEnd.right(2);

            StartHour = HoraStart + ':00 ' + meridiaStart;
            EndHour = HoraEnd + ':00 ' + meridiaEnd;
        }
        if(lstActivitys.get(0).Description__c!=null) {
            eve.Description = lstActivitys.get(0).Description__c;
        }else {
            eve.Description = '';
        }
        eve.OwnerId = lstActivitys.get(0).OwnerId;
        eve.WhatId = lstActivitys.get(0).Id;

        if(lstActivitys.get(0).Contact_Name__r.Name!=null){
            ContactName = lstActivitys.get(0).Contact_Name__r.Name;
        }else{
            ContactName = '';
        }

        String urlEvent = 'https://na34.salesforce.com/00U/e?retURL=%2F'+lstActivitys.get(0).Id;

        if(eve.WhatId!=null)urlEvent = urlEvent + '&what_id=' + eve.WhatId;
        if(eve.OwnerId!=null)urlEvent = urlEvent + '&evt1_lkid=0231F000001D1Rz'+'&evt1=LPA Master Calendar';
        if(eve.Description!=null)urlEvent = urlEvent + '&evt6=' + eve.Description;
        if(lstActivitys.get(0).Event_Date__c!=null)urlEvent=urlEvent+ '&StartDateTime='+StartDate+
                '&StartDateTime_time='+StartHour+'&EndDateTime='+StartDate+'&EndDateTime_time='+EndHour;
        if(eve.Subject!=null)urlEvent=urlEvent+ '&evt5='+eve.Subject;
        if(lstActivitys.get(0).Account__r.Name!=null) urlEvent=urlEvent+'&CF00N6100000ClmNF='+lstActivitys.get(0).Account__r.Name;
        if(ContactName!=null) urlEvent=urlEvent+'&evt2='+ContactName;
        if(lstActivitys.get(0).Contact_Name__c!=null) urlEvent = urlEvent +'&evt2_lkid='+lstActivitys.get(0).Contact_Name__c;
        PageReference pageRef = new PageReference(urlEvent);
        return pageRef;

        /*PageReference pageRef = null;
        if(StartHour!=null && EndHour!=null){
            pageRef = new PageReference('https://cs90.salesforce.com/00U/e?retURL=%2F'+lstActivitys.get(0).Id+'&what_id='+eve.WhatId+'&evt1_lkid='+
                    String.valueOf(eve.OwnerId).SubString(0,15)+'&evt1='+lstActivitys.get(0).Owner.Name+'&evt6='+eve.Description+'&StartDateTime='+StartDate+
                    '&StartDateTime_time='+StartHour+'&EndDateTime='+StartDate+'&EndDateTime_time='+EndHour+'&evt5='+eve.Subject+'&CF00N6100000ClmNF='+
                    lstActivitys.get(0).Account__r.Name+'&CF00N6100000ClmNF_lkid='+lstActivitys.get(0).Account__c+'&evt2='+ContactName+
                    '&evt2_lkid='+lstActivitys.get(0).Contact_Name__c);
        }else{
            pageRef = new PageReference('https://cs90.salesforce.com/00U/e?retURL=%2F'+lstActivitys.get(0).Id+'&what_id='+eve.WhatId+'&evt1_lkid='+
                    String.valueOf(eve.OwnerId).SubString(0,15)+'&evt1='+lstActivitys.get(0).Owner.Name+'&evt6='+eve.Description+
                    '&evt5='+eve.Subject+'&CF00N6100000ClmNF='+
                    lstActivitys.get(0).Account__r.Name+'&CF00N6100000ClmNF_lkid='+lstActivitys.get(0).Account__c+'&evt2='+ContactName+
                    '&evt2_lkid='+lstActivitys.get(0).Contact_Name__c);
        }

        pageRef.setRedirect(true);
        return pageRef;*/
        //return null;
    }
}