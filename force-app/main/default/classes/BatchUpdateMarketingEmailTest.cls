/*****
* Created by Girikon 05-May-2025 
* Test Class : BatchUpdateLegacyDataTest(100%)
* Purpose: to update Donor Email
*     Change logr
 
*     Author            Date            Description
* ==============================================================================================================================================================
*
*/
@isTest
private class BatchUpdateMarketingEmailTest {

    @testSetup
    static void setupTestData() {
        List<Contact> testContacts = new List<Contact>();

        for (Integer i = 0; i < 10; i++) {
            testContacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'User' + i,
                Email = 'testuser' + i + '@example.com',
                HasOptedOutOfEmail = false,
                npsp__Do_Not_Contact__c = false,
                No_Newsletter__c = false,
                Marketing_Emails__c = false // Initially false
            ));
        }

        // Add some contacts that should not be picked up by the query
        testContacts.add(new Contact(
            FirstName = 'Opted',
            LastName = 'Out',
            Email = 'optedout@example.com',
            HasOptedOutOfEmail = true,
            npsp__Do_Not_Contact__c = false,
            No_Newsletter__c = false,
            Marketing_Emails__c = false
        ));

        insert testContacts;
    }

    @isTest
    static void testBatchExecution() {
        // Run the batch
        Test.startTest();
        BatchUpdateMarketingEmail batch = new BatchUpdateMarketingEmail();
        Database.executeBatch(batch, 10); // Small batch size for test coverage
        Test.stopTest();

        // Verify that only eligible contacts were updated
        List<Contact> updatedContacts = [
            SELECT Id, Marketing_Emails__c, HasOptedOutOfEmail, npsp__Do_Not_Contact__c, No_Newsletter__c
            FROM Contact
            WHERE HasOptedOutOfEmail = false
            AND npsp__Do_Not_Contact__c = false
            AND No_Newsletter__c = false
        ];

        for (Contact c : updatedContacts) {
            System.assertEquals(true, c.Marketing_Emails__c, 'Marketing_Emails__c should be true');
        }

        // Make sure opted out contact is not affected
        Contact optedOut = [SELECT Marketing_Emails__c FROM Contact WHERE Email = 'optedout@example.com' LIMIT 1];
        System.assertEquals(false, optedOut.Marketing_Emails__c, 'Opted out contact should not be updated');
    }
}