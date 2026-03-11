/**
* @Description : Update Promary Relationship Manager Contact record
* @Author : Girikon
* Test Class: UpdatePrimaryRelationshipManagerTest
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
*
*==============================================================================
* 1.0 | 11 Feb, 2026 |   | Initial Version
**/
public class UpdatePrimaryRelationshipManager {
    public class Request {
        @InvocableVariable(required=true)
        public string contactId;
        
        @InvocableVariable(required=true)
        public string prmId;
    }
    @InvocableMethod(label='Update Primary Relationship Manager on Contact'
                     description='Updates the Primary Relationship Manager field on Contact with given User Id and bypasses duplicate rules')
    public static void updateContactPRM(List<Request> requests) {
        system.debug('requests->'+requests);
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for (Request req : requests) {
            if (req.contactId != null && req.prmId != null) {
                Contact con = new Contact(
                    Id = req.contactId,
                    Primary_Relationship_Manager__c = req.prmId
                );
                contactsToUpdate.add(con);
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            
            Database.DMLOptions dmlOptions = new Database.DMLOptions();
            dmlOptions.DuplicateRuleHeader.allowSave = true;  // Bypass duplicate rules
            dmlOptions.DuplicateRuleHeader.runAsCurrentUser = true;
            
            Database.update(contactsToUpdate, dmlOptions);
        }
    }
    
    
}