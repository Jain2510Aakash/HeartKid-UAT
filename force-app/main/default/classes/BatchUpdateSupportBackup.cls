/*****
* Created by Girikon 15-July-2025 
* Test Class : BatchUpdateSupportBackupTest(100%)
* Purpose: to update Support 1:1 as true on contact where Contact_Status__c = 'Bereaved Family - on hold'
*     Change logr

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/

public class BatchUpdateSupportBackup implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        if(!test.isRunningTest())  {
            return Database.getQueryLocator([Select id,Support_Personal_1_1_Only__c from contact where Contact_Status__c = 'Bereaved Family - on hold' ]);
        }  else{    
            return Database.getQueryLocator([Select id,Support_Personal_1_1_Only__c from contact where Contact_Status__c = 'Bereaved Family - on hold' ]);
        }
    }
    public void execute(Database.BatchableContext bc, List<Contact> contactList) {
        if(!contactList.isEmpty()){
            for(Contact con : contactList){
                con.Support_Personal_1_1_Only__c = TRUE;
            }
            database.update(contactList, FALSE);
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
}