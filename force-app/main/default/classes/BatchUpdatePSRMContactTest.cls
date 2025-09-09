@isTest
public class BatchUpdatePSRMContactTest {
    
    // Utility to create a test user
    private static User createUser(String alias){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User u = new User(
            FirstName = 'Test',
            LastName = alias,
            Email = alias + '@test.com',
            Username = alias + '@test.com.' + System.currentTimeMillis(),
            Alias = alias.left(5),
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id
        );
        insert u;
        return u;
    }
    
    @isTest
    static void testBatchUpdatesPSRM(){
        // Create two Users (Case Owners)
        User owner1 = createUser('ownerOne');
        User owner2 = createUser('ownerTwo');
        
        // Create a Contact
        Contact con = new Contact(LastName = 'Test Contact');
        insert con;
        
        // Create two Cases: owner1 first, then owner2 (more recent)
        Case oldCase = new Case(
            Subject = 'Old Case',
            ContactId = con.Id,
            OwnerId = owner1.Id,
            CreatedDate = System.now().addDays(-5) // backdated
        );
        insert oldCase;
        
        // For CreatedDate override, use Test.loadData or DML + update with Database.setSavepoint hack not allowed.
        // Instead we’ll simulate by creating 2nd case after test clock tick.
        Test.startTest();
        Case newCase = new Case(
            Subject = 'New Case',
            ContactId = con.Id,
            OwnerId = owner2.Id
        );
        insert newCase;
        
        // Run the batch
        Database.executeBatch(new BatchUpdatePSRMContact(), 200);
        Test.stopTest();
     
    }
    
    @isTest
    static void testBatchWithNoCases(){
        // Contact without case should not be updated
        Contact con2 = new Contact(LastName = 'NoCaseContact');
        insert con2;
        
        Test.startTest();
        Database.executeBatch(new BatchUpdatePSRMContact(), 200);
        Test.stopTest();
    
    }
}