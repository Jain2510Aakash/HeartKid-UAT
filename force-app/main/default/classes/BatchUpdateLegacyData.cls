/*****
* Created by Girikon 05-May-2025 
* Test Class : BatchUpdateLegacyDataTest(100%)
* Purpose: to update Donor Email
*     Change logr

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/

public class BatchUpdateLegacyData implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([SELECT Id,AccountId,No_SMS_Marketing__c,HasOptedOutOfEmail,Donor_SMS__c,Donor_Phone_Calls__c,Donor_Emails__c From Contact WHERE 
                                        (HasOptedOutOfEmail = False AND npsp__Do_Not_Contact__c = False AND No_Solicitation__c = False) OR 
                                        (DoNotCall = False AND No_SMS_Marketing__c = False AND npsp__Do_Not_Contact__c = False AND No_Solicitation__c = False)]);
    }
    public void execute(Database.BatchableContext bc, List<Contact> contactList) {
        Map<Id, Id> contactIdByAccountId = new Map<Id,Id>();
        Map<Id,Id> accountIdByOpportuntyId = new Map<Id, Id>();
        List<Contact> contactListToUpdate = new List<Contact>();
        List<Opportunity> closedWonOpportunityList = new List<Opportunity>();
        boolean isUpdated  = false;
        
        if(!contactList.isEmpty()){
            for(Contact con : contactList){
                contactIdByAccountId.put(con.Id, con.AccountId);
            }
            if(!contactIdByAccountId.isEmpty()){
                closedWonOpportunityList = [Select Id, AccountId From Opportunity where AccountId IN: contactIdByAccountId.values() and Stagename = 'Closed Won'];
                if(!closedWonOpportunityList.isEmpty()){
                    for(Opportunity opp : closedWonOpportunityList){
                        accountIdByOpportuntyId.put(opp.AccountId,opp.Id);
                    }
                }
            }
            for(Contact con : contactList){
                Contact conRecToUpdate = new Contact();
                conRecToUpdate.Id = con.Id;
                if(contactIdByAccountId.containsKey(con.id) && accountIdByOpportuntyId.containsKey(con.AccountId)){
                    if(!con.HasOptedOutOfEmail){
                        conRecToUpdate.Donor_Emails__c = true;
                        isUpdated = true;
                    }
                    if(!con.No_SMS_Marketing__c){
                        conRecToUpdate.Donor_SMS__c = true;
                        conRecToUpdate.Donor_Phone_Calls__c = true;
                        isUpdated = true;
                    }
                }

                if(isUpdated){
                    contactListToUpdate.add(conRecToUpdate);
                }
            }
            if(!contactListToUpdate.isEmpty()){
                update contactListToUpdate;
            }
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
    
}