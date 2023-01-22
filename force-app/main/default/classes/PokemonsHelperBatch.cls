public with sharing class PokemonsHelperBatch {

    public static Pokemon__c getPokemon(Integer pokemonId) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
		Pokemons pokemonBodyToParse = new Pokemons();
        

        if(response.getStatusCode() == 200) {

            String result = String.valueOf(response.getBody());
            pokemonBodyToParse = Pokemons.parse(result);

        	return returnedPokemon(pokemonBodyToParse);
        }
        else { 

            System.debug('Status code: ' + response.getStatusCode());
            return null;
        }
    }


    public static Pokemon__c returnedPokemon(Pokemons pokemonParsed) {

        Pokemon__c newPokemon = new Pokemon__c();

        newPokemon.ExtId__c = pokemonParsed.id;
        newPokemon.Name = pokemonParsed.name.capitalize();
        newPokemon.Name__c = pokemonParsed.name.capitalize();
        newPokemon.Height__c = Double.valueOf(pokemonParsed.height) / 10;
        newPokemon.Weight__c = Double.valueOf(pokemonParsed.weight) / 10;
        newPokemon.Image__c = pokemonParsed.sprites.front_default;   
        

        for (Integer i = 0; i <= 4; i++) {
                
            try {
                
                if(i == 0) {
                    newPokemon.Types__c = pokemonParsed.types.get(i).type.name;
                }
                else {
                    newPokemon.Types__c = newPokemon.Types__c + ';' + pokemonParsed.types.get(i).type.name;
                }
            }
            catch (Exception error) {
                break;
            }
        }
        
        
        // CREO VARIABLES PARA HABILIDADES ALEATORIAS
        Integer randomAbility = Integer.valueof((Math.random() * pokemonParsed.abilities.Size()));
        String ability = pokemonParsed.abilities.get(randomAbility).ability.name;  
             
        try {
            newPokemon.Abilities__c = [
                SELECT Id 
                FROM Ability__c 
                WHERE Name=:ability 
                LIMIT 1
            ].Id;
        }
        catch(System.QueryException error) {
            System.debug(error);
        }
          
        // CREO metodo try catch para que no largue error, el error que salia es que en el campo velocidad estaba fuera de los limites List index out of bounds: 5
        if(pokemonParsed.stats.get(0).base_stat != Null) {
            newPokemon.Life__c = String.valueOf(pokemonParsed.stats.get(0).base_stat);
        }
        
        if(pokemonParsed.stats.get(1).base_stat != Null) {
        	newPokemon.Attack__c = String.valueOf(pokemonParsed.stats.get(1).base_stat);
        }
        
        if(pokemonParsed.stats.get(2).base_stat != Null) {
            newPokemon.Defense__c = String.valueOf(pokemonParsed.stats.get(2).base_stat);
        }
        
        if(pokemonParsed.stats.get(5).base_stat != Null) {
            newPokemon.Speed__c = String.valueOf(pokemonParsed.stats.get(5).base_stat);
        }
                    
  
        // CREO VARIABLE PARA MOVIMIENTOS ALEATORIAS   
        try {
            Integer random = Integer.valueof((Math.random() * pokemonParsed.moves.Size()));
            String movement = pokemonParsed.moves.get(random).move.name;  
           	
            newPokemon.Slot1__c = [
                SELECT Id 
                FROM Movement__c 
                WHERE Name=:movement 
                LIMIT 1
            ].Id;
            
            random = Integer.valueof((Math.random() * pokemonParsed.moves.Size()));
            movement = pokemonParsed.moves.get(random).move.name;

            newPokemon.Slot2__c = [
                SELECT Id 
                FROM Movement__c
                WHERE Name=:movement
            ].Id;
            
            random = Integer.valueof((Math.random() * pokemonParsed.moves.Size()));
            movement = pokemonParsed.moves.get(random).move.name;  
            
            newPokemon.Slot3__c = [
                SELECT Id 
                FROM Movement__c 
                WHERE Name=:movement
            ].Id;
            
            random = Integer.valueof((Math.random() * pokemonParsed.moves.Size()));
            movement = pokemonParsed.moves.get(random).move.name;  
            
            newPokemon.Slot4__c = [
                SELECT Id 
                FROM Movement__c 
                WHERE Name=:movement
            ].Id; 
        }
        catch(System.NullPointerException error) {
            System.debug(error);
        }
        
        // System.debug('Your pokemon is: ' + newPokemon);      
        return newPokemon;  
    }
}