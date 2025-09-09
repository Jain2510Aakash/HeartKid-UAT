@isTest
public class CaseTriggerTest {
    
    // Utility to create a test User
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
    static void testAfterInsert() {
        User owner1 = createUser('owner1');
        Contact con = new Contact(LastName = 'TestCon');
        insert con;
        
        Test.startTest();
        Case c = new Case(Subject = 'Case1', ContactId = con.Id, OwnerId = owner1.Id);
        insert c;
        Test.stopTest();
        
    }
    
    @isTest
    static void testAfterUpdate_ownerChange() {
        User owner1 = createUser('owner2a');
        User owner2 = createUser('owner2b');
        Contact con = new Contact(LastName = 'TestCon2');
        insert con;
        
        Case c = new Case(Subject = 'Case2', ContactId = con.Id, OwnerId = owner1.Id);
        insert c;
        
        Test.startTest();
        c.OwnerId = owner2.Id;
        update c;   // triggers afterUpdate
        Test.stopTest();
        
    }
    
    @isTest
    static void testAfterUpdate_contactChange() {
        User owner1 = createUser('owner3a');
        Contact con1 = new Contact(LastName = 'ContactOne');
        Contact con2 = new Contact(LastName = 'ContactTwo');
        insert new List<Contact>{con1, con2};
            
            Case c = new Case(Subject = 'Case3', ContactId = con1.Id, OwnerId = owner1.Id);
        insert c;
        
        Test.startTest();
        // Move case to a different contact
        c.ContactId = con2.Id;
        update c;
        Test.stopTest();
       
    }
    
    @isTest
    static void testAfterDelete() {
        User owner1 = createUser('owner4a');
        User owner2 = createUser('owner4b');
        
        Contact con = new Contact(LastName = 'DeleteTest');
        insert con;
        
        Case c1 = new Case(Subject = 'Older Case', ContactId = con.Id, OwnerId = owner1.Id);
        insert c1;
        Case c2 = new Case(Subject = 'Newer Case', ContactId = con.Id, OwnerId = owner2.Id);
        insert c2;
        
    
        Test.startTest();
        delete c2;   // delete most recent case
        Test.stopTest();
    }
}