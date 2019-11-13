trigger DeleteStudents on Class__c (after update) {
   List<Student__c> deletStd = new List<Student__c>();
   if(Trigger.isUpdate && Trigger.isAfter ){
       for(Class__c clas :[SELECT id,(SELECT id FROM Students__r) FROM Class__c WHERE Custom_Status__c='Reset' AND id IN : Trigger.New]){
           for(Student__c id :clas.Students__r){
           		deletStd.add(id);
           }
       }
   }
   delete deletStd;
}