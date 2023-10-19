trigger AccountTrigger on Account (after update,before update,before delete) {

    /*task 1** 
    write trigger that will update a coustum field 
    on contact object when the related account's billingState was updated*/

    switch on Trigger.operationType {
        when AFTER_UPDATE {
           // AccountContactServices.updateContactWhenAccoutsAreUpadted(Trigger.new);
           AccountContactServices.updateCoustumFieldOfContactWhenAccountGotUpdate(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_UPDATE {
            //AccountContactServices.validateBeforeUpdating(Trigger.new);
        }
        when BEFORE_DELETE{
            AccountContactServices.preventTheDeletingWithAboveConditions(trigger.new, trigger.old,trigger.oldMap);
            //AccountContactServices.deleteAccountIfNotAssociatedWithOpportunity(Trigger.old);
        }
    }
}   