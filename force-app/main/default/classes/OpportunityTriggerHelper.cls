public class OpportunityTriggerHelper {
   /* public static void populatePRMonContact(set<Id> insertedOppIds, Set<Id> updatedOppIds){
        set<string> usernameSet = new Set<String>();
        List<Contact> contactListToUpdate = new List<Contact>();
        Map<String,String> stateByUsernameMap = new Map<String, String>();
        Map<String,String> usernameByUserIdMap = new Map<String, String>();
        string exceptionUsernames = system.label.Exceptions_For_Fundraiser_PRM_Override;
        
        system.debug('insertedOppIds->'+insertedOppIds);
        system.debug('updatedOppIds->'+insertedOppIds);
        
        List<Opportunity> oppList = [Select Id,npsp__Primary_Contact__r.Primary_Relationship_Manager__c,npsp__Primary_Contact__c,npsp__Primary_Contact__r.MailingState From Opportunity Where npsp__Primary_Contact__c != null AND (Id In: insertedOppIds OR Id in: updatedOppIds) ];
        system.debug('oppList->'+oppList);
        List<Fundraising_PRM__mdt> fundPRMMDT = [Select Fundraising_Coordinator__c,State__c From Fundraising_PRM__mdt];
        system.debug('fundPRMMDT->'+fundPRMMDT);
        if(!fundPRMMDT.isEmpty()){
            for(Fundraising_PRM__mdt mdtRec : fundPRMMDT){
                stateByUsernameMap.put(mdtRec.State__c, mdtRec.Fundraising_Coordinator__c+'.girikonpar');
                string username = ContactHandlerHelper.getBaseUsername(mdtRec.Fundraising_Coordinator__c)+'.girikonpar';
                usernameSet.add(username);
            }
            system.debug('usernameSet->'+usernameSet);
            
            if(!stateByUsernameMap.isEmpty()){
                List<User> userList = [Select Id,username,email from User where username IN : usernameSet];
                for(User userRec : userList){
                    usernameByUserIdMap.put(userRec.username,userRec.Id);
                }
            }
        }
        system.debug('usernameByUserIdMap->'+usernameByUserIdMap);
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                
                system.debug('opp.npsp__Primary_Contact__c'+opp.npsp__Primary_Contact__c);
                system.debug('opp.npsp__Primary_Contact__r.Primary_Relationship_Manager__c'+opp.npsp__Primary_Contact__r.Primary_Relationship_Manager__c);
                
                if(opp.npsp__Primary_Contact__r.Primary_Relationship_Manager__c == null || (opp.npsp__Primary_Contact__r.Primary_Relationship_Manager__c != null && !exceptionUsernames.contains(opp.npsp__Primary_Contact__r.Primary_Relationship_Manager__c) )){
                    Contact conToUpdatePRM = new Contact();
                    conToUpdatePRM.Id = opp.npsp__Primary_Contact__c;
                    conToUpdatePRM.Primary_Relationship_Manager__c =   usernameByUserIdMap.get(stateByUsernameMap.get(opp.npsp__Primary_Contact__r.MailingState));  
                    contactListToUpdate.add(conToUpdatePRM);
                }
            }
        }
        system.debug('contactListToUpdate in opp trigger'+contactListToUpdate);
        
        if(!contactListToUpdate.isEmpty()){
            update contactListToUpdate;
            
            Contact conAfterUpdate = [Select Id,Name,Primary_Relationship_Manager__c From Contact Where Id=:contactListToUpdate[0].Id];
            system.debug('contactListToUpdate in opp trigger'+conAfterUpdate);
        }
    }*/
}