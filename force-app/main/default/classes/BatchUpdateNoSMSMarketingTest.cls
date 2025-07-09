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
private class BatchUpdateNoSMSMarketingTest {

    @testSetup
    static void setupTestData() {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(
                LastName = 'Contact ' + i,
                No_SMS_Marketing__c = true,
                Marketing_SMS__c = true,  // Initially true
                Donor_SMS__c = true       // Initially true
            ));
        }

        // Contacts that shouldn't be updated
        for (Integer i = 0; i < 3; i++) {
            contacts.add(new Contact(
                LastName = 'Other Contact ' + i,
                No_SMS_Marketing__c = false,
                Marketing_SMS__c = true,
                Donor_SMS__c = true
            ));
        }

        insert contacts;
    }

    @isTest
    static void testBatchExecution() {
        Test.startTest();
        BatchUpdateNoSMSMarketing batch = new BatchUpdateNoSMSMarketing();
        Database.executeBatch(batch, 5);  // Small batch size for test
        Test.stopTest();

        // Query contacts where No_SMS_Marketing__c was true
        List<Contact> updatedContacts = [
            SELECT Id, Marketing_SMS__c, Donor_SMS__c
            FROM Contact
            WHERE No_SMS_Marketing__c = true
        ];

        for (Contact con : updatedContacts) {
            System.assertEquals(false, con.Marketing_SMS__c, 'Marketing_SMS__c should be false');
            System.assertEquals(false, con.Donor_SMS__c, 'Donor_SMS__c should be false');
        }

        // Ensure others were not modified
        List<Contact> untouchedContacts = [
            SELECT Id, Marketing_SMS__c, Donor_SMS__c
            FROM Contact
            WHERE No_SMS_Marketing__c = false
        ];

        for (Contact con : untouchedContacts) {
            System.assertEquals(true, con.Marketing_SMS__c, 'Other contacts should not be updated');
            System.assertEquals(true, con.Donor_SMS__c, 'Other contacts should not be updated');
        }
    }
}