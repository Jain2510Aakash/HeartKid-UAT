//Created By : Girikon(2-July-2025) 
// Description : For Grant opportunities handle the opportunity Name corresponding to Npsp settings

trigger OpportunityTrigger on Opportunity (before insert, before update) {
    if(trigger.isbefore && (trigger.isInsert || trigger.isUpdate)){
        for(Opportunity opp : trigger.new){
            if(opp.Name != NULL && (opp.Name).contains('!@#$')){
                List<String> parts = (opp.Name).split('!@#\\$');
                opp.Name = parts[parts.size() - 1].trim();
            }
        }
    }
}