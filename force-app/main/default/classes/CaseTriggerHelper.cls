/**
* @Description : to fill PSRM on the related contact
* @Author : Girikon
* Test Class : CaseTriggerTest
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
*
*==============================================================================
* 1.0 | July 11, 2025 |   | Initial Version
**/


public class CaseTriggerHelper {
    public static void afterInsert(Map<Id,Case> oldMap, Map<Id,Case> newMap){
        List<Contact> ContactListToUpdatePSRM = new List<Contact>();
        for(Case caseRec : newMap.values()){
            if(caseRec.ContactId != null){
                contact conRec = new Contact();
                conRec.Id = caseRec.ContactId;
                conRec.Primary_Support_Relationship_Manager__c = caseRec.ownerId;
                ContactListToUpdatePSRM.add(conRec);
            }
        }
        if(!ContactListToUpdatePSRM.isEmpty()){
            database.update(ContactListToUpdatePSRM, false);
        }
    }
    public static void afterUpdate(Map<Id, Case> oldMap, Map<Id, Case> newMap) {
        Map<Id, Contact> contactMapToUpdate = new Map<Id, Contact>();
        Set<Id> contactIdsToReevaluate = new Set<Id>();
        
        for (Case newCase : newMap.values()) {
            Case oldCase = oldMap.get(newCase.Id);
            
            Boolean contactChanged = newCase.ContactId != oldCase.ContactId;
            Boolean ownerChanged = newCase.OwnerId != oldCase.OwnerId;
            system.debug('contactChanged'+contactChanged);
            system.debug('ownerChanged'+ownerChanged);
            
            if (contactChanged) {
                if (oldCase.ContactId != null) {
                    contactIdsToReevaluate.add(oldCase.ContactId); 
                }
                if (newCase.ContactId != null) {
                    contactIdsToReevaluate.add(newCase.ContactId); 
                }
            } else if (!contactChanged && ownerChanged) {
                contactIdsToReevaluate.add(newCase.ContactId); 
            }
            system.debug('contactIdsToReevaluate'+contactIdsToReevaluate);
        }
        
        if (!contactIdsToReevaluate.isEmpty()) {
            List<Contact> contacts = [
                SELECT Id, Primary_Support_Relationship_Manager__c,
                (SELECT Id, OwnerId FROM Cases ORDER BY CreatedDate DESC LIMIT 1)
                FROM Contact
                WHERE Id IN :contactIdsToReevaluate
            ];
            system.debug('contacts->'+contacts);
            
            for (Contact con : contacts) {
                Contact conToUpdate = new Contact(Id = con.Id);
                if (!con.Cases.isEmpty()) {
                    conToUpdate.Primary_Support_Relationship_Manager__c = con.Cases[0].OwnerId;
                } else {
                    conToUpdate.Primary_Support_Relationship_Manager__c = null;
                }
                contactMapToUpdate.put(conToUpdate.Id, conToUpdate);
            }
            system.debug('contactMapToUpdate->'+contactMapToUpdate);
            if (!contactMapToUpdate.isEmpty()) {
                Database.update(contactMapToUpdate.values(), false);
            }
        }
    }
    
    public static void afterDelete(Map<Id, Case> caseOldMap, Map<Id, Case> caseNewMap){
        Map<Id,Contact> ContactMapToUpdatePSRM = new Map<Id, Contact>();
        set<Id> contactIdSet = new set<Id>();
        
        for(Case caseRec : caseOldMap.values()){
            if(caseRec.ContactId != null){
                contactIdSet.add(caseRec.ContactId);
            }
        }
        system.debug('contactIdSet'+contactIdSet);
        if(!contactIdSet.isEmpty()){
            List<Contact> contactList = [Select Id,Primary_Support_Relationship_Manager__c,(Select Id,OwnerId From Cases order by CreatedDate Desc limit 1) From Contact where Id in: contactIdSet];
            system.debug('contactList'+contactList);
            if(!contactList.isEmpty()){
                for(Contact con : contactList){
                    system.debug('contactList->'+contactList);
                    system.debug('con.Cases->'+con.Cases);
                    if(con.Cases != null && !con.Cases.isEmpty()){
                        contact conRecToUpdate = new Contact();
                        conRecToUpdate.Id = con.Id;
                        conRecToUpdate.Primary_Support_Relationship_Manager__c =  con.Cases[0].ownerId;
                        ContactMapToUpdatePSRM.put(conRecToUpdate.Id, conRecToUpdate);
                    }else if(con.Cases.isEmpty() || con.cases == null){
                        contact conRecToUpdate = new Contact();
                        conRecToUpdate.Id = con.Id;
                        conRecToUpdate.Primary_Support_Relationship_Manager__c =  null;
                        ContactMapToUpdatePSRM.put(conRecToUpdate.Id, conRecToUpdate);
                    }
                }
            }
        }
        if(!ContactMapToUpdatePSRM.isEmpty()){
            database.update(ContactMapToUpdatePSRM.values(), false);
        }
    }
}