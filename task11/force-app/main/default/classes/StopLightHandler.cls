public class StopLightHandler {
    public static void StopLight(List<Task_4_Custom_Obj1__c> newTask4, Map<Id, Task_4_Custom_Obj1__c> task4Map){
        List<Task_4_Custom_Obj1__c> greenTask4 = new List<Task_4_Custom_Obj1__c>();
        for(Task_4_Custom_Obj1__c t: newTask4){
            Task_4_Custom_Obj1__c oldTask4 = task4Map.get(t.id);
            if(t.Stoplight_Status__c =='Green' && oldTask4.Stoplight_Status__c !='Green'){
                greenTask4.add(t);
            }            
        }


 		 List<Task4Stoplight__e> eventList = new List<Task4Stoplight__e>();
        

         for (Task_4_Custom_Obj1__c g : greenTask4) {
                Task4Stoplight__e  event = new Task4Stoplight__e();
                event.Task4Id__c = g.Id;
                event.Stoplight_Status__c = 'Green';
                system.debug('eventevent ' +event );
                eventList.add(event);
            }

 

			// Publish the Platform Events

            Database.SaveResult[] results = EventBus.publish(eventList);

			system.debug('result: ' + results);
            for (Database.SaveResult result : results) {

                if (!result.isSuccess()) {

                    for (Database.Error error : result.getErrors()) {
                       system.debug(error.getMessage());
                    }

                }

                else if(result.isSuccess()) {
                    system.debug('success');
                }
            }      
    }
}