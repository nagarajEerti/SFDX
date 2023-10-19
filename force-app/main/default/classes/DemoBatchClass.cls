public with sharing class DemoBatchClass implements Database.Batchable<SObject> {
     

        public Database.QueryLocator start(Database.BatchableContext bc){
         return Database.getQueryLocator( [SELECT Id,LeadSource FROM Lead]) ;
        }
        public  void execute(Database.BatchableContext bc,List<Lead> leads){
            for (Lead lead : leads) {
                lead.LeadSource = 'web';
            }
            update leads;
        }
        public  void finish(Database.BatchableContext bc){ 
            System.debug('batch finished');
        }

}