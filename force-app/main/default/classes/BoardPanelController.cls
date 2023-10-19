public with sharing class BoardPanelController {
   
    @AuraEnabled
    public static string addResult(string result ,string mode){
        try {
            wordShaffule__c gameResult = new wordShaffule__c(gameMode__c=mode,gameResult__c=result);
            insert gameResult;
            return 'success';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}