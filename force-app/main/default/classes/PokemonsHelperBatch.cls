public with sharing class PokemonsHelperBatch {


    // Construct list of pokemons Id for batch
    public static List<Pokemon__c> getPokemonsList(List<Integer> pokemonIdList) {

        List<Pokemon__c> pokemonsListResult = new List<Pokemon__c>();

        for(Integer idPokemon : pokemonIdList) {
            
            Pokemon__c pokeAux = getPokemon(idPokemon);
            
            if(pokeAux != null) {
                pokemonsListResult.add(getPokemon(idPokemon));
            }
        }

        return pokemonsListResult;
    }


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


    public static Pokemon__c returnedPokemon(Pokemons pokemonBodyToParse) {

        Pokemon__c newPokemon = new Pokemon__c();

        newPokemon.ExtId__c = pokemonBodyToParse.id;
        newPokemon.Name = pokemonBodyToParse.name.capitalize();
        newPokemon.Name__c = pokemonBodyToParse.name.capitalize();
        newPokemon.Height__c = Double.valueOf(pokemonBodyToParse.height) / 10;
        newPokemon.Weight__c = Double.valueOf(pokemonBodyToParse.weight) / 10;
        newPokemon.Image__c = pokemonBodyToParse.sprites.other.home.front_default;   
        

        for (Integer i = 0; i <= 2; i++) {
            try {
                if(i == 0) {
                    newPokemon.Types__c = pokemonBodyToParse.types.get(i).type.name;
                }
                else {
                    newPokemon.Types__c = newPokemon.Types__c + ';' + pokemonBodyToParse.types.get(i).type.name;
                }
            }
            catch (Exception error) {
                break;
            }
        }
        
        
        // CREO VARIABLES PARA HABILIDADES ALEATORIAS
        Integer randomAbility = Integer.valueof((Math.random() * pokemonBodyToParse.abilities.Size()));
        String ability = pokemonBodyToParse.abilities.get(randomAbility).ability.name;  
             
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
          
        // Creo metodo try catch para que no largue error, el error que salia es que en el campo velocidad estaba fuera de los limites List index out of bounds: 5
        if(pokemonBodyToParse.stats.get(0).base_stat != null) {
            newPokemon.Life__c = String.valueOf(pokemonBodyToParse.stats.get(0).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(1).base_stat != null) {
        	newPokemon.Attack__c = String.valueOf(pokemonBodyToParse.stats.get(1).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(2).base_stat != null) {
            newPokemon.Defense__c = String.valueOf(pokemonBodyToParse.stats.get(2).base_stat);
        }
        
        if(pokemonBodyToParse.stats.get(5).base_stat != null) {
            newPokemon.Speed__c = String.valueOf(pokemonBodyToParse.stats.get(5).base_stat);
        }
                    
  
        // CREO VARIABLE PARA MOVIMIENTOS   
        try {

            if (pokemonBodyToParse.moves.size() >= 1) {

                String movement = pokemonBodyToParse.moves.get(0).move.name; 

                newPokemon.Slot1__c = [
                    SELECT Id 
                    FROM Movement__c 
                    WHERE Name=:movement.capitalize()
                    LIMIT 1
                ].Id;
            }

            if (pokemonBodyToParse.moves.size() >= 2) {

                String movement = pokemonBodyToParse.moves.get(1).move.name;

                newPokemon.Slot2__c = [
                    SELECT Id 
                    FROM Movement__c
                    WHERE Name=:movement.capitalize()
                ].Id;
            }
            
            if (pokemonBodyToParse.moves.size() >= 3) {

                String movement = pokemonBodyToParse.moves.get(2).move.name;  
            
                newPokemon.Slot3__c = [
                    SELECT Id 
                    FROM Movement__c 
                    WHERE Name=:movement
                ].Id;
            }
            
            if (pokemonBodyToParse.moves.size() >= 4) {

                String movement = pokemonBodyToParse.moves.get(3).move.name;  
            
                newPokemon.Slot4__c = [
                    SELECT Id 
                    FROM Movement__c 
                    WHERE Name=:movement
                ].Id; 
            }         
        }
        catch(System.NullPointerException error) {
            System.debug(error);
        }
        
        // System.debug('Your pokemon is: ' + newPokemon);      
        return newPokemon;  
    }
}