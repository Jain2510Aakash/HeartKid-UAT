@IsTest
public class UpdatePrimaryRelationshipManagerTest {

    @IsTest
    static void testUpdatePrimaryRelationshipManager() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'PRM',
            Email = 'testprm@example.com',
            Username = 'testprm' + System.currentTimeMillis() + '@example.com',
            Alias = 'tprm',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = p.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;

        Contact testContact = new Contact(
            LastName = 'Test Contact'
        );
        insert testContact;

        UpdatePrimaryRelationshipManager.Request req =
            new UpdatePrimaryRelationshipManager.Request();
        req.contactId = testContact.Id;
        req.prmId = testUser.Id;

        List<UpdatePrimaryRelationshipManager.Request> requests =
            new List<UpdatePrimaryRelationshipManager.Request>{ req };

        Test.startTest();
        UpdatePrimaryRelationshipManager.updateContactPRM(requests);
        Test.stopTest();

        Contact updatedContact = [
            SELECT Id, Primary_Relationship_Manager__c
            FROM Contact
            WHERE Id = :testContact.Id
        ];

    }
}