/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 03, 2024
@description        : Test class for ExtractDataCls and ToolingAPI_Cls.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class ExtractDataCls_Test {

    @testSetup
    static void makeData()
    {
        // Create Lead data
        Lead testLead = new Lead(LastName = 'Test',Company = 'Test Company',LeadSource = 'Web', Status = 'New');
        insert testLead;
        // Create Task for Lead.
        Task leadTask = new Task(Subject = 'Test Task', WhoId = testLead.Id);
        insert leadTask;

        /* Insert Pricebook */
        Pricebook2 customPricebook = new Pricebook2(
            Name = 'Custome Price book',
            IsActive = true
        );
        insert customPricebook;
        /* Create Product */
        Product2 pro = new Product2(Name = 'iPhone X');
        Insert pro;
        /* Create Standard Pricebook Entry*/
        PricebookEntry pbe1 = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe1;
        /* Create Custom Pricebook Entry*/
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = customPricebook.Id,
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        /* Create Opportunity */
        Opportunity opp = new Opportunity(
            Name ='Hubspot Opportunity', StageName='Discovery',Amount=100, CloseDate=System.today().addDays(34),
            Pricebook2Id = customPricebook.Id
        );
        insert opp;

        OpportunityLineItem testOLI = new OpportunityLineItem(
            OpportunityId = opp.Id, 
            Quantity = 1, 
            UnitPrice = 100, 
            PricebookEntryId = pbe.Id
        );
        insert testOLI;

        Task testTask = new Task(Subject = 'Test Task', WhatId = opp.Id);
        insert testTask;

    }
 
    @isTest
    static void testLeadExtract() {
        Test.startTest();
        
        // Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);

         Salesforce_Assist_Question_Answer__c assistData = TestDataFactory.assistDataAssistQuestionAnswerInsert();
        // call the "updateSalesforceAssistData" Method for lead update.
        String leadAssitData = ExtractDataCls.updateSalesforceAssistData(assistData, 'Lead');
        // call the "updateSalesforceAssistData" Method for Account update.
        String accountAssitData = ExtractDataCls.updateSalesforceAssistData(assistData, 'Account');
        // call the "updateSalesforceAssistData" Method for Contact update.
        String contactAssitData = ExtractDataCls.updateSalesforceAssistData(assistData, 'Contact');
        // call the "updateSalesforceAssistData" Method for Opportunity update.
        String opportunityAssitData = ExtractDataCls.updateSalesforceAssistData(assistData, 'Opportunity');
        String leadDiagramBody = ExtractDataCls.updateDiagramBody('lead Diagram', 'Lead');
        String accDiagramBody = ExtractDataCls.updateDiagramBody('Account Diagram', 'Account');
        String contDiagramBody = ExtractDataCls.updateDiagramBody('Contact Diagram', 'Contact');
        String oppDiagramBody = ExtractDataCls.updateDiagramBody('Opportunity Diagram', 'Opportunity');
        Salesforce_Assist_Question_Answer__c result3 = ExtractDataCls.getDiagramBody();
        Decimal result4 = ExtractDataCls.leadWithActivities();
        Decimal result5 = ExtractDataCls.opportunityWithActivities();
        Organization result6 = ExtractDataCls.getOrgDetails();
        List<ExtractDataCls.Modal4> result7 = ExtractDataCls.getAllLicenses();
        // Invoke the method
        ExtractDataCls.Modal result8 = ExtractDataCls.leadExtract();
        
        // Validate results
        //System.assertNotEquals(null, result);
        //System.assertEquals('Lead',result.relationShipObject);
        //System.assertEquals(1, result.percentageOfActivities);
        //System.assertEquals(true, result.isConverted);

        Test.stopTest();
    }
    
    // This method Cover Else part of updateSalesforceAssistData method.
    @isTest
    static void testLeadUpdateSalesforceAssistData() {
        Test.startTest();
        
        // Create test data for lead
        Salesforce_Assist_Question_Answer__c assistData = new Salesforce_Assist_Question_Answer__c();
        assistData.Lead_Q_1__c = 1.1;
        assistData.Lead_Q_2__c = 'Answer 2';
        assistData.Lead_Q_3__c = true;
        assistData.Lead_Q_4__c = 'Answer 4';
        assistData.Lead_Q_5__c = 'Answer 5';
        assistData.Lead_Q_6__c = 1;
        assistData.Lead_Q_7__c = 2.1;
        assistData.Lead_Q_8__c = 2.2;
        assistData.Lead_Q_9__c = 2.3;
        assistData.Lead_Business_Process__c = 'Diagram';
        
        // Invoke the method
        String result = ExtractDataCls.updateSalesforceAssistData(assistData, 'Lead');
        // Validate results
        System.assertEquals('Inserted', result,'Record Insert Successfully');
        
        Test.stopTest();
    }

    // This method Cover Else part of updateSalesforceAssistData method.
    @isTest
    static void testAccountUpdateSalesforceAssistData() {
        Test.startTest();
        
        // Create test data for lead
        Salesforce_Assist_Question_Answer__c assistData = new Salesforce_Assist_Question_Answer__c();
        assistData.Account_Q_1__c = 'Test';
        assistData.Account_Q_2__c = 2;
        assistData.Account_Q_3__c = 6;
        assistData.Account_Q_4__c = 1;
        assistData.Account_Q_5__c = 3;
        assistData.Account_Q_6__c = false;
        assistData.Account_Q_7__c = 1;
        assistData.Account_Business_Process__c = 'Diagram2';
        
        // Invoke the method
        String result = ExtractDataCls.updateSalesforceAssistData(assistData, 'Account');
        
        // Validate results
        System.assertEquals('Inserted', result,'Record Insert Successfully');
        
        Test.stopTest();
    }

     // This method Cover Else part of updateSalesforceAssistData method.
     @isTest
     static void testContactUpdateSalesforceAssistData() {
         Test.startTest();
         
         // Create test data for lead
         Salesforce_Assist_Question_Answer__c assistData = new Salesforce_Assist_Question_Answer__c();
         assistData.Contact_Q_1__c = 'Test1';
        assistData.Contact_Q_2__c = 1;
        assistData.Contact_Q_3__c = 1.2;
        assistData.Contact_Q_4__c = 8;
        assistData.Contact_Q_5__c = 4;
        assistData.Contact_Q_6__c = 6;
        assistData.Contact_Q_7__c = 7;
        assistData.Contact_Business_Process__c = 'Diagram3';
         
         // Invoke the method
         String result = ExtractDataCls.updateSalesforceAssistData(assistData, 'Contact');
         
         // Validate results
         System.assertEquals('Inserted', result,'Record Insert Successfully');
         
         Test.stopTest();
     }

     // This method Cover Else part of updateSalesforceAssistData method.
     @isTest
     static void testOpportunityUpdateSalesforceAssistData() {
         Test.startTest();
         
         // Create test data for lead
        Salesforce_Assist_Question_Answer__c assistData = new Salesforce_Assist_Question_Answer__c();
        assistData.Opportunity_Q_1__c = 2.1;
        assistData.Opportunity_Q_2__c = 2.2;
        assistData.Opportunity_Q_3__c = 'test3';
        assistData.Opportunity_Q_4__c = 'test4';
        assistData.Opportunity_Q_5__c = 1;
        assistData.Opportunity_Q_6__c = 2;
        assistData.Opportunity_Q_7__c = 4;
        assistData.Opportunity_Q_8__c = 2;
        assistData.Opportunity_Q_9__c = 1;
        assistData.Opportunity_Business_Process__c = 'Diagram4';
         
         // Invoke the method
         String result = ExtractDataCls.updateSalesforceAssistData(assistData, 'Opportunity');
         // Validate results
         System.assertEquals('Inserted', result,'Record Insert Successfully');
         
         Test.stopTest();
     }
 
    @isTest
    static void testOpportunityExtract() {
        Test.startTest();
        
        // Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);

        // Invoke the method
        ExtractDataCls.Modal2 result = ExtractDataCls.opporunityExtract();
        
        // Validate results
        //System.assertNotEquals(null, result);
        //System.assertEquals('Opportunity', result.relationShipObject);
        //System.assertEquals(1, result.percentageOfActivities);

        Test.stopTest();
    }
    
}