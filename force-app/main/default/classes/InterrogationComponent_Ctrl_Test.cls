/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 04, 2024
@description        : Test class for InterrogationComponent_Ctrl.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class InterrogationComponent_Ctrl_Test {
    @testSetup
    static void makeData()
    {
        // Create Account data
        Interrogation__c interrogate = TestDataFactory.createInterrogationIntance();
        insert interrogate;
       

    }

    @isTest
    static void testCreateFieldRecord() {
        Test.startTest();
        //Get the interrogation instance.
        Interrogation__c interrogate = TestDataFactory.createInterrogationIntance();
        // Invoke the method
        String result = InterrogationComponent_Ctrl.createFieldRecord(interrogate);
        // Validate results
        System.assertEquals('Success', result,'Record inserted successfully.');
        Test.stopTest();
    }

    @isTest
    static void testDeleteRecord() {
        Test.startTest();
        //Get the interrogation instance.
        String recordId = [Select Id From Interrogation__c Where Label__c = 'Name'].Id;
        // Invoke the method
        String result = InterrogationComponent_Ctrl.deleteRecord(recordId);
        // Validate results
        System.assertEquals('Success', result,'Record Deleted successfully.');
        Test.stopTest();
    }

    @isTest
    static void testUpdateRecord() {
        Test.startTest();
        List<Interrogation__c> interList = new List<Interrogation__c>();
        Interrogation__c interRecord = [Select Id,Name From Interrogation__c Where Label__c = 'Name'];
        interRecord.value__c = 'Account';
        interList.add(interRecord);
        // Invoke the method
        Boolean result = InterrogationComponent_Ctrl.updateRecords(interList);
        // Validate results
        System.assertEquals(true, result,'Record Updated successfully.');
        Test.stopTest();
    }

    @isTest
    static void testGetRecord() {
        
        Test.startTest();
        String recordId = [Select Id,Label__c From Interrogation__c Where Label__c = 'Name'].Id;
        // Invoke the method
        Interrogation__c result = InterrogationComponent_Ctrl.getRecord(recordId);
        // Validate results
        System.assertEquals('Name', result.Label__c,'Success');
        Test.stopTest();
        
    }

    @isTest
    static void testGetAllTheFieldValues() {
        
        Test.startTest();
       
        // Invoke the method
        List<InterrogationComponent_Ctrl.FieldCreator_Cls> result = InterrogationComponent_Ctrl.getAllTheFieldValues('Lead');
        List<InterrogationComponent_Ctrl.Option_cls> optionResult = InterrogationComponent_Ctrl.createMergeFields('Lead');
        // Validate results
        //System.assertEquals('Name', result.Label__c,'Success');
        Test.stopTest();
        
    }
    
}