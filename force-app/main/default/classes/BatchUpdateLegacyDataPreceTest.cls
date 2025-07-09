@isTest
public class BatchUpdateLegacyDataPreceTest {

    @isTest
    static void testBatchUpdateLegacyDataPrece() {
        // Create contacts
        Contact contactWithClosedWon = new Contact(FirstName = 'John', LastName = 'Doe');
        Contact contactWithoutClosedWon = new Contact(FirstName = 'Jane', LastName = 'Smith');
        insert new List<Contact>{ contactWithClosedWon, contactWithoutClosedWon };

        // Create a Closed Won opportunity related to the first contact
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            ContactId = contactWithClosedWon.Id
        );
        insert opp;

        // Run the batch
        Test.startTest();
        BatchUpdateLegacyDataPrece batch = new BatchUpdateLegacyDataPrece();
        Database.executeBatch(batch);
        Test.stopTest();

        // Reload contacts to check updated values
        List<Contact> updatedContacts = [SELECT Id, Donor_Emails__c, Donor_SMS__c, Donor_Phone_Calls__c,
                                         (SELECT Id, StageName FROM Opportunities WHERE StageName = 'Closed Won')
                                         FROM Contact WHERE Id IN :new List<Id>{contactWithClosedWon.Id, contactWithoutClosedWon.Id}];

        for (Contact c : updatedContacts) {
            if (c.Id == contactWithClosedWon.Id) {
                System.assertEquals(true, c.Donor_Emails__c, 'Should be true for contact with Closed Won');
                System.assertEquals(true, c.Donor_SMS__c, 'Should be true for contact with Closed Won');
                System.assertEquals(true, c.Donor_Phone_Calls__c, 'Should be true for contact with Closed Won');
            } else {
                System.assertEquals(false, c.Donor_Emails__c, 'Should be false for contact without Closed Won');
                System.assertEquals(false, c.Donor_SMS__c, 'Should be false for contact without Closed Won');
                System.assertEquals(false, c.Donor_Phone_Calls__c, 'Should be false for contact without Closed Won');
            }
        }
    }
}