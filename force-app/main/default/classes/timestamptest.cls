@istest 
public class timestamptest {
  
    public static testmethod void createdata(){
        
        case obj = new case();
        obj.Total_Time_Spent__c = 3.333;
        insert obj;       
      
        task taskobj = new task();
        taskobj.whatId = obj.id;
       	taskobj.Time_Spent__c = '1.00';
        insert taskobj;
        
        delete taskobj;
        
        obj.Total_Time_Spent__c = obj.Total_Time_Spent__c - double.valueof(taskobj.Time_Spent__c);
        update obj;
    }
    
    
    
    

}