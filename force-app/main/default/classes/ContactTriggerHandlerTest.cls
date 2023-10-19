@isTest
public with sharing class ContactTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
        List<Account> testAccounts = new List<Account>();
           testAccounts.add(new Account(Name='test1'));
           testAccounts.add(new Account(Name='test2'));
           insert testAccounts;

           List<Contact> testContacts = new List<Contact>();

           testContacts.add(new Contact(LastName='test contact 1',AccountId= testAccounts[0].Id,Active__c=true));
           testContacts.add(new Contact(LastName='test contact 2',AccountId=testAccounts[0].Id,Active__c=true));
           testContacts.add(new Contact(LastName='test contact 3',AccountId=testAccounts[0].Id));
           testContacts.add(new Contact(LastName='test contact 4',AccountId=testAccounts[0].Id));
           testContacts.add(new Contact(LastName='test contact 5',AccountId=testAccounts[1].Id));
   
           insert testContacts;
    }

    @isTest
    public static void afterInsertHandlerTest1(){

             List<Account> accs = [SELECT Id,Active_Contact__c,Name  FROM Account];
            for (Account a : accs) {
                if(a.Name=='test1'){
                    System.debug(a.Active_Contact__c);
                    System.assertEquals(2,a.Active_Contact__c );
                }
                if(a.Name=='test2'){
                    System.debug(a.Active_Contact__c);
                    System.assertEquals(null,a.Active_Contact__c );
                }
            }
              List<Contact> cons =[SELECT Id FROM Contact];
              System.assertEquals(5, cons.size());
    }
    @isTest
    public static void afterInsertHandlerTestBulk(){
        // Account testAccount = [SELECT Id Name FROM Account WHERE Name = 'test1'];
           
         List<Contact> testContacts = new List<Contact>();
           for(Integer i =0;i<1000;i++){
            // testContacts.add(new Contact(LastName='test Account '+i,AccountId=testAccount.Id,Active__c=true));
           }        
   
           insert testContacts;

             List<Account> accs = [SELECT Id,Active_Contact__c,Name  FROM Account];
            for (Account a : accs) {
                if(a.Name=='test1'){
                    System.debug(a.Active_Contact__c);
                    System.assertEquals(1002,a.Active_Contact__c );
                }
                if(a.Name=='test2'){
                    System.debug(a.Active_Contact__c);
                    System.assertEquals(null,a.Active_Contact__c );
                }
            }
              List<Contact> cons =[SELECT Id FROM Contact];
              System.assertEquals(1005, cons.size());
    }

}