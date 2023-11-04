trigger CaseTrigger on Case (after insert, before update) {
    if (Trigger.isAfter && Trigger.isInsert) {
        List<Id> caseIds = new List<Id>();
        for (Case newCase : Trigger.new) {
            caseIds.add(newCase.Id);
        }
        CaseTriggerHandler.createTasksForCase(caseIds);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        Set<Id> accountIdsWithOpenCases = new Set<Id>();
        
        for (Case updatedCase : Trigger.new) {
            if (updatedCase.Status == 'Closed' && Trigger.oldMap.get(updatedCase.Id).Status != 'Closed') {
                // Check if the related Account has other open cases with the same Subject
                List<Case> relatedOpenCases = [SELECT Id FROM Case WHERE AccountId = :updatedCase.AccountId AND Status != 'Closed' AND Subject = :updatedCase.Subject];
                
                if (!relatedOpenCases.isEmpty()) {
                	throw new DmlException('Cannot close the case. There are other open cases with the same Subject related to this Account ID: ' + updatedCase.AccountId);
                }
            }
        }

    }
}