/*
Created By          : Girikon (Mohd Sahil)
Created On          : March 11, 2024
@description        : This class is used to get the validation, flow, trigger, Custom Object, Score, Record Type and etc.
Test Class          : Summary_Cls_Test (Coverage: 85%)

Modification log --
Modified By         : 
Modified On         : 

*/
public With Sharing class  Summary_Cls {


    // This is used to get the all record types form the org.
    @AuraEnabled(cacheable=true)
    public static List<RecordType> getRecordTypeDetails(String objectName)
    {
        String query='';
        if(objectName != Null && objectName != '')
        {
            query = 'SELECT Id , Name , DeveloperName , NamespacePrefix , Description , BusinessProcessId , SobjectType , IsActive , CreatedById , CreatedDate , LastModifiedById , LastModifiedDate , SystemModstamp FROM RecordType Where IsActive = True AND SobjectType=\''+ objectName+'\' with SECURITY_ENFORCED';
        }
        else
        {
            query = 'SELECT Id , Name , DeveloperName , NamespacePrefix , Description , BusinessProcessId , SobjectType , IsActive , CreatedById , CreatedDate , LastModifiedById , LastModifiedDate , SystemModstamp FROM RecordType Where IsActive = True with SECURITY_ENFORCED';
        }
        System.debug('Query: ' + query);
        // Query for record types.
        List<RecordType> recordtypeList = Database.query(query);
        if(!recordtypeList.isEmpty())
        {
            return recordtypeList;
        }
        return null;
    }

    // This is used to get the validation rules.
    @AuraEnabled(cacheable=true)
    public static List<ExtractDataCls.Modal3> getValidationRules()
    {
        List<ExtractDataCls.Modal3> validationRuleList = new List<ExtractDataCls.Modal3>();
        //To get the validation rule which are related to opportunity.
        String query = 'SELECT+Id+,+ValidationName+,+Active+,+Description+,+EntityDefinition.DeveloperName+FROM+ValidationRule+Where+Active+=+True';
        String validationRule = ToolingAPI_Cls.getResponseBody(query);
        if(validationRule != Null && validationRule !='')
        {
            validationRuleList = ExtractDataCls.makeModal3Data(validationRule);
        }

        if(!validationRuleList.isEmpty())
        {
            return validationRuleList;
        }
      return null;  
    }

    // This is used to get the all custom apex classes.
    @AuraEnabled(cacheable=true)
    public static List<ApexClass> getApexClasses()
    {
        List<ApexClass> apexList = [SELECT Id , NamespacePrefix , Name , ApiVersion , Status , IsValid , BodyCrc , Body , LengthWithoutComments , CreatedDate , CreatedBy.Name , LastModifiedDate , LastModifiedById , SystemModstamp FROM ApexClass Where NamespacePrefix = Null AND Status = 'Active' WITH SECURITY_ENFORCED];
        if(!apexList.isEmpty())
        {
            return apexList;
        }

        return null;
    }

    // This is used to get the all custom flows.
    @AuraEnabled(cacheable=true)
    public static List<FlowDefinitionView> getflows(String objectName)
    {
        String query='';
        if(objectName != Null && objectName != '')
        {
            query = 'SELECT Id , Label , Description , ProcessType , TriggerType , NamespacePrefix , IsActive  , TriggerObjectOrEventLabel , RecordTriggerType  , VersionNumber, LastModifiedBy FROM FlowDefinitionView Where NamespacePrefix = Null AND IsActive = true AND TriggerObjectOrEventLabel =\''+ objectName+'\'';
        }
        else
        {
            query = 'SELECT Id , Label , Description , ProcessType , TriggerType , NamespacePrefix , IsActive  , TriggerObjectOrEventLabel , RecordTriggerType  , VersionNumber, LastModifiedBy FROM FlowDefinitionView Where NamespacePrefix = Null AND IsActive = true';
        }
        System.debug('Query: ' + query);
        List<FlowDefinitionView> flowsList = Database.query(query);
        if(!flowsList.isEmpty())
        {
            return flowsList;
        }

        return null;
    }

    // This is used to get the all custom apex classes.
    @AuraEnabled(cacheable=true)
    public static List<Modal1> getCustomObject()
    {
        List<Modal1> customObjectList = new List<Modal1>();
        String query = 'Select+Id+,+DeveloperName+,+NamespacePrefix+,+Description+From+CustomObject+Where+NamespacePrefix+=+Null';
        String customObject = ToolingAPI_Cls.getResponseBody(query);
        System.debug('custom object=>'+customObject);
        if(customObject != Null && customObject !='')
        {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(customObject);
            if((Integer)responseMap.get('size')>0)
            {
                List<Object> records = (List<Object>) responseMap.get('records');
                for (Object record : records) {
                    Modal1 modal=new Modal1();
                    Map<String, Object> recordMap = (Map<String, Object>) record;
                    modal.name = (String) recordMap.get('DeveloperName');
                    modal.description = (String) recordMap.get('Description');
                    customObjectList.add(modal);                  
                }

            }
                      
        }

        if(!customObjectList.isEmpty())
        {
            return customObjectList;
        }
        return null;
    }


    // This method used to get the all duplicates rule on objects.
    public static List<DuplicateRule> getDuplicateRule(String objectName){
        String query='';
        if(objectName != Null && objectName != '')
        {
            query = 'SELECT Id , CreatedBy.Name , CreatedDate , DeveloperName , IsActive , IsDeleted , Language , LastModifiedById , LastModifiedDate , LastViewedDate , MasterLabel , NamespacePrefix , SobjectSubtype , SobjectType , SystemModstamp FROM DuplicateRule Where IsActive = true AND SobjectType =\''+ objectName+'\' WITH SECURITY_ENFORCED';
        }
        else
        {
            query = 'SELECT Id , CreatedBy.Name , CreatedDate , DeveloperName , IsActive , IsDeleted , Language , LastModifiedById , LastModifiedDate , LastViewedDate , MasterLabel , NamespacePrefix , SobjectSubtype , SobjectType , SystemModstamp FROM DuplicateRule Where IsActive = true WITH SECURITY_ENFORCED';
        }
        System.debug('Query: ' + query);
        List<DuplicateRule> dulicateRuleList = Database.query(query);
        System.debug('duplicate rules=>'+dulicateRuleList);
        if(!dulicateRuleList.isEmpty())
        {
            return dulicateRuleList;
        }

        return null;
    }

    // This is used to get the metadata. 
    // @AuraEnabled(cacheable=true)
    // public static List<Range_Setting__mdt> getMetadataType()
    // {
    //     List<Range_Setting__mdt> settingList = [SELECT Id, Label, DeveloperName, Type__c, Start_Range__c,End_Range__c,Value__c FROM Range_Setting__mdt WITH SECURITY_ENFORCED];

    //     if(!settingList.isEmpty())
    //     {
    //         return settingList;
    //     }
    //     return null;
    // }

    // This is used to get the Diagram data from the Salesforce assis question answer object, which data sent to the Eraser API to get the image url.
    @AuraEnabled
    public static Salesforce_Assist_Question_Answer__c getSalesforceAssistData(){
        try {
            Salesforce_Assist_Question_Answer__c asistData = [Select Id, Name, Account_Business_Process__c, Contact_Business_Process__c, Lead_Business_Process__c, Opportunity_Business_Process__c From Salesforce_Assist_Question_Answer__c With SECURITY_ENFORCED Limit 1];
            return asistData;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //This is used to get the all object score from the Salesforce Assist Score object.
    @AuraEnabled
    public static List<Salesforce_Assist_Score__c> allObjectScore(){
        try {
            List<Salesforce_Assist_Score__c> asistScoreList = [SELECT Id, Name, Object_Type__c, Scoring_Rule_Name__c, Rule__c, Output__c FROM Salesforce_Assist_Score__c With SECURITY_ENFORCED];
            return asistScoreList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //this wrapper class used for custom objects.
    Public class Modal1
    {
        @AuraEnabled Public String name;
        @AuraEnabled Public String description;
    }

}