global with sharing class PokemonBatchMock implements HttpCalloutMock {
    
    protected String body;
    protected Integer statusCode;
    

    public PokemonBatchMock(String body, Integer statusCode) {
        this.body = body;
        this.statusCode = statusCode;
    }    
   
    
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        
        response.setBody(this.body);
        response.setStatusCode(statusCode);
        
        return response;
    }
}