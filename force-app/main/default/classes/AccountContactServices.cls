public class AccountContactServices {

    public static void updateActiveContacts(Set<Id> accIds ){
        System.debug('After update');
        List<AggregateResult> results= [SELECT AccountId, COUNT(Id)totalContacts 
                                          FROM Contact 
                                          WHERE AccountId IN:accIds AND Active__C = true 
                                          GROUP BY AccountId];
        List<Account> accountsToUpdate = new List<Account>();
             for(AggregateResult result:results){
              String accId = String.valueOf(result.get('AccountId'));
              Integer totalContacts = Integer.valueOf(result.get('totalContacts'));
              Account acc = new Account(Id=accId,Active_Contact__c=totalContacts);
              accountsToUpdate.add(acc);
             }
             update accountsToUpdate;
    }
    public static void updateContactWhenAccoutsAreUpadted(List<Account> acc){
            try {
                System.debug('after update account and contact task');
                List<Id> accIds = new List<Id>();
                for (Account a:acc){
                accIds.add(a.Id);
                }
                List<Contact> cons =new List<Contact>();
                if(Schema.SObjectType.Account.isAccessible()){
                   cons = [SELECT Id,Name FROM Contact WHERE AccountId IN :accIds];
                }
                List<Contact> consTobeUpdate = new List<Contact>();
                // System.debug(cons.size());
                // System.debug(Schema.SObjectType.Contact.fields.Department.isUpdateable());
                if(cons.size() > 0){
                    for(Contact c : cons) {
                        if (Schema.SObjectType.Contact.fields.Department.isUpdateable()) {
                            c.Department='added from me';
                        } else {
                            System.debug('we dont have acceess to edit the field');
                        }
                                               
                        consTobeUpdate.add(c);
                      }
                }else {
                    System.debug('no contacts found');
                }
                update consTobeUpdate;
            } catch (Exception e) {
                System.debug(e.getCause())  ;
            }
    }
    public static void validateBeforeUpdating(List<Account> acc){
            try {
                System.debug('before update called');
                List<Account> updateAcc = new List<Account>();
                for(Account a:acc){
                    if(a.Name == 'nani' && a.Phone == '9581519337'){
                        a.Website = 'www.google.com';
                    }
                    updateAcc.add(a);
                }
                update updateAcc;
            } catch (Exception e) {
                System.debug(e.getCause())  ;
            }
    }
    public static void deleteAccountIfNotAssociatedWithOpportunity(List<Account> acc){
        // You want to prevent users from deleting Account records 
        // if there are related Opportunity records associated with the Account. 
        // How can you achieve this using an Apex Trigger?
            try {
                System.debug('before delete called');
                Set<Id> tobeDeleteIds = new Set<Id>();
                for(Account a:acc){
                  tobeDeleteIds.add(a.Id);
                }
                List<Opportunity> opps = [SELECT  Id ,AccountId,Name FROM Opportunity WHERE AccountId IN :tobeDeleteIds];
                if(!opps.isEmpty()){
                    for (Account a : acc) {
                        a.addError('You cannot delete this Account because it has related Opportunity records.');
                    }
                }

            } catch (Exception e) {
                System.debug(e.getCause())  ;
            }
    }
    public static void updateCoustumFieldOfContactWhenAccountGotUpdate(List<Account> acc,Map<Id,Account> oldAcc){
        try {
            System.debug('updateCoustumFieldOfContactWhenAccountGotUpdate');
            Set<Id> accIds = new Set<Id>();
       for(Account a:acc){
           if( a.BillingState != oldAcc.get(a.Id).BillingState){
               accIds.add(a.Id);
           }
       }
       //Languages__c
       List<Contact> contactsToUpdate = new List<Contact>();
       List<Contact> cons = [SELECT Id,Name ,Languages__c FROM Contact WHERE AccountId IN:accIds];
       for(Contact c :cons){
        //added for testing
        c.Languages__c = 'telugu';
        contactsToUpdate.add(c);
       }
        if (contactsToUpdate.size() > 0)  update contactsToUpdate;
        } catch (Exception e) {
            System.debug(e.getCause());
        }
    }
    /*
     prevent the deleting of account if related case has open and user is owner of account 
    */
    public static void preventTheDeletingWithAboveConditions(List<Account> acc,List<Account> oldAcc,Map<Id,Account> oldAccMap){
        
        try {
             Set<Id> accIds = new Set<Id>();
             for(Case c : [SELECT Id,AccountId,Status FROM Case WHERE AccountId IN : oldAccMap.keySet() AND Status != 'Closed']){
                        accIds.add(c.AccountId);
             }
             for(Account a : oldAcc){
                    if(a.OwnerId != UserInfo.getUserId() || accIds.contains(a.Id)){
                        a.addError('Dear '+ UserInfo.getFirstName()+' you dont have permission to delete');
                    //   not giving name  // a.addError('Dear '+ Profile.Name+' you dont have permission to delete');
                    }
             }
        } catch (Exception e) {
            System.debug(e.getCause());
        }
    }

}