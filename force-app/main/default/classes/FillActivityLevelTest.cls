@isTest
private class FillActivityLevelTest {

    static testMethod void myUnitTest() {
        Activity__c ac = new Activity__c();
        ac.Name = 'Test';
        ac.Safety__c = 'High';
        ac.Reliability__c = 'Medium';
        ac.Financial__c = 'Low';
        ac.Environmental__c = 'Medium';
        ac.Compliance__c = 'Medium';
        ac.How_soon_is_stakeholder_impact__c= '1-3 months';
        ac.How_soon_must_LPA_respond__c = '3-6 months';
        ac.More_than_one_jurisdiction_involved__c = 'No';
        ac.Past_Issue__c = 'Yes';
        ac.Compounding_issue__c = 'No';
        insert ac;
        
        ac.Safety__c = 'High';
        ac.Reliability__c = 'High';
        ac.Financial__c = 'Medium';
        ac.Environmental__c = 'High';
        ac.Compliance__c = 'Medium';
        ac.How_soon_is_stakeholder_impact__c= '6-12 months';
        ac.How_soon_must_LPA_respond__c = '1-3 months';
        ac.More_than_one_jurisdiction_involved__c = 'Yes';
        ac.Past_Issue__c = 'No';
        ac.Compounding_issue__c = 'Yes';
        update ac;
        
        ac.Safety__c = 'High';
        ac.Reliability__c = 'High';
        ac.Financial__c = 'High';
        ac.Environmental__c = 'High';
        ac.Compliance__c = 'High';
        ac.How_soon_is_stakeholder_impact__c= '1-7 days';
        ac.How_soon_must_LPA_respond__c = '1-3 months';
        ac.More_than_one_jurisdiction_involved__c = 'Yes';
        ac.Past_Issue__c = 'Yes';
        ac.Compounding_issue__c = 'Yes';
        update ac;
        
        ac.Safety__c = 'High';
        ac.Reliability__c = 'Medium';
        ac.Financial__c = 'Low';
        ac.Environmental__c = 'High';
        ac.Compliance__c = 'Medium';
        ac.How_soon_is_stakeholder_impact__c= '1 Year or longer';
        ac.How_soon_must_LPA_respond__c = '1-3 months';
        ac.More_than_one_jurisdiction_involved__c = 'Yes';
        ac.Past_Issue__c = 'Yes';
        ac.Compounding_issue__c = 'Yes';
        update ac;
        
        ac.Safety__c = 'Low';
        ac.Reliability__c = 'Low';
        ac.Financial__c = 'Low';
        ac.Environmental__c = 'Low';
        ac.Compliance__c = 'Low';
        ac.How_soon_is_stakeholder_impact__c= '1 Year or longer';
        ac.How_soon_must_LPA_respond__c = '1 Year or longer';
        ac.More_than_one_jurisdiction_involved__c = 'No';
        ac.Past_Issue__c = 'No';
        ac.Compounding_issue__c = 'Yes';
        update ac;
        
         ac.Safety__c = 'Low';
        ac.Reliability__c = 'Low';
        ac.Financial__c = 'Low';
        ac.Environmental__c = 'Low';
        ac.Compliance__c = 'Low';
        ac.How_soon_is_stakeholder_impact__c= '1 Year or longer';
        ac.How_soon_must_LPA_respond__c = '6-12 months';
        ac.Compounding_issue__c = 'Yes';
        ac.More_than_one_jurisdiction_involved__c = 'Yes';
        ac.Past_Issue__c = 'Yes';
        update ac;
    }
}