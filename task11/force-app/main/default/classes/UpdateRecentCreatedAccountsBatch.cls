public class UpdateRecentCreatedAccountsBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        // Query all Accounts created this year
        Date startDate = Date.newInstance(System.today().year(), 1, 1);
        Date endDate = Date.newInstance(System.today().year(), 12, 31);
        String query = 'SELECT Id, Recent_Created__c FROM Account WHERE CreatedDate >= :startDate AND CreatedDate <= :endDate';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext context, List<Account> scope) {

        for (Account acc : scope) {
            acc.Recent_Created__c = true;
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
		System.debug('test');
    }
}