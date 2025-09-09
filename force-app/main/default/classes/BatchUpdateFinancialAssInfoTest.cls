@isTest
private class BatchUpdateFinancialAssInfoTest {
    
    @isTest
    static void testScheduledClassLogic() {
        // Create dummy accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                Total_Financial_Assistance_Provided_CFY__c = 1000,
                Total_In_Kind_Assistance_Provided_CFY__c = 500
            ));
        }
        insert accounts;

        // Run the scheduled class logic directly
        Test.startTest();
        new ScheduleBatchUpdateFinancialAssInfo().execute(null); // Direct call
        Test.stopTest();
    }
}