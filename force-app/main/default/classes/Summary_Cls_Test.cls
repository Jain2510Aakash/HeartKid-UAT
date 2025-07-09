/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 04, 2024
@description        : Test class for Summary_Cls.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class Summary_Cls_Test {

    @testSetup
    static void makeData()
    {
        // Create Account data
        Salesforce_Assist_Score__c score = TestDataFactory.createSalesforceAssistScoreRecord();
        insert score;

    }

    @isTest
    static void testGetRecordTypeDetails() {
        Test.startTest();
        // Setup mock callout
        // MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        // Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        //Get recordType with object.
        List<RecordType> record1 = Summary_Cls.getRecordTypeDetails('Account');
        //Get record type without object.
        List<RecordType> record2 = Summary_Cls.getRecordTypeDetails('');
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testGetValidationRules() {
        Test.startTest();
        //Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        List<ExtractDataCls.Modal3> validationRule = Summary_Cls.getValidationRules();
    
        // Validate results
        //System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testGetApexClasses() {
        Test.startTest();
        // Invoke the method
        List<ApexClass> apexList = Summary_Cls.getApexClasses();
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testGetflows() {
        Test.startTest();
        // Invoke the method
        //Get flows along with object.
        List<FlowDefinitionView> flowList1 = Summary_Cls.getflows('Account');
        //Get flows along without object.
        List<FlowDefinitionView> flowList2 = Summary_Cls.getflows('');
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testGetCustomObject() {
        Test.startTest();
        //Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        List<Summary_Cls.Modal1> customObject = Summary_Cls.getCustomObject();
    
        // Validate results
        //System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testGetDuplicateRule() {
        Test.startTest();
        // Invoke the method
        //Get duplicate along with object.
        List<DuplicateRule> duplicateRule1 = Summary_Cls.getDuplicateRule('Account');
        //Get duplicate along without object.
        List<DuplicateRule> duplicateRule2 = Summary_Cls.getDuplicateRule('');
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    // @isTest
    // static void testMetaData() {
    //     Test.startTest();
    //     // Invoke the method
    //     List<Range_Setting__mdt> metadata = Summary_Cls.getMetadataType();
    //     // Validate results
    //    // System.assertEquals(accountExtract != Null, accountExtract,'test');
    //     Test.stopTest();
    // }

    @isTest
    static void testGetSalesforceAssistData() {
        Test.startTest();
        Salesforce_Assist_Question_Answer__c assistQuestions = TestDataFactory.assistDataAssistQuestionAnswerInsert();
        // Invoke the method
        Salesforce_Assist_Question_Answer__c result = Summary_Cls.getSalesforceAssistData();
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testAllObjectScore() {
        Test.startTest();
        // Invoke the method
        List<Salesforce_Assist_Score__c> result = Summary_Cls.allObjectScore();
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }
}