trigger Task4StopLightTrigger on Task_4_Custom_Obj1__c (after update) {
	StopLightHandler.StopLight(Trigger.New, Trigger.OldMap);
}