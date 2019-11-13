trigger ClassDeleteNotAllowed on Class__c (before delete) {
    List<Class__c> cla = [SELECT id, (Select Class__c from students__r where sex__c = 'Female') From class__c where id IN :Trigger.old];
    for(Class__c cl: cla){
        if(cl.students__r.size()>1)
        {
           Trigger.oldmap.get(cl.id).addError('This Class cannot delete because it has atleast one Female Student');
        }
    }
}