public class AccountController {

    public static Account insertAccount(Account acc){
        insert acc;
        return acc;
    }
    public static List<Account> insertAccount(List<Account> acc){
          insert acc;
        return acc;
    }
    public static List<Account> getAllAccounts(){
         List<Account> acc = [SELECT Name,Phone FROM Account];
        return acc;
    }
    public static void printAllAccounts(){
         List<Account> acc = getAllAccounts();
        for(Account a:acc){
           System.debug('name:'+a.Name +' Phone:'+a.Phone);
        }
    }
    public static Integer getAllAccountsCount(){
         Integer acc = getAllAccounts().size();
        return acc;
    }
        
}