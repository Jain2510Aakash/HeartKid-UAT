global class BatchMergeDuplicateContact implements Database.Batchable<sObject>, Database.Stateful {
    private String calledFrom;
    private Set<String> processedKeys = new Set<String>();
    
    public BatchMergeDuplicateContact(String calledFrom) {
        this.calledFrom = calledFrom;
    }
    
    private static List<String> interestingFields;
    static {
        interestingFields = new List<String>();
        interestingFields.add('FirstName');
        interestingFields.add('LastName');
        interestingFields.add('Email');
        interestingFields.add('Phone');
        interestingFields.add('Birthdate');
        interestingFields.add('Personal_Connection_to_CHD__c');
        interestingFields.add('Gender__c');
        interestingFields.add('Description');
        
        System.debug('Interesting fields identified for merge: ' + interestingFields);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        ContactHandler.isMerging = true;
        String recordId = '0039h00000V0xj0AAB';
        String query = 'SELECT Id, FirstName, LastName, Email, Phone, MobilePhone,Birthdate, Personal_Connection_to_CHD__c, Gender__c,LastModifiedDate, IsDeleted,MasterRecordId,AccountId,Description FROM Contact WHERE FirstName != NULL  AND Email != NULL';
        DateTime latestEditedRecords = System.now().addSeconds(-20); 
        
        if (calledFrom == 'trigger') {
            query += ' AND (CreatedDate >= :latestEditedRecords OR LastModifiedDate >= :latestEditedRecords)';
        }else if(calledFrom == 'testing'){
            query = 'SELECT Id, FirstName, LastName, Email, Phone, MobilePhone,Birthdate, Personal_Connection_to_CHD__c, Gender__c,LastModifiedDate, IsDeleted,MasterRecordId,AccountId,Description FROM Contact WHERE FirstName != NULL AND LastName != NULL AND Email != NULL and Id = \'' + recordId + '\'';
        }
        else{
            // in case of one time execution
            query = 'SELECT Id, FirstName, LastName, Email, Phone, MobilePhone,Birthdate, Personal_Connection_to_CHD__c, Gender__c,LastModifiedDate, IsDeleted,MasterRecordId,AccountId,Description FROM Contact WHERE FirstName != NULL AND LastName != NULL AND Email != NULL';

        }
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> scope) {
        List<Contact> toUpdate = new List<Contact>();
        List<Contact> toDelete = new List<Contact>();
        
        Map<String, Contact> seedByKey = new Map<String, Contact>();
        for (Contact seed : scope) {
            String key = makeKey(seed);
            System.debug('Processing seed Contact: ' + seed.Id + ', Key: ' + key);
            if (!processedKeys.contains(key)) {
                processedKeys.add(key);
                seedByKey.put(key, seed);
            } else {
                System.debug('Duplicate key already processed in earlier batch chunk: ' + key);
            }
        }
        
        if (seedByKey.isEmpty()) {
            System.debug('No new keys to process in this batch scope.');
            return;
        }
        
        for (String key : seedByKey.keySet()) {
            Contact seed = seedByKey.get(key);
            System.debug('Starting processing for key group: ' + key + ', Seed: ' + seed.Id);
            
            List<Contact> dups = [
                SELECT Id, FirstName, LastName, Email, Phone, MobilePhone,
                Birthdate, Personal_Connection_to_CHD__c, Gender__c,
                LastModifiedDate, IsDeleted,MasterRecordId,AccountId,Description
                FROM Contact
                WHERE FirstName = :seed.FirstName
                AND LastName = :seed.LastName
                AND Email = :seed.Email
            ];
            if (!dups.contains(seed)) {
                dups.add(seed);
            }
            System.debug('Found ' + dups.size() + ' records for key: ' + key);
            
            // Skip if only one record (no duplicate to merge from)
            if (dups.size() <= 1) {
                System.debug('Only one record found. Skipping merge for key: ' + key);
                continue;
            }
            // Master from duplicate
            Contact master = selectMaster(dups);
            if (master == null) {
                System.debug('No suitable master found for key: ' + key + '. Skipping.');
                continue;
            }
            
            System.debug('Selected master: ' + master.Id + ' for key: ' + key);
            mergeFields(master, dups);
            toUpdate.add(master);
            
            for (Contact c : dups) {
                system.debug('c->'+c);
                system.debug('master->'+master);
                
                if (c.Id != master.Id) {
                    System.debug('Marking contact for deletion: ' + c.Id);
                    toDelete.add(c);
                }
            }
        }
        
        System.debug('Total contacts to update: ' + toUpdate.size());
        System.debug('Total contacts to delete: ' + toDelete.size());
        
        // Uncomment to apply changes in your org
        if (!toUpdate.isEmpty()) Database.update(toUpdate);
        if (!toDelete.isEmpty()){
            Database.DeleteResult[] results = Database.delete(toDelete, false);
            for (Database.DeleteResult res : results) {
                if (!res.isSuccess()) {
                    for (Database.Error err : res.getErrors()) {
                        System.debug('Delete failed: ' + err.getMessage());
                    }
                }
            }
        }
    }
    
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch completed. Processed key groups: ' + processedKeys.size());
        ContactHandler.isMerging = false;

    }
    
    private static String makeKey(Contact c) {
        return (c.FirstName == null ? '' : c.FirstName.trim().toLowerCase()) + '||' +
            (c.LastName == null ? '' : c.LastName.trim().toLowerCase()) + '||' +
            (c.Email == null ? '' : c.Email.trim().toLowerCase());
    }
    
    private static Contact selectMaster(List<Contact> listCon) {
        Contact winner = null;
        Integer bestCount = -1;
        
        for (Contact c : listCon) {
            Integer count = 0;
            for (String fld : interestingFields) {
                Object v = c.get(fld);
                if (v != null && String.valueOf(v).trim() != '') {
                    count++;
                }
            }
            
            Boolean isBetter = (count > bestCount) ||
                (count == bestCount && (winner == null || c.LastModifiedDate > winner.LastModifiedDate));
            if (isBetter) {
                winner = c;
                bestCount = count;
                System.debug('New master candidate: ' + c.Id + ' with ' + count + ' filled fields.');
            }
        }
        
        return winner;
    }
    
    private static void mergeFields(Contact master, List<Contact> listCon) {
        for (String fld : interestingFields) {
            Object masterVal = master.get(fld);
            if (masterVal != null && String.valueOf(masterVal).trim() != '') {
                continue;
            }
            
            for (Contact c : listCon) {
                if (c.Id == master.Id) continue;
                
                Object donorVal = c.get(fld);
                if (donorVal != null && String.valueOf(donorVal).trim() != '') {
                    master.put(fld, donorVal);
                    System.debug('Merged field "' + fld + '" from donor ' + c.Id + ' to master ' + master.Id);
                    break;
                }
            }
        }
        
        System.debug('Final merged master values for Contact: ' + master.Id + ' -> ' + master);
    }
}