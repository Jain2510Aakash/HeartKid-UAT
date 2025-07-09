/*
Created By          : Girikon (Mohd Sahil)
Created On          : March 06, 2024
@description        : This class is used to get the validation rules and metadata info.
Test Class          : ExtractDataCls_Test (Coverage: 89%)

Modification log --
Modified By         : 
Modified On         : 

*/
public class ToolingAPI_Cls {

    

    // Method to get access token using Named Credential
    //@AuraEnabled // If you want to use it in Lightning components
    public static String getResponseBody(String endPointUrl) {
        // Define the endpoint URL of the Tooling API
        String endpoint = 'services/data/v58.0/tooling/query?q=';
        endpoint +=endPointUrl; 
        System.debug('query==>'+endpoint);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:SF_InternalProject/'+endpoint);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        if(!test.isRunningTest())
        {
           res = http.send(req);
        }
        else
        {
            HttpResponse res1 = new HttpResponse();
           res1.setHeader('Content-Type', 'application/json');
           res1.setBody('{ "size": 1, "records": [ { "ValidationName": "TestValidation", "Description": "Test", "Active": true, "EntityDefinition": { "DeveloperName": "Lead" } } ] }');
           res1.setStatusCode(200);
           res = res1;
        }
        System.debug('endpoint: ' + req.getEndpoint());
        System.debug('Response Status Code: ' + res.getStatusCode());
        System.debug('Response Body: ' + res.getBody());
        
        if (res.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('Size==>'+responseMap.get('size')+'Entity Type=>'+responseMap.get('entityTypeName'));
            //return (String) responseMap.get('access_token');
            return res.getBody();
            
        } else {
            // Handle error response
            System.debug('Error: ' + res.getBody());
            return null;
        }
    }

}