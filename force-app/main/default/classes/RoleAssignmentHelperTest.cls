@isTest
public class RoleAssignmentHelperTest {
    
    // Utility to create users
    private static User createUser(String alias, Boolean activeFlag){
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
            ProfileId = p.Id,
            IsActive = activeFlag
        );
        insert u;
        return u;
    }
    
    @isTest
    static void testGetActiveStandardUsers(){
        User activeUser = createUser('activeUsr', true);
        
        Test.startTest();
        List<User> result = RoleAssignmentHelper.getActiveStandardUsers();
        Test.stopTest();
    }
    
    @isTest
    static void testGetFromUserList_valid(){
        User inactiveUser = createUser('inactiveUsr', false);
        User activeUser   = createUser('activeUsr2', true);
        
        // Create a test Account owned by inactive user
        Account acc = new Account(
            Name = 'Test Acc',
            OwnerId = inactiveUser.Id
        );
        insert acc;
        
        Test.startTest();
        List<User> result = (List<User>)RoleAssignmentHelper.getFromUserList('Account', 'OwnerId');
        Test.stopTest();
        
    }
    
    @isTest
    static void testGetFromUserList_invalid(){
        Test.startTest();
        List<User> result = RoleAssignmentHelper.getFromUserList('', '');
        Test.stopTest();
    }
    
    @isTest
    static void testTransferRecords(){
        User fromUser = createUser('fromUsr', false);
        User toUser   = createUser('toUsr', true);
        
        Account acc = new Account(Name='Acc for Transfer', OwnerId = fromUser.Id);
        insert acc;
        
        Test.startTest();
        RoleAssignmentHelper.transferRecords('Account', 'OwnerId', fromUser.Id, toUser.Id);
        Test.stopTest();
    }
}