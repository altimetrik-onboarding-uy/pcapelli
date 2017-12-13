trigger SetSubmittedStatus on Compensation__c (before insert, before update, before delete) {

    if (Trigger.isUpdate || Trigger.isDelete){

            for(Compensation__c c : Trigger.old){
                     System.debug(c.Submitted__c);
                  if(c.Submitted__c == true){
                   	c.addError('Cannot modify or delete a submitted compensation.');
                  }
            }
    }

    if (Trigger.isInsert){
        for(Compensation__c c : Trigger.New) {
          if (c.Submitted__c == true){
              c.Status__c  = 'SUBMITTED';
          }   
        }

        }
}
