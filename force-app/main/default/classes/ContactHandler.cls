/*****
* Created by Girikon 20-Apr-2025 
* Test Class : ContactTriggerTest(90%)
* Purpose: to fill Child contact details on parent contact
*     Change log

*     Author            Date            Description
*	Aakash Jain			11-July-2025	added logic to update PSRM on contact from latest case
* ==============================================================================================================================================================
*
*/
public class ContactHandler {
    public static Boolean isMerging = false;
    
    public static void afterInsertAndUpdate(Map<Id, Contact> oldMap, Map<Id, Contact> newMap){
        system.debug('afterInsertAndUpdate in contacthandler');
        set<Id> contactIds = new Set<Id>();
        set<Id> newContactIds = new Set<Id>();
        List<Contact> contactListToUpdatePSRM = new List<Contact>();
        
        try {
            for (Contact con : newMap.values()) {
                Boolean isChanged = false;
                
                if (Trigger.isInsert) {
                    // Check if Personal_Connection_to_CHD__c is not null
                    if (con.Personal_Connection_to_CHD__c != null) {
                        isChanged = true;
                    }
                    newContactIds.add(con.Id);
                } else if (Trigger.isUpdate && oldMap != null && oldMap.containsKey(con.Id)) {
                    Contact oldCon = oldMap.get(con.Id);
                    
                    isChanged = (
                        con.Personal_Connection_to_CHD__c != oldCon.Personal_Connection_to_CHD__c ||
                        con.FirstName != oldCon.FirstName ||
                        con.LastName != oldCon.LastName ||
                        con.Birthdate != oldCon.Birthdate ||
                        con.Gender__c != oldCon.Gender__c ||
                        con.Heart_Conditions__c != oldCon.Heart_Conditions__c ||
                        con.Heart_Conditions_Other__c != oldCon.Heart_Conditions_Other__c ||
                        con.Aboriginal_or_Torres_Strait_Islander__c != oldCon.Aboriginal_or_Torres_Strait_Islander__c ||
                        con.Age__c != oldCon.Age__c
                    );
                }
                
                if (isChanged) {
                    contactIds.add(con.Id);
                }
            }
            system.debug('contactIds->'+contactIds);
            if(!contactIds.isEmpty()){
                ContactHandlerHelper.fillPrimarySecondaryDetails(contactIds);
            }
            if(!newContactIds.isEmpty()){
                List<Contact> contactListwithcases = [Select Id,Primary_Support_Relationship_Manager__c,(Select Id,OwnerId From Cases order by CreatedDate Desc limit 1) From Contact where ID In : newContactIds ];
                if(!contactListwithcases.isEmpty()){
                    for(Contact contactRec : contactListwithcases){
                        if(contactRec.Cases != null){
                            Contact conToUpdatePSRM = new Contact();
                            conToUpdatePSRM.Id = contactRec.Id;
                            conToUpdatePSRM.Primary_Support_Relationship_Manager__c = contactRec.Cases[0].ownerId;
                            contactListToUpdatePSRM.add(conToUpdatePSRM);
                        }
                    }
                    if(!contactListToUpdatePSRM.isEmpty()){
                        database.update(contactListToUpdatePSRM, false);
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error in afterInsertAndUpdate : ' + e.getMessage());
        }
    }
    
    
    
    public static void afterUpdate(Map<Id, Contact> oldMap, Map<Id, Contact> newMap){
        system.debug('afterUpdate');
        set<Id> contactIdSet = new Set<Id>();
        set<Id> contactIdSetUpdatedMailingState = new Set<Id>();
        Map<string, string> contactIdByOwnerId = new Map<String, String>();
        
        for (Contact newCon : newMap.Values()) {
            Contact oldCon = oldMap.get(newCon.Id);
            
            if (newCon.Support_Personal_1_1_Only__c != oldCon.Support_Personal_1_1_Only__c && newCon.Support_Personal_1_1_Only__c == true) {
                contactIdSet.add(newCon.ID);
                contactIdByOwnerId.put(newCon.ID, newCon.Ownerid);
            }
            //if(newCon.MailingState != oldCon.MailingState && newCon.MailingState != null){
                //contactIdSetUpdatedMailingState.add(newCon.Id);
            //}
        }
        if(!contactIdSet.isEmpty()){
            system.debug('Calling createFollowupTaskForSupport1on1');
            ContactHandlerHelper.createFollowupTaskForSupport1on1(contactIdSet, contactIdByOwnerId);
        }
        if(!contactIdSetUpdatedMailingState.isEmpty()){
            system.debug('Calling populatePRMonContact from contact trigger');
            //ContactHandlerHelper.populatePRMonContact(contactIdSetUpdatedMailingState);
        }
    }
}