public class BatchUpdateLegacyDataForFalse implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, FirstName, LastName, Email, Donor_Emails__c, Donor_SMS__c, Donor_Phone_Calls__c
            FROM Contact
            WHERE Id NOT IN (
                SELECT ContactId FROM OpportunityContactRole WHERE Opportunity.StageName = 'Closed Won'
            )
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> contactList) {
        List<Contact> contactListToUpdate = new List<Contact>();

        for (Contact con : contactList) {
            con.Donor_Emails__c = false;
            con.Donor_SMS__c = false;
            con.Donor_Phone_Calls__c = false;

            contactListToUpdate.add(con);
        }

        if (!contactListToUpdate.isEmpty()) {
            update contactListToUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
    }
}