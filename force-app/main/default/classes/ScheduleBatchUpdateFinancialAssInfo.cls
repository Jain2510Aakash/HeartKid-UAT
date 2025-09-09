/*****
* Created by Girikon 07-Aug-2025 
* Test Class : BatchUpdateFinancialAssInfoTest
* Purpose: This will be executed on 12:00 AM of 1 July
Referenced from: Scheduled


Schedule 

String cronExp = '0 0 0 1 7 ? *'; // Every year on July 1st at 12:00 AM
String jobName = 'ScheduleBatchUpdateFinancialAssInfo_EveryJuly1st';
MyScheduledClass myJob = new MyScheduledClass();
System.schedule(jobName, cronExp, myJob);

Abort 

List<CronTrigger> jobsToAbort = [SELECT Id, CronJobDetail.Name FROM CronTrigger WHERE CronJobDetail.Name = 'ScheduleBatchUpdateFinancialAssInfo_EveryJuly1st'];

for (CronTrigger job : jobsToAbort) {
    System.abortJob(job.Id);
    System.debug('Aborted job: ' + job.CronJobDetail.Name);
}

*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/
global class ScheduleBatchUpdateFinancialAssInfo implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        BatchUpdateFinancialAssInfo batch = new BatchUpdateFinancialAssInfo();
        Database.executeBatch(batch, 200);
    }
}