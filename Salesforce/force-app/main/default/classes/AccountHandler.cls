public class AccountHandler {
    public static Account insertNewAccount(String AccountName){
        Account acc=new Account(Name=AccountName);
        try
		{
			insert acc;
		}
        catch (Exception e) {
			return null;
		}
    return acc;
    }
}