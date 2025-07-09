/*
Created By          : Girikon (Sahil Khan)
Created On          : Oct 25, 2024
Description         : This class is used to find out the duplicate account records and transer the related data from duplicate record to unique Account record.
Test Class          : DedupeAccountsBatchTest (Coverage: 83%)

Modification log --
Modified By         : 
Modified On         : 
*/
public class DedupeAccountsBatch implements Database.Batchable<sObject> 
{
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator('SELECT Id FROM Account WHERE BillingStreet != \'\' AND BillingCity != \'\' AND BillingState != \'\' AND BillingPostalCode != \'\' AND BillingCountry != \'\'');
    }
    public void execute(Database.BatchableContext bc, List<Account> records)
    {
        List<Account> currentAccount = [SELECT Id, Is_Duplicate__c, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Is_Duplicate__c = false AND Id = :records[0].Id];
        if(!currentAccount.isEmpty())
        {
            try
            {
                List<Account> duplicateAccounts = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, Is_Duplicate__c, (SELECT Id, AccountId FROM Contacts), (SELECT Id, AccountId FROM Opportunities), (SELECT Id, AccountId FROM Cases), (Select Id, WhatId from Tasks), (Select Id, WhatId from ActivityHistories WHERE IsTask = true), (SELECT Id, npsp__Household_Account__c FROM npsp__Addresses__r), (SELECT Id, npe5__Organization__c,npe5__Contact__c,npe5__Description__c,npe5__EndDate__c,npe5__Primary__c,npsp__Related_Opportunity_Contact_Role__c,npe5__Role__c,npe5__StartDate__c,npe5__Status__c FROM npe5__Affiliations__r), (SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLinks) from Account WHERE Name = :currentAccount[0].Name AND BillingStreet = :currentAccount[0].BillingStreet AND BillingCity = :currentAccount[0].BillingCity AND BillingState = :currentAccount[0].BillingState AND BillingPostalCode = :currentAccount[0].BillingPostalCode AND BillingCountry = :currentAccount[0].BillingCountry AND Id != :currentAccount[0].Id];
                // System.debug('duplicateAccounts => ' + duplicateAccounts);
                if(!duplicateAccounts.isEmpty())
                {
                    List<Account> accsToUpdate = new List<Account>();
                    List<Contact> consToUpdate = new List<Contact>();
                    List<Opportunity> oppsToUpdate = new List<Opportunity>();
                    List<Case> casesToUpdate = new List<Case>();
                    List<Task> tasksToUpdate = new List<Task>();
                    // List<ActivityHistory> ahsToUpdate = new List<ActivityHistory>();
                    List<npsp__Address__c> addsToUpdate = new List<npsp__Address__c>();
                    List<npe5__Affiliation__c> affsToUpdate = new List<npe5__Affiliation__c>();
                    List<ContentDocumentLink> cdlsToInsert = new List<ContentDocumentLink>();
                    for(Account acc : duplicateAccounts)
                    {
                        Account accToUpdate = new Account();
                        accToUpdate.Id = acc.Id;
                        accToUpdate.Is_Duplicate__c = true;
                        accsToUpdate.add(accToUpdate);
                        if(!acc.Contacts.isEmpty())
                        {
                            for(Contact conObj : acc.Contacts)
                            {
                                Contact con = new Contact();
                                con.Id = conObj.Id;
                                con.AccountId = currentAccount[0].Id;
                                consToUpdate.add(con);
                            }
                        }
                        if(!acc.Opportunities.isEmpty())
                        {
                            for(Opportunity oppObj : acc.Opportunities)
                            {
                                Opportunity opp = new Opportunity();
                                opp.Id = oppObj.Id;
                                opp.AccountId = currentAccount[0].Id;
                                oppsToUpdate.add(opp);
                            }
                        }
                        if(!acc.Cases.isEmpty())
                        {
                            for(Case csObj : acc.Cases)
                            {
                                Case cs = new Case();
                                cs.Id = csObj.Id;
                                cs.AccountId = currentAccount[0].Id;
                                casesToUpdate.add(cs);
                            }
                        }
                        if(!acc.Tasks.isEmpty())
                        {
                            for(Task tskObj : acc.Tasks)
                            {
                                Task tsk = new Task();
                                tsk.Id = tskObj.Id;
                                tsk.WhatId = currentAccount[0].Id;
                                tasksToUpdate.add(tsk);
                            }
                        }
                        if(!acc.npsp__Addresses__r.isEmpty())
                        {
                            for(npsp__Address__c addObj : acc.npsp__Addresses__r)
                            {
                                npsp__Address__c add = new npsp__Address__c();
                                add.Id = addObj.Id;
                                add.npsp__Household_Account__c = currentAccount[0].Id;
                                addsToUpdate.add(add);
                            }
                        }
                        if(!acc.npe5__Affiliations__r.isEmpty())
                        {
                            for(npe5__Affiliation__c affObj : acc.npe5__Affiliations__r)
                            {
                                npe5__Affiliation__c aff = new npe5__Affiliation__c();
                                // aff.Id = affObj.Id;
                                aff.npe5__Organization__c = currentAccount[0].Id;
                                aff.npe5__Contact__c = affObj.npe5__Contact__c;
                                aff.npe5__Description__c = affObj.npe5__Description__c;
                                aff.npe5__EndDate__c = affObj.npe5__EndDate__c;
                                aff.npe5__Primary__c = affObj.npe5__Primary__c;
                                aff.npsp__Related_Opportunity_Contact_Role__c = affObj.npsp__Related_Opportunity_Contact_Role__c;
                                aff.npe5__Role__c = affObj.npe5__Role__c;
                                aff.npe5__StartDate__c = affObj.npe5__StartDate__c;
                                aff.npe5__Status__c = affObj.npe5__Status__c;
                                affsToUpdate.add(aff);
                            }
                        }
                        if(!acc.ContentDocumentLinks.isEmpty())
                        {
                            for(ContentDocumentLink cdlObj : acc.ContentDocumentLinks)
                            {
                                ContentDocumentLink cdl = new ContentDocumentLink();
                                cdl.LinkedEntityId = currentAccount[0].Id;
                                cdl.ContentDocumentId = cdlObj.ContentDocumentId ;
                                cdlsToInsert.add(cdl);
                            }
                        }
                    }
                    if(!accsToUpdate.isEmpty())
                    {
                        UPDATE accsToUpdate;
                    }
                    if(!consToUpdate.isEmpty())
                    {
                        UPDATE consToUpdate;
                    }
                    if(!oppsToUpdate.isEmpty())
                    {
                        UPDATE oppsToUpdate;
                    }
                    if(!casesToUpdate.isEmpty())
                    {
                        UPDATE casesToUpdate;
                    }
                    if(!tasksToUpdate.isEmpty())
                    {
                        UPDATE tasksToUpdate;
                    }
                    if(!addsToUpdate.isEmpty())
                    {
                        UPDATE addsToUpdate;
                    }
                    if(!affsToUpdate.isEmpty())
                    {
                        INSERT affsToUpdate;
                    }
                    if(!cdlsToInsert.isEmpty())
                    {
                        INSERT cdlsToInsert;
                    }
                }
            }
            catch(Exception e)
            {
                currentAccount[0].Batch_Error_Message__c = 'Error => ' + e.getMessage();
                UPDATE currentAccount[0];
            }
        }
    }
    public void finish(Database.BatchableContext bc)
    {
        // execute any post-processing operations
    }
}