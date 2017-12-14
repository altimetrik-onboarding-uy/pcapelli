global class ScheduledSubmitCompensations implements Schedulable {
    global void execute(SchedulableContext sc){
        String query = 'SELECT Id FROM Compensation__c WHERE Submitted__c = false AND CreatedDate < LAST_N_DAYS:2';
        AutomaticallySubmitCompensations submBatch = new AutomaticallySubmitCompensations(query);
        Id BatchProcessId = Database.ExecuteBatch(submBatch);
        System.debug('ejecute el batch' + BatchProcessId);
    }
}
