/*
Created By          : Girikon (Mohd Sahil)
Created On          : Oct 23, 2024
@description        : This class is used to update "Record Type flag" field on Campaign Object.
Test Class          : UpdateCampaignRecordTypeBatch_Test (Coverage: 94%)

Modification log --
Modified By         : 
Modified On         : 

*/
global class UpdateCampaignRecordTypeBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id FROM Campaign';
        
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Campaign> sc)
    {
        Set<Id> Ids = new Set<Id>();
        for(Campaign cam:sc)
        {
            Ids.add(cam.Id);
        }
        List<Campaign> scope = [SELECT Id, AmountAllOpportunities, Total_Value_of_Fundraising_Page__c, RecordTypeId, (Select Id, Total_Value_of_Fundraising_Page__c, AmountAllOpportunities, RecordTypeId, (Select Id, Total_Value_of_Fundraising_Page__c, AmountAllOpportunities, RecordTypeId From ChildCampaigns Where AmountAllOpportunities > 0 OR Total_Value_of_Fundraising_Page__c > 0) from ChildCampaigns) FROM Campaign Where Id IN :Ids];       
        boolean flag = false;
        List<Campaign> campList = new List<Campaign>();
        
        for(Campaign a : scope)
        {
            if(a.AmountAllOpportunities >0 || a.Total_Value_of_Fundraising_Page__c >0)
            {
                flag = true;
                campList.add(new Campaign (Id = a.Id, Record_Type_Flag__c = flag));                
            }
            else If(a.ChildCampaigns.size() >0)
            {
                for(Campaign b:a.ChildCampaigns)
                {
                    if(b.AmountAllOpportunities >0 || b.Total_Value_of_Fundraising_Page__c >0)
                    {
                        flag = true;
                        campList.add(new Campaign (Id = a.Id, Record_Type_Flag__c = flag)); 
                        break;
                    }
                    else if(b.ChildCampaigns.size() >0)
                    {
                        flag = true;
                        campList.add(new Campaign (Id = a.Id, Record_Type_Flag__c = flag)); 
                        break;
                    }
                }
                
            }
            flag = false;
        }
        if(!campList.isEmpty())
        {
            update campList;
        }
        
        
    }
    global void finish(Database.BatchableContext BC) {
    }
}