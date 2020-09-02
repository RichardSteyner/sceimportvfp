public class CreateCommController {
    public Activity__c act {get; set;}
    public Id ActivityId { get; set;}

    public CreateCommController(){
        ActivityId = ApexPages.currentPage().getParameters().get('Id');
    }

    public PageReference CreatecommLog(){
        List<Activity__c> lstActivitys = [SELECT Id,Account__c, Account__r.Name,Name,Activity_Name__c,
                                          Type__c,Contact_Name__c, Contact_Name__r.Name, Event_Date__c, Description__c,
                                          Requested_Amount__c,
                                          Detailed_Description__c,OwnerId,Realted_Activity__c, Activity_Type__c,
                                          RecordTypeId FROM Activity__c WHERE Id =: ActivityId];
        Communication_log__c commLog = new Communication_Log__c();
        //commLog.Breif_Description__c = lstActivitys.get(0).Name+' ' + 'Event';
        String BriefDescription = lstActivitys.get(0).Name+' ' + 'Event';
        String Subject ='';
        /*if(lstActivitys.get(0).Account__r.Name!=null){
            Subject = lstActivitys.get(0).Account__r.Name +' '+lstActivitys.get(0).Type__c + ' Event';
        }else if(lstActivitys.get(0).Type__c!=null){
            Subject = lstActivitys.get(0).Type__c + ' Event';
        }else{
            Subject = '';
        }*/
        Subject = lstActivitys.get(0).Name;
        String Account = '';
        String Contact = '';
        String AccountName = '';
        String ContactName = '';
        String brief_description = '';

        if(lstActivitys.get(0).Description__c!=null){
            brief_description = lstActivitys.get(0).Description__c;
        }

        if(lstActivitys.get(0).Account__c!=null){
            Account = lstActivitys.get(0).Account__c;
            AccountName = lstActivitys.get(0).Account__r.name;
        }

        if(lstActivitys.get(0).Contact_Name__c!=null){
            Contact = lstActivitys.get(0).Contact_Name__c;
            ContactName = lstActivitys.get(0).Contact_Name__r.Name;
        }
        //commLog.Event_Subject__c = lstActivitys.get(0).Account__r.Name +' '+lstActivitys.get(0).Type__c + 'Event';

               // Event_Start_Date_time__c =Activity__c.Activity__c.Event_Date__c
        String StartDate='';
       	Decimal requested_amount = 0.0;
        String StartHour='';
        String EndHour='';
        String startDateEvent='';
        String endDateEvent='';


        requested_amount = lstActivitys.get(0).Requested_Amount__c;


        if(lstActivitys.get(0).Event_Date__c!=null){
            /* Integer month = lstActivitys.get(0).Event_Date__c.month();
             Integer year = lstActivitys.get(0).Event_Date__c.year();
             Integer day = lstActivitys.get(0).Event_Date__c.day();
             Integer hour = System.now().hour();
             Integer minutes = System.now().minute();
             DateTime myDateTime;
             if(minutes>0){
                 myDateTime = DateTime.newInstance(year, month, day,hour+3,0,0);
             }else if(minutes==0){
                 myDateTime = DateTime.newInstance(year, month, day,hour+2,0,0);
             }
             Act.Event_Start_Date_time__c = myDateTime;
             Act.Event_End_date_time__c = myDateTime.AddHours(1);
             System.debug('***************Act.Event_Start_Date_time__c: ' + Act.Event_Start_Date_time__c);
             System.debug('***************Act.Event_End_date_time__c : ' + Act.Event_End_date_time__c );*/

            Integer month = lstActivitys.get(0).Event_Date__c.month();
            Integer year = lstActivitys.get(0).Event_Date__c.year();
            Integer day = lstActivitys.get(0).Event_Date__c.day();
            StartDate = month+'/'+day+'/'+year;

            String dtConveted = System.now().format('MM/dd/yyyy HH:mm a');


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
            //12
            /*if(hour>=0 && hour<12){
                StartHour = String.valueOf(hour) +':00 AM';
            }else if(hour>=24){
                if(hour-24 == 0){
                    hour = 0;
                }else{
                    hour = hour-24;
                }
                StartHour = String.valueOf(hour) + ':00 PM';
            }else{
                if(hour-12 == 0){
                    hour = 12;
                }else{
                    hour = hour-12;
                }
                StartHour = String.valueOf(hour) + ':00 PM';
            }*/
            //System.debug('**************** StartHour: ' + StartHour);
            /*hour2 = hour2+2;
            if(hour2>=0 && hour2<12){
                EndHour = String.valueOf(hour2) +':00 AM';
            }else{
                if(hour2-12 == 0){
                    hour2 = 0;
                }else{
                    hour2 = hour2-12;
                }
                EndHour = String.valueOf(hour2) + ':00 AM';
            }*/
            if(StartDate!=null && StartHour !=null){
                startDateEvent = StartDate +' ' + StartHour;
            }

            if(StartDate != null && EndHour != null){
                endDateEvent = StartDate + ' ' + EndHour;
            }
        }

        commLog.Event_Description__c = lstActivitys.get(0).Description__c;
        commLog.Contributions_Type__c = lstActivitys.get(0).Type__c;



        String UrlEvent= 'https://na34.salesforce.com/a0R/e?RecordType=01261000000SgVB&'; 
        if(AccountName!=null && AccountName!='') UrlEvent = UrlEvent + '&CF00N6100000Hjm1r='+AccountName;
        if(Account!=null && Account!='') UrlEvent = UrlEvent + '&CF00N6100000Hjm1r_lkid=' + Account;
        UrlEvent = UrlEvent + '&00N6100000HtLqf=' + 1;
        if(BriefDescription!=null && BriefDescription!='') UrlEvent = UrlEvent + '&00N6100000HtKpC='+ brief_description;
        if(ContactName!=null && ContactName!='') UrlEvent = UrlEvent + '&CF00N6100000Hjm1n='+ContactName;
        if(requested_amount!=0.0) UrlEvent = UrlEvent + '&00N6100000HtKrX='+requested_amount;
        if(Contact!=null && Contact!='') UrlEvent = UrlEvent + '&CF00N6100000Hjm1n_lkid='+Contact;
        if(Subject!=null) UrlEvent = UrlEvent + '&00N6100000HtKoi='+Subject;
        if(startDateEvent!=null) UrlEvent = UrlEvent + '&00N6100000HtKpM='+startDateEvent;
        if(endDateEvent!=null) UrlEvent = UrlEvent + '&00N6100000HtKpH='+endDateEvent;
 
        //if(lstActivitys.get(0).Description__c!=null && lstActivitys.get(0).Description__c!='') UrlEvent = UrlEvent + '&00N6100000HtKpC='+lstActivitys.get(0).Detailed_Description__c;
        if(lstActivitys.get(0).Type__c!=null && lstActivitys.get(0).Type__c!='') UrlEvent = UrlEvent + '&00N6100000HtKp7='+lstActivitys.get(0).Type__c;
        if(lstActivitys.get(0).Name!=null && lstActivitys.get(0).Name!='') UrlEvent = UrlEvent + '&CF00N6100000HjkWI='+lstActivitys.get(0).Name;
        if(lstActivitys.get(0).Id!=null) UrlEvent = UrlEvent + '&CF00N6100000HjkWI_lkid'+lstActivitys.get(0).Id;
        System.debug(UrlEvent);
        PageReference pageRef = new PageReference(UrlEvent);
        System.debug(pageRef);
        return pageRef;

//        Pagereference pageReference;
//        pageReference = new Pagereference('/apex/VFP_RelatedMultipleRecords?newid={!Communication_Log__c.Id}&recordOrigin={!Communication_Log__c.Id}&master={!Communication_Log__c.Master_Communication_Log__c}');
////        pageReference.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
//
//        pageReference.setredirect(true);
//        System.debug(pageReference);
//        return pageReference;


        /*PageReference pageRef = new PageReference('https://cs90.salesforce.com/a0R/e?retURL=%2F'+lstActivitys.get(0).Id+'&RecordType=0121F000000BLnj&'
        +'&CF00N6100000Hjm1r='+AccountName+'&CF00N6100000Hjm1r_lkid=' + Account+
        '&00N6100000Hjm1l='+ BriefDescription +'&CF00N6100000Hjm1n='+ContactName+'&CF00N6100000Hjm1n_lkid='+Contact+
        '&00N1F000001qA7L='+Subject+'&00N1F000001qA7Q='+startDateEvent+'&00N1F000001qA7V='+endDateEvent+'&00N1F000001qA7f='+lstActivitys.get(0).Description__c+
        '&00N1F000001qA7p='+lstActivitys.get(0).Type__c+'&CF00N6100000EnnVd='+lstActivitys.get(0).Name+'&CF00N6100000EnnVd_lkid'+lstActivitys.get(0).Id);
        pageRef.setRedirect(true);
        return pageRef;*/
    }
}