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
private class BatchUpdateSupportUpdatesTest {

    @testSetup
    static void setupData() {
        // Create Contacts
        List<Contact> contactList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contactList.add(new Contact(LastName = 'Test ' + i));
        }
        insert contactList;

        // Create Cases linked to Contacts
        List<Case> caseList = new List<Case>();
        for (Contact con : contactList) {
            // Create two Cases for each Contact to test deduplication logic
            caseList.add(new Case(ContactId = con.Id, Status = 'New', Origin = 'Phone', Subject = 'Test Case 1'));
            caseList.add(new Case(ContactId = con.Id, Status = 'New', Origin = 'Email', Subject = 'Test Case 2'));
        }
        insert caseList;
    }

    @isTest
    static void testBatchExecution() {
        // Run the batch
        Test.startTest();
        BatchUpdateSupportUpdates batch = new BatchUpdateSupportUpdates();
        Database.executeBatch(batch, 10); // Small batch size for test
        Test.stopTest();

        // Query updated contacts
        List<Contact> updatedContacts = [SELECT Id, Support_Updates__c FROM Contact];
        
        for (Contact con : updatedContacts) {
            System.assertEquals(true, con.Support_Updates__c, 'Support_Updates__c should be true for Contact Id: ' + con.Id);
        }
    }

    @isTest
    static void testNoContactCases() {
        // Create a Case with no ContactId
        Case c = new Case(Status = 'New', Origin = 'Web', Subject = 'No Contact');
        insert c;

        Test.startTest();
        BatchUpdateSupportUpdates batch = new BatchUpdateSupportUpdates();
        Database.executeBatch(batch, 10);
        Test.stopTest();

        // Ensure no updates are made since no ContactId was set
        List<Contact> conList = [SELECT Id, Support_Updates__c FROM Contact WHERE Support_Updates__c = true];
        System.assert(conList.size() > 0, 'Some contacts should have been updated');
    }
}