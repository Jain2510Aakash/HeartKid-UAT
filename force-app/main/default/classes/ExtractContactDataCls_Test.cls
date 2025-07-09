/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 04, 2024
@description        : Test class for ExtractContactDataCls.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class ExtractContactDataCls_Test {
    @testSetup
    static void makeData()
    {
        // Create Account data
        Account acc = TestDataFactory.createAccountInstance();
        insert acc;
        // Create Contact data
        Contact cont = TestDataFactory.createContactInstance();
        cont.AccountId = acc.Id;
        insert cont;
        // Create Task for Contact.
        Task contTask = TestDataFactory.createTaskInstance();
        contTask.WhoId = cont.Id;
        // contTask.Subject = 'Call';
        // contTask.Status = 'Completed';
        // contTask.Priority = 'Normal';
        // contTask.ActivityDate = System.today();
        insert contTask;

    }

    @isTest
    static void testContactExtract() {
        Test.startTest();
        // Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        ExtractAccountDataCls.Modal1 contactExtract = ExtractContactDataCls.extractContact();
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }
   
}