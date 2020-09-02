trigger FillActivityLevel on Activity__c (before insert, before update) {
	for(Activity__c ac : trigger.new){
		if(ac.Final_Score__c>0 && ac.Final_Score__c<1.2){
			ac.Activity_Level__c = 'No Action/Monitor';
		}
		else if(ac.Final_Score__c>1.2 && ac.Final_Score__c<2.2){
			ac.Activity_Level__c = 'Monitor';
		}
		else if(ac.Final_Score__c>2.2 && ac.Final_Score__c<3.5){
			ac.Activity_Level__c = 'Consult - Monitor';
		}
		else if(ac.Final_Score__c>3.5 && ac.Final_Score__c<4.4){
			ac.Activity_Level__c = 'Support Other OU with AGAR';
		}
		else if(ac.Final_Score__c>4.4 && ac.Final_Score__c<7){
			ac.Activity_Level__c = 'Support Other OU with LPA Project Manager';
		}		
		else if(ac.Final_Score__c>7){
			ac.Activity_Level__c = 'LPA Owns - LPA Project Manager';
		}
	}
}