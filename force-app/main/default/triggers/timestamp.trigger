trigger timestamp on Task (after delete,after update,after insert,after undelete) {
    
    
    set<ID>CaseIds = new set<ID>();   
    
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete)
    {
        //case ids
        for(Task tass : trigger.new)
        {
            String caseid = tass.WhatId;
            if(caseid != null && caseid.startswith('500'))
                CaseIds.add(tass.WhatId);
        }
    }
    else if(Trigger.isDelete)
    {
        //case ids
        for(Task tass: trigger.old)
        {
            String caseid = tass.WhatId;
            if(caseid != null)
            {
                if(caseid.startswith('500'))
                {
                    CaseIds.add(tass.WhatId);
                }
            }
        }
    }
    
    list<task> tasklist = [Select id,Time_Spent__c,WhatId from task where WhatId in :CaseIds AND CreatedDate >= 2021-07-01T00:00:00Z];
    
    map<id,double> amtmap = new map<id,double>();
    
    if(!tasklist.isEmpty()){
        
        
        for(task item: tasklist){
            if(item.Time_Spent__c != null) 
            {
                if(amtmap.containsKey(item.WhatId)){
                    
                    double sum = amtmap.get(item.WhatId);
                    sum= sum+double.valueOf(item.Time_Spent__c);
                    amtmap.put(item.WhatId, sum);    
                }
                else
                {
                    
                    amtmap.put(item.WhatId, double.valueOf(item.Time_Spent__c));  
                }
            }
            
        }
    }
    
    list<case> caselist = new list<case>();
    if(!amtmap.isEmpty()){ 
        for(Id item: amtmap.keySet())
        {
            case obj = New Case();
            obj.Id = item; 
            obj.Total_Time_Spent__c = amtmap.get(item);
            caselist.add(obj); 
        }
    }
    
    if(caselist.size()>0){
        update caselist; 
    }   
    
    
    
}