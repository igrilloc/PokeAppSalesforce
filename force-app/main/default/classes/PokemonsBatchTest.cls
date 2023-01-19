@isTest
public class PokemonsBatchTest {
    
    @isTest
    static void testPokemonsBatch() {
        
        // Creo una lista de enteros con los IDs de los Pokemons
        List<Integer> pokeIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            pokeIdList.add(i);
        }
        
        // Creo una respuesta mock para la llamada HTTP a la API
        String body = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        Integer statusCode = 200;
        
        HttpCalloutMock mock = new PokemonBatchMock(body, statusCode);
        
        // Asigno el mock para las llamadas HTTP en el test
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Ejecuta el proceso en batch y detiene la prueba
        PokemonsBatch batch = new PokemonsBatch(pokeIdList);
        
        Test.startTest();
            Database.executeBatch(batch, 10);
        Test.stopTest();
        
        // Comprobacion de inserción del objeto "Pokemon" con el nombre "Test"
        List<Pokemon__c> poke = [
            SELECT Name 
            FROM Pokemon__c 
            WHERE Name = 'Test'
        ];
        
        System.assertEquals(poke[0].Name, 'Test');   
    }
    
    
    @isTest
    static void testPokeErrorBatch() {
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> PokeIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            PokeIdList.add(i);
        }
        
        // Crea una respuesta mock para la llamada HTTP a la API
        String mockResponse = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 400));
        
        // Ejecuta el proceso en batch y detiene la prueba
        PokemonsBatch batch = new PokemonsBatch(PokeIdList);
        
        Test.startTest();
            try {
                Database.executeBatch(batch, 10);
            } catch (Exception e) {
                System.assert(e.getMessage().contains('Error inserting Pokemon'));
            }
        Test.stopTest();
    }    
}