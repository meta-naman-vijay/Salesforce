public class ApexAssignment1 {
    private static final Date monday = Date.newInstance(1900, 1, 3);
	private static Integer getDayOfWeek(Date value) {
    return Math.mod(monday.daysBetween(value), 7);
	}
    
    public static List<Student__c> GetNameById(String ClassId){
        List<Student__c> studList=[SELECT name FROM Student__c WHERE class__r.Id =:ClassId];
        system.debug('Student Name are:'+studList);
    	return studList;
    }
    
    
    

  	public static Map<String , List<Id>> GetStudentMap(){     
       Map<String, List<Id>> classStudentMap =  new Map<String, List<Id>>();
     
       List<Class__c> classList = [Select Id,Name from Class__c] ;
        List<Student__c> stuList = [SELECT Id,Name,Class__r.Id  FROM Student__c];
               
               //Fetching class ids
        for(Class__c cla : classList){
                   List<Id> stuInClassList = new List<Id>();
                   for(Student__c stu : stuList){
                       if(cla.Id == stu.class__r.Id){          
                    stuInClassList.add(stu.Id);
                       }
                   }
         	classStudentMap.put(cla.Name,stuInClassList);
       }
       System.debug(classStudentMap.values());
       System.debug(classStudentMap.keySet());
       
      return classStudentMap;
       
   }
    
    
    public static Integer daysBetweenExcludingWeekends(DateTime startDate, DateTime endDate) {
       Integer numberOfDays = 0;
       if(startDate > endDate){
           DateTime temDate = endDate;
           endDate = startDate;
           startDate = temDate;
       }
       startDate = startDate.addDays(1);
       while (startDate < endDate) {
           System.debug(startDate);
           if (startDate.formatGmt('E') != 'Sat' && startDate.formatGmt('E') != 'Sun') {
               System.debug(startDate.formatGmt('E'));
               numberOfDays++;
           }
           startDate = startDate.addDays(1);
       }
       return numberOfDays;
   }
    
    
    
   public static void GetAllsObject(){
        List<string> SObjectList = new List<string>();
       	for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
  			 String name = objTyp.getDescribe().getName();
             SobjectList.add(name);
             System.debug( 'Name : ' + name);
    	} 
    }
    
    
}