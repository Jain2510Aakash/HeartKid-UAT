/* 
* Created By:   {Girikon(Sahil Khan)}
* Created On:   Aug 21, 2024
* Description/Purpose:  Schedulable class to schedule UpdateGivingStatusBatch class.
* Test Class:   {UpdateGivingStatusBatchSchedulable_Test} {Coverage 100% }
*
* Modification log --
*/
public with sharing class UpdateGivingStatusBatchSchedulable implements Schedulable
{
    public void execute(SchedulableContext sc) 
    {
        UpdateGivingStatusBatch batchObj = new UpdateGivingStatusBatch();
        Database.executeBatch(batchObj);
    }
}