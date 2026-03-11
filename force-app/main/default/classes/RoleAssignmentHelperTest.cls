@IsTest
public class RoleAssignmentHelperTest {
    
    // ---------- Utility Method ----------
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
    
    // ---------- Test Active Standard Users ----------
    @IsTest
    static void testGetActiveStandardUsers(){
        User activeUser = createUser('activeUsr', true);
        User inactiveUser = createUser('inactiveUsr', false);
        
        Test.startTest();
        RoleAssignmentHelper.getActiveStandardUsers();
        Test.stopTest();
        
    }
    
    // ---------- Test getFromUserList with valid inputs ----------
    @IsTest
    static void testGetFromUserList_valid(){
        User inactiveUser = createUser('inactiveUsr2', false);
        User activeUser   = createUser('activeUsr2', true);
        
        // Create test Accounts owned by inactive user
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 4; i++) {
            accounts.add(new Account(Name = 'Test Acc ' + i, OwnerId = inactiveUser.Id));
        }
        insert accounts;
        
        Test.startTest();
        RoleAssignmentHelper.getFromUserList('Account', 'OwnerId');
        Test.stopTest();
        
    }
    
    // ---------- Test getFromUserList with invalid inputs ----------
    @IsTest
    static void testGetFromUserList_invalid(){
        Test.startTest();
        RoleAssignmentHelper.getFromUserList('', '');
        Test.stopTest();
    }
    
    // ---------- Test getInactiveUsersMailingState for Contact ----------
    @IsTest
    static void testGetInactiveUsersMailingState_contact(){
        User fromUser = createUser('fromUsrC', false);
        Contact c1 = new Contact(LastName='Test Contact 1', OwnerId=fromUser.Id, MailingState='VIC');
        Contact c2 = new Contact(LastName='Test Contact 2', OwnerId=fromUser.Id, MailingState='NSW');
        Contact c3 = new Contact(LastName='Test Contact 3', OwnerId=fromUser.Id, MailingState='N/A');
        insert new List<Contact>{c1, c2, c3};
            
            Test.startTest();
        RoleAssignmentHelper.getInactiveUsersMailingState('Contact', 'OwnerId', fromUser.Id);
        Test.stopTest();
        
    }
    
    // ---------- Test getInactiveUsersMailingState for Account ----------
    @IsTest
    static void testGetInactiveUsersMailingState_account(){
        User fromUser = createUser('fromUsrA', false);
        Account acc1 = new Account(Name='Test A1', OwnerId=fromUser.Id, BillingState='QLD');
        Account acc2 = new Account(Name='Test A2', OwnerId=fromUser.Id, BillingState='NSW');
        Account acc3 = new Account(Name='Test A2', OwnerId=fromUser.Id, BillingState='N/A');
        insert new List<Account>{acc1, acc2, acc3};
            
            Test.startTest();
        RoleAssignmentHelper.getInactiveUsersMailingState('Account', 'OwnerId', fromUser.Id);
        Test.stopTest();
        
    }
    
    // ---------- Test Transfer Records + Batch execution ----------
    @IsTest
    static void testTransferRecords(){
        User fromUser = createUser('fromUsr', false);
        User toUser   = createUser('toUsr', true);
        
        Account acc1 = new Account(Name='Acc1', OwnerId = fromUser.Id, BillingState='VIC');
        Account acc2 = new Account(Name='Acc2', OwnerId = fromUser.Id, BillingState='NSW');
        Account acc3 = new Account(Name='Acc3', OwnerId = fromUser.Id, BillingState='N/A');
        insert new List<Account>{acc1, acc2, acc3};
            
            Test.startTest();
        RoleAssignmentHelper.transferRecords('Account', 'OwnerId', fromUser.Id, toUser.Id, 'N/A');
        Test.stopTest();
        
    }
    @IsTest
    static void testTransferRecordsAccountMS(){
        User fromUser = createUser('fromUsr', false);
        User toUser   = createUser('toUsr', true);
        
        Account acc1 = new Account(Name='Acc1', OwnerId = fromUser.Id, BillingState='VIC');
        Account acc2 = new Account(Name='Acc2', OwnerId = fromUser.Id, BillingState='NSW');
        Account acc3 = new Account(Name='Acc3', OwnerId = fromUser.Id, BillingState='N/A');
        insert new List<Account>{acc1, acc2, acc3};
            
            Test.startTest();
        RoleAssignmentHelper.transferRecords('Account', 'OwnerId', fromUser.Id, toUser.Id, 'VIC');
        Test.stopTest();
        
    }
    @IsTest
    static void testTransferRecordsContactMS(){
        User fromUser = createUser('fromUsr', false);
        User toUser   = createUser('toUsr', true);
        
        Contact c1 = new Contact(LastName='Test Contact 1', OwnerId=fromUser.Id, MailingState='VIC');
        Contact c2 = new Contact(LastName='Test Contact 2', OwnerId=fromUser.Id, MailingState='NSW');
        Contact c3 = new Contact(LastName='Test Contact 3', OwnerId=fromUser.Id, MailingState='N/A');
        insert new List<Contact>{c1, c2, c3};
            
            Test.startTest();
        RoleAssignmentHelper.transferRecords('Contact', 'OwnerId', fromUser.Id, toUser.Id, 'VIC');
        Test.stopTest();
    }
    
    
}