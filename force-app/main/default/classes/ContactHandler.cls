/*****
* Created by Girikon 20-Apr-2025 
* Test Class : ContactTriggerTest(90%)
* Purpose: to fill Child contact details on parent contact
*     Change log

*     Author            Date            Description
* ==============================================================================================================================================================
*
*/public class ContactHandler {
    
    public static void afterInsertAndUpdate(Map<Id, Contact> oldMap, Map<Id, Contact> newMap){
        set<Id> contactIds = new Set<Id>();
        try {
            for (Contact con : newMap.values()) {
                Boolean isChanged = false;
                
                if (Trigger.isInsert) {
                    // Check if Personal_Connection_to_CHD__c is not null
                    if (con.Personal_Connection_to_CHD__c != null) {
                        isChanged = true;
                    }
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
        } catch (Exception e) {
            System.debug('Error in afterInsertAndUpdate : ' + e.getMessage());
        }
    }
    
    public static void afterUpdate(Map<Id, Contact> oldMap, Map<Id, Contact> newMap){
        set<Id> contactIdSet = new Set<Id>();
        Map<string, string> contactIdByOwnerId = new Map<String, String>();
        
        for (Contact newCon : newMap.Values()) {
            Contact oldCon = oldMap.get(newCon.Id);
            
            if (newCon.Support_Personal_1_1_Only__c != oldCon.Support_Personal_1_1_Only__c && newCon.Support_Personal_1_1_Only__c == true) {
                contactIdSet.add(newCon.ID);
                contactIdByOwnerId.put(newCon.ID, newCon.Ownerid);
            }
        }
        if(!contactIdSet.isEmpty()){
            ContactHandlerHelper.createFollowupTaskForSupport1on1(contactIdSet, contactIdByOwnerId);
        }
    }
}