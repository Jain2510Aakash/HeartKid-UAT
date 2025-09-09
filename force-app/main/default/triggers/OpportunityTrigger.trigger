//Created By : Girikon(2-July-2025) 
// Description : For Grant opportunities handle the opportunity Name corresponding to Npsp settings

trigger OpportunityTrigger on Opportunity (before insert, before update,after insert, after update) {
    if(trigger.isbefore && trigger.isUpdate){
        OpportunityTriggerHandler.beforeUpdate(trigger.oldMap, trigger.newMap);
    }
    if(trigger.isbefore && trigger.isInsert){
        OpportunityTriggerHandler.beforeInsert(trigger.new);
    }
    if(trigger.isafter && (trigger.isInsert || trigger.isUpdate)){
        system.debug('Opportunity After Insert and Update');
        //OpportunityTriggerHandler.afterInsertUpdate(trigger.oldMap, trigger.newMap);
    }
}