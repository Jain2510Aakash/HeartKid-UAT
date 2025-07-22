@isTest
public class BatchUpdateSupportBackupTest {
    
    @testSetup
    static void setupTestData() {
        List<Contact> contacts = new List<Contact>();

        // These records should NOT be picked up by the batch
        contacts.add(new Contact(
            LastName = 'NonMatchingStatus',
            Support_Personal_1_1_Only__c = false
        ));
        
        contacts.add(new Contact(
            LastName = 'AlreadyFalse',
            Contact_Status__c = 'Bereaved Family - on hold',
            Support_Personal_1_1_Only__c = false
        ));
        
        insert contacts;
    }
    
    @isTest
    static void testBatchUpdateSupportBackup() {
        // Run the batch
        Test.startTest();
        BatchUpdateSupportBackup batch = new BatchUpdateSupportBackup();
        Database.executeBatch(batch, 200);
        Test.stopTest();
    }
}