/*
Created By          : Girikon (Mohd Sahil)
Created On          : May 27, 2024
@description        : This class used to get the record from the Assist Score Object .
Test Class          : SalesforceAssistScore_Ctrl_Test (Coverage: 100%)

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class SalesforceAssistScore_Ctrl {
    
    //This method used to retriev the whole records.
    @AuraEnabled
    public Static List<Salesforce_Assist_Score__c> getScoreRecords(String objectName)
    {
        List<Salesforce_Assist_Score__c> scoreList;
        if(!String.isEmpty(objectName) || !String.isBlank(objectName))
        {
            scoreList = [Select Id,Scoring_Rule_Name__c,Output__c From Salesforce_Assist_Score__c Where Object_Type__c =:objectName WITH SECURITY_ENFORCED];
        }
       
        // try {
        //     List<Salesforce_Assist_Score__c> scoreList = [Select Id,Scoring_Rule_Name__c,Output__c From Salesforce_Assist_Score__c Where Object_Type__c =:objectName WITH SECURITY_ENFORCED];
        //     return scoreList;
            
        // } catch (Exception ex) {
        //     return [Select Id,Scoring_Rule_Name__c,Output__c From Salesforce_Assist_Score__c Where Scoring_Rule_Name__c = 'Score from catch block' WITH SECURITY_ENFORCED];
        // }
        return scoreList;
    }
}