//Dailyu runs at 9:00 am autralia
/*
String cronExp = '0 00 09 * * ?'; // 09:00 AM daily
String jobName = 'SendDailyTaskReminderScheduler';
System.schedule(jobName, cronExp, new SendDailyTaskReminderScheduler());
*/
public class SendDailyTaskReminderScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        SendDailyTaskReminderHelper.sendDueTodayReminders();
    }
}