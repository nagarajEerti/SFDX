trigger OpportunityTrigger on Opportunity (after insert,after update,after delete) {
   switch on Trigger.operationType {
    when  AFTER_INSERT{
      
    }
    when  AFTER_UPDATE{
      OpprtunityController.updateAccountWithNoOfChildOpps(Trigger.new);
    }
    when  AFTER_DELETE{
   
    }
    when else {
        
    }
   }
}