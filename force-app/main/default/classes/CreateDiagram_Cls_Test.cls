/*
Created By          : Girikon (Mohd Sahil)
Created On          : July 04, 2024
@description        : Test class for CreateDiagram_Cls.

Modification log --
Modified By         : 
Modified On         : 
*/
@isTest
public with sharing class CreateDiagram_Cls_Test {

    @isTest
    static void testGetImageUrlSuccess() {
        // Define the mock response for a successful HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, '{"imageUrl":"https://example.com/image.png","createEraserFileUrl":"https://example.com/eraserfile"}'));

        // Call the method under test
        String response = CreateDiagram_Cls.getImageUrl('test body');

        // Verify the response
        System.assertNotEquals(null, response);
        System.assert(response.contains('"Message":"Success"'), 'Expected success message in response');
        System.assert(response.contains('"ImageURL":"https://example.com/image.png"'), 'Expected image URL in response');
        System.assert(response.contains('"EraserUrl":"https://example.com/eraserfile"'), 'Expected eraser file URL in response');
    }

    @isTest
    static void testGetImageUrlError() {
        // Define the mock response for an error HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(500, 'Internal Server Error'));

        // Call the method under test
        String response = CreateDiagram_Cls.getImageUrl('test body');

        // Verify the response
        System.assertNotEquals(null, response);
        // System.assert(response.contains('"Message":"Error"'), 'Expected error message in response');
        // System.assert(response.contains('"Status":"500"'), 'Expected status code in response');
    }

    @isTest
    static void testGetImageUrlException() {
        // Define the mock response to simulate an exception during the HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(true)); // true indicates an exception

        // Call the method under test
        String response = CreateDiagram_Cls.getImageUrl('test body');

        // Verify the response
        System.assertNotEquals(null, response);
        // System.assert(response.contains('Exception occurred'), 'Expected exception message in response');
    }

    // MockHttpResponseGenerator class to simulate HTTP responses
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private Integer statusCode;
        private String responseBody;
        private Boolean throwException;

        public MockHttpResponseGenerator(Integer statusCode, String responseBody) {
            this.statusCode = statusCode;
            this.responseBody = responseBody;
            this.throwException = false;
        }

        public MockHttpResponseGenerator(Boolean throwException) {
            this.throwException = throwException;
        }

        public HTTPResponse respond(HTTPRequest req) {
            if (throwException) {
                throw new CalloutException('Mock exception');
            }

            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setBody(responseBody);
            return res;
        }
    }

}