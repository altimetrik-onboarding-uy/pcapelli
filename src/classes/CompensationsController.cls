public with sharing class CompensationsController {

	@AuraEnabled
	public static List<Compensation__c> getCompensations(String recordType, String contactId, String submittedValue) {
        System.debug(recordType);
        System.debug(submittedValue);


        List<Compensation__c> comps = new List<Compensation__c>();


        if (recordType == 'all' && submittedValue == 'all'){
            if (contactId != null){
                for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE Contact__r.Id =:contactId  LIMIT 50000]) {
                                comps.addAll(com);
                            }
                return comps;
            }
            for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c  LIMIT 50000]) {
                                comps.addAll(com);
                            }
            return comps;

        }else{
            Boolean submitted = true;
            if (submittedValue != 'Submitted'){
                submitted = false;
            }
            if (recordType == 'all' && submittedValue != 'all'){
                if (contactId != null){
                    for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE  Contact__r.Id =:contactId AND Submitted__c =:submitted LIMIT 50000]) {
                        comps.addAll(com);
                    }
                    return comps;
                }else{
                    for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE  Submitted__c =:submitted LIMIT 50000]) {
                        comps.addAll(com);
                    }
                    return comps;
                }
            }
            if (submittedValue == 'all'){
                System.debug('entre');
                if (contactId != null){
                    for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType AND Contact__r.Id =:contactId LIMIT 50000]) {
                        comps.addAll(com);
                    }
                    return comps;
                }
                for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType LIMIT 50000]) {
                    comps.addAll(com);
                }
                return comps;


            }
            if (contactId != null){
                    for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType AND Submitted__c =:submitted AND Contact__r.Id =:contactId LIMIT 50000]) {
                        comps.addAll(com);
                    }
                    return comps;
                }

            for (List<Compensation__c> com : [SELECT Id, Name, Contact__r.Id, Contact__r.Name, Contact__r.Birthdate, Job_Category__c, RecordType.Name, Amount__c, Location__c, Office__c, Submitted__c, Status__c FROM Compensation__c WHERE RecordType.Name=:recordType AND Submitted__c =:submitted LIMIT 50000]) {
                        comps.addAll(com);
                    }
                    return comps;


        }

    }



    @AuraEnabled
    public static void setCompensationsAsSubmitted(List < String > recordIdToSubmit) {
        List<Compensation__c> compensations = [SELECT Id FROM Compensation__c WHERE Id IN :recordIdToSubmit];

        for (Compensation__c compensation : compensations){
            compensation.Submitted__c = true;
            compensation.Status__c = 'SUBMITTED';
        }
        update compensations;
        for (Compensation__c compensation : compensations){
            System.debug('Compensation Id dentro del metodo'+compensation.Submitted__c);
        }
        }




	}
