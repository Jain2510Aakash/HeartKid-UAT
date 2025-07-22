public class TaskTriggerHelper {
    public static void afterInsert(Map<Id,Task> newTaskMap, Map<Id,Task> oldTaskMap){
        Set<Id> taskIdSet = new Set<Id>();
        List<Task> existingTaskList = new List<Task>();
        Map<String, Task> taskIdTaskRec = new Map<String, Task>();
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress[] owea = [SELECT Id, Address, DisplayName FROM OrgWideEmailAddress where address = 'community@heartkids.org.au' limit 1];
        
         for(Task taskRec: newTaskMap.values()){
            if(taskRec.subject == 'Review Communications Pause'){
               taskIdSet.add(taskRec.Id);
            }
        }
        if(!taskIdSet.isEmpty()){
            existingTaskList = [Select id,Owner.Email,Owner.Name From Task where Id in : taskIdSet];
            if(!existingTaskList.isEmpty()){
                for(Task taskRec : existingTaskList){
                    taskIdTaskRec.put(taskRec.id, taskRec);
                }
            }
        }
        for(Task taskRec: newTaskMap.values()){
            if(taskRec.subject == 'Review Communications Pause'){
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setToAddresses(new String[] { taskIdTaskRec.get(taskRec.Id).Owner.Email });
                mail.setSubject('Review Communications Pause');

                String taskLink = System.Url.getOrgDomainUrl().toExternalForm() + '/' + taskRec.Id;
                String DueDateStr = taskRec.ActivityDate.format();
                
                String body = 'Hi '+taskIdTaskRec.get(taskRec.Id).Owner.Name+',\n\n' +
                    'Please review your communications pause.\n\n' +
                    'Task Link: ' + taskLink + '\n' +
                    'Due Date: ' + DueDateStr + '\n\n' +
                    'Thank you.';
                
                mail.setPlainTextBody(body);
                emailsToSend.add(mail);
            }
        }
        if (!emailsToSend.isEmpty()) {
            system.debug('emailsToSend->'+emailsToSend);
            try {
                Messaging.sendEmail(emailsToSend);
            } catch (Exception ex) {
                System.debug('Email sending failed: ' + ex.getMessage());
            }
        }
    }
    
}