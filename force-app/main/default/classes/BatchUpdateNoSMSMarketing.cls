global class BatchUpdateNoSMSMarketing  implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [SELECT Id, Marketing_SMS__c,Donor_SMS__c  FROM Contact  WHERE No_SMS_Marketing__c = true]
        );
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Contact> contactsToUpdate = new List<Contact>();

        for (SObject s : scope) {
            Contact con = (Contact) s;
            con.Marketing_SMS__c = false;
            con.Donor_SMS__c = false;
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