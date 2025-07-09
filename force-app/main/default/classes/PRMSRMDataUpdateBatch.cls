/* 
* Created By:   {Girikon(Sahil Khan)}
* Created On:   Sep 02, 2024
* Description/Purpose:  Batch class to update PRM and SRM fields for xeisting Contacts.
* Test Class:   {PRMSRMDataUpdateBatch_Test} {Coverage __% }
*
* Modification log --
*/
public with sharing class PRMSRMDataUpdateBatch implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator(
            'SELECT Id, Primary_Relationship_Manager__c, Secondary_Relationship_Manager__c, MailingState FROM Contact'
        );
    }
    public void execute(Database.BatchableContext bc, List<Contact> records)
    {
        Boolean isGrant = false;
        Boolean isCorporateOrInKind = false;
        Boolean isDonation = false;
        Boolean isOther = false;
        List<Opportunity> oppList = [SELECT Id, RecordType.DeveloperName FROM Opportunity WHERE npsp__Primary_Contact__c = :records[0].Id AND IsWon = true AND Amount > 0];
        if(!oppList.isEmpty())
        {
            for(Opportunity opp : oppList)
            {
                if(opp.RecordType.DeveloperName == 'Grant') 
                {
                    isGrant = true;
                }
                else if(opp.RecordType.DeveloperName == 'Corporate' || opp.RecordType.DeveloperName == 'InKindGift')
                {
                    isCorporateOrInKind = true;
                }
                else if(opp.RecordType.DeveloperName == 'Donation') 
                {
                    isDonation = true;
                }
                else if(opp.RecordType.DeveloperName == 'MatchingGift' || opp.RecordType.DeveloperName == 'MajorGift' || opp.RecordType.DeveloperName == 'Bequest' || opp.RecordType.DeveloperName == 'Membership')
                {
                    isOther = true;
                }
            }
            PRM_SRM_Setting__mdt mdt = new PRM_SRM_Setting__mdt();
            if(isGrant)
            {
                mdt = PRMSRMDataUpdateBatch.getPRM_SRMSettings('Grant', 'Blank');
            }
            else if(isCorporateOrInKind)
            {
                mdt = PRMSRMDataUpdateBatch.getPRM_SRMSettings('Corporate', 'Blank');
            }
            else if(isDonation)
            {
                mdt = PRMSRMDataUpdateBatch.getPRM_SRMSettings('Donation', records[0].MailingState);
            }
            else if(isOther)
            {
                mdt = PRMSRMDataUpdateBatch.getPRM_SRMSettings('MajorGift', 'Blank');
            }
            List<User> userList = [SELECT Id, Username FROM User WHERE Username = :mdt.PRM_Username__c OR Username = :mdt.SRM_Username__c];
            for(User usr : userList)
            {
                if(usr.Username == mdt.PRM_Username__c)
                {
                    records[0].Primary_Relationship_Manager__c = usr.Id;
                }
                if(usr.Username == mdt.SRM_Username__c)
                {
                    records[0].Secondary_Relationship_Manager__c = usr.Id;
                }
            }
            UPDATE records[0];
        }
    }
    public void finish(Database.BatchableContext bc)
    {
        // execute any post-processing operations
    }
    public static PRM_SRM_Setting__mdt getPRM_SRMSettings(String recordTypeName, String state)
    {
        List<PRM_SRM_Setting__mdt> mdtList = [SELECT Id, Opportunity_Record_Type_Name__c, PRM_Username__c, SRM_Username__c, State__c FROM PRM_SRM_Setting__mdt WHERE Opportunity_Record_Type_Name__c = :recordTypeName AND State__c = :state];
        if(mdtList.isEmpty())
        {
            mdtList = [SELECT Id, Opportunity_Record_Type_Name__c, PRM_Username__c, SRM_Username__c, State__c FROM PRM_SRM_Setting__mdt WHERE Opportunity_Record_Type_Name__c = :recordTypeName AND State__c = 'Blank'];
        }
        return mdtList[0];
    }
}