trigger practiceOnTriggersWithAccount on Account (before insert ,after insert,after update) {

    switch on Trigger.operationType {
        when BEFORE_INSERT{
            PracticeAccountHHandler.accountShippingAddress(Trigger.new); 
        }
        when AFTER_INSERT{
            PracticeAccountHHandler.sendEmailToAdmin(Trigger.new); 
        }
        when AFTER_UPDATE{
            PracticeAccountHHandler.updateOpportunityStage(Trigger.new);
        }
    }
}