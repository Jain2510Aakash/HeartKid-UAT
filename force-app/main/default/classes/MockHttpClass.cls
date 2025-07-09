/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 03, 2024
@description        : 

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class MockHttpClass {

   // Mock class for ToolingAPI_Cls
   public class ToolingAPI_ClsMock implements HttpCalloutMock {
       public HTTPResponse respond(HTTPRequest req) {
           HttpResponse res = new HttpResponse();
           res.setHeader('Content-Type', 'application/json');
           res.setBody('{ "size": 1, "records": [ { "ValidationName": "TestValidation", "Description": "Test", "Active": true, "EntityDefinition": { "DeveloperName": "Lead" } } ] }');
           res.setStatusCode(200);
           return res;
       }
   }
}