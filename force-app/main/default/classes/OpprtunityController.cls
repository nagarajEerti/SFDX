public class OpprtunityController {
    public static void updateProfile(List<id> oppIds){
        List<Opportunity> opps = [SELECT Amount,Name,Profile__c FROM Opportunity WHERE Id In: oppIds];
        for(Opportunity opp:opps){
            
            if(opp.Amount == null){
              opp.Profile__c = '';
            }
            else if(opp.Amount < 10000){
                   opp.Profile__c= 'Low';
            }
            else if(opp.Amount > 500000){
                opp.Profile__c= 'High';
          }
            else{
                 opp.Profile__c= 'Meidum';
           }
            update opp;
        }
    }
    /* write a code to capture total count of
     opportunitys record on a prent account record

     */
     public static void updateAccountWithNoOfChildOpps(List<Opportunity> opps){
        try{
            System.debug('updateAccountWithNoOfChildOpps : start');
           Account acc;
           List<Account> accListToUpdate = new List<Account>();
           List<Id> accIds = new List<Id>();
             for(Opportunity opp:opps){
                if(opp.AccountId != null) accIds.add(opp.AccountId);
             }
           
            for(AggregateResult ar : [SELECT COUNT(Id)opp ,AccountId FROM Opportunity WHERE AccountId IN :accIds GROUP BY AccountId]){
               acc = new Account();
               System.debug(ar);
               acc.id = (Id)ar.get('AccountId');
               acc.relatedOpportunities__c = (Decimal)ar.get('opp');
               accListToUpdate.add(acc);
            }
            System.debug(accListToUpdate);
            if(accListToUpdate.size() > 0) update accListToUpdate;
            System.debug('updateAccountWithNoOfChildOpps : end');
        }
        catch(Exception e){
           System.debug(e.getCause());
        }
     }
}