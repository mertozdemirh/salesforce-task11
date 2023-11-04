public class AfterInsertTask9PlatformEvent {
    public static void AfterInsertPush(list<Task_9__c> task9){
        
        try{
            
            List<Task9SubEvent__e> pelist = new List<Task9SubEvent__e> ();
            
            for(Task_9__c b: task9 ){
                Task9SubEvent__e p = new Task9SubEvent__e();
                
                p.Amount__c = String.valueof(b.Amount__c);
                p.Type__c = b.Type__c;
                
                pelist.add(p);
            }
            database.saveResult [] re = EventBus.publish(pelist);
            for(database.saveResult s : re){
                if(s.isSuccess()){
                    system.debug('success');
                }
                else{
                    system.debug('failed');
                }
             }
        }
        catch(exception e){
            system.debug(e.getMessage());
        }
    }
}