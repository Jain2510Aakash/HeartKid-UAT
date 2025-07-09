/*
Created By          : Girikon (Mohd Sahil)
Created On          : March 22, 2024
@description        : This is used to get the account data.
Test Class          : ExtractAccountDataCls_Test (Coverage: 91%)

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class ExtractAccountDataCls {

    // This is used to extract account data.
    @AuraEnabled
    public static Modal1 extractAccount()
    {
      //Modal1 is a wrapper class to contains multiple types of data. 
       Modal1 wrapperCls = new Modal1();
       wrapperCls.relationShipObjectList = ExtractDataCls.getCustomObjectLookup('Account');
       wrapperCls.recordTypeList = Summary_Cls.getRecordTypeDetails('Account');
       wrapperCls.triggersList = ExtractDataCls.getTriggers('Account');
       wrapperCls.duplicateRulesList = Summary_Cls.getDuplicateRule('Account');
       wrapperCls.isPersonAccount = personAccountsEnabled() ? true:false;
       wrapperCls.flowList = Summary_Cls.getflows('Account');
       //To get the pagelayout which are related to the Account.
       String query = 'Select+id+,+name+,+EntityDefinitionId+from+Layout+WHERE+EntityDefinitionId+=+\'Account\'';
       String response = getPageLayout(query);//Call tooling API from this method.
       System.debug('response line 29'+response);
       if(response != Null && response !='')
       {
         System.debug('response body line 32=>'+response);
         wrapperCls.pageLayoutList = getPageLayoutList(response);
         System.debug(wrapperCls.pageLayoutList);
       }
        //To get the validation rule which are related to Account.
        String query1 = 'SELECT+Id+,+ValidationName+,+Description+,+Active+,+EntityDefinition.DeveloperName+FROM+ValidationRule+Where+Active+=+True+AND+EntityDefinition.DeveloperName+=+\'Account\'';
        String validationRule = getValidationRule(query1);
        System.debug('validation response line 39'+validationRule);
        if(validationRule != Null && validationRule !='')
        {
            System.debug('validation response body line 42=>'+validationRule);
            wrapperCls.validationRule = ExtractDataCls.makeModal3Data(validationRule);          
        }
       
       if(wrapperCls != Null)
       {
         return wrapperCls;
       }
       return null;
    }

    public static string getValidationRule(String query)
    {
        if(query != Null && query !='')
        {
           //ToolingAPI_Cls toolingApi1 = new ToolingAPI_Cls();
           return ToolingAPI_Cls.getResponseBody(query);
        }
        return null;
    }

    public static string getPageLayout(String query)
    {
        if(query != Null && query !='')
        {
            //ToolingAPI_Cls toolingApi2 = new ToolingAPI_Cls();
            return ToolingAPI_Cls.getResponseBody(query);
        }
        return null;
    }
    // This is used to extract contact data.
    @AuraEnabled
    public static List<String> extractContact()
    {
       return ExtractDataCls.getCustomObjectLookup('Contact');
    }

    // Check to see if person accounts are enabled.
    public static Boolean personAccountsEnabled()
    {
        // Describe the Account object to get a map of all fields
        // then check to see if the map contains the field 'isPersonAccount'
        return Schema.sObjectType.Account.fields.getMap().containsKey( 'isPersonAccount' );
    }

    // This method used to call when I need to get the Page layout.    
    public static List<Modal2> getPageLayoutList(String pageLayout)
    {
        List<Modal2> pageLayoutList = new List<Modal2>();
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(pageLayout);
        if((Integer)responseMap.get('size')>0)
        {
            List<Object> records = (List<Object>) responseMap.get('records');
            for (Object record : records) {
                Modal2 modal=new Modal2();
                Map<String, Object> recordMap = (Map<String, Object>) record;
                modal.name = (String) recordMap.get('Name');
                modal.sObjectName = (String) recordMap.get('EntityDefinitionId');
                pageLayoutList.add(modal);                  
            }
        }
        if(!pageLayoutList.isEmpty())
        {
            return pageLayoutList;
        }
        return null;
    }

     //Wrapper class used for Account object and Contact object as well in ExtractContactData controller.
     public class Modal1
     {
         @AuraEnabled Public List<String> relationShipObjectList;
         @AuraEnabled Public List<RecordType> recordTypeList;
         @AuraEnabled Public List<ApexTrigger> triggersList;
         @AuraEnabled Public List<Modal2> pageLayoutList;
         @AuraEnabled Public List<DuplicateRule> duplicateRulesList;
         @AuraEnabled Public Boolean isPersonAccount;
         @AuraEnabled Public List<FlowDefinitionView> flowList;
         @AuraEnabled Public List<ExtractDataCls.Modal3> validationRule;
         @AuraEnabled Public Decimal percentageOfActivities = 0;
        //  public Modal1()
        //  {
        //      validationRule = new List<ExtractDataCls.Modal3>();
        //  }
     }
     //This wrapper used to contains the page layout info.
     public class Modal2
     {
         @AuraEnabled Public String name;
         @AuraEnabled Public String sObjectName;
     }
}