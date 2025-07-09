/*****
* Created by Girikon 20-Apr-2025 
* Test Class : ContactTriggerTest(100%)
* Purpose: to fill Child contact details on parent contact
*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/
trigger ContactTrigger on Contact (after insert, after update, before update) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        ContactHandler.afterInsertAndUpdate(trigger.oldMap, trigger.newMap);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        ContactHandler.afterUpdate(trigger.oldMap, trigger.newMap);
    }
}