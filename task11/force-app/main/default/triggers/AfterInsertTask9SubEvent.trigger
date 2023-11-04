trigger AfterInsertTask9SubEvent on Task9SubEvent__e (after insert) {
    try{
        Task9SubEventClass.Task9SubEventConsume(Trigger.new);
    }
    catch(exception e){
        system.debug(e.getMessage());
    }
}