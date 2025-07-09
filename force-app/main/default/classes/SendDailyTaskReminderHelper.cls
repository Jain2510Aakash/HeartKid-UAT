// Send email notofication for "Review Communications Pause" tasks on daily basis
public class SendDailyTaskReminderHelper {
    public static void sendDueTodayReminders() {
        Date today = Date.today();
        List<Task> todayTasks = [
            SELECT Id, Subject, Owner.Email, Owner.Name, ActivityDate 
            FROM Task 
            WHERE Subject = 'Review Communications Pause'
            AND ActivityDate = :today
            AND Owner.Email != null
        ];
        
        if (todayTasks.isEmpty()) return;
        
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress[] owea = [
            SELECT Id FROM OrgWideEmailAddress 
            WHERE address = 'sahil.294@girikon.com' 
            LIMIT 1
        ];
        
        for (Task taskRec : todayTasks) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setOrgWideEmailAddressId(owea.isEmpty() ? null : owea[0].Id);
            mail.setToAddresses(new String[] { taskRec.Owner.Email });
            mail.setSubject('Reminder: Review Communications Pause - Due Today');
            
            String taskLink = URL.getOrgDomainUrl().toExternalForm() + '/' + taskRec.Id;
            String dueDateStr = taskRec.ActivityDate.format();
            
            String body = 'Hi ' + taskRec.Owner.Name + ',\n\n' +
                'This is a reminder to review your communications pause task due today.\n\n' +
                'Task Link: ' + taskLink + '\n' +
                'Due Date: ' + dueDateStr + '\n\n' +
                'Thank you.';
            
            mail.setPlainTextBody(body);
            emailsToSend.add(mail);
        }
        
        if (!emailsToSend.isEmpty()) {
            try {
                Messaging.sendEmail(emailsToSend);
            } catch (Exception ex) {
                System.debug('Email sending failed: ' + ex.getMessage());
            }
        }
    }
}