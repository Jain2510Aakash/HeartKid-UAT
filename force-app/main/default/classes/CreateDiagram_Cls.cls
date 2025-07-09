/*
Created By          : Girikon (Mohd Sahil)
Created On          : April 29, 2024
@description        : This class used to get the image url from the Eraser.
Test Class          : CreateDiagram_Cls_Test (Coverage: 100%)

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class CreateDiagram_Cls {
    @AuraEnabled
    public static string getImageUrl(String body)
    {
        System.debug('Body==>'+body);
        Eraser_Configuration__mdt eraserConfig;
        if(Schema.sObjectType.Eraser_Configuration__mdt.isAccessible() && Schema.sObjectType.Eraser_Configuration__mdt.isQueryable())
        {
            eraserConfig = Eraser_Configuration__mdt.getInstance('Eraser_Config');
        }
        //Define the JSON payload
        string payload = '{"diagramTitle":"GiriTest","diagramType":"flowchart-diagram",';
        payload += '"text":'+ '"'+body+'"}';
        System.debug('full Body==>'+payload);

        // Set up the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://app.eraser.io/api/render/prompt');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer '+ eraserConfig.BearerToken__c); // Replace YOUR_API_TOKEN with your actual token
        req.setHeader('Content-Type', 'application/json');
        req.setBody(payload);
        req.setTimeout(120000); // Set timeout to 30 seconds (30000 milliseconds)
        // Make the HTTP request
        Http http = new Http();
        HttpResponse res;
        try {
            res = http.send(req);
            System.debug('response code:'+res.getStatusCode());
            // Parse the response
            if (res.getStatusCode() == 200) {
                // Successful request
                String responseBody = res.getBody();
                System.debug('Response Body success: ' + responseBody);
                // Parse the JSON data
                Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

                // Get the imageUrl
                String imageUrl = (String) responseData.get('imageUrl');
                String eraserFileUrl = (String) responseData.get('createEraserFileUrl');
                System.debug('Image URL: ' + imageUrl);
                System.debug('Eraser URl: ' + eraserFileUrl);
                String successData = '{"Message":"Success",';
                successData +='"ImageURL":'+'"'+imageUrl+'",';
                successData +='"EraserUrl":'+'"'+eraserFileUrl+'"}';
                System.debug('success data ==>'+successData);
                return successData;
            } else {
                // Error handling
                //String responseBody = res.getBody();
                System.debug('Error: ' + res.getStatus());
                System.debug('Response Body error: ' + res.getBody());
                String errorData = '{"Message":"Error",';
                errorData +='"Status":'+'"'+res.getStatus()+'"}';
                System.debug('error data ==>'+errorData);
                return errorData;
            }
        } catch (Exception e) {
            // Exception handling
            System.debug('Exception occurred: ' + e.getMessage());
            return e.getMessage();
        }

         //return payload;
    }
}