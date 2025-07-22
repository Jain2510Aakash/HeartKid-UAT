trigger CaseTrigger on Case (After insert, after update, after delete) {
    if(trigger.isAfter && trigger.isInsert){
        CaseTriggerHelper.afterInsert(trigger.oldMap, trigger.newMap);
    }
     if(trigger.isAfter && trigger.isUpdate){
        CaseTriggerHelper.afterUpdate(trigger.oldMap, trigger.newMap);
    }
    if(trigger.isafter && trigger.isDelete){
        CaseTriggerHelper.afterDelete(trigger.oldMap, trigger.newMap);
    }
}