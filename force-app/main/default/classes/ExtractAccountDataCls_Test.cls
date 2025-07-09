/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 03, 2024
@description        : Test class for ExtractAccountDataCls.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class ExtractAccountDataCls_Test {

    @isTest
    static void testAccountExtract() {
        Test.startTest();
        // Setup mock callout
        MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        ExtractAccountDataCls.Modal1 accountExtract = ExtractAccountDataCls.extractAccount();
        // Validate results
       // System.assertEquals(accountExtract != Null, accountExtract,'test');
        Test.stopTest();
    }

    @isTest
    static void testContactExtract() {
        Test.startTest();
        // Setup mock callout
        // MockHttpClass.ToolingAPI_ClsMock mock = new MockHttpClass.ToolingAPI_ClsMock();
        // Test.setMock(HttpCalloutMock.class, mock);
        // Invoke the method
        List<String> contactExtract = ExtractAccountDataCls.extractContact();
        // Validate results
       // System.assertEquals(!contactExtract.isEmpty(), contactExtract,'List should not be null');
        Test.stopTest();
    }
    
}