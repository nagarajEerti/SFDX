public with sharing class GameResultController {
    @AuraEnabled
    public static List<wordShaffule__c> getResults(){
        try {
            String userId = UserInfo.getUserId();
            List<wordShaffule__c> allresults =[SELECT Id,Name,gameResult__c,gameMode__c FROM wordShaffule__c WHERE CreatedById = :userId ] ;
            return allresults;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}