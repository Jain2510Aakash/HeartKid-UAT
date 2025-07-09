/*
Created By          : Girikon (Mohd Sahil)
Created On          : April 04, 2024
@description        : This is used to get the contact data.
Test Class          : ExtractContactDataCls_Test (Coverage: 89%)

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class ExtractContactDataCls {
    // This is used to extract contact data.
     @AuraEnabled
     public static ExtractAccountDataCls.Modal1 extractContact()
     {
       //Modal1 is a wrapper class to contains multiple types of data. 
       ExtractAccountDataCls.Modal1 wrapperCls = new ExtractAccountDataCls.Modal1();
        wrapperCls.relationShipObjectList = ExtractDataCls.getCustomObjectLookup('Contact');
        wrapperCls.recordTypeList = Summary_Cls.getRecordTypeDetails('Contact');
        wrapperCls.triggersList = ExtractDataCls.getTriggers('Contact');
        wrapperCls.duplicateRulesList = Summary_Cls.getDuplicateRule('Contact');
        wrapperCls.flowList = Summary_Cls.getflows('Contact');
        wrapperCls.percentageOfActivities = contactWithActivities();
        //To get the validation rule which are related to Contact.
        String query1 = 'SELECT+Id+,+ValidationName+,+Description+,+Active+,+EntityDefinition.DeveloperName+FROM+ValidationRule+Where+Active+=+True+AND+EntityDefinition.DeveloperName+=+\'Contact\'';
        String validationRule = ToolingAPI_Cls.getResponseBody(query1);
        if(validationRule != Null && validationRule !='')
        {
          wrapperCls.validationRule = ExtractDataCls.makeModal3Data(validationRule);          
        }
 
        String query = 'Select+id+,+name+,+EntityDefinitionId+from+Layout+WHERE+EntityDefinitionId+=+\'Contact\'';
        String response = ToolingAPI_Cls.getResponseBody(query);
        if(response != Null && response !='')
        {
          wrapperCls.pageLayoutList = ExtractAccountDataCls.getPageLayoutList(response);
          System.debug(wrapperCls.pageLayoutList);
        }
        
        if(wrapperCls != Null)
        {
          return wrapperCls;
        }
        return null;
     }

      // This is used to calculate percentage of contact activities.
    public static Decimal contactWithActivities()
    {
        // Query for get the total no. of contact record's by using aggregate query.
        AggregateResult result = [Select COUNT(Id) TotalContact from Contact WITH SECURITY_ENFORCED];
        Integer totalContacts = integer.valueOf(result.get('TotalContact'));

        // Query for get the total no. of task record's which is associated to contact by using aggregate query.
        //AggregateResult count=[SELECT COUNT(Id) totalTask FROM Task where recordId__c like '003%' WITH SECURITY_ENFORCED];
        AggregateResult count =[SELECT COUNT(Id) totalTask FROM Task WHERE WhoId IN (SELECT Id FROM Contact)];
        Integer totalTask = integer.valueOf(count.get('totalTask'));
        //[Select Id,Subject, WhoId, WhatId From Tasks];

        // Calculate the percentage
        Decimal percentage = (Decimal.valueOf(totalTask) / Decimal.valueOf(totalContacts)) * 100;

        //Round of for two decimal places.
        Decimal rounded = Math.round(percentage * 100) / 100.0;

        // Print or return the percentage
        System.debug('Percentage of Contact with activities: ' + rounded + '%');

        return rounded;
    }

    //  // This is used to calculate percentage of contact activities.
    // public static Decimal contactWithActivities()
    // {
    //     // Query for Contact and related activities
    //     List<Contact> contactWithActivities = [Select id, (Select Id,Subject, WhoId, WhatId From Tasks) from Contact WITH SECURITY_ENFORCED LIMIT 40000];

    //     Integer contactWithActivitiesCount = 0;
    //     Integer totalContacts = contactWithActivities.size();

    //     // Iterate through the Contact to count those with related Activities.
    //     for(Contact l : contactWithActivities) {
    //         if(l.tasks.size() > 0) {
    //             contactWithActivitiesCount++;
    //         }
    //     }
    //     // Calculate the percentage
    //     Decimal percentage = (Decimal.valueOf(contactWithActivitiesCount) / Decimal.valueOf(totalContacts)) * 100;

    //     //Round of for two decimal places.
    //     Decimal rounded = Math.round(percentage * 100) / 100.0;

    //     // Print or return the percentage
    //     System.debug('Percentage of Contact with activities: ' + rounded + '%');

    //     return rounded;
    // }

     //Wrapper class used for contact object.
    //  public class Modal1
    //  {
    //      @AuraEnabled Public List<String> relationShipObjectList;
    //      @AuraEnabled Public List<RecordType> recordTypeList;
    //      @AuraEnabled Public List<ApexTrigger> triggersList;
    //      @AuraEnabled Public List<Modal2> pageLayoutList;
    //      @AuraEnabled Public List<DuplicateRule> duplicateRulesList;
    //  }
}