global class MailOpptyOwner implements Schedulable{
   global void execute(SchedulableContext ctx) {
       List<Opportunity> opptys = [SELECT Id,Owner.Email FROM Opportunity WHERE LastModifiedDate >= LAST_N_DAYS:30];
List<String> opptysOwnerEmails;
       
       for(Opportunity o : opptys){
           opptysOwnerEmails.add(o.Owner.Email);
       }
           sendEmail(opptysOwnerEmails);        
   }
   
    public void sendEmail( List<String> opptysOwnerEmailList)
        {// Please add your logic according to requirement
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string [] toaddress= opptysOwnerEmailList;
                for(String o:opptysOwnerEmailList){
                    System.debug(o);
                }
                email.setSubject('Testing Apex Scheduler-Subject');
                email.setPlainTextBody('Testing Apex Scheduler-Body');
                email.setToAddresses(toaddress);
                Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
           }
   
}