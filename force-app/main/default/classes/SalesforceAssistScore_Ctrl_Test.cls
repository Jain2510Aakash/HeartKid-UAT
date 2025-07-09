/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 04, 2024
@description        : Test class for SalesforceAssistScore_Ctrl.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class SalesforceAssistScore_Ctrl_Test {


    @isTest
    static void testGetScoreRecords() {
        Test.startTest();
        Salesforce_Assist_Score__c assistData = TestDataFactory.createSalesforceAssistScoreRecord();
        insert assistData;
        // this method covered try block.
        List<Salesforce_Assist_Score__c> result = SalesforceAssistScore_Ctrl.getScoreRecords('Lead');
        // Validate results
        System.assertEquals(true, !result.isEmpty(),'List has values.');
        Test.stopTest();
    }

}