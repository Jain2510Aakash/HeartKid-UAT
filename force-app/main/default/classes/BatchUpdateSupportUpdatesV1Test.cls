@isTest
public class BatchUpdateSupportUpdatesV1Test {
    
    @testSetup
    static void setupTestData() {
        List<Contact> contactsToInsert = new List<Contact>();

        // These should be updated (match criteria)
        for (Integer i = 0; i < 1; i++) {
            contactsToInsert.add(new Contact(
                FirstName = 'Update',
                LastName = 'Contact' + i,
                Email = 'update' + i + '@test.com',
                Support_Updates__c = true,
                npsp__Do_Not_Contact__c = true
            ));
        }

        // These should NOT be updated (do not match criteria)
        for (Integer i = 0; i < 1; i++) {
            contactsToInsert.add(new Contact(
                FirstName = 'Skip',
                LastName = 'Contact' + i,
                Email = 'skip' + i + '@test.com',
                Support_Updates__c = false,
                npsp__Do_Not_Contact__c = true
            ));
        }

        insert contactsToInsert;
    }
    
    @isTest
    static void testBatchUpdateSupportUpdates() {
        Test.startTest();
        BatchUpdateSupportUpdatesV1 batch = new BatchUpdateSupportUpdatesV1();
        Database.executeBatch(batch, 10);
        Test.stopTest();

    }
}