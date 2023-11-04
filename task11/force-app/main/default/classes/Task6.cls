public class Task6 {
	//---6.3 DML Tasks---//
    public static void AccountDML(){
        // Create a new Account record
        Account newAccount = new Account();
        newAccount.Name = 'Test2 Task6';
        newAccount.BillingCity = 'Izmir';
        newAccount.BillingCountry = 'Turkey';
 
        // Insert the Account record into Salesforce
        insert newAccount;
        system.debug('inserted account: ' +newAccount);
        // Check if the insertion was successful
        if (newAccount.Id != null) {
            System.debug('Account Id: ' + newAccount.Id);
        } else {
            System.debug('Failed to create the Account.');
        }
 
    }

    public static void updateAccountName(Id accountId, String newAccountName) {
        // Retrieve the Account record with the given accountId
        Account accountToUpdate = [SELECT Id, Name FROM Account WHERE Id = :accountId];
 
        // Check if the Account record exists
        if (accountToUpdate != null) {
            // Update the Account Name field
            accountToUpdate.Name = newAccountName;
 
            // Update the Account record in Salesforce
            update accountToUpdate;

            System.debug('Account Name updated successfully. New Name: ' + newAccountName);
        } else {
            System.debug('Account with the given Id was not found.');
        }
    }

      public static void deleteAccount(Id accountId) {
        // Create an instance of Account with the given Id to delete it
        Account accountToDelete = new Account(Id = accountId);
 
        // Delete the Account record in Salesforce
        delete accountToDelete;

    }


     public static void undeleteAccount(Id accountId) {
        // Create an instance of Account with the given Id to undelete it
        Account accountToUndelete = new Account(Id = accountId);
 
        // Undelete the Account record in Salesforce
        Database.UndeleteResult result = Database.undelete(accountToUndelete);

    }

      public static void updateRecordWithSavepoint(Id recordId, String newName) {
        // Create a Savepoint
        Savepoint sp = Database.setSavepoint();
 
        try {
            // Retrieve the record with the given Id
            Account recordToUpdate = [SELECT Id, Name FROM Account WHERE Id = :recordId];
 
            // Update the record's Name
            recordToUpdate.Name = newName;
 
            // Update the record
            update recordToUpdate;
 
            System.debug('Record updated successfully. Account Id: ' + recordToUpdate.Id);
        } catch (Exception ex) {
            // Rollback to the Savepoint if an exception occurs during the update
            Database.rollback(sp);
            System.debug('Rollback! Update failed. Error: ' + ex.getMessage());
        }
    }
     public static void insertAccountAndUser() {
        // Create a new Account record
        Account newAccount = new Account();
        newAccount.Name = 'Test Task6 Account';
        newAccount.BillingCity = 'Istanbul';
        newAccount.BillingCountry = 'Turkey';
 
        // Create a new User record
        User newUser = new User();
        newUser.FirstName = 'Lisa';
        newUser.LastName = 'Jones';
        newUser.Email = 'lisa.jones@example.com';
        newUser.Username = 'lisa.jones@example.com';
        newUser.Alias = 'lisajoness';
        newUser.EmailEncodingKey = 'ISO-8859-1';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.LocaleSidKey = 'en_US';
        newUser.TimeZoneSidKey = 'America/Los_Angeles';
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard Platform User'];
        newUser.ProfileId = profile.Id;
 
        // Perform the insert operations in a single transaction
        Database.SaveResult[] saveResults = Database.insert(new List<SObject>{ newAccount, newUser });
 
        // Check the results of the insert operations
        for (Database.SaveResult sr : saveResults) {
            if (sr.isSuccess()) {
                System.debug('Record created successfully. Id: ' + sr.getId());
            } else {
                for (Database.Error err : sr.getErrors()) {
                    System.debug('Error while creating record: ' + err.getStatusCode() + ' - ' + err.getMessage());
                }
            }
        }
    }

     public static void insertValidAccounts(List<Account> accountsToInsert) {
        List<Account> validAccounts = new List<Account>();
        List<Database.SaveResult> saveResults;
 
        // Data validation to determine valid accounts
        for (Account acc : accountsToInsert) {
            if (isValidAccount(acc)) {
                validAccounts.add(acc);
            } else {
                System.debug('Account is not valid and will not be inserted: ' + acc);
            }
        }
 
        // Insert only the valid accounts
        if (!validAccounts.isEmpty()) {
            saveResults = Database.insert(validAccounts, false); // Use the allOrNone parameter as false to allow partial success
        }
 
        // Check the results of the insert operations
        if (saveResults != null && !saveResults.isEmpty()) {
            for (Integer i = 0; i < saveResults.size(); i++) {
                Database.SaveResult sr = saveResults[i];
                if (sr.isSuccess()) {
                    System.debug('Record ' + (i + 1) + ' created successfully. Id: ' + sr.getId());
                } else {
                    for (Database.Error err : sr.getErrors()) {
                        System.debug('Error while creating record ' + (i + 1) + ': ' + err.getStatusCode() + ' - ' + err.getMessage());
                    }
                }
            }
        }
    }
 
    // Sample validation method - Replace this with your custom validation criteria
    private static Boolean isValidAccount(Account acc) {
        // For demonstration purposes, let's assume an Account is valid if it has a Name and BillingCity set.
        return !String.isBlank(acc.Name) && !String.isBlank(acc.BillingCity);
    }
}