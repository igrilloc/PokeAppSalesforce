public with sharing class MovementsHelperBatch {


    // Construct list of movements Id for batch
    public static List<Movement__c> getMovementsList(List<Integer> movementList) {

        List<Movement__c> movementsListResult = new List<Movement__c>();

        for(Integer idMovement : movementList) {
            
            Movement__c moveAux = getMovement(idMovement);
            
            if(moveAux != null) {
                movementsListResult.add(getMovement(idMovement));
            }
        }

        return movementsListResult;
    }


    public static Movement__c getMovement(Integer movimientId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+ movimientId);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
		Movimients movimentBodyToParse = new Movimients();
        

        if(response.getStatusCode() == 200) {

            String result = String.valueOf(response.getBody());
            movimentBodyToParse = Movimients.parse(result);

        	return returnedMovimient(movimentBodyToParse);
        }
        else { 

            System.debug('Status code: ' + response.getStatusCode());
            return null;
        }
    }

    public static Movement__c returnedMovimient(Movimients movementParsed){

        Movement__c newMovement = new Movement__c();
             
        newMovement.Name = movementParsed.name == null ? 'No Name' : movementParsed.name.capitalize();
        newMovement.Name__c = movementParsed.name == null ? 'No Name' : movementParsed.name.capitalize();
        newMovement.ExtId__c = movementParsed.id == null ? 0 : movementParsed.id;         
        newMovement.Accuracy__c = movementParsed.accuracy == null ? 'None' : String.valueOf(movementParsed.accuracy);                        
        newMovement.Effect_Chance__c = movementParsed.effect_chance == null ? 'None' : movementParsed.effect_chance;            
        newMovement.Effect__c = movementParsed.effect_entries.isEmpty() ? 'No Effect' : movementParsed.effect_entries[0].short_effect;           
        newMovement.Power__c = movementParsed.power == null ? 'None' : String.valueOf(movementParsed.power);           
        newMovement.Pp__c = movementParsed.pp == null ? 'None' : String.valueOf(movementParsed.pp);            
        newMovement.Priority__c = movementParsed.priority == null ? 'None' : String.valueOf(movementParsed.priority);          
        newMovement.Type__c = movementParsed.type.name == null ? 'None' : movementParsed.type.name.capitalize();
        newMovement.Target__c = movementParsed.target.name == null ? 'None' : movementParsed.target.name;
            
        return newMovement;
    }
}