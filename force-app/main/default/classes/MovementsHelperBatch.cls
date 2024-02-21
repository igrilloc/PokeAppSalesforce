public with sharing class MovementsHelperBatch {


    // Construct list of movements Id for batch
    public static List<Movement__c> getMovementsList(List<Integer> movementList) {

        List<Movement__c> movementsListResult = new List<Movement__c>();

        for (Integer idMovement : movementList) {
            
            Movement__c moveAux = getMovement(idMovement);
            
            if (moveAux != null) {
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
        

        if (response.getStatusCode() == 200) {

            String result = String.valueOf(response.getBody());
            movimentBodyToParse = Movimients.parse(result);

        	return returnedMovimient(movimentBodyToParse);
        }
        else { 

            System.debug('Status code: ' + response.getStatusCode());
            return null;
        }
    }

    public static Movement__c returnedMovimient(Movimients movimentBodyToParse) {

        Movement__c newMovement = new Movement__c();
             
        newMovement.Name = movimentBodyToParse.name == null ? 'No Name' : movimentBodyToParse.name.capitalize();
        newMovement.Name__c = movimentBodyToParse.name == null ? 'No Name' : movimentBodyToParse.name.capitalize();
        newMovement.ExtId__c = movimentBodyToParse.id == null ? 0 : movimentBodyToParse.id;         
        newMovement.Accuracy__c = movimentBodyToParse.accuracy == null ? 'None' : String.valueOf(movimentBodyToParse.accuracy);                        
        newMovement.Effect_Chance__c = movimentBodyToParse.effect_chance == null ? 'None' : movimentBodyToParse.effect_chance;            
        newMovement.Effect__c = movimentBodyToParse.effect_entries.isEmpty() ? 'No Effect' : movimentBodyToParse.effect_entries[0].short_effect;           
        newMovement.Power__c = movimentBodyToParse.power == null ? 'None' : String.valueOf(movimentBodyToParse.power);           
        newMovement.Pp__c = movimentBodyToParse.pp == null ? 'None' : String.valueOf(movimentBodyToParse.pp);            
        newMovement.Priority__c = movimentBodyToParse.priority == null ? 'None' : String.valueOf(movimentBodyToParse.priority);          
        newMovement.Type__c = movimentBodyToParse.type.name == null ? 'None' : movimentBodyToParse.type.name.capitalize();
        newMovement.Target__c = movimentBodyToParse.target.name == null ? 'None' : movimentBodyToParse.target.name;
            
        return newMovement;
    }
}