trigger notInsertStudentAfterMaxLimit on Student__c (before insert) {
    Map<Id,Class__c> mapOfClass=new Map<Id,Class__c>();
    List<Class__c> classList= [select id,NumberOfStudents__c,maxSize__c from Class__c];
    
    for(Class__c cls: classList)
    {
        mapOfClass.put(cls.Id, cls);
    }
    
    for(Student__c stu: Trigger.New)
    {
     	Class__c stuClass=mapOfClass.get(stu.Class__c);
        if(stuClass.NumberOfStudents__c>=stuClass.MaxSize__c)
        {
            stu.addError('Can\'t add Student because this class size is full.');
        }
    }
}