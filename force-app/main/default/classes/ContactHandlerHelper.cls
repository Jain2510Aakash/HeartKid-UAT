/*****
* Created by Girikon 20-Apr-2025 
* Test Class : ContactTriggerTest(80%)
* Purpose: to fill Child contact details on parent contact
*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/
public class ContactHandlerHelper {
    public static void fillPrimarySecondaryDetails(Set<Id> contactIds) {
        system.debug('contactIds->'+contactIds);
        
        try {
            Id householdRTId = Schema.SObjectType.Account
                .getRecordTypeInfosByName()
                .get('Household Account')
                .getRecordTypeId();
            
            Set<Id> householdAccountIds = new Set<Id>();
            for (AggregateResult ar : [
                SELECT AccountId 
                FROM Contact 
                WHERE Id IN :contactIds 
                AND AccountId != NULL 
                AND Account.RecordTypeId = :householdRTId 
                GROUP BY AccountId
            ]) {
                householdAccountIds.add((Id) ar.get('AccountId'));
            }
            
            if (householdAccountIds.isEmpty()) return;
            system.debug('householdAccountIds->'+householdAccountIds);
            List<Contact> allContacts = [
                SELECT Id, FirstName, LastName, AccountId, Birthdate, 
                Personal_Connection_to_CHD__c, Gender__c, Heart_Conditions__c, 
                Heart_Conditions_Other__c, Aboriginal_or_Torres_Strait_Islander__c, Age__c 
                FROM Contact 
                WHERE AccountId IN :householdAccountIds
            ];
            
            Set<String> parentRoles = new Set<String>{
                'Heart Kid Parent/Carer', 
                    'Heart Angel Parent/Carer'
                    };
                        Set<String> childRoles = new Set<String>{
                            'Heart Kid', 
                                'Heart Angel', 
                                'Heart Kid Sibling', 
                                'Heart Angel Sibling'
                                };
                                    
                                    Map<Id, List<Contact>> accountToParents = new Map<Id, List<Contact>>();
            Map<Id, List<Contact>> accountToChildren = new Map<Id, List<Contact>>();
            Map<Id, List<Contact>> accountToOtherContacts = new Map<Id, List<Contact>>();
            system.debug('allContacts->'+allContacts);
            
            for (Contact con : allContacts) {
                Boolean isClassified = false;
                
                List<String> roles = con.Personal_Connection_to_CHD__c != null
                    ? con.Personal_Connection_to_CHD__c.split(';')
                    : new List<String>();
                
                for (String role : roles) {
                    if (parentRoles.contains(role)) {
                        if (!accountToParents.containsKey(con.AccountId)) {
                            accountToParents.put(con.AccountId, new List<Contact>());
                        }
                        accountToParents.get(con.AccountId).add(con);
                        isClassified = true;
                        break; 
                    }
                }
                
                if (!isClassified) {
                    for (String role : roles) {
                        if (childRoles.contains(role)) {
                            if (!accountToChildren.containsKey(con.AccountId)) {
                                accountToChildren.put(con.AccountId, new List<Contact>());
                            }
                            accountToChildren.get(con.AccountId).add(con);
                            isClassified = true;
                            break;
                        }
                    }
                }
                
                if (!isClassified) {
                    if (!accountToOtherContacts.containsKey(con.AccountId)) {
                        accountToOtherContacts.put(con.AccountId, new List<Contact>());
                    }
                    accountToOtherContacts.get(con.AccountId).add(con);
                }
            }
            
            List<Contact> contactsToUpdate = new List<Contact>();
            for (Id accId : accountToParents.keySet()) {
                List<Contact> parents = accountToParents.get(accId);
                system.debug('parents->'+parents);
                system.debug('parents.size()->'+parents.size());
                List<Contact> children = accountToChildren.get(accId);
                Integer maxChildren = Math.min(6, children != null ? children.size() : 0);
                system.debug('maxChildren->'+maxChildren);
                
                for (Contact parent : parents) {
                    Contact updateCon = new Contact(Id = parent.Id);
                    
                    
                    for (Integer i = 0; i < 6 ; i++) {
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
                    system.debug('updateCon->'+updateCon);
                    contactsToUpdate.add(updateCon);
                }
            }
            system.debug('contactsToUpdate->'+contactsToUpdate);
            List<Contact> mergedList = new List<Contact>();
            
            if(!accountToChildren.isEmpty())
                for (List<Contact> contactList : accountToChildren.values()) {
                    mergedList.addAll(contactList);
                }
            if(!accountToOtherContacts.isEmpty())
                for (List<Contact> contactList : accountToOtherContacts.values()) {
                    mergedList.addAll(contactList);
                }
            if(!mergedList.isEmpty())
                for (Contact conRec : mergedList) {
                    Contact updateCon = new Contact(Id = conRec.Id);
                    
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
                    
                    contactsToUpdate.add(updateCon);
                }
            
            if (!contactsToUpdate.isEmpty()) {
                system.debug('updating contact');
                Set<Contact> uniqueContacts = new Set<Contact>(contactsToUpdate);
                contactsToUpdate = new List<Contact>(uniqueContacts);
                update contactsToUpdate;
            }
        } catch (Exception e) {
            System.debug('Error in fillPrimarySecondaryDetails: ' + e.getMessage());
            System.debug('Error in fillPrimarySecondaryDetails: ' + e.getLineNumber());
        }
    }
  
    public static void createFollowupTaskForSupport1on1(set<Id> contactIdSet, Map<string, string> contactIdByOwnerId){
        String SupportTaskRT = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Support Task').getRecordTypeId();
        
        List<Task> taskListToInsert = new List<Task>();
        
        try{
            if(!contactIdSet.isEmpty()){
                for(Id conId : contactIdSet){
                    Task taskToInsert = new Task();
                    taskToInsert.WhoId = conId;
                    taskToInsert.Subject = 'Review Communications Pause';
                    taskToInsert.ActivityDate = system.Today().addDays(30);
                    taskToInsert.IsReminderSet = true;
                    taskToInsert.ReminderDateTime = system.now().addDays(29);
                    taskToInsert.OwnerId = contactIdByOwnerId.get(conId);
                    taskToInsert.RecordTypeId = SupportTaskRT;
                    taskListToInsert.add(taskToInsert);
                }
                if(!taskListToInsert.isEmpty()){
                    insert taskListToInsert;
                }
            }
        }
        catch (Exception e) {
            System.debug('Error in createFollowupTaskForSupport1on1: ' + e.getMessage());
            System.debug('Error in createFollowupTaskForSupport1on1: ' + e.getLineNumber());
        }
    }
}