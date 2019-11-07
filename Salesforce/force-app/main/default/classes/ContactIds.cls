public class ContactIds {
   
    public static void setContactIds(ID contactId)
    {
        List<Contact> listContacts = [SELECT Account.Id, Account.ContactIDs__c FROM Contact WHERE id =: contactId];
        ID accountId = listContacts.get(0).Account.Id;
        String resultantContactId = listContacts.get(0).Account.ContactIDs__c;
        if(resultantContactId == null)
        {
            makeList(contactId);
        }
        else
        {
            updateList(contactId);
        }
    }
   
    private static void makeList(ID contactId)
    {
        String result = '';
        List<Account> listAccounts = [SELECT id, (SELECT id FROM Contacts)
                                      FROM Account WHERE id IN (SELECT AccountId FROM Contact WHERE id=:contactId)];
        System.debug(listAccounts.size());
        for(Integer i = 0; i < listAccounts.get(0).Contacts.size(); i++)
        {
            if(i == listAccounts.get(0).Contacts.size()-1)
            {
                result = result + listAccounts.get(0).Contacts.get(i).id;
            }
            else
            {
                result = result + listAccounts.get(0).Contacts.get(i).id + ' , ';
            }
        }
        Account acc = [SELECT id, Name,ContactIDs__c FROM Account WHERE id =: listAccounts.get(0).id][0];
        acc.ContactIDs__c = result;
        upsert acc;
    }
   
   
    private static void updateList(ID contactId)
    {
        List<Account> listAccounts = [SELECT id, ContactIds__c FROM Account WHERE id IN (SELECT AccountId FROM Contact WHERE id =: contactId)];
        String ContactIds = listAccounts.get(0).ContactIds__c;
        if(!ContactIds.contains(String.valueOf(contactId)))
        {
            ContactIds = ContactIds + ' , ' + String.valueOf(contactId);
            Account acc = [SELECT id, Name,ContactIDs__c FROM Account WHERE id =: listAccounts.get(0).id][0];
            acc.ContactIDs__c = ContactIds;
            upsert acc;
        }
        else
        {
            System.debug('Id Already present in the list');
        }
    }
}