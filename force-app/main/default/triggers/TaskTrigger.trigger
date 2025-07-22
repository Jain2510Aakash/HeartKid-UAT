trigger TaskTrigger on Task (after insert) {
   if (Trigger.isAfter && Trigger.isInsert ) {
       
        //TaskTriggerHelper.afterInsert(trigger.newMap, trigger.oldMap);
    }
}