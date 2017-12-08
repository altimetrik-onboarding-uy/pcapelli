public with sharing class CompensationsController {

	@AuraEnabled
	public static List<Compensation__c> getCompensations(String recordType, String contactId) {
        System.debug(recordType);
        System.debug(contactId);
        if (recordType == 'all'){
            if (contactId != null){
                return [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE Contact__r.Id =:contactId];
            }
            return [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c];
        }else{
            if (contactId != null){
                return [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType AND Contact__r.Id =:contactId];
            }
            return [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType];

        }

    }
	}
