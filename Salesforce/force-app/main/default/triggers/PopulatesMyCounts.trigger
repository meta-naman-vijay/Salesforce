trigger PopulatesMyCounts on Student__c (after insert,before update,after update) {
    List<Class__c> clas = new List<Class__c>();
   if(Trigger.isInsert){
       for(Class__c cla : [SELECT MyCount__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.New)]){
           if(cla.MyCount__c==null){
               cla.MyCount__c=1;
           }else{
             cla.MyCount__c++;
           }
           clas.add(cla);        
       }  
   }
   else if(Trigger.isUpdate){
       if(Trigger.isBefore){
           for(Class__c cla : [SELECT MyCount__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.old)]){
               cla.MyCount__c--;
          clas.add(cla);
           }
       }
       if(Trigger.isAfter){
         for(Class__c cla : [SELECT MyCount__c FROM Class__c WHERE id IN (SELECT Class__c FROM Student__c WHERE id IN:Trigger.New)]){
               cla.MyCount__c++;
          clas.add(cla);
           }  
       }
   }
   upsert clas;

}