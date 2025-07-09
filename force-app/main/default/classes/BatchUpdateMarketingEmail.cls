global class BatchUpdateMarketingEmail implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [SELECT Id, Marketing_Emails__c  FROM Contact  WHERE HasOptedOutOfEmail = false  AND npsp__Do_Not_Contact__c = false AND No_Newsletter__c = false]
        );
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Contact> contactsToUpdate = new List<Contact>();

        for (SObject s : scope) {
            Contact con = (Contact) s;
            con.Marketing_Emails__c = true;
            contactsToUpdate.add(con);
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    global void finish(Database.BatchableContext bc) {
        // Optional: Add logging or post-processing here
    }
}