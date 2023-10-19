public  class ContactTriggerHandler {
    public ContactTriggerHandler() {
    }
    public static void afterInsertHandler(List<Contact> newContacts){
        Set<Id> accIds = new Set<Id>();
      for(Contact con : newContacts){
        accIds.add(con.AccountId);
      }
       //update Active Contacts\
       AccountContactServices.updateActiveContacts(accIds);
    }
    
    public static void afterUpdateHandler(List<Contact> newContacts,Map<Id, Contact> oldMapContacts){
      System.debug('after update ');
        Set<Id> accIds = new Set<Id>();
        for(Contact con : newContacts){
          if(String.isNotBlank(con.AccountId) && oldMapContacts.get(con.Id).Active__C != con.Active__C){
                accIds.add(con.AccountId);
          }
          else if( oldMapContacts.get(con.Id).AccountId != con.AccountId){
            accIds.add(con.AccountId);
            accIds.add(oldMapContacts.get(con.Id).AccountId);
          }
        }
       
         //update Active Contacts
         AccountContactServices.updateActiveContacts(accIds);
    }
}