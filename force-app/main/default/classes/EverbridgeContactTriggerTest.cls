@isTest
public class EverbridgeContactTriggerTest {
    static testMethod void Method001(){
        Account acc = new Account(name='Cloud Creations',Organization_County__c='Kern', BillingCity='Opelika');
        insert acc;

        Contact con = new Contact(firstName='Juan', LastName='Peréz', middlename='C', MailingStreet='Street', MailingCity='Opelika', MailingCountry='US',
                MailingState='AL',MailingPostalCode='36801',Email='bvalenzuela@cloudcreations.com', Phone='(213) 595-7880',MobilePhone='(213) 595-7880',Emergency_Contact__c=true,
                SCE_Alert__c=true, Rotating_Outage_Contact__c=false, PSPS__c=false, Role_s_In_Organization__c='Mayor',Sync_with_Everbridge__c=true, title='Mr',AccountId = acc.Id);
        insert con;
    }

    @istest Static void Method002(){
        Account acc = new Account(name='Cloud Creations',Organization_County__c='Kern', BillingCity='Opelika');
        insert acc;

        Contact con = new Contact(firstName='Juan', LastName='Peréz', middlename='C', MailingStreet='Street', MailingCity='Opelika', MailingCountry='US',
                MailingState='AL',MailingPostalCode='36801',Email='bvalenzuela@cloudcreations.com', Phone='(213) 595-7880',MobilePhone='(213) 595-7880',Emergency_Contact__c=true,
                SCE_Alert__c=true, Rotating_Outage_Contact__c=false, PSPS__c=false, Role_s_In_Organization__c='Mayor',Sync_with_Everbridge__c=true, title='Mr', AccountId = acc.Id);
        insert con;
        Test.startTest();
        system.Test.setMock(HttpCalloutMock.class, new EverbridgeMockImplementation());
        Database.executeBatch(new SyncEverbridgeBatch(),1);
        Test.stopTest();
    }

    @istest Static void Method003(){
        Account acc = new Account(name='Cloud Creations',Organization_County__c='Kern', BillingCity='Opelika');
        insert acc;

        Contact con = new Contact(firstName='Juan', LastName='Peréz', middlename='C', MailingStreet='Street', MailingCity='Opelika', MailingCountry='US',
                MailingState='AL',MailingPostalCode='36801',Email='bvalenzuela@cloudcreations.com', Phone='(213) 595-7880',MobilePhone='(213) 595-7880',Emergency_Contact__c=false,
                SCE_Alert__c=false, Rotating_Outage_Contact__c=false, PSPS__c=false, Role_s_In_Organization__c='Mayor',Sync_with_Everbridge__c=false, AccountId = acc.Id, title='Mr', ExternalID__c='7973666914587017');
        insert con;

        con.Sync_with_Everbridge__c = true;
        con.Active_Former__c = 'Former';
        update con;
    }

    @istest Static void Method004(){
        Circuit__c c = new Circuit__c(Name = 'CircuitTest');
        insert c;
    }
}