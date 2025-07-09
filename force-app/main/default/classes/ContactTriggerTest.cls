/*
*  Created by Girikon  22-Apr-2025
*  Test class for ContactTrigger class
*
*/
@isTest
public class ContactTriggerTest {
    
    @isTest
    static void testAfterInsertAndUpdate() {
        // Step 1: Create Account with Household RecordType
        RecordType householdRT = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'Household Account' LIMIT 1];
        Account acc = new Account(Name = 'Test Household', RecordTypeId = householdRT.Id);
        insert acc;
        
        // Step 2: Create a Parent Contact
        Contact parent = new Contact(
            FirstName = 'ParentFirst',
            LastName = 'ParentLast',
            AccountId = acc.Id,
            Personal_Connection_to_CHD__c = 'Heart Kid Parent/Carer'
        );
        insert parent;
        
        // Step 3: Create a Child Contact
        Contact child = new Contact(
            FirstName = 'ChildFirst',
            LastName = 'ChildLast',
            AccountId = acc.Id,
            Birthdate = Date.newInstance(2010, 5, 10),
            Gender__c = 'Male',
            Heart_Conditions__c = 'Arrhythmia',
            Heart_Conditions_Other__c = 'Other info',
            Aboriginal_or_Torres_Strait_Islander__c = 'Yes',
            Personal_Connection_to_CHD__c = 'Heart Kid'
        );
        insert child;
                
    }
}