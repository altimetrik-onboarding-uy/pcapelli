public with sharing class CompensationsController {

	@AuraEnabled
	public static List<Compensation__c> getCompensations(String recordType, String contactId) {

        List<Compensation__c> comps = new List<Compensation__c>();


        if (recordType == 'all'){
            if (contactId != null){
                for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE Contact__r.Id =:contactId]) {
                                comps.addAll(com);
                            }
                return comps;
            }
            for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c]) {
                                comps.addAll(com);
                            }
            return comps;
        }else{
            if (contactId != null){
                for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType AND Contact__r.Id =:contactId]) {
                                comps.addAll(com);
                            }
            	return comps;
            }
            for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType]) {
                                comps.addAll(com);
                            }
            	return comps;

        }

    }
	}
