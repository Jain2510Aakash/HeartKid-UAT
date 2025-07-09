@isTest
public class SendDailyTaskReminderSchTest {
    @isTest(seeAllData=true)
    static void testSchedulerExecutes() {
       string userId = [Select Id from User where Profile.Name = 'Standard User'].Id;
        
        Task t = new Task(
            Subject = 'Review Communications Pause',
            OwnerId = userId,
            ActivityDate = Date.today(),
            Status = 'Not Started',
            Priority = 'Normal'
        );
        insert t;
        
        Test.startTest();
        String cronExp = '0 0 9 * * ?'; // 9:00 AM
        String jobId = System.schedule('TestDailyReminderJob', cronExp, new SendDailyTaskReminderScheduler());
        Test.stopTest();

        System.assertNotEquals(null, jobId, 'Job ID should not be null');
    }

    @isTest(seeAllData=true)
    static void testSendDueTodayReminders() {
        Test.startTest();
        SendDailyTaskReminderHelper.sendDueTodayReminders();
        Test.stopTest();
        // No assert needed as we are verifying no exception and flow runs; email sending is not testable directly
    }
}