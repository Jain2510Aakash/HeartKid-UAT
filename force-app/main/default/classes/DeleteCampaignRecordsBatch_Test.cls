/*
Created By          : Girikon (Mohd Sahil)
Created On          : Oct 24, 2024
@description        : This Test class covered "DeleteCampaignRecordsBatch".
Test Class          : DeleteCampaignRecordsBatch (Coverage: %)

Modification log --
Modified By         : 
Modified On         : 

*/
@isTest
public class DeleteCampaignRecordsBatch_Test {
 // Set up reusable test data for the test class
    @testSetup
    static void setupData() {
        // Create a parent campaign with 0 values
        Campaign parentCampaign = new Campaign(
            Name = 'Parent Campaign',
            Total_Value_of_Fundraising_Page__c = 0
        );
        insert parentCampaign;

        // Create a child campaign with values > 0 (this should trigger the flag)
        Campaign childCampaign1 = new Campaign(
            Name = 'Child Campaign 1',
            ParentId = parentCampaign.Id,
            Total_Value_of_Fundraising_Page__c = 250
        );

        // Create another child campaign with 0 values (should not trigger the flag)
        Campaign childCampaign2 = new Campaign(
            Name = 'Child Campaign 2',
            ParentId = parentCampaign.Id,
            Total_Value_of_Fundraising_Page__c = 0
        );

        insert new List<Campaign> {childCampaign1, childCampaign2};
    }

    // Test method to verify the batch logic
    @isTest
    static void testBatchProcess() {
        // Start a test block to simulate batch execution
        Test.startTest();

       // Execute the batch class
        DeleteCampaignRecordsBatch batch = new DeleteCampaignRecordsBatch();
        Database.executeBatch(batch, 200);

        // End the test block to ensure async operations complete
        Test.stopTest();

        // Query campaigns to verify updates
        List<Campaign> updatedCampaigns = [
            SELECT Id, Delete_Flag__c 
            FROM Campaign 
            WHERE Delete_Flag__c = true
        ];

        // Assert that only the relevant campaigns are updated
        System.assertEquals(2, updatedCampaigns.size(), 
            'Two campaigns should have the Record_Type_Flag__c set to true');
    }
}