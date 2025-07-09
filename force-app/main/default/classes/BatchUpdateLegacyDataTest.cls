@isTest
public class BatchUpdateLegacyDataTest {
    @isTest
    static void testBatchExecution() {
        // Create test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create a Contact who qualifies for update
        Contact contactToUpdate = new Contact(
            LastName = 'Qualified Contact',
            AccountId = testAccount.Id,
            HasOptedOutOfEmail = false,
            DoNotCall = false,
            npsp__Do_Not_Contact__c = false,
            No_Solicitation__c = false,
            No_SMS_Marketing__c = false
        );
        insert contactToUpdate;
        
        // Create Opportunity with Stage 'Closed Won' for the same Account
        Opportunity wonOpp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert wonOpp;
        
        // Create another Contact that should not be updated
        Contact contactNotToUpdate = new Contact(
            LastName = 'Not Qualified',
            AccountId = testAccount.Id,
            HasOptedOutOfEmail = true,
            DoNotCall = true,
            npsp__Do_Not_Contact__c = true,
            No_Solicitation__c = true,
            No_SMS_Marketing__c = true
        );
        insert contactNotToUpdate;
        
        // Run the batch
        Test.startTest();
        BatchUpdateLegacyData batch = new BatchUpdateLegacyData();
        Database.executeBatch(batch, 1); // Use small batch size for test
        Test.stopTest();
        
        // Assert updated contact fields
        Contact updatedCon = [SELECT Donor_Emails__c, Donor_SMS__c, Donor_Phone_Calls__c FROM Contact WHERE Id = :contactToUpdate.Id];
        System.assertEquals(true, updatedCon.Donor_Emails__c, 'Donor_Emails__c should be true');
        System.assertEquals(true, updatedCon.Donor_SMS__c, 'Donor_SMS__c should be true');
        System.assertEquals(true, updatedCon.Donor_Phone_Calls__c, 'Donor_Phone_Calls__c should be true');
        
        // Assert that the non-qualified contact was not updated
        Contact notUpdatedCon = [SELECT Donor_Emails__c, Donor_SMS__c, Donor_Phone_Calls__c FROM Contact WHERE Id = :contactNotToUpdate.Id];
        System.assertEquals(false, notUpdatedCon.Donor_Emails__c, 'Non-qualified contact should not be updated');
        System.assertEquals(false, notUpdatedCon.Donor_SMS__c, 'Non-qualified contact should not be updated');
        System.assertEquals(false, notUpdatedCon.Donor_Phone_Calls__c, 'Non-qualified contact should not be updated');
    }
}