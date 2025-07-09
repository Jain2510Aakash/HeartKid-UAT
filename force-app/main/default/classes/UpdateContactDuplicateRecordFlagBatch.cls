/*
Created By          : Girikon (Mohd Sahil)
Created On          : Oct 23, 2024
@description        : This class is used to find out the duplicate contact records and transer the related data from duplicate record to unique contact record.
Test Class          : UpdateContactFlagBatchTest (Coverage: 90%)

Modification log --
Modified By         : Girikon (Sahil Khan)
Modified On         : Nov 04, 2024
*/
global class UpdateContactDuplicateRecordFlagBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'Select Id,FirstName ,LastName ,Email ,Phone  From Contact Where (FirstName != \'\' AND LastName != \'\' AND (Email != \'\' OR Phone != \'\')) AND Migrated_From_Dependent_Record__c = false';
        
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Contact> records)
    {
        
        List<Contact> currentContact =[Select Id,FirstName ,LastName ,Email ,Phone ,Duplicate_Contact_Flag__c, AccountId  From Contact Where Id =: records[0].Id AND Duplicate_Contact_Flag__c = false AND Migrated_From_Dependent_Record__c = false];
        
        if(!currentContact.isEmpty())
        {
            try
            {
                List<Contact> duplicateContacts = [SELECT Id, FirstName, LastName, Email, Phone, Duplicate_Contact_Flag__c, (SELECT Id , Primary_Contact__c,Secondary_Contact__c FROM Dependents__r),(SELECT Id,Secondary_Contact__c FROM Dependents1__r), (SELECT Id, npsp__Primary_Contact__c, AccountId FROM Opportunities), (SELECT Id, ContactId, AccountId FROM Cases), (Select Id, WhoId from Tasks), (Select Id, WhoId from ActivityHistories WHERE IsTask = true),(SELECT Id, Name, npe5__Contact__c, npe5__Organization__c,npe5__Description__c,npe5__EndDate__c,npe5__Primary__c,npsp__Related_Opportunity_Contact_Role__c,npe5__Role__c,npe5__StartDate__c,npe5__Status__c FROM npe5__Affiliations__r),(SELECT Id,npe4__Contact__c, npe4__Description__c, npe4__ReciprocalRelationship__c,npe4__RelatedContact__c,npe4__SYSTEM_SystemCreated__c,npe4__Status__c,npe4__Type__c,npsp__Related_Opportunity_Contact_Role__c FROM npe4__Relationships1__r), (SELECT Id,npe4__Contact__c, npe4__Description__c, npe4__ReciprocalRelationship__c,npe4__RelatedContact__c,npe4__SYSTEM_SystemCreated__c,npe4__Status__c,npe4__Type__c,npsp__Related_Opportunity_Contact_Role__c FROM npe4__Relationships__r), (SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLinks) from Contact WHERE FirstName = :currentContact[0].FirstName AND LastName = :currentContact[0].LastName AND ((Email != '' AND Email = :currentContact[0].Email) OR (Phone != '' AND Phone = :currentContact[0].Phone)) AND Id !=: currentContact[0].Id AND Migrated_From_Dependent_Record__c = false];
                System.debug('Duplcate Contacts=>'+duplicateContacts);
                if(!duplicateContacts.isEmpty())
                {
                    //List<Account> accsToUpdate = new List<Account>();
                    List<Contact> consToUpdate = new List<Contact>();
                    List<Opportunity> oppsToUpdate = new List<Opportunity>();
                    List<Case> casesToUpdate = new List<Case>();
                    List<Task> tasksToUpdate = new List<Task>();
                    // List<ActivityHistory> ahsToUpdate = new List<ActivityHistory>();
                    List<npe5__Affiliation__c> affsToInsert = new List<npe5__Affiliation__c>();
                    List<ContentDocumentLink> cdlsToInsert = new List<ContentDocumentLink>();
                    List<Dependents__c> depToUpdate = new List<Dependents__c>();
                    List<npe4__Relationship__c> relToUpdate = new List<npe4__Relationship__c>();
                    List<npe4__Relationship__c> relToInsert = new List<npe4__Relationship__c>();
                    List<npe4__Relationship__c> relToDelete = new List<npe4__Relationship__c>();
                    
                    for(Contact con : duplicateContacts)
                    {
                        Contact conToUpdate = new Contact();
                        conToUpdate.Id = con.Id;
                        conToUpdate.Duplicate_Contact_Flag__c = true;
                        consToUpdate.add(conToUpdate);
                        if(!con.Opportunities.isEmpty())
                        {
                            for(Opportunity oppObj : con.Opportunities)
                            {
                                Opportunity opp = new Opportunity();
                                opp.Id = oppObj.Id;
                                opp.AccountId = currentContact[0].AccountId;
                                opp.npsp__Primary_Contact__c = currentContact[0].Id;
                                oppsToUpdate.add(opp);
                            }
                        }
                        if(!con.Cases.isEmpty())
                        {
                            for(Case csObj : con.Cases)
                            {
                                Case cs = new Case();
                                cs.Id = csObj.Id;
                                cs.AccountId = currentContact[0].AccountId;
                                cs.ContactId = currentContact[0].Id;
                                casesToUpdate.add(cs);
                            }
                        }
                        if(!con.Tasks.isEmpty())
                        {
                            for(Task tskObj : con.Tasks)
                            {
                                Task tsk = new Task();
                                tsk.Id = tskObj.Id;
                                tsk.WhoId = currentContact[0].Id;
                                tasksToUpdate.add(tsk);
                            }
                        }
                        if(!con.npe5__Affiliations__r.isEmpty())
                        {
                            for(npe5__Affiliation__c affObj : con.npe5__Affiliations__r)
                            {
                                npe5__Affiliation__c aff = new npe5__Affiliation__c();
                                // aff.Id = affObj.Id;
                                aff.npe5__Organization__c = currentContact[0].AccountId; // affObj.npe5__Organization__c;
                                aff.npe5__Contact__c = currentContact[0].Id;
                                aff.npe5__Description__c = affObj.npe5__Description__c;
                                aff.npe5__EndDate__c = affObj.npe5__EndDate__c;
                                aff.npe5__Primary__c = affObj.npe5__Primary__c;
                                aff.npsp__Related_Opportunity_Contact_Role__c = affObj.npsp__Related_Opportunity_Contact_Role__c;
                                aff.npe5__Role__c = affObj.npe5__Role__c;
                                aff.npe5__StartDate__c = affObj.npe5__StartDate__c;
                                aff.npe5__Status__c = affObj.npe5__Status__c;
                                affsToInsert.add(aff);
                            }
                        }
                        if(!con.ContentDocumentLinks.isEmpty())
                        {
                            for(ContentDocumentLink cdlObj : con.ContentDocumentLinks)
                            {
                                ContentDocumentLink cdl = new ContentDocumentLink();
                                cdl.LinkedEntityId = currentContact[0].Id;
                                cdl.ContentDocumentId = cdlObj.ContentDocumentId ;
                                cdlsToInsert.add(cdl);
                            }
                        }
                        
                        if(!con.Dependents__r.isEmpty())
                        {
                            for(Dependents__c depObj : con.Dependents__r)
                            {
                                Dependents__c dep = new Dependents__c();
                                dep.Id = depObj.Id;
                                dep.Primary_Contact__c = currentContact[0].Id;
                                depToUpdate.add(dep);
                            }
                        }
                        if(!con.Dependents1__r.isEmpty())
                        {
                            for(Dependents__c depObj : con.Dependents1__r)
                            {
                                Dependents__c dep = new Dependents__c();
                                dep.Id = depObj.Id;
                                dep.Secondary_Contact__c = currentContact[0].Id;
                                depToUpdate.add(dep);
                            }
                        }
                        //Insert relationship for npe4__RelatedContact__c contacts
                        /*if(!con.npe4__Relationships1__r.isEmpty())
                        {
                            for(npe4__Relationship__c relObj : con.npe4__Relationships1__r)
                            {
                                npe4__Relationship__c rel = new npe4__Relationship__c();
                                rel.npe4__Contact__c = relObj.npe4__Contact__c;
                                rel.npe4__Description__c = relObj.npe4__Description__c;
                                //rel.npe4__ReciprocalRelationship__c = relObj.npe4__ReciprocalRelationship__c;
                                rel.npe4__RelatedContact__c = currentContact[0].Id;
                                rel.npe4__SYSTEM_SystemCreated__c = relObj.npe4__SYSTEM_SystemCreated__c;
                                rel.npe4__Status__c = relObj.npe4__Status__c;
                                rel.npe4__Type__c = relObj.npe4__Type__c;
                                rel.npsp__Related_Opportunity_Contact_Role__c = relObj.npsp__Related_Opportunity_Contact_Role__c;
                                relToInsert.add(rel);
                            }
                        }*/
                        //Insert relationship for npe4__Contact__c contacts
                        /*if(!con.npe4__Relationships__r.isEmpty())
                        {
                            for(npe4__Relationship__c relObj : con.npe4__Relationships__r)
                            {
                                
                                npe4__Relationship__c rel = new npe4__Relationship__c();
                                rel.npe4__Contact__c = currentContact[0].Id;
                                rel.npe4__Description__c = relObj.npe4__Description__c;
                                //rel.npe4__ReciprocalRelationship__c = relObj.npe4__ReciprocalRelationship__c;
                                rel.npe4__RelatedContact__c = relObj.npe4__RelatedContact__c;
                                rel.npe4__SYSTEM_SystemCreated__c = relObj.npe4__SYSTEM_SystemCreated__c;
                                rel.npe4__Status__c = relObj.npe4__Status__c;
                                rel.npe4__Type__c = relObj.npe4__Type__c;
                                rel.npsp__Related_Opportunity_Contact_Role__c = relObj.npsp__Related_Opportunity_Contact_Role__c;
                                relToInsert.add(rel);
                            }
                        }*/
                        
                    }
                    if(!consToUpdate.isEmpty())
                    {
                        UPDATE consToUpdate;
                    }
                    if(!casesToUpdate.isEmpty())
                    {
                        UPDATE casesToUpdate;
                    }
                    if(!tasksToUpdate.isEmpty())
                    {
                        UPDATE tasksToUpdate;
                    }
                    /*if(!relToUpdate.isEmpty())
                    {
                        UPDATE relToUpdate;
                    }*/
                    /*if(!relToInsert.isEmpty())
                    {
                        INSERT relToInsert;
                    }*/
                    if(!affsToInsert.isEmpty())
                    {
                        INSERT affsToInsert;
                    }
                    if(!cdlsToInsert.isEmpty())
                    {
                        INSERT cdlsToInsert;
                    }
                    if(!depToUpdate.isEmpty())
                    {
                        Update depToUpdate;
                    }
                    if(!oppsToUpdate.isEmpty())
                    {
                        UPDATE oppsToUpdate;
                    }
                }
            }
            catch(Exception e)
            {
                currentContact[0].Batch_Error_Message__c = 'Error => ' + e.getMessage();
                UPDATE currentContact[0];
            }
        }
        
    }
    global void finish(Database.BatchableContext BC) {
    }
}