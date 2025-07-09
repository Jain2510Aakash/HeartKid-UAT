/*
Created By          : Girikon (Mohd Sahil)
Created On          : Oct 24, 2024
@description        : This class is used to update "Delete flag" field on Campaign Object.
Test Class          : DeleteCampaignRecordsBatch_Test (Coverage: 80%)

Modification log --
Modified By         : 
Modified On         : 

*/
global class DeleteCampaignRecordsBatch implements Database.Batchable<sObject> {
    
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
        List<Campaign> scope = [SELECT Id, AmountAllOpportunities, Total_Value_of_Fundraising_Page__c, Number_of_Parents_in_Attendance__c, Number_of_Dependents_in_Attendance__c, (Select Id From CampaignMembers limit 1),(Select Id, Total_Value_of_Fundraising_Page__c, AmountAllOpportunities, Number_of_Parents_in_Attendance__c, Number_of_Dependents_in_Attendance__c, (Select Id From CampaignMembers limit 1), (Select Id, Total_Value_of_Fundraising_Page__c, AmountAllOpportunities, Number_of_Parents_in_Attendance__c, Number_of_Dependents_in_Attendance__c, (Select Id From CampaignMembers limit 1) From ChildCampaigns Where AmountAllOpportunities > 0 OR Total_Value_of_Fundraising_Page__c > 0 OR Number_of_Parents_in_Attendance__c >0 OR Number_of_Dependents_in_Attendance__c >0) from ChildCampaigns) FROM Campaign Where Id IN :Ids];       
        boolean flag = false;
        List<Campaign> campList = new List<Campaign>();
        
        for(Campaign a : scope)
        {
            if(a.AmountAllOpportunities >0 || a.Total_Value_of_Fundraising_Page__c >0 || a.Total_Value_of_Fundraising_Page__c >0 || a.Number_of_Parents_in_Attendance__c >0 || a.CampaignMembers.size() >0)
            {
                flag = true;
                campList.add(new Campaign (Id = a.Id, Delete_Flag__c = flag));                
            }
            else If(a.ChildCampaigns.size() >0)
            {
                for(Campaign b:a.ChildCampaigns)
                {
                    if(b.AmountAllOpportunities >0 || b.Total_Value_of_Fundraising_Page__c >0 || b.Total_Value_of_Fundraising_Page__c >0 || b.Number_of_Parents_in_Attendance__c >0 || b.CampaignMembers.size() >0)
                    {
                        flag = true;
                        campList.add(new Campaign (Id = a.Id, Delete_Flag__c = flag)); 
                        break;
                    }
                    else if(b.ChildCampaigns.size() >0)
                    { 
                        for(Campaign c:b.ChildCampaigns)
                        {
                            if(c.CampaignMembers.size() >0)
                            {
                                flag = true;
                                campList.add(new Campaign (Id = a.Id, Delete_Flag__c = flag)); 
                                break;
                            }      
                        } 
                        break;
                    }
                }
                
            }
            flag = false;
        }
        if(!campList.isEmpty())
        {
         	Database.Update(campList);
        }        
    }
    global void finish(Database.BatchableContext BC) {
    }
}