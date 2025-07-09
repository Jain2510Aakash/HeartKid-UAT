/*
Created By          : Girikon (Mohd Sahil)
Created On          : May 15, 2024
@description        : This class used to create dynamic field records in .
Test Class          : InterrogationComponent_Ctrl_Test (Coverage: 86%)

Modification log --
Modified By         : 
Modified On         : 

*/
public with sharing class InterrogationComponent_Ctrl {


    //This is used to create the field record in to the interrogation object.
    @AuraEnabled
    public Static String createFieldRecord(Interrogation__c  interrogationData)
    {
        if(interrogationData != Null)
        {
            Database.SaveResult srList = Database.insert(interrogationData);
            if (srList.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted record: ' + srList.getId());
                return 'Success'; 
            }
            else
            {
                //return srList.getErrors().getMessage();
                return 'Error';
            }
            
        }
        return null;
    }

    @AuraEnabled
    public Static String deleteRecord(String id)
    {
        if(!String.isEmpty(id) || !String.isBlank(id))
        {
            Interrogation__c inter = [Select Id,Name From Interrogation__c Where Id =:id With Security_Enforced limit 1];
            if(inter != Null)
            {
                Delete inter;
                Return 'Success';
            }
        }
        return 'Error';
    }

    @AuraEnabled
    public static Boolean updateRecords(List<Interrogation__c> interList){
       // List<Interrogation__c> inter = new List<Interrogation__c>();
        if(!interList.isEmpty())
        {
            Update interList;
            return true; 
        }
        return false;
    }

    @AuraEnabled
    public static Interrogation__c getRecord(String recordId){
        Interrogation__c inter;
        if(!String.isBlank(recordId) || !String.isEmpty(recordId) )
        {
           inter = [Select Id,Label__c,Pick_Values__c,DataType__c,Value__c From Interrogation__c Where Id =:recordId With Security_Enforced];
        }
        
        return inter;
    }

    //This is used to get records from the interrogation object.
    @AuraEnabled
    public static List<FieldCreator_Cls> getAllTheFieldValues(String sObjectName)
    {
        List<FieldCreator_Cls> fieldCreatorList = new List<FieldCreator_Cls>();
        String query='Select Id, Name, Label__c, Object_Type__c, Pick_Values__c, DataType__c, Value__c From Interrogation__c';
        if(sObjectName != Null || sObjectName != '')
        {
            query+=' Where Object_Type__c =\''+ sObjectName+'\'';
        }
        System.debug('Query=>'+query);
        List<Interrogation__c> interList = Database.query(query);
        if(!interList.isEmpty())
        {
            for(Interrogation__c intr: interList)
            {
                FieldCreator_Cls modal = new FieldCreator_Cls();
                modal.id = intr.Id;
                modal.field_Id = intr.Name; 
                modal.fieldName = intr.Label__c;
                modal.dataType = intr.DataType__c;
                modal.value = intr.Value__c;
                if(!String.isEmpty(intr.Pick_Values__c) || !String.isBlank(intr.Pick_Values__c))
                {
                    List<String> splitData = intr.Pick_Values__c.split(';');
                    for(String str: splitData)
                    {
                        Option_cls option = new Option_cls();
                        option.label = str;
                        option.value = str;
                        System.debug('option=>'+option);
                        modal.options.add(option);
                    }

                    if(modal.dataType == 'Picklist (Multi-Select)' && (!String.isEmpty(intr.Value__c) || !String.isBlank(intr.Value__c)))
                    {
                        modal.selectedOptions = intr.Value__c.split(';');
                    }

                }
                if(modal.dataType == 'Picklist (Multi-Select)')
                {
                    modal.isMultiPicklist = true;
                }
                else if(modal.dataType == 'Picklist')
                {
                    modal.isPickList = true;
                }
                else if(modal.dataType == 'Text')
                {
                    modal.isText = true;
                }
                else if(modal.dataType == 'Number')
                {
                    modal.isNumber = true;
                }
                else if(modal.dataType == 'Checkbox')
                {
                    modal.isCheckbox = true;
                }
                fieldCreatorList.add(modal);
            }
        }
        System.debug('Field Creator List=>'+fieldCreatorList);
        return fieldCreatorList; 
    }

    //this is used to create merge field.
    @AuraEnabled
    public static List<Option_cls> createMergeFields(String sObjectName)
    {
        List<Option_cls> modal = new List<Option_cls>();
        String query='Select Id, Label__c, Object_Type__c, Pick_Values__c, DataType__c, Value__c From Interrogation__c';
        if(sObjectName != Null || sObjectName != '')
        {
            query+=' Where Object_Type__c =\''+ sObjectName+'\'';
        }
        System.debug('Query=>'+query);
        List<Interrogation__c> interList = Database.query(query);
        if(!interList.isEmpty())
        {
            for(Interrogation__c intr: interList)
            {
                Option_cls opt=new Option_cls();
                opt.value=intr.Value__c;
                opt.label=intr.Label__c;
                modal.add(opt);
            }
        }
        return modal;
    }

    public class FieldCreator_Cls
    {
       @AuraEnabled public String id;
       @AuraEnabled public String field_Id;
       @AuraEnabled public String fieldName;
       @AuraEnabled public String dataType;
       @AuraEnabled public Boolean isText;
       @AuraEnabled public Boolean isNumber;
       @AuraEnabled public Boolean isPickList;
       @AuraEnabled public Boolean isMultiPicklist;
       @AuraEnabled public Boolean isCheckbox;
       @AuraEnabled public String value;
       @AuraEnabled public List<Option_cls> options;
       @AuraEnabled public List<String> selectedOptions;

        public FieldCreator_Cls()
        {
            options = new List<Option_cls>();
            selectedOptions = new List<String>();
            isText = false;
            isNumber = false;
            isPickList = false;
            isMultiPicklist = false;
            isCheckbox = false;
            value ='';
        }
    }

    public class Option_cls 
    {
        @AuraEnabled public String label;
        @AuraEnabled public String value;

    }
}