@isTest
public class DedupeAccountsBatchTest {
    @testSetup
    static void setup() {
        // Create mock accounts with duplicate data
        Id householdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
        Account acc1 = new Account(Name = 'Test Account', BillingStreet = '123 Test St', BillingCity = 'Test City', 
                                   BillingState = 'TS', BillingPostalCode = '12345', BillingCountry = 'USA', Is_Duplicate__c = false, RecordTypeId = householdAccount);
        insert acc1;
        
        Account acc2 = new Account(Name = 'Test Account', BillingStreet = '123 Test St', BillingCity = 'Test City', 
                                   BillingState = 'TS', BillingPostalCode = '12345', BillingCountry = 'USA', Is_Duplicate__c = false, RecordTypeId = householdAccount);
        insert acc2;
        
        // Create related records for the first account
        Contact con1 = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc1.Id);
        insert con1;
        
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = acc1.Id);
        insert opp1;
        
        Case cs1 = new Case(Subject = 'Test Case 1', AccountId = acc1.Id);
        insert cs1;
        
        npsp__Address__c add1 = new npsp__Address__c(npsp__Household_Account__c = acc1.Id);
        insert add1;
        
        npe5__Affiliation__c aff1 = new npe5__Affiliation__c(npe5__Contact__c = con1.Id, npe5__Organization__c = acc1.Id);
        insert aff1;
        
        Task tsk1 = new Task(Subject = 'Test Subject 1', WhatId = acc1.Id);
        insert tsk1;
        
        // Create related records for the second account
        Contact con = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = acc2.Id);
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = acc2.Id);
        insert opp;
        
        Case cs = new Case(Subject = 'Test Case', AccountId = acc2.Id);
        insert cs;
        
        npsp__Address__c add = new npsp__Address__c(npsp__Household_Account__c = acc2.Id);
        insert add;
        
        npe5__Affiliation__c aff = new npe5__Affiliation__c(npe5__Contact__c = con.Id, npe5__Organization__c = acc2.Id);
        insert aff;
        
        Task tsk = new Task(Subject = 'Test Subject', WhatId = acc2.Id);
        insert tsk;
        
        acc1.Name = 'Test Account';
        UPDATE acc1;
        
        acc1.Name = 'Test Account';
        UPDATE acc2;   
    }
    
    @isTest
    static void testDedupeAccountsBatch() {
        // Start the test
        Test.startTest();
        // Create an instance of the batch class and run it
        DedupeAccountsBatch batch = new DedupeAccountsBatch();
        Database.executeBatch(batch);
        
        // Stop the test
        Test.stopTest();
    }
}