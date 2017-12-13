@isTest
private class TestCompensationController {

	@isTest static void testCompensationsController() {
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

        List<Compensation__c> everyCompensation = CompensationsController.getCompensations('all',null, null);

        System.assert(everyCompensation.size() > 0);

        String contactId = newContact.Id;
        List<Compensation__c> everyCompensationContact = CompensationsController.getCompensations('all', contactId, null);
        for (integer i = 0; i<everyCompensationContact.size(); i++){
            System.assertEquals(everyCompensationContact[i].RecordTypeId, rt.Id);
        }
        List<Compensation__c> StudyComepensation = CompensationsController.getCompensations('Study', contactId, null);
        for (integer i = 0; i<StudyComepensation.size(); i++){
            System.assertEquals(StudyComepensation[i].RecordTypeId, rt.Id);
        }

        List<Compensation__c> compensations = CompensationsController.getCompensations('all', contactId, 'all');
        System.assert(compensations.size() > 0);

        List<Compensation__c> compensationsn = CompensationsController.getCompensations('all', null, 'all');
        System.assert(compensationsn.size() > 0);

        List<Compensation__c> compensationsnm = CompensationsController.getCompensations('Study', null, 'Not Submitted');
        System.assert(compensationsnm.size() > 0);

        List<Compensation__c> compensationsnmn = CompensationsController.getCompensations('Study', null, 'all');
        System.assert(compensationsnmn.size() > 0);

        List<Compensation__c> compensationsnmni = CompensationsController.getCompensations('Study', contactId, 'all');
        System.assert(compensationsnmni.size() > 0);






	}
    @isTest static void testSetCompensationsAsSubmittedController() {
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

        Compensation__c comp = new Compensation__c(Name='Unit test Compensation not submitted',
                                                  Contact__c = newContact.Id,
                                                   RecordTypeId = rt.Id,
                                                  Location__c = 'Uruguay',
                                                   Submitted__c = false,
                                                   Office__c = 'MVD WTC 2',
                                                   Job_Category__c = 'Junior',
                                                   Status__c = 'NOT SUBMITTED'
                                                  );
        insert comp;

        //Compensation__c listCompId = [SELECT Id from Compensation__c WHERE Name = 'Unit test Compensation not submitted' LIMIT 1];
        List<String> compId = new List<String>();
        compId.add(comp.Id);

        Test.startTest();
        CompensationsController.setCompensationsAsSubmitted(compId);
        Test.stopTest();

        comp = [SELECT Id,Submitted__c FROM Compensation__c WHERE Id = :comp.Id LIMIT 1];
        System.assertEquals(true, comp.Submitted__c);




    }
    @isTest static void testBatch() {
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

        //Compensation__c[] compList = new List<Compensation__c>();
        for (Integer i=0;i<20;i++) {
            Compensation__c c = new Compensation__c(Name='Compensation' + i,
                                                    Contact__c = newContact.Id,
                                                    RecordTypeId = rt.Id,
                                                    Location__c = 'Uruguay',
                                                    Submitted__c = false,
                                                    Office__c = 'MVD WTC 2',
                                                    Job_Category__c = 'Junior',
                                                    Status__c = 'NOT SUBMITTED'
                                                   );
            	insert c;
            	Test.setCreatedDate(c.Id, DateTime.newInstance(2017,11,11));

        }


        Test.startTest();
        String query = 'SELECT Id FROM Compensation__c WHERE Submitted__c = false AND CreatedDate < LAST_N_DAYS:2';
        AutomaticallySubmitCompensations submBatch = new AutomaticallySubmitCompensations(query);
        Database.ExecuteBatch(submBatch);
        Test.stopTest();


        Compensation__c[] comUpdatedList = [SELECT Id,Submitted__c FROM Compensation__c];
        System.assertEquals(true, comUpdatedList[0].Submitted__c);
    }


}
