/*****
* Created by Girikon 18-Apr-2025 
* Test Class : BatchFillPrimarySecondaryContTest(98%)
* Purpose: to backfill primary and secondary contact on child contacts
*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/

public class BatchFillPrimarySecondaryCont implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Set<Id> accountIdSet = new Set<Id>();
        String accountHouseHoldRTId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
        list<Account> accList = new List<Account>();
        
        // add where clause for account recordtype for household only
        List<AggregateResult> aggAccountList  = new List<AggregateResult>();
        if(Test.isRunningTest()){
            aggAccountList = [SELECT AccountId FROM Contact WHERE AccountId != NULL GROUP BY AccountId];
        }
        
        return Database.getQueryLocator([SELECT Id, Name FROM Account WHERE RecordTypeId =: accountHouseHoldRTId]);
    }
    public void execute(Database.BatchableContext bc, List<Account> accountList) {
        List<Contact> contactList = new List<Contact>();
        Map<Id, Contact> contactMapToUpdate = new Map<Id,Contact>();
        Map<Id,List<Contact>> accountIdToParentContact = new Map<Id,List<Contact>>();
        Map<Id,List<Contact>> accountIdToChildContact = new Map<Id,List<Contact>>();
        Set<String> parentRoles = new Set<String>{ 'Heart Kid Parent/Carer', 'Heart Angel Parent/Carer'};
            Set<String> childRoles = new Set<String>{'Heart Kid', 'Heart Angel','Heart Kid Sibling', 'Heart Angel Sibling'};
                
                
                Set<Id> accountIds = new Set<Id>();
        for (Account acc : accountList) accountIds.add(acc.Id);
        
        contactList = [
            SELECT Id, FirstName, LastName, AccountId, Birthdate, 
            Personal_Connection_to_CHD__c, Gender__c, Heart_Conditions__c, 
            Heart_Conditions_Other__c, Aboriginal_or_Torres_Strait_Islander__c,Age__c
            FROM Contact
            WHERE AccountId IN :accountIds order by createdDate asc
        ];
        
        system.debug('contactList->'+contactList);
        
        system.debug('contactList->'+contactList.size());
        
        Map<Id, List<Contact>> accountIdToChildContacts = new Map<Id, List<Contact>>();
        Map<Id, List<Contact>> accountIdToParentContacts = new Map<Id, List<Contact>>();
      
        for (Contact con : contactList) {
            Boolean isClassified = false;
            List<String> roles = con.Personal_Connection_to_CHD__c != null
                ? con.Personal_Connection_to_CHD__c.split(';')
                : new List<String>();

            for (String role : roles) {
                if (parentRoles.contains(role)) {
                    if (!accountIdToParentContacts.containsKey(con.AccountId)) {
                            accountIdToParentContacts.put(con.AccountId, new List<Contact>());
                        }
                        accountIdToParentContacts.get(con.AccountId).add(con);
                        isClassified = true;
                    break;
                }
            }

            if (!isClassified) {
                for (String role : roles) {
                    if (childRoles.contains(role)) {
                        if (!accountIdToChildContacts.containsKey(con.AccountId)) {
                            accountIdToChildContacts.put(con.AccountId, new List<Contact>());
                        }
                        accountIdToChildContacts.get(con.AccountId).add(con);
                        break;
                    }
                }
            }
        }

        List<Contact> contactsToUpdate = new List<Contact>();
        for (Id accId : accountIdToParentContacts.keySet()) {
            List<Contact> parents = accountIdToParentContacts.get(accId);
            List<Contact> children = accountIdToChildContacts.get(accId);
            Integer maxChildren = Math.min(6, (children != null ? children.size() : 0));

            for (Contact parent : parents) {
                Contact updateCon = new Contact(Id = parent.Id);

                // Clear all child fields first
                for (Integer i = 0; i < 6; i++) {
                    String prefix = 'Child_' + (i + 1) + '_';
                    updateCon.put(prefix + 'First_Name__c', null);
                    updateCon.put(prefix + 'Last_Name__c', null);
                    updateCon.put(prefix + 'Age__c', null);
                    updateCon.put(prefix + 'D_O_B__c', null);
                    updateCon.put(prefix + 'Personal_connection__c', null);
                    updateCon.put(prefix + 'Gender__c', null);
                    updateCon.put(prefix + 'Heart_Conditions__c', null);
                    updateCon.put(prefix + 'Heart_Conditions_Other__c', null);
                    updateCon.put(prefix + 'Aboriginal_or_TSI__c', null);
                }

                for (Integer i = 0; i < maxChildren; i++) {
                    Contact child = children[i];
                    String prefix = 'Child_' + (i + 1) + '_';
                    updateCon.put(prefix + 'First_Name__c', child.FirstName);
                    updateCon.put(prefix + 'Last_Name__c', child.LastName);
                    updateCon.put(prefix + 'Age__c', child.Age__c);
                    updateCon.put(prefix + 'D_O_B__c', child.Birthdate);
                    updateCon.put(prefix + 'Personal_connection__c', child.Personal_Connection_to_CHD__c);
                    updateCon.put(prefix + 'Gender__c', child.Gender__c);
                    updateCon.put(prefix + 'Heart_Conditions__c', child.Heart_Conditions__c);
                    updateCon.put(prefix + 'Heart_Conditions_Other__c', child.Heart_Conditions_Other__c);
                    updateCon.put(prefix + 'Aboriginal_or_TSI__c', child.Aboriginal_or_Torres_Strait_Islander__c);
                }

                contactsToUpdate.add(updateCon);
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
    
}