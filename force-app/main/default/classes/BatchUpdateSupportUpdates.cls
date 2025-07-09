/*****
* Created by Girikon 23-Jun-2025 
* Test Class :
* Purpose: to update Support Updates

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/

public class BatchUpdateSupportUpdates implements Database.Batchable<SObject>, Database.Stateful {
    private Set<Id> processedContactId = new Set<Id>();
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        // Query all Cases where ContactId is not null
        return Database.getQueryLocator([SELECT ContactId  FROM Case  WHERE ContactId != null]);
    }
    public void execute(Database.BatchableContext bc, List<Case> CaseList) {
        List<Contact> conListToUpdate = new List<contact>();
        
        for (Case caseRec : CaseList) {
            if (caseRec.ContactId != null && !processedContactId.Contains(caseRec.ContactId)) {
                contact con = new Contact();
                con.Id = caseRec.ContactId;
                con.Support_Updates__c = True;
                
                conListToUpdate.add(con);
                processedContactId.add(caseRec.ContactId);
            }
        }
        if(!conListToUpdate.isEMpty()){
            update conListToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
}