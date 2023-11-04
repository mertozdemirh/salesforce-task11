trigger OpportunityTrigger on Opportunity (after update) {
    Set<Id> accountIdsToUpdate = new Set<Id>();
    
    // Collect the Account Ids from Opportunities
    for (Opportunity opp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        
        if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won') {
            accountIdsToUpdate.add(opp.AccountId);
        }
    }
    
    // Query for related Opportunities
    Map<Id, Integer> accountClosedWonOpportunities = new Map<Id, Integer>();
    
    for (AggregateResult ar : [SELECT AccountId, COUNT(Id) numClosedWonOpportunities FROM Opportunity 
                               WHERE AccountId IN :accountIdsToUpdate AND StageName = 'Closed Won' GROUP BY AccountId]) {
        accountClosedWonOpportunities.put((Id)ar.get('AccountId'), (Integer)ar.get('numClosedWonOpportunities'));
    }
    System.debug(accountClosedWonOpportunities);
    // Update Account Status
    List<Account> accountsToUpdate = new List<Account>();
    
    for (Id accountId : accountIdsToUpdate) {
        if (!accountClosedWonOpportunities.containsKey(accountId) || accountClosedWonOpportunities.get(accountId) == 1) {
            Account acc = new Account(
                Id = accountId,
                Status__c = 'Customer'
            );
            accountsToUpdate.add(acc);
        }
    }
    
    // Update Account records
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}