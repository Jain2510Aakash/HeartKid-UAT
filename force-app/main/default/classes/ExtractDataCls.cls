/*
Created By          : Girikon (Mohd Sahil)
Created On          : Jan 10, 2024
@description        : This class used to get the sort of information like lead, opportunity extract and related to the org etc. 
Test Class          : ExtractDataCls_Test (Coverage: 96%)

Modification log --
Modified By         : 
Modified On         : 

*/
public With Sharing class ExtractDataCls {
    
    @AuraEnabled
    public static Modal leadExtract()
    {
        Modal wrapper=new Modal();
        wrapper.relationShipObject = getCustomObjectLookup('Lead');
        wrapper.recordType = Summary_Cls.getRecordTypeDetails('Lead');
        wrapper.duplicateRulesList = Summary_Cls.getDuplicateRule('Lead');
        wrapper.percentageOfActivities = leadWithActivities();
        wrapper.isTriggers = getTriggers('Lead');
        wrapper.flowList = Summary_Cls.getflows('Lead');
        //To get the validation rule which are related to Lead.
        String query = 'SELECT+Id+,+ValidationName+,+Description+,+Active+,+EntityDefinition.DeveloperName+FROM+ValidationRule+Where+Active+=+True+AND+EntityDefinition.DeveloperName+=+\'Lead\'';
        String validationRule = ToolingAPI_Cls.getResponseBody(query);
        if(validationRule != Null && validationRule !='')
        {
            wrapper.validationRule = makeModal3Data(validationRule);          
        }

        Map<String,Integer> source=new Map<String,Integer>();
        //To get the lead activities and lead is converted or not.
        List<Lead> leadList=[Select id, Name, isConverted, LeadSource, (Select Id,Subject, WhoId, WhatId From Tasks) from lead WITH SECURITY_ENFORCED Limit 50000];
        
        if(!leadList.isEmpty())
        {
            for(Lead l:leadList)
            {
                if(l.tasks.size()>0)
                {
                    wrapper.activities = l.tasks.size();
                }

                if(l.isConverted)
                {
                    wrapper.isConverted = l.isConverted;
                }
                else
                {
                    wrapper.isConverted = l.isConverted;
                }
            }
          
        }

        //To find out the where lead source are used in records.
        List<AggregateResult> leadSourceList = [SELECT LeadSource, COUNT(Id)Number FROM Lead Where LeadSource != Null WITH SECURITY_ENFORCED GROUP BY LeadSource];
        if(!leadSourceList.isEmpty())
        {
            for(AggregateResult l:leadSourceList)
            {
                source.put((String)l.get('LeadSource'),(Integer)l.get('Number'));
            }
            wrapper.leadSource = source;
        }
        // To get the lead status values.
        List<String> defaultVal = new List<String>();
        Schema.DescribeFieldResult result1 = Lead.Status.getDescribe();
        List <Schema.PicklistEntry> pickVals = result1.getPicklistValues();        
        for (Schema.PicklistEntry pv: pickVals) {
        System.debug('value---'+pv.getValue());
        defaultVal.add(pv.getValue());
        }
        if(!defaultVal.isEmpty())
        {
            wrapper.leadStatus = defaultVal;
        }

        if(wrapper != null)
        {
            return wrapper;
        }

        return null;
    }

    // This method is used to update Salesforce Assist Question Answer object fields.
    @AuraEnabled
    public static string updateSalesforceAssistData(Salesforce_Assist_Question_Answer__c salesAssistData, String objectType)
    {

        List<Salesforce_Assist_Question_Answer__c>  assistQuestion = [Select Id, Name From Salesforce_Assist_Question_Answer__c WITH SECURITY_ENFORCED Limit 1];

        if(!assistQuestion.isEmpty() && salesAssistData != Null)
        {
            System.debug('update');
            if(objectType == 'Lead')
            {
                assistQuestion[0].Lead_Q_1__c = salesAssistData.Lead_Q_1__c;
                assistQuestion[0].Lead_Q_2__c = salesAssistData.Lead_Q_2__c;
                assistQuestion[0].Lead_Q_3__c = salesAssistData.Lead_Q_3__c;
                assistQuestion[0].Lead_Q_4__c = salesAssistData.Lead_Q_4__c;
                assistQuestion[0].Lead_Q_5__c = salesAssistData.Lead_Q_5__c;
                assistQuestion[0].Lead_Q_6__c = salesAssistData.Lead_Q_6__c;
                assistQuestion[0].Lead_Q_7__c = salesAssistData.Lead_Q_7__c;
                assistQuestion[0].Lead_Q_8__c = salesAssistData.Lead_Q_8__c;
                assistQuestion[0].Lead_Q_9__c = salesAssistData.Lead_Q_9__c;
            }
            if(objectType == 'Account')
            {
                assistQuestion[0].Account_Q_1__c = salesAssistData.Account_Q_1__c;
                assistQuestion[0].Account_Q_2__c = salesAssistData.Account_Q_2__c;
                assistQuestion[0].Account_Q_3__c = salesAssistData.Account_Q_3__c;
                assistQuestion[0].Account_Q_4__c = salesAssistData.Account_Q_4__c;
                assistQuestion[0].Account_Q_5__c = salesAssistData.Account_Q_5__c;
                assistQuestion[0].Account_Q_6__c = salesAssistData.Account_Q_6__c;
                assistQuestion[0].Account_Q_7__c = salesAssistData.Account_Q_7__c;
            }
            if(objectType == 'Contact')
            {
                assistQuestion[0].Contact_Q_1__c = salesAssistData.Contact_Q_1__c;
                assistQuestion[0].Contact_Q_2__c = salesAssistData.Contact_Q_2__c;
                assistQuestion[0].Contact_Q_3__c = salesAssistData.Contact_Q_3__c;
                assistQuestion[0].Contact_Q_4__c = salesAssistData.Contact_Q_4__c;
                assistQuestion[0].Contact_Q_5__c = salesAssistData.Contact_Q_5__c;
                assistQuestion[0].Contact_Q_6__c = salesAssistData.Contact_Q_6__c;
                assistQuestion[0].Contact_Q_7__c = salesAssistData.Contact_Q_7__c;
            }
            if(objectType == 'Opportunity')
            {
                assistQuestion[0].Opportunity_Q_1__c = salesAssistData.Opportunity_Q_1__c;
                assistQuestion[0].Opportunity_Q_2__c = salesAssistData.Opportunity_Q_2__c;
                assistQuestion[0].Opportunity_Q_3__c = salesAssistData.Opportunity_Q_3__c;
                assistQuestion[0].Opportunity_Q_4__c = salesAssistData.Opportunity_Q_4__c;
                assistQuestion[0].Opportunity_Q_5__c = salesAssistData.Opportunity_Q_5__c;
				assistQuestion[0].Opportunity_Q_6__c = salesAssistData.Opportunity_Q_6__c;
                assistQuestion[0].Opportunity_Q_7__c = salesAssistData.Opportunity_Q_7__c;
                assistQuestion[0].Opportunity_Q_8__c = salesAssistData.Opportunity_Q_8__c;
                assistQuestion[0].Opportunity_Q_9__c = salesAssistData.Opportunity_Q_9__c;
            }
            
            Database.update(assistQuestion);
            return 'Updated';
        }
        else if(salesAssistData != Null)
        {
            System.debug('inserted');
            Salesforce_Assist_Question_Answer__c sales = new Salesforce_Assist_Question_Answer__c();
            if(objectType == 'Lead')
            {
                sales.Lead_Q_1__c = salesAssistData.Lead_Q_1__c;
                sales.Lead_Q_2__c = salesAssistData.Lead_Q_2__c;
                sales.Lead_Q_3__c = salesAssistData.Lead_Q_3__c;
                sales.Lead_Q_4__c = salesAssistData.Lead_Q_4__c;
                sales.Lead_Q_5__c = salesAssistData.Lead_Q_5__c;
                sales.Lead_Q_6__c = salesAssistData.Lead_Q_6__c;
                sales.Lead_Q_7__c = salesAssistData.Lead_Q_7__c;
                sales.Lead_Q_8__c = salesAssistData.Lead_Q_8__c;
                sales.Lead_Q_9__c = salesAssistData.Lead_Q_9__c;
            }
            if(objectType == 'Account')
            {
                sales.Account_Q_1__c = salesAssistData.Account_Q_1__c;
                sales.Account_Q_2__c = salesAssistData.Account_Q_2__c;
                sales.Account_Q_3__c = salesAssistData.Account_Q_3__c;
                sales.Account_Q_4__c = salesAssistData.Account_Q_4__c;
                sales.Account_Q_5__c = salesAssistData.Account_Q_5__c;
                sales.Account_Q_6__c = salesAssistData.Account_Q_6__c;
                sales.Account_Q_7__c = salesAssistData.Account_Q_7__c;
            }
            if(objectType == 'Contact')
            {
                sales.Contact_Q_1__c = salesAssistData.Contact_Q_1__c;
                sales.Contact_Q_2__c = salesAssistData.Contact_Q_2__c;
                sales.Contact_Q_3__c = salesAssistData.Contact_Q_3__c;
                sales.Contact_Q_4__c = salesAssistData.Contact_Q_4__c;
                sales.Contact_Q_5__c = salesAssistData.Contact_Q_5__c;
                sales.Contact_Q_6__c = salesAssistData.Contact_Q_6__c;
                sales.Contact_Q_7__c = salesAssistData.Contact_Q_7__c;
            }
            if(objectType == 'Opportunity')
            {
                sales.Opportunity_Q_1__c = salesAssistData.Opportunity_Q_1__c;
                sales.Opportunity_Q_2__c = salesAssistData.Opportunity_Q_2__c;
                sales.Opportunity_Q_3__c = salesAssistData.Opportunity_Q_3__c;
                sales.Opportunity_Q_4__c = salesAssistData.Opportunity_Q_4__c;
                sales.Opportunity_Q_5__c = salesAssistData.Opportunity_Q_5__c;
				sales.Opportunity_Q_6__c = salesAssistData.Opportunity_Q_6__c;
                sales.Opportunity_Q_7__c = salesAssistData.Opportunity_Q_7__c;
                sales.Opportunity_Q_8__c = salesAssistData.Opportunity_Q_8__c;
                sales.Opportunity_Q_9__c = salesAssistData.Opportunity_Q_9__c;
            }

            if(sales != Null)
            {
                Database.insert(sales);
            }
            
            return 'Inserted';
        }

       return null;
    }

    // This method is used to update business process field value in Salesforce Assist Question Answer object.
    @AuraEnabled
    public static string updateDiagramBody(String diagramBody, String objectType)
    {
        List<Salesforce_Assist_Question_Answer__c>  assistQuestion = [Select Id, Lead_Business_Process__c From Salesforce_Assist_Question_Answer__c WITH SECURITY_ENFORCED Limit 1];

        if(!assistQuestion.isEmpty() && (!String.isEmpty(diagramBody) || !String.isBlank(diagramBody)))
        {
            if(objectType == 'Lead')
            {
                assistQuestion[0].Lead_Business_Process__c = diagramBody;
            }
            else if(objectType == 'Account')
            {
                assistQuestion[0].Account_Business_Process__c = diagramBody;
            }
            else if(objectType == 'Opportunity')
            {
                assistQuestion[0].Opportunity_Business_Process__c = diagramBody;
            }
            else if(objectType == 'Contact')
            {
                assistQuestion[0].Contact_Business_Process__c = diagramBody;
            }
        
            Database.update(assistQuestion);
            return 'Success';
        }
        return 'Error';
    }

    @AuraEnabled
    public static Salesforce_Assist_Question_Answer__c getDiagramBody()
    {
        Salesforce_Assist_Question_Answer__c  assistQuestionAnswer = [Select Id, Lead_Business_Process__c, Account_Business_Process__c, Contact_Business_Process__c, Opportunity_Business_Process__c From Salesforce_Assist_Question_Answer__c WITH SECURITY_ENFORCED];
        return assistQuestionAnswer;
    }

    // This is used to calculate percentage of lead activities.
    public static Decimal leadWithActivities()
    {
        // Query for get the total no. of lead record's by using aggregate query.
        AggregateResult result = [Select COUNT(Id) TotalLead from lead WITH SECURITY_ENFORCED];
        Integer totalLeads = integer.valueOf(result.get('TotalLead'));

        // Query for get the total no. of task record's which is associated to lead by using aggregate query.
        AggregateResult count = [SELECT COUNT(Id) totalTask FROM Task WHERE WhoId IN (SELECT Id FROM lead) WITH SECURITY_ENFORCED];
        Integer totalTask = integer.valueOf(count.get('totalTask'));

        // Calculate the percentage
        Decimal percentage = (Decimal.valueOf(totalTask) / Decimal.valueOf(totalLeads)) * 100;

        //Round of for two decimal places.
        Decimal rounded = Math.round(percentage * 100) / 100.0;

        // Print or return the percentage
        System.debug('Percentage of Lead with activities: ' + rounded + '%');

        return rounded;
    }

    // This is used to calculate percentage of opportunity activities.
    public static Decimal opportunityWithActivities()
    {
        // Query for get the total no. of opportunity record's by using aggregate query.
        AggregateResult result = [Select COUNT(Id) TotalOpp from Opportunity WITH SECURITY_ENFORCED];
        Integer totalOpportunity = integer.valueOf(result.get('TotalOpp'));

        // Query for get the total no. of task record's which is associated to opportunity by using aggregate query.
        AggregateResult count = [SELECT COUNT(Id) totalTask FROM Task WHERE WhatId IN (SELECT Id FROM Opportunity) WITH SECURITY_ENFORCED];
        Integer totalTask = integer.valueOf(count.get('totalTask'));

        // Calculate the percentage
        Decimal percentage = (Decimal.valueOf(totalTask) / Decimal.valueOf(totalOpportunity)) * 100;

        //Round of for two decimal places.
        Decimal rounded = Math.round(percentage * 100) / 100.0;

        // Print or return the percentage
        System.debug('Percentage of opportunity with activities: ' + rounded + '%');

        return rounded;
    }

    // This is used to get the org info.
    @AuraEnabled(cacheable=true)
    public static Organization getOrgDetails()
    {
        Organization orgInfo = [SELECT Id, Name, OrganizationType, IsSandbox, InstanceName FROM Organization WITH SECURITY_ENFORCED LIMIT 1];
        if(orgInfo != Null)
        {
            return orgInfo;
        }
        return null;
    }

     // This is used to get the org licenses.
     @AuraEnabled(cacheable=true)
     public static List<Modal4> getAllLicenses()
     {
        List<Modal4> licenseList = new List<Modal4>();
        // UsedLicensesLastUpdated, MonthlyLoginsEntitlement and MonthlyLoginsUsed these are query fields I revomed It bcs of these fields does not exist in the Australia region org.
         List<UserLicense> licenses = [SELECT Id , LicenseDefinitionKey , TotalLicenses , Status , UsedLicenses ,
                                        Name , MasterLabel , CreatedDate , LastModifiedDate , 
                                       SystemModstamp FROM UserLicense Where Status = 'Active'  WITH SECURITY_ENFORCED];
         if(!licenses.isEmpty())
         {
            for(UserLicense userLic:licenses)
            {
                Modal4 modal = new Modal4();
                modal.name = userLic.Name;
                modal.totalLicenses = userLic.TotalLicenses;
                modal.usedLicenses = userLic.UsedLicenses;
                modal.status = userLic.Status;

                // Calculate the percentage
                Decimal percentage = (Decimal.valueOf(userLic.UsedLicenses) / Decimal.valueOf(userLic.TotalLicenses)) * 100;

                //Round of for two decimal places.
                Decimal rounded = Math.round(percentage * 100) / 100.0;

                modal.percentage = rounded;
                System.debug(modal.percentage);
                licenseList.add(modal);
            }
             //return licenses;
         }

         if(!licenseList.isEmpty())
         {
            return licenseList;
         }
         
        return null; 
     }

    @AuraEnabled
    public static Modal2 opporunityExtract()
    {
        Map<String,String>  validRules=new Map<String,String>();
        Modal2 wrapper2=new Modal2();
        //To call the opportunityWithProducts method.
        wrapper2.percentageOfOpporunity = opportunityWithProducts();
        wrapper2.isTriggers = getTriggers('Opportunity');
        wrapper2.relationShipObject = getCustomObjectLookup('Opportunity');
        wrapper2.flowList = Summary_Cls.getflows('Opportunity');
        wrapper2.recordType = Summary_Cls.getRecordTypeDetails('Opportunity');
        wrapper2.percentageOfActivities = opportunityWithActivities();
        wrapper2.duplicateRulesList = Summary_Cls.getDuplicateRule('Opportunity');
        //To get the validation rule which are related to opportunity.
        String query = 'SELECT+Id+,+ValidationName+,+Description+,+Active+,+EntityDefinition.DeveloperName+FROM+ValidationRule+Where+Active+=+True+AND+EntityDefinition.DeveloperName+=+\'Opportunity\'';
        String validationRule = ToolingAPI_Cls.getResponseBody(query);
        if(validationRule != Null && validationRule !='')
        {
            wrapper2.validationRule = makeModal3Data(validationRule);          
        }

        //To get the pagelayout which are related to the Account.
        String query1 = 'Select+id+,+name+,+EntityDefinitionId+from+Layout+WHERE+EntityDefinitionId+=+\'Opportunity\'';
        String response = ToolingAPI_Cls.getResponseBody(query1);
        if(response != Null && response !='')
        {
            wrapper2.pageLayoutList = ExtractAccountDataCls.getPageLayoutList(response);
        }

        // To get the Opporunity stages values.
        List<String> defaultVal = new List<String>();
        Schema.DescribeFieldResult result1 = Opportunity.StageName.getDescribe();
        List <Schema.PicklistEntry> pickVals = result1.getPicklistValues();        
        for (Schema.PicklistEntry pv: pickVals) {
        //System.debug('value---'+pv.getValue());
        defaultVal.add(pv.getValue());
        }
        if(!defaultVal.isEmpty())
        {
            wrapper2.opportunityStages = defaultVal;
        }
        System.debug('wrapper2==>'+wrapper2);

        if(wrapper2 != null)
        {
            return wrapper2;
        }

        return null;
    }

    // This method used to call when I need to get the validation rules.    
    public static List<Modal3> makeModal3Data(String validationRule)
    {
        List<Modal3> validationRuleList = new List<Modal3>();
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(validationRule);
        if((Integer)responseMap.get('size')>0)
        {
            List<Object> records = (List<Object>) responseMap.get('records');
            for (Object record : records) {
                Modal3 modal=new Modal3();
                Map<String, Object> recordMap = (Map<String, Object>) record;
                //This map used to get the developer name like object name
                Map<String, Object> devName = (Map<String, Object>) recordMap.get('EntityDefinition');
                modal.name = (String) recordMap.get('ValidationName');
                modal.description = (String) recordMap.get('Description');
                modal.sObjects = (String) devName.get('DeveloperName');
                modal.isActive = (Boolean) recordMap.get('Active');
                validationRuleList.add(modal);                  
            }

        }

        if(!validationRuleList.isEmpty())
        {
            return validationRuleList;
        }

        return null;
    }

    // This is used to get the all opportunity which is related to product or not.
    //@AuraEnabled
    public static Decimal opportunityWithProducts()
    {
        // Query for get the total no. of Opportunity record's by using aggregate query.
        AggregateResult result = [Select COUNT(Id) TotalOpp from Opportunity WITH SECURITY_ENFORCED];
        Integer totalOpportunities = integer.valueOf(result.get('TotalOpp'));

        // Query for get the total no. of Opportunity Line Item record's which is associated to Opportunity by using aggregate query.
        AggregateResult count=[SELECT COUNT(Id) totalLineItem FROM OpportunityLineItem where OpportunityId != Null WITH SECURITY_ENFORCED];
        Integer totalLineItem = integer.valueOf(count.get('totalLineItem'));

        // Calculate the percentage
        Decimal percentage = (Decimal.valueOf(totalLineItem) / Decimal.valueOf(totalOpportunities)) * 100;

        //Round of for two decimal places.
        Decimal rounded = Math.round(percentage * 100) / 100.0;

        // Print or return the percentage
        System.debug('Percentage of opportunities with products: ' + percentage + '%');

        return rounded;
    }


    //This method used to fetch the trigger related to the object.
    @AuraEnabled
    public static List<ApexTrigger> getTriggers(String objectName)
    {
        String query='';
        if(objectName != Null && objectName != '')
        {
            query = 'SELECT Id, Name, Body, TableEnumOrId, CreatedBy.Name, LengthWithoutComments, ApiVersion, Status FROM ApexTrigger WHERE NamespacePrefix = Null AND Status = \'Active\' AND TableEnumOrId =\''+ objectName+'\'';
        }
        else
        {
            query = 'SELECT Id, Name, Body, TableEnumOrId, CreatedBy.Name, LengthWithoutComments, ApiVersion, Status FROM ApexTrigger WHERE NamespacePrefix = Null AND Status = \'Active\'';
        }
        System.debug('Query: ' + query);
        // Query for triggers related to the Opportunity object
        List<ApexTrigger> opportunityTriggers = Database.query(query);//[SELECT Id, Name, Body, TableEnumOrId FROM ApexTrigger WHERE TableEnumOrId =: objectName AND Status = 'Active'];

        if(!opportunityTriggers.isEmpty())
        {
            return opportunityTriggers;
        }

        return null;
    }
    
    //This method used to find out the relationship of particular object.
    public static List<String> getCustomObjectLookup(String objectName)
    {
        List<String> objList = new List<String>();
        if(objectName != Null && objectName != '')
        {
            // Query for custom objects
            List<Schema.SObjectType> customObjectList = Schema.getGlobalDescribe().Values();        
            // Iterate through custom objects
            for(Schema.SObjectType objType : customObjectList) 
            {
                // Check if the object is custom
                if(objType.getDescribe().isCustom()) 
                {
                    // Get the object's fields
                    Map<String, Schema.SObjectField> fieldMap = objType.getDescribe().fields.getMap();
                    // Display object name and its fields
                    // System.debug('Custom Object: ' + objType.getDescribe().getName());
                    // Iterate through the fields of the object
                    for(String fieldName : fieldMap.keySet()) 
                    {
                        Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe(); 
                        // Check if the field is a lookup field and custom
                        if(fieldDescribe.getType() == Schema.DisplayType.Reference && fieldDescribe.isCustom() && fieldDescribe.getReferenceTo()[0].getDescribe().getName() == objectName) 
                        {
                            // Print the custom lookup field name
                            //System.debug('Custom Lookup Field Name: ' + fieldDescribe.getName());
                            //System.debug('Master Object: ' + fieldDescribe.getReferenceTo()[0].getDescribe().getName());
                            objList.add(objType.getDescribe().getName());
                        }
                    }
                }
            }
        }
        System.debug('obj List=>'+objList);
        if(!objList.isEmpty())
        {
            return objList;
        }

        return null;
    }

    //Wrapper class for lead object
    public class Modal
    {
        @AuraEnabled Public Integer activities;
        @AuraEnabled Public Decimal percentageOfActivities = 0;
        @AuraEnabled Public Boolean isConverted;
        @AuraEnabled Public Decimal stageAvgTime;
        @AuraEnabled Public Map<String,Integer> leadSource;
        @AuraEnabled Public List<String> leadStatus;
        @AuraEnabled Public List<String> relationShipObject;
        @AuraEnabled Public List<RecordType> recordType;
        @AuraEnabled Public List<DuplicateRule> duplicateRulesList;
        @AuraEnabled Public List<ApexTrigger> isTriggers;
        @AuraEnabled Public List<FlowDefinitionView> flowList;
        @AuraEnabled Public List<Modal3> validationRule;

        public Modal()
        {
            validationRule = new List<Modal3>();
        }

    }

    //Wrapper class for Opportunity object
    public class Modal2
    {
        @AuraEnabled Public Decimal percentageOfActivities = 0;
        @AuraEnabled Public Decimal percentageOfOpporunity = 0;
        @AuraEnabled Public List<ApexTrigger> isTriggers;
        @AuraEnabled Public List<String> opportunityStages;
        @AuraEnabled Public List<FlowDefinitionView> flowList;
        @AuraEnabled Public List<Modal3> validationRule;
        @AuraEnabled Public List<String> relationShipObject;
        @AuraEnabled Public List<RecordType> recordType;
        @AuraEnabled Public List<DuplicateRule> duplicateRulesList;
        @AuraEnabled Public List<ExtractAccountDataCls.Modal2> pageLayoutList;

        public Modal2()
        {
            validationRule = new List<Modal3>();
            //pageLayoutList = new List<Modal5>();
        }

    }

    //This Wrapper class makes for validation rules and used in to the Modal2 as a list.
    public class Modal3
    {
        @AuraEnabled Public String name;
        @AuraEnabled Public String description;
        @AuraEnabled Public String sObjects;
        @AuraEnabled Public Boolean isActive;
    }

    //This Wrapper class used to contains org licenses details.
    public class Modal4
    {
        @AuraEnabled Public String name;
        @AuraEnabled Public Integer totalLicenses;
        @AuraEnabled Public Integer usedLicenses;
        @AuraEnabled Public String status;
        @AuraEnabled Public Decimal percentage;
    }

    //  //This wrapper used to contains the page layout info.
    //  public class Modal5
    //  {
    //      @AuraEnabled Public String name;
    //      @AuraEnabled Public String sObjectName;
    //  }
}