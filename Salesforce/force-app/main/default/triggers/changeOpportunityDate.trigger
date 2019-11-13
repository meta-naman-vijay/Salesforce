trigger changeOpportunityDate on Opportunity (before update,after update) 
{
   if (Trigger.IsBefore && Trigger.isUpdate) {
		for (Opportunity opp:Trigger.New) {
 			if ((Trigger.oldMap.get(opp.Id).StageName != 'Closed Won' ||  Trigger.oldMap.get(opp.Id).StageName != 'Closed Won') && (opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost')) {
				opp.CloseDate = System.Today();
			}
		}
	}
}