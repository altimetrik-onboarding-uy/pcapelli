global class AutomaticallySubmitCompensations implements Database.Batchable<sObject> {

	String query;

	global AutomaticallySubmitCompensations(String q) {
        Query=q;
	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Compensation__c> scope) {
        for(Compensation__c c : scope)
        {
            c.Submitted__c = true;
            c.Status__c = 'SUBMITTED';
        }
        update scope;

	}

	global void finish(Database.BatchableContext BC) {

	}

}
