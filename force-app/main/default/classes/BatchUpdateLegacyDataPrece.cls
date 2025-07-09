public class BatchUpdateLegacyDataPrece implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([SELECT Id, FirstName, LastName, Email, Donor_Emails__c,Donor_SMS__c,Donor_Phone_Calls__c,
                                         (SELECT OpportunityId FROM OpportunityContactRoles WHERE Opportunity.StageName = 'Closed Won')
                                         FROM Contact
                                         WHERE Id IN (
                                             SELECT ContactId FROM OpportunityContactRole WHERE Opportunity.StageName = 'Closed Won'
                                         )]);
    }
    public void execute(Database.BatchableContext bc, List<Contact> contactList) {
        List<Contact> contactListToUpdate = new List<Contact>();
        
        for(contact con : contactList){
            con.Donor_Emails__c = True;
            con.Donor_SMS__c = True;
            con.Donor_Phone_Calls__c = True;
            contactListToUpdate.add(con);
            
        }
        if(!contactListToUpdate.isEMpty()){
            system.debug(contactListToUpdate);
            system.debug('-->'+contactListToUpdate.size());
            database.update(contactListToUpdate,false);
        }
    }
    public void finish(Database.BatchableContext bc) {
        
    }
    
}