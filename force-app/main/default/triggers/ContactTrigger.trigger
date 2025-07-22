trigger ContactTrigger on Contact (after insert, after update, before update) {
    //if (ContactHandler.isMerging) {
    //    return;
    //}
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        ContactHandler.afterInsertAndUpdate(trigger.oldMap, trigger.newMap);
      //  if (!System.isBatch() && !System.isFuture() && !System.isQueueable()) {
            //System.enqueueJob(new MergeDuplicateContactQue());
      //  }
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        ContactHandler.afterUpdate(trigger.oldMap, trigger.newMap);
    }
    
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        //ContactRealTimeMergeHandler.handle(Trigger.new);
    }
}