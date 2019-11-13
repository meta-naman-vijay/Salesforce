public class UpdateOfOpportunities { 
   public static void updateOpportunities(List<Opportunity> Opptys){
 
       List<Opportunity> intermediateOpportunity = new List<Opportunity>();
       for(Opportunity opp: Opptys){
           if(opp.BillToContact__c != null && opp.Manager__c == null){
           
               opp.Manager__c = opp.BillToContact__r.AccountId;
               intermediateOpportunity.add(opp);
               System.debug(opp.Name);
           }   
       }
        upsert intermediateOpportunity;
   }

}