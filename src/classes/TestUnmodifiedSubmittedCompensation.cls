@isTest
private class TestUnmodifiedSubmittedCompensation {

	@isTest static void TestInsertCompensationStatusSubmitted() {

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

        Compensation__c comp = new Compensation__c(Name=' Unit test Compensation',
                                                  Contact__c = newContact.Id,
                                                  Location__c = 'Uruguay',
                                                   Office__c = 'MVD WTC 2',
                                                   Job_Category__c = 'Junior',
                                                   Submitted__c = true
                                                  );
        insert comp;

        String status;
        System.debug('ContactId' + newContact.Id);
        for(Compensation__c m:[SELECT Status__c FROM Compensation__c WHERE Id = :comp.Id]) {
               status = m.Status__c;
               System.debug( 'Submited'+ m.Status__c);
            }
        System.debug('Id' + comp.Id);
        System.debug('Status' + status);

        System.assertEquals('SUBMITTED', status);

        //comp.Job_Category__c = 'Senior';
        //update comp;

        Test.startTest();
        Database.DeleteResult results = Database.delete(comp, false);
        Test.stopTest();

        System.assertEquals('Cannot modify or delete a submitted compensation.',
                                 results.getErrors()[0].getMessage());





	}




}
