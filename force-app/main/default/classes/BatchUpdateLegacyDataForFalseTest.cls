@isTest
public class BatchUpdateLegacyDataForFalseTest {
    
    @testSetup
    static void setupData() {
        // Create test contacts
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 1; i++) {
            contacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                Email = 'test' + i + '@email.com',
                Donor_Emails__c = true,
                Donor_SMS__c = true,
                Donor_Phone_Calls__c = true
            ));
        }
        insert contacts;
        
        // Create an Account for Opportunity
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Create a Closed Won Opportunity linked to one of the contacts
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 1000,
            AccountId = acc.Id
        );
        insert opp;
        
        // Link Contact[0] to this Closed Won Opportunity
        OpportunityContactRole ocr = new OpportunityContactRole(
            OpportunityId = opp.Id,
            ContactId = contacts[0].Id,
            Role = 'Decision Maker'
        );
        insert ocr;
    }
    
    @isTest
    static void testBatchUpdateLegacyDataForFalse() {
        // Run the batch
        Test.startTest();
        BatchUpdateLegacyDataForFalse batch = new BatchUpdateLegacyDataForFalse();
        Database.executeBatch(batch, 1);
        Test.stopTest();
        
    }
}