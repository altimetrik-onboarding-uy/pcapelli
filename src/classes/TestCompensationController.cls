@isTest
private class TestCompensationController {

	@isTest static void test_method_one() {
        Account newAccount = new Account(Name = 'AcName',
        BillingCity ='TestCity',
        BillingCountry ='TestCountry',
        BillingStreet ='TestStreet',
        BillingPostalCode ='t3stcd3'
        );

        insert newAccount;

        Contact NewContact = new Contact (
        FirstName = 'Unit',
        LastName = 'Test',
        AccountId = newAccount.Id,
        Email = 'xyzmail@mail.com'
        );

        insert newContact;

        RecordType rt = [SELECT Id from RecordType WHERE Name = 'Study' LIMIT 1];

        Compensation__c comp = new Compensation__c(Name=' Unit test Compensation',
                                                  Contact__c = newContact.Id,
                                                   RecordTypeId = rt.Id,
                                                  Location__c = 'Uruguay',
                                                   Office__c = 'MVD WTC 2',
                                                   Job_Category__c = 'Junior',
                                                   Status__c = 'SUBMITTED'
                                                  );
        insert comp;

        List<Compensation__c> everyCompensation = CompensationsController.getCompensations('all',null);

        System.assert(everyCompensation.size() > 0);

        String contactId = newContact.Id;
        List<Compensation__c> everyCompensationContact = CompensationsController.getCompensations('all', contactId);
        for (integer i = 0; i<everyCompensationContact.size(); i++){
            System.assertEquals(everyCompensationContact[i].RecordTypeId, rt.Id);
        }
        List<Compensation__c> StudyComepensation = CompensationsController.getCompensations('Study', contactId);
        for (integer i = 0; i<StudyComepensation.size(); i++){
            System.assertEquals(StudyComepensation[i].RecordTypeId, rt.Id);
        }

        List<Compensation__c> compensations = CompensationsController.getCompensations(null, null);
        System.assert(compensations.size() > 0);





	}


}
