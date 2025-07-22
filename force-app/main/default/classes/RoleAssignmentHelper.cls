public class RoleAssignmentHelper {
    @AuraEnabled(cacheable=true)
    public static List<User> getActiveStandardUsers() {
        return [SELECT Id, Name FROM User WHERE isActive = TRUE AND UserType = 'Standard' ORDER BY Name];
    }
    @AuraEnabled
    public static List<User> getFromUserList(String objName, String fieldName){
        try {
            if(string.isBlank(objName) || string.isBlank(fieldName)){
                return null;
            }
            string parentField = fieldName.contains('__c') ? fieldName.replace('__c','__r') : fieldName.replace('Id','');
            String query = '';
            query = 'Select Id,Primary_Relationship_Manager__c,OwnerId,Primary_Relationship_Manager__r.Name,Owner.name From '+ objName +' Where '+fieldName+' != null AND '+parentField+'.IsActive = False order by name';
            system.debug('query->'+query);
            List<Sobject> sObjectList = Database.query(query);
            system.debug('sObjectList->'+sObjectList.size());
            // Use a Map to remove duplicates based on the field value
            Map<Id, SObject> uniqueMap = new Map<Id, SObject>();

            for (SObject record : sObjectList) {
                Id fieldValue = (Id) record.get(fieldName);
                // Only keep one contact per unique fieldValue (e.g., OwnerId)
                if (!uniqueMap.containsKey(fieldValue)) {
                    uniqueMap.put(fieldValue, record);
                }
            }

            return new List<SObject>(uniqueMap.values());

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static void transferRecords(string objName, String fieldName, String fromUserId, String toUserid){
        system.debug('objName->'+objName);
        system.debug('fieldName->'+fieldName);
        system.debug('fromUserId->'+fromUserId);
        system.debug('toUserid->'+toUserid);
        Database.executeBatch(new RoleAssignmentTransferBatch(objName, fieldName, fromUserId, toUserId), 200);
        
    }
}