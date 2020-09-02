/**
 * Created by AF @CloudCreations on 01/18/2019.
 */

public with sharing class RedirectPageController {
    private ApexPages.StandardController stdCtrl;
    private Communication_Log__c communicationLog;
    public String redirectUrl { get; set; }
    public Integer flag { get; set; }
    public RedirectPageController(ApexPages.StandardController stdController) {
        flag = 0;
        this.stdCtrl = stdController;
        this.communicationLog = (Communication_Log__c) stdController.getRecord();
    }
    public void redirect() {
        redirectUrl = '/apex/VFP_RelatedMultipleRecords?newid=' + communicationLog.Id + '&recordOrigin=' + communicationLog.Id;
        if (communicationLog != null) {
            if (communicationLog.Redirect_on_Save__c != null && communicationLog.Redirect_on_Save__c == true) {
                flag = 1;
                communicationLog.Redirect_on_Save__c = false;
                ApexUtil.isRecordRedirected = true;
                update communicationLog;
            } else {
            }
        }
    }
}