/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 03, 2024
@description        : 

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class TestDataFactory {
    
    // This method insert record into Salesforce assist questions answer.
    public static Salesforce_Assist_Question_Answer__c assistDataAssistQuestionAnswerInsert()
    {
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
        assistData.Account_Q_1__c = 'Test';
        assistData.Account_Q_2__c = 2;
        assistData.Account_Q_3__c = 6;
        assistData.Account_Q_4__c = 1;
        assistData.Account_Q_5__c = 3;
        assistData.Account_Q_6__c = false;
        assistData.Account_Q_7__c = 1;
        assistData.Account_Business_Process__c = 'Diagram2';
        assistData.Contact_Q_1__c = 'Test1';
        assistData.Contact_Q_2__c = 1;
        assistData.Contact_Q_3__c = 1.2;
        assistData.Contact_Q_4__c = 8;
        assistData.Contact_Q_5__c = 4;
        assistData.Contact_Q_6__c = 6;
        assistData.Contact_Q_7__c = 7;
        assistData.Contact_Business_Process__c = 'Diagram3';
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

        insert assistData;

        return assistData;
    }
     // This method used to return Account instance.
     public static Account createAccountInstance()
     {
         Account acc=new Account(
             Name = 'Sahil',
             Phone = '1234567890'
         );
 
         return acc;
     }

    // This method used to return contact instance.
    public static Contact createContactInstance()
    {
        Contact cont=new Contact(
            LastName = 'Sahil'
        );

        return cont;
    }

    // This method used to return task instance.
    public static Task createTaskInstance()
    {
        Task tsk = new Task(Subject = 'Test Task');

        return tsk;
    }

    public static Interrogation__c createInterrogationIntance()
    {
         Interrogation__c interrogate = new Interrogation__c(
            Label__c = 'Name',
            Object_Type__c = 'Lead',
            DataType__c	= 'Text',
            Pick_Values__c = 'test1;test2'
         );
         return interrogate;
    }

    public static Salesforce_Assist_Score__c createSalesforceAssistScoreRecord()
    {
        Salesforce_Assist_Score__c assistScore = new Salesforce_Assist_Score__c(
            Scoring_Rule_Name__c = 'Number should not be blank.',
            Object_Type__c = 'Lead',
            Output__c	= 10,
            Rule__c = 'Number should not be blank.'
         );
         return assistScore;
    }

}