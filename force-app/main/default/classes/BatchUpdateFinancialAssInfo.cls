/*****
* Created by Girikon 07-Aug-2025 
* Test Class : BatchUpdateFinancialAssInfoTest
* Purpose: to Fill the previous Year Assistance Provided and Empty the CFY assistanve provided on Account
Referenced from: ScheduleBatchUpdateFinancialAssInfo
*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/


public class BatchUpdateFinancialAssInfo implements Database.Batchable<SObject> {
    
    // Query all Account records
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
        SELECT Id,Total_Financial_Assistance_Provided_CFY__c,Previous_value_of_total_financial_assita__c,Previous_value_of_total_In_Kind_assita__c,Total_In_Kind_Assistance_Provided_CFY__c FROM Account where Total_In_Kind_Assistance_Provided_CFY__c > 0 OR Total_Financial_Assistance_Provided_CFY__c > 0]);
    }
    
    // Process and update each batch of records
    public void execute(Database.BatchableContext bc, List<Account> accntList) {
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : accntList) {
            acc.Previous_value_of_total_financial_assita__c = acc.Total_Financial_Assistance_Provided_CFY__c;
            acc.Total_Financial_Assistance_Provided_CFY__c = 0;
            acc.Previous_value_of_total_In_Kind_assita__c = acc.Total_In_Kind_Assistance_Provided_CFY__c;
            acc.Total_In_Kind_Assistance_Provided_CFY__c = 0;
            accountsToUpdate.add(acc);
        }
        
        if (!accountsToUpdate.isEmpty()) {
            Database.update(accountsToUpdate,false);
        }
    }
    
    
    public void finish(Database.BatchableContext bc) {

    }
}