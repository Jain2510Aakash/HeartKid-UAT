@IsTest
private class EventsDeleteBatch_Test 
{
    @IsTest
	static void batchTest()
    {
        Event e = new Event(Subject = '[Autopilot] Test Event', DurationInMinutes = 10, ActivityDateTime = Datetime.now());
        INSERT e;
        Database.executeBatch(new EventsDeleteBatch());
    }
}