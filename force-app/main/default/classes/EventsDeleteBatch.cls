public class EventsDeleteBatch implements Database.Batchable<sObject> 
{
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator('SELECT Id FROM Event WHERE Subject LIKE \'[Autopilot]%\'');
    }
    public void execute(Database.BatchableContext bc, List<Event> records)
    {
        if(!records.isEmpty())
        {
			DELETE records;
        }
    }
    public void finish(Database.BatchableContext bc)
    {
        // execute any post-processing operations
    }
}