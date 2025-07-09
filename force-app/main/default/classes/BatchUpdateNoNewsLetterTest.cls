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
private class BatchUpdateNoNewsLetterTest {

    @testSetup
    static void setupTestData() {
        List<Contact> contacts = new List<Contact>();

        // Contacts to be updated
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(
                LastName = 'Newsletter Blocked ' + i,
                No_Newsletter__c = true,
                Marketing_Emails__c = true  // Initially true
            ));
        }

        // Contacts that should not be updated
        for (Integer i = 0; i < 3; i++) {
            contacts.add(new Contact(
                LastName = 'Newsletter Allowed ' + i,
                No_Newsletter__c = false,
                Marketing_Emails__c = true
            ));
        }

        insert contacts;
    }

    @isTest
    static void testBatchExecution() {
        // Execute the batch class
        Test.startTest();
        BatchUpdateNoNewsLetter batch = new BatchUpdateNoNewsLetter();
        Database.executeBatch(batch, 5);  // Use small batch size for testing
        Test.stopTest();

        // Verify that only applicable contacts were updated
        List<Contact> updatedContacts = [
            SELECT Id, Marketing_Emails__c
            FROM Contact
            WHERE No_Newsletter__c = true
        ];

        for (Contact con : updatedContacts) {
            System.assertEquals(false, con.Marketing_Emails__c, 'Marketing_Emails__c should be false for contact with No_Newsletter__c = true');
        }

        // Verify that others remain unchanged
        List<Contact> unchangedContacts = [
            SELECT Id, Marketing_Emails__c
            FROM Contact
            WHERE No_Newsletter__c = false
        ];

        for (Contact con : unchangedContacts) {
            System.assertEquals(true, con.Marketing_Emails__c, 'Marketing_Emails__c should remain true for contact with No_Newsletter__c = false');
        }
    }
}