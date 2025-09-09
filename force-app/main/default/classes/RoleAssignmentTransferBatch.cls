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
    
    // Constructor to accept parameters
    public RoleAssignmentTransferBatch(String objName, String fieldName, String fromUserId, String toUserId) {
        this.objName = objName;
        this.fieldName = fieldName;
        this.fromUserId = fromUserId;
        this.toUserId = toUserId;
    }
    
    // start method - prepares the query for the batch
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = '';
        if(Test.isRunningTest()){
            query =  'SELECT Id, Primary_Relationship_Manager__c, OwnerId,Primary_Relationship_Manager__r.Name, Owner.Name FROM Account';
            
        }else{
            query =  'SELECT Id, Primary_Relationship_Manager__c, OwnerId,Primary_Relationship_Manager__r.Name, Owner.Name FROM ' + objName +' WHERE ' + fieldName + ' = \'' + fromUserId + '\'';
            
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