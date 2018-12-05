public with sharing class ReservationManagerController {
	@auraEnabled
    public static List<CustomerServices.Customer> getCustomerList(String sObjectType)
    {
        List<CustomerServices.Customer> customers = new List<CustomerServices.Customer>();
        
        if(sObjectType == 'Lead')
        {
            for(Lead l:[SELECT Id, Email, Name, City, State, Status 
                        FROM Lead 
                        WHERE Status 
                        IN ('Open - Not Contacted') 
                        LIMIT 5])
            {
                CustomerServices.Customer c = new CustomerServices.Customer(l.Name, l.Email, l.City, l.State, l.Status,l.Id);
                customers.add(c);
            }
        }
                
        if(sObjectType == 'Contact')
        {
            for(Contact c:[SELECT Id, Email, Name, MailingCity, MailingState, Reservation_Status__c FROM Contact WHERE Reservation_Status__c IN ('Not Started') LIMIT 5])
            {
                CustomerServices.Customer cu = new CustomerServices.Customer(c.Name, c.Email, c.MailingCity, c.MailingState, c.Reservation_Status__c, c.Id);
                customers.add(cu);
            }
        }
        return customers;
    }

    @auraEnabled
    public static List<Reservation__c> getOpenReservations()
    {
        return [SELECT Id, Name, Contact__c, Contact__r.Name, Lead__c, Lead__r.Name, Market__c, Market__r.Name, Status__c, Start_Date__c, End_Date__c, Total_Number_of_Guests__c 
                FROM Reservation__c 
                WHERE Status__c IN ('Not Started', 'Draft') 
                LIMIT 10];
    }
}