/**
* @Description : to fill PSRM on the contact where cases exists for legacy data  
* @Author : Girikon
* Test Class : BatchUpdatePSRMContactTest
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
*
*==============================================================================
* 1.0 | July 11, 2025 |   | Initial Version
**/

global class BatchUpdatePSRMContact implements Database.Batchable<SObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([
            SELECT Id
            FROM Contact
            WHERE Id IN (
                SELECT ContactId FROM Case WHERE ContactId != null
            )
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        Set<Id> contactIds = new Set<Id>();
        for (Contact con : scope) {
            contactIds.add(con.Id);
        }

        // Map to store ContactId → Most Recent Case OwnerId
        Map<Id, Id> contactToOwnerMap = new Map<Id, Id>();

        // Query most recent Case for each Contact
        List<AggregateResult> recentCases = [
            SELECT ContactId, MAX(CreatedDate) maxDate
            FROM Case
            WHERE ContactId IN :contactIds
            GROUP BY ContactId
        ];

        // Map to hold (ContactId, MaxDate)
        Map<Id, Datetime> contactToMaxDate = new Map<Id, Datetime>();
        for (AggregateResult ar : recentCases) {
            contactToMaxDate.put((Id)ar.get('ContactId'), (Datetime)ar.get('maxDate'));
        }

        // Fetch the Case records matching the most recent created date for each contact
        List<Case> caseList = [
            SELECT Id, ContactId, OwnerId, CreatedDate
            FROM Case
            WHERE ContactId IN :contactIds AND CreatedDate IN :contactToMaxDate.values()
        ];

        for (Case c : caseList) {
            if (!contactToOwnerMap.containsKey(c.ContactId)) {
                // Assign OwnerId if not already set (in case of multiple matches on same timestamp)
                contactToOwnerMap.put(c.ContactId, c.OwnerId);
            }
        }

        // Update Contact records
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Contact con : scope) {
            if (contactToOwnerMap.containsKey(con.Id)) {
                con.Primary_Support_Relationship_Manager__c = contactToOwnerMap.get(con.Id);
                contactsToUpdate.add(con);
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            Database.update(contactsToUpdate,False);
        }
    }

    global void finish(Database.BatchableContext BC) {
    }
}