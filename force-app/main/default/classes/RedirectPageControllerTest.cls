@isTest
private class RedirectPageControllerTest {
    @istest static void test(){
        Communication_Log__c cl = [select Id, title__c, activity__c, redirect_on_save__c from Communication_Log__c limit 1];
        PageReference pageRef = new PageReference('/'+cl.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(cl);
        RedirectPageController rpc = new RedirectPageController(sc);
        rpc.redirect();
    }
    @isTest static void triggertest(){
        Communication_Log__c cl = [select Id, addToMasterCalendar__c,Event_Subject__c,Event_Start_date_time__c,Event_End_date_time__c,Title__c from Communication_Log__c limit 1];
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
        insert ev;
        
        cl.addToMasterCalendar__c = false;
        update cl;
        cl.addToMasterCalendar__c = true;
        update cl;
        cl.addToMasterCalendar__c = true;
        update cl;
        
    }
    
    @isTest static void test2(){
        Communication_Log__c cl = [select Id, title__c, activity__c, redirect_on_save__c from Communication_Log__c limit 1];
        PageReference pageRef = new PageReference('https://na34.salesforce.com?Id='+cl.Activity__c);
        Test.setCurrentPage(pageRef);
        CreateCommController rpc = new CreateCommController();
        rpc.CreatecommLog();

    }
    
    @isTest static void test3(){
        Activity__c act = [select Id from Activity__c limit 1];
        PageReference pageRef = new PageReference('https://na34.salesforce.com?Id='+act.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(act);
        CreateEventController rpc = new CreateEventController(sc);
        rpc.CreateEvent();
    }
    
    @testSetup static void config(){
        Account acc = new Account();
        acc.name = 'test';
        insert acc;
        Contact con = new Contact();
        con.firstname = 'test';
        con.lastname = 'test';
        con.AccountId = acc.Id;
        insert con;
        Activity__c act = new Activity__c();
       	act.Account__c = acc.Id;
        act.Name ='test';
 		act.Type__c = 'Charitable';
        act.Contact_Name__c = con.Id;
        act.Event_Date__c = date.parse('2/18/2019');
        act.Description__c = 'test';
        act.Requested_Amount__c = 10;
        act.Detailed_Description__c = 'tst';
        act.Activity_Type__c = 'Issue';
        act.Referred_from_a_Govt_Official__c = 'Yes';
        act.Intake_Assessment_Level__c = 'Further Assessment Complete';
        act.Who_has_primary_responsibility__c = 'IT';
        act.Type_of_Referral__c ='External Stakeholder';
        act.Safety__c = 'Low';
        act.Compounding_issue__c = 'test';
        act.Reliability__c = 'Low';
        act.From_an_Elected_Official_Office__c = 'Yes';
        act.Further_Assessment_Level__c = null;
        act.Activity_Level__c = null;
        insert act;        
        Communication_Log__c cl = new Communication_Log__c();
        cl.Title__c = 'test';
        cl.addToMasterCalendar__c = true;
        cl.Activity__c = act.Id;
        cl.Redirect_on_Save__c = true;
        insert cl;

    }
}