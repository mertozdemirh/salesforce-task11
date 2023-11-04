trigger CreateLinkedContactTrigger on Account (after insert) {
    List<Contact> newContacts = new List<Contact>();
    
    for (Account acc : Trigger.new) {
        // Create a new Contact
        Contact newContact = new Contact();
        newContact.LastName = acc.Name; 
        newContact.Email = acc.Email__c; 

        newContacts.add(newContact);
    }
    
    // Insert the new Contacts
    if (!newContacts.isEmpty()) {
        insert newContacts;
    }
}