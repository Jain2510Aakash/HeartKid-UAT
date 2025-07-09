/*
*  Created by Girikon  21-Apr-2025
*  Test class for BatchFillPrimarySecondaryCont class
*
*/
@isTest
public class BatchFillPrimarySecondaryContTest {
    
    @testSetup
    static void setupTestData() {
        // Create RecordType for Household Account if not already present
        Id householdRTId;
        if (Test.isRunningTest()) {
            householdRTId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
        }
        
        // Create test Household Account
        Account acc = new Account(
            Name = 'Test Household Account',
            RecordTypeId = householdRTId
        );
        insert acc;
        
        // Parent Contact with a matching role
        Contact parent = new Contact(
            FirstName = 'ParentFirst',
            LastName = 'ParentLast',
            AccountId = acc.Id,
            Personal_Connection_to_CHD__c = 'Heart Kid Parent/Carer'
        );
        
        // Multiple Child Contacts
        List<Contact> childContacts = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            childContacts.add(new Contact(
                FirstName = 'ChildFirst' + i,
                LastName = 'ChildLast' + i,
                AccountId = acc.Id,
                Birthdate = Date.today().addYears(-10 - i),
                Gender__c = 'Male',
                Heart_Conditions__c = 'Bicuspid Valve',
                Heart_Conditions_Other__c = 'Other Info',
                Aboriginal_or_Torres_Strait_Islander__c = 'No',
                Personal_Connection_to_CHD__c = 'Heart Kid'
            ));
        }
        
        insert parent;
        insert childContacts;
    }
    
    @isTest
    static void testBatchExecution() {
        // Instantiate the batch class
        Test.startTest();
        BatchFillPrimarySecondaryCont batch = new BatchFillPrimarySecondaryCont();
        ID batchId = Database.executeBatch(batch, 200);
        Test.stopTest();
        
        // Validate updates
        List<Contact> updatedParents = [SELECT Id, Child_1_First_Name__c, Child_2_First_Name__c, Child_3_First_Name__c FROM Contact WHERE FirstName LIKE '%Parent%'];
        
        System.assertEquals(1, updatedParents.size(), 'One parent should be updated');
        System.assertEquals('ChildFirst0', updatedParents[0].Child_1_First_Name__c);
        System.assertEquals('ChildFirst1', updatedParents[0].Child_2_First_Name__c);
        System.assertEquals('ChildFirst2', updatedParents[0].Child_3_First_Name__c);
    }
}