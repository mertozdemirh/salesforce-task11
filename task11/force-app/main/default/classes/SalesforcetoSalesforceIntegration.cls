public class SalesforcetoSalesforceIntegration {
	
    public static void CreateAccount(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Task9Integration/services/data/v59.0/sobjects/Account');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json; charset=UTF-8');
        request.setBody('{"Name":"Test Account", "Rating":"Hot"}');
        
        HttpResponse response = http.send(request);
        
        System.debug(response.getStatusCode());
    }
}