public class CaseTriggerHandler {
    @future
    public static void createTasksForCase(List<Id> caseIds) {
        List<Task> taskList = new List<Task>();
        
        for (Id caseId : caseIds) {
            Case newCase = [SELECT Id FROM Case WHERE Id = :caseId LIMIT 1]; // Query the Case record
            
            if (newCase != null) {
                // Create task 1: Email user
                Task emailTask = new Task(
                    Subject = 'Email user',
                    WhatId = newCase.Id,
                    ActivityDate = System.today(),
                    Status = 'Not Started'
                );
                taskList.add(emailTask);
                
                // Create task 2: Check Account Data
                Task checkAccountDataTask = new Task(
                    Subject = 'Check Account Data',
                    WhatId = newCase.Id,
                    ActivityDate = System.today(),
                    Status = 'Not Started'
                );
                taskList.add(checkAccountDataTask);
                
                // Create task 3: Verify Related Cases
                Task verifyRelatedCasesTask = new Task(
                    Subject = 'Verify Related Cases',
                    WhatId = newCase.Id,
                    ActivityDate = System.today(),
                    Status = 'Not Started'
                );
                taskList.add(verifyRelatedCasesTask);
            }
        }
        
        // Insert the list of tasks
        if (!taskList.isEmpty()) {
            insert taskList;
        }
    }
    
}