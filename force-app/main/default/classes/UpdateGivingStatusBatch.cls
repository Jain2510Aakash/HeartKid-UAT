/* 
* Created By:   {Girikon(Sahil Khan)}
* Created On:   Aug 14, 2024
* Description/Purpose:  Batch class to update Giving Status for Contacts.
* Test Class:   {UpdateGivingStatusBatchSchedulable_Test} {Coverage 100% }
*
* Modification log --
*/
public with sharing class UpdateGivingStatusBatch implements Database.Batchable<sObject>
{
    List<Contact> consToUpdate;
    Date lastGiftDate;
    Date inactiveStartDate;
    Date inactiveEndDate;
    Date lapsedStartDate;
    Date lapsedEndDate;
    Date veryLapsedStartDate;
    Date veryLapsedEndDate;
    Date archivedDate;
    public UpdateGivingStatusBatch()
    {
        Integer currentYear = Date.today().year();
        this.inactiveStartDate = Date.newInstance(currentYear - 1, 7, 1);
        this.inactiveEndDate = Date.newInstance(currentYear, 6, 30);
        this.lapsedStartDate = Date.newInstance(currentYear - 4, 7, 1);
        this.lapsedEndDate = Date.newInstance(currentYear - 1, 6, 30);
        this.veryLapsedStartDate = Date.newInstance(currentYear - 5, 7, 1);
        this.veryLapsedEndDate = Date.newInstance(currentYear - 4, 6, 30);
        this.archivedDate = Date.newInstance(currentYear - 5, 6, 30);
    }
    public Database.QueryLocator start(Database.BatchableContext bc) 
    {
        return Database.getQueryLocator(
            'SELECT Id, Giving_Status__c, npo02__LastCloseDate__c, npsp__Last_Soft_Credit_Date__c FROM Contact WHERE npo02__LastCloseDate__c != null OR npsp__Last_Soft_Credit_Date__c != null'
        );
    }
    public void execute(Database.BatchableContext bc, List<Contact> records)
    {
        this.consToUpdate = new List<Contact>();
        for(Contact con : records)
        {
            if(con.npo02__LastCloseDate__c != null && con.npsp__Last_Soft_Credit_Date__c == null)
            {
                this.lastGiftDate = con.npo02__LastCloseDate__c;
            }
            else if(con.npo02__LastCloseDate__c == null && con.npsp__Last_Soft_Credit_Date__c != null)
            {
                this.lastGiftDate = con.npsp__Last_Soft_Credit_Date__c;
            }
            else if(con.npo02__LastCloseDate__c != null && con.npsp__Last_Soft_Credit_Date__c != null && con.npo02__LastCloseDate__c >= con.npsp__Last_Soft_Credit_Date__c)
            {
                this.lastGiftDate = con.npo02__LastCloseDate__c;
            }
            else if(con.npo02__LastCloseDate__c != null && con.npsp__Last_Soft_Credit_Date__c != null && con.npo02__LastCloseDate__c < con.npsp__Last_Soft_Credit_Date__c)
            {
                this.lastGiftDate = con.npsp__Last_Soft_Credit_Date__c;
            }
            Contact conToUpdate = new Contact();
            conToUpdate.Id = con.Id;
            if(this.lastGiftDate >= this.inactiveStartDate && this.lastGiftDate <= this.inactiveEndDate)
            {
                conToUpdate.Giving_Status__c = 'Inactive';
            }
            else if(this.lastGiftDate >= this.lapsedStartDate && this.lastGiftDate <= this.lapsedEndDate)
            {
                conToUpdate.Giving_Status__c = 'Lapsed';
            }
            else if(this.lastGiftDate >= this.veryLapsedStartDate && this.lastGiftDate <= this.veryLapsedEndDate)
            {
                conToUpdate.Giving_Status__c = 'Very Lapsed';
            }
            else if(this.lastGiftDate <= this.archivedDate)
            {
                conToUpdate.Giving_Status__c = 'Archived';
            }
            this.consToUpdate.add(conToUpdate);
        }
        if(!this.consToUpdate.isEmpty())
        {
            UPDATE this.consToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc)
    {
        // execute any post-processing operations
    }
}