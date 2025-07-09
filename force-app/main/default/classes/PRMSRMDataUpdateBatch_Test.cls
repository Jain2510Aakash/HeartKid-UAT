/* 
* Created By:   {Girikon(Sahil Khan)}
* Created On:   Sep 02, 2024
* Description/Purpose:  Test class for PRMSRMDataUpdateBatch class.
*
* Modification log --
*/
@isTest
public with sharing class PRMSRMDataUpdateBatch_Test 
{
    @isTest
    static void executeTest1()
    {
        Contact con = new Contact();
        con.LastName = 'Test';
        INSERT con;
        Id grantRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Grant').getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Grant Opp Test', RecordTypeId = grantRecordTypeId, CloseDate = System.today(), StageName = 'Closed Won', Amount = 100, npsp__Primary_Contact__c = con.Id);
        INSERT opp;
        Test.startTest();
        PRMSRMDataUpdateBatch bObj = new PRMSRMDataUpdateBatch();
        Database.executeBatch(bObj);
        Test.stopTest();
    }
    @isTest
    static void executeTest2()
    {
        Contact con = new Contact();
        con.LastName = 'Test';
        INSERT con;
        Id donationRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Donation').getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Donation Opp Test', RecordTypeId = donationRecordTypeId, CloseDate = System.today(), StageName = 'Closed Won', Amount = 100, npsp__Primary_Contact__c = con.Id);
        INSERT opp;
        Test.startTest();
        PRMSRMDataUpdateBatch bObj = new PRMSRMDataUpdateBatch();
        Database.executeBatch(bObj);
        Test.stopTest();
    }
    @isTest
    static void executeTest3()
    {
        Contact con = new Contact();
        con.LastName = 'Test';
        INSERT con;
        Id majorGiftRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('MajorGift').getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Major Gift Opp Test', RecordTypeId = majorGiftRecordTypeId, CloseDate = System.today(), StageName = 'Closed Won', Amount = 100, npsp__Primary_Contact__c = con.Id);
        INSERT opp;
        Test.startTest();
        PRMSRMDataUpdateBatch bObj = new PRMSRMDataUpdateBatch();
        Database.executeBatch(bObj);
        Test.stopTest();
    }
    @isTest
    static void executeTest4()
    {
        Contact con = new Contact();
        con.LastName = 'Test';
        INSERT con;
        Id corporateRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('Corporate').getRecordTypeId();
        Opportunity opp = new Opportunity(Name = 'Corporate Opp Test', RecordTypeId = corporateRecordTypeId, CloseDate = System.today(), StageName = 'Closed Won', Amount = 100, npsp__Primary_Contact__c = con.Id);
        INSERT opp;
        Test.startTest();
        PRMSRMDataUpdateBatch bObj = new PRMSRMDataUpdateBatch();
        Database.executeBatch(bObj);
        Test.stopTest();
    }
}