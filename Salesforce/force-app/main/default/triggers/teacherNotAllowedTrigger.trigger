trigger teacherNotAllowedTrigger on Teach__c (before insert,before update) {
	List<Teach__c> teachList = new List<Teach__c>();
   
    if(Trigger.isInsert)
    {
       for(Teach__c teach : Trigger.New)
       {
           if(teach.Subject__c .contains('Hindi'))
           {
      			teach.addError('Not allowed.');
           }
       }
   }
   else if(Trigger.isUpdate){
       for(Teach__c teach : [select id,Teacher__r.Name from teach__c where subject__c INCLUDES('Hindi') AND id IN: Trigger.New])
       {
          Trigger.newMap.get(teach.Id).addError('Not allowed.');
       }
   }
}