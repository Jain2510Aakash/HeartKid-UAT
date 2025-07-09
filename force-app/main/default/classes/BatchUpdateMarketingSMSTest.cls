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
private class BatchUpdateMarketingSMSTest {

    @testSetup
    static void setupTestData() {
        List<Contact> contacts = new List<Contact>();

        // Contacts eligible for SMS marketing update
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(
                LastName = 'Eligible Contact ' + i,
                DoNotCall = false,
                npsp__Do_Not_Contact__c = false,
                No_SMS_Marketing__c = false,
                Marketing_SMS__c = false // Initially false
            ));
        }

        // Contacts not eligible due to various flags
        contacts.add(new Contact(
            LastName = 'Do Not Call Contact',
            DoNotCall = true,
            npsp__Do_Not_Contact__c = false,
            No_SMS_Marketing__c = false,
            Marketing_SMS__c = false
        ));

        contacts.add(new Contact(
            LastName = 'Do Not Contact Contact',
            DoNotCall = false,
            npsp__Do_Not_Contact__c = true,
            No_SMS_Marketing__c = false,
            Marketing_SMS__c = false
        ));

        contacts.add(new Contact(
            LastName = 'No SMS Marketing Contact',
            DoNotCall = false,
            npsp__Do_Not_Contact__c = false,
            No_SMS_Marketing__c = true,
            Marketing_SMS__c = false
        ));

        insert contacts;
    }

    @isTest
    static void testBatchExecution() {
        // Run the batch
        Test.startTest();
        BatchUpdateMarketingSMS batch = new BatchUpdateMarketingSMS();
        Database.executeBatch(batch, 5); // Small batch size for testing
        Test.stopTest();

        // Check that only eligible contacts were updated
        List<Contact> updatedContacts = [
            SELECT Id, Marketing_SMS__c
            FROM Contact
            WHERE DoNotCall = false
              AND npsp__Do_Not_Contact__c = false
              AND No_SMS_Marketing__c = false
        ];

        for (Contact con : updatedContacts) {
            System.assertEquals(true, con.Marketing_SMS__c,
                'Eligible contact should have Marketing_SMS__c = true');
        }

        // Ensure ineligible contacts were not updated
        List<Contact> ineligibleContacts = [
            SELECT Id, Marketing_SMS__c
            FROM Contact
            WHERE DoNotCall = true
               OR npsp__Do_Not_Contact__c = true
               OR No_SMS_Marketing__c = true
        ];

        for (Contact con : ineligibleContacts) {
            System.assertEquals(false, con.Marketing_SMS__c,
                'Ineligible contact should not have been updated');
        }
    }
}