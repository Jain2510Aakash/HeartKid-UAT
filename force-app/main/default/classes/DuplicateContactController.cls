public with sharing class DuplicateContactController {
    @AuraEnabled(cacheable=true)
    public static List<EmailGroupWrapper> getDuplicateContacts() {
        Map<String, List<Contact>> emailToContacts = new Map<String, List<Contact>>();
        
        for (Contact con : [SELECT Id, FirstName, LastName, Email, Phone,State__c,Primary_Relationship_Manager__r.FirstName,Primary_Relationship_Manager__r.LastName,Primary_Support_Relationship_Manager__r.FirstName,Primary_Support_Relationship_Manager__r.LastName
                            FROM Contact
                            WHERE Email != null
                            ORDER BY Email, LastModifiedDate DESC limit 1000]) {
                                if (!emailToContacts.containsKey(con.Email)) {
                                    emailToContacts.put(con.Email, new List<Contact>());
                                }
                                emailToContacts.get(con.Email).add(con);
                            }
        
        List<EmailGroupWrapper> grouped = new List<EmailGroupWrapper>();
        for (String email : emailToContacts.keySet()) {
            List<Contact> conList = emailToContacts.get(email);
            if (conList.size() > 1) {
                grouped.add(new EmailGroupWrapper(email, conList));
            }
        }
        
        return grouped;
    }
    
    public class EmailGroupWrapper {
        @AuraEnabled public String email;
        @AuraEnabled public List<Contact> contacts;
        
        public EmailGroupWrapper(String email, List<Contact> contacts) {
            this.email = email;
            this.contacts = contacts;
        }
    }
}