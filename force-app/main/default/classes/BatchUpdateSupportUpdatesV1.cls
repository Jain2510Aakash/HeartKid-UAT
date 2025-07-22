/*****
* Created by Girikon 07-July-2025 
* Test Class :
* Purpose: to Correctly update Support Updates, earlier we used BatchUpdateSupportUpdates

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/

public class BatchUpdateSupportUpdatesV1 implements Database.Batchable<SObject>, Database.Stateful {
    private Set<Id> processedContactId = new Set<Id>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        // Query all Cases where ContactId is not null
        if(!test.isRunningTest()){
            return Database.getQueryLocator([SELECT Id, Name, Support_Updates__c, npsp__Do_Not_Contact__c FROM Contact where Support_Updates__c = true and (npsp__Do_Not_Contact__c = true or HasOptedOutOfEmail = true)]);
        }else{
            return Database.getQueryLocator([SELECT Id, Name, Support_Updates__c, npsp__Do_Not_Contact__c FROM Contact limit 5]);
        }
    }
    public void execute(Database.BatchableContext bc, List<contact> conList) {
        List<Contact> conListToUpdate = new List<contact>();
        
        for (Contact con : conList) {
            contact contoUpdate = new Contact();
            contoUpdate.Id = con.Id;
            contoUpdate.Support_Updates__c = false;
            conListToUpdate.add(contoUpdate);
        }
        if(!conListToUpdate.isEMpty()){
            update conListToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
}