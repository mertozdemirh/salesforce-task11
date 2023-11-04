public class Task9SubEventClass {
    public static void Task9SubEventConsume(List<Task9SubEvent__e> task9subevent){
        
        try{
             list<Task_9_Log__c> task9logs = new List<Task_9_Log__c>();
             for(Task9SubEvent__e pe : task9subevent){
            	Task_9_Log__c t = new Task_9_Log__c();
                t.Logs__c = 'Type is ' + pe.Type__c + ' and Amount is ' + pe.Amount__c;
                task9logs.add(t);
        	}
            insert task9logs;
        }
        catch(exception e){
            system.debug(e.getMessage());
        }

    }
}