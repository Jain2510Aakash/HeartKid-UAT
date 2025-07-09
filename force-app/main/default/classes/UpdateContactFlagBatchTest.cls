/*
Created By          : Girikon (Mohd Sahil)
Created On          : Oct 28, 2024
@description        : 
Test Class          : UpdateContactDuplicateRecordFlagBatch (Coverage: 90%)

Modification log --
Modified By         : 
Modified On         : 

*/
@isTest
public class UpdateContactFlagBatchTest {
    @testSetup
    static void setup() {
        // Create mock accounts with duplicate data
        Id householdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
        Account acc1 = new Account(Name = 'Test Account', BillingStreet = '123 Test St', BillingCity = 'Test City', 
                                   BillingState = 'TS', BillingPostalCode = '12345', BillingCountry = 'USA', Is_Duplicate__c = false, RecordTypeId = householdAccount);
        insert acc1;
        
        Account acc2 = new Account(Name = 'Test Account1', BillingStreet = '123 Test St', BillingCity = 'Test City', 
                                   BillingState = 'TS', Is_Duplicate__c = false, RecordTypeId = householdAccount);
        insert acc2;
        
        // Create mock contacts with duplicate data
        Contact con1 = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@gmail.com' , Phone = '1111111111', Duplicate_Contact_Flag__c = false, AccountId = acc1.Id);
        insert con1;
        Contact con2 = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@gmail.com' , Phone = '1111111111', Duplicate_Contact_Flag__c = false, AccountId = acc2.Id);
        insert con2;
        // Create related records for the first contact
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity 1', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = acc1.Id, npsp__Primary_Contact__c = con1.Id);
        insert opp1;
        
        /*OpportunityContactRole oppCont1 = new OpportunityContactRole(OpportunityId = opp1.Id, ContactId = con1.Id, IsPrimary = true);
        insert oppCont1;*/
        
        Case cs1 = new Case(Subject = 'Test Case 1', contactId = con1.Id);
        insert cs1;
        
        npe5__Affiliation__c aff1 = new npe5__Affiliation__c(npe5__Contact__c = con1.Id , npe5__Organization__c = acc1.Id, npe5__Description__c = 'Test Description' , npe5__EndDate__c=Date.today().addDays(30),npe5__Primary__c = true
                                                            , npsp__Related_Opportunity_Contact_Role__c = 'Soft Credit', npe5__Role__c = 'CEO', npe5__StartDate__c = date.today(), npe5__Status__c = 'Current');
        insert aff1;
        
        Task tsk1 = new Task(Subject = 'Test Subject 1', WhoId = con1.Id);
        insert tsk1;
        
        Dependents__c dep1 = new Dependents__c(Primary_Contact__c = con1.Id); 
        insert dep1;
        
        Dependents__c dep2 = new Dependents__c(Secondary_Contact__c = con1.Id); 
        insert dep2;
        
        npe4__Relationship__c rel1 = new npe4__Relationship__c(npe4__Contact__c = con1.Id, npe4__Status__c = 'Current', npe4__RelatedContact__c	= con2.Id,npe4__Description__c = 'relationship test',npe4__SYSTEM_SystemCreated__c = true
                                                              ,npe4__Type__c = 'Family',npsp__Related_Opportunity_Contact_Role__c = 'Soft Credit');
        insert rel1;
        
        // Create related records for the second contact
               
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = acc2.Id, npsp__Primary_Contact__c = con2.Id);
        insert opp;
        
        /*OpportunityContactRole oppCont = new OpportunityContactRole(OpportunityId = opp.Id, ContactId = con2.Id, IsPrimary = true);
        insert oppCont;*/
        
        Case cs = new Case(Subject = 'Test Case', contactId = con2.Id);
        insert cs;
        
        npe5__Affiliation__c aff = new npe5__Affiliation__c(npe5__Contact__c = con2.Id, npe5__Organization__c = acc2.Id);
        insert aff;
        
        Task tsk = new Task(Subject = 'Test Subject', WhoId = con2.Id);
        insert tsk;
        
        Dependents__c dep3 = new Dependents__c(Primary_Contact__c = con2.Id); 
        insert dep3;
        
        Dependents__c dep4 = new Dependents__c(Secondary_Contact__c = con2.Id); 
        insert dep4;
        
        npe4__Relationship__c rel = new npe4__Relationship__c(npe4__Contact__c = con2.Id, npe4__Status__c = 'Current', npe4__RelatedContact__c	= con1.Id);
        insert rel;

    }
    
    @isTest
    static void testDedupeAccountsBatch() {
        // Start the test
        Test.startTest();
        
        // Create an instance of the batch class and run it
        UpdateContactDuplicateRecordFlagBatch batch = new UpdateContactDuplicateRecordFlagBatch();
        Database.executeBatch(batch);
        
        // Stop the test
        Test.stopTest();
    }

}