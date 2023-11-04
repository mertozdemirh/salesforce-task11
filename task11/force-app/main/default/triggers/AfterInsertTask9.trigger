trigger AfterInsertTask9 on Task_9__c (after insert) {
	
    try{
        AfterInsertTask9PlatformEvent.AfterInsertPush(Trigger.new);
    }
    catch(exception e){
        system.debug(e.getMessage());
    }
}