public  class PracticeAccountHHandler {
    
    public static void accountShippingAddress(List<Account> accList){

        List<Account> newAccounts = new List<Account>();
          for (Account ac : accList) {
            if(ac.BillingStreet != null){
                ac.ShippingStreet = ac.BillingStreet;
            }
            if(ac.BillingState != null){
                ac.ShippingState = ac.BillingState;
            }
            if(ac.BillingPostalCode != null){
                ac.ShippingPostalCode = ac.BillingPostalCode;
            }
            if(ac.BillingCountry != null){
                ac.ShippingCountry = ac.BillingCountry;
            }
              newAccounts.add(ac);
          }
           
    }

    public static void updateOpportunityStage(List<Account> accList){
        
        Set<Id> accIds = new Set<Id>();
        for (Account a : accList) {
            accIds.add(a.Id);
        }
        List<Opportunity> toBeUpdateOpportunities =new  List<Opportunity>();
        List<Opportunity> opps = [SELECT  Id, AccountId, StageName, CreatedDate, CloseDate FROM Opportunity WHERE AccountId IN : accIds];
        Datetime days30 = System.now()-30;
        if(opps.size()>0){
            for (Opportunity opp : opps) {
                if(opp.CreatedDate < days30 && opp.StageName != 'Closed Won' ){
                    opp.StageName = 'Closed Lost';
                    opp.CloseDate = System.today();
                }
                toBeUpdateOpportunities.add(opp);
            }
        }
        update toBeUpdateOpportunities;
    }

    public static void sendEmailToAdmin(List<Account> accList){
        // To send list of mails when there are insertion of list of Accounts
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        //query to get email of systemAdmin
        User userObj = [select Id,Profile.Name,Email from user where Profile.Name='System Administrator'];
     // User userObj = [SELECT Id,Profile.name,Email from User WHERE Profile ='System Administrator'];

        for(Account ac : accList){
         //checking if the user email is not null
         if(userObj.Email != null){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            //assigning the sender name for email 
            mail.setSenderDisplayName('SalesForce');
            //We are make all this below fields as false because those are not needed for now
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);

            //assigning the revicer mail Address
            mail.toaddresses = new String[] {userObj.Email};
            //assign the subject 
            mail.setSubject('New Account Was Created');
            String body = 'Dear System Administrator, <br/>';
            body += 'An account has been created and name is '+ac.Name+'.';
            mail.setHtmlBody(body);

            //add mail to list of mail

            mails.add(mail);
         }

        }
        if(mails.size()>0){
            //send msgs
            Messaging.SendEmailResult[] result = Messaging.sendEmail(mails);
            if(result[0].success){
                System.debug('the eamil was sent successfully');
            }
            else {
                System.debug('The email failed to send: '+ result[0].errors[0].message);
            }
        }
        
    }
}