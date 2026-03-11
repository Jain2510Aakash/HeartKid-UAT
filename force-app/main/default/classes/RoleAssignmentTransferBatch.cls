/**
* @Description : Transfer Account and Contact records 
* @Author : Girikon
* Test Class: RoleAssignmentHelperTest
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
*
*==============================================================================
* 1.0 | August 01, 2025 |   | Initial Version
**/

global class RoleAssignmentTransferBatch implements Database.Batchable<SObject> {
    
    // Parameters
    private String objName;
    private String fieldName;
    private String fromUserId;
    private String toUserId;
    private String mailingState;
    
    // Constructor to accept parameters
    public RoleAssignmentTransferBatch(String objName, String fieldName, String fromUserId, String toUserId, String mailingState) {
        this.objName = objName;
        this.fieldName = fieldName;
        this.fromUserId = fromUserId;
        this.toUserId = toUserId;
        this.mailingState = mailingState;

        system.debug('objName->'+this.objName);
        system.debug('fieldName->'+this.fieldName);
        system.debug('fromUserId->'+this.fromUserId);
        system.debug('toUserId->'+this.toUserId);
        system.debug('mailingState->'+this.mailingState);
    }
    
    // start method - prepares the query for the batch
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = '';
        
        system.debug('mailingState->'+mailingState);
        query =  'SELECT Id, Primary_Relationship_Manager__c, OwnerId,Primary_Relationship_Manager__r.Name, Owner.Name FROM ' + objName +' WHERE ' + fieldName + ' = \'' + fromUserId + '\'';
        if(!string.isBlank(mailingState) && mailingState != 'N/A' && mailingState != 'ALL'){
            system.debug('blank');
            if(objName == 'Contact'){
                query += ' AND MailingState =  \'' + mailingState + '\'';
            }else if(objName == 'Account'){
                query += ' AND BillingState =  \'' + mailingState + '\'';
            }
            
        }else if(mailingState == 'N/A'){
            system.debug('N/A');
            if(objName == 'Contact'){
                query += ' AND MailingState =  \'' + mailingState + '\'';
            }else if(objName == 'Account'){
                query += ' AND BillingState =  \'' + mailingState + '\'';
            }             
        }
        system.debug('query->'+query);
        return Database.getQueryLocator(query);
    }
    
    // execute method - processes each batch of records
    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        
        system.debug('PrvScope->'+scope);
        
        for(SObject sc : scope){
            
            sc.put(fieldName,toUserId);
        }     
        system.debug('Scope->'+scope);
        
        if(!scope.isEmpty()){
            
            // Perform partial update: successful records update, failed ones are reported
            Database.SaveResult[] results = Database.update(scope, false);
            
            for (Integer i = 0; i < results.size(); i++) {
                if (!results[i].isSuccess()) {
                    SObject failedRecord = scope[i];
                    System.debug('Failed to update record Id: ' + failedRecord.Id);
                    for (Database.Error err : results[i].getErrors()) {
                        System.debug('Error: ' + err.getMessage());
                    }
                }
            }    
            
        }
        
        
    }
    
    // finish method - called after all batches are processed
    global void finish(Database.BatchableContext BC) {
        // Optional: send email or log completion
        
    }
}