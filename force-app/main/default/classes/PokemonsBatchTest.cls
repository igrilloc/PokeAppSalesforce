@isTest
public with sharing class PokemonsBatchTest {
    
    @isTest
    static void PokemonsBatchTest() {
        
        // Create test data
        List<Integer> testPokemonsList = new List<Integer> {1, 2, 3};
        List<Pokemon__c> testPokemons = new List<Pokemon__c>();
    	
        for (integer i : testPokemonsList) {
            testPokemons.add(new Pokemon__c(Name = 'PokeName ' + i));
    	}
        
        insert testPokemons;
        
		// Test start method
        PokemonsBatch pokemonsBatch = new PokemonsBatch(testPokemonsList);        
        Iterable<Integer> startResult = pokemonsBatch.start(null);
  
        String pokemonTest = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(pokemonTest, 200));
        
		System.assertEquals(testPokemonsList, startResult);   
        
        // Test execute method
        Test.startTest();
            pokemonsBatch.execute(null, testPokemonsList);
        Test.stopTest();
        
        // Verify that the abilities were inserted
        List<Pokemon__c> insertedPokemon = [
            SELECT Id 
            FROM Pokemon__c  
            LIMIT 1
        ];
        
        System.assertEquals(testPokemonsList.size(), insertedPokemon.size());

        // Test finish method
        Test.startTest();
            pokemonsBatch.finish(null);
        Test.stopTest();
    }
    
    @isTest
    static void testAbilityBatchError() {
        
        // Create test data
        List<Integer> testPokemonsList = new List<Integer> {1, 2, 3};
        List<Pokemon__c> testPokemons = new List<Pokemon__c>();
    	
        for (integer i : testPokemonsList) {
            testPokemons.add(new Pokemon__c(Name = 'PokeName ' + i));
    	}
        
        insert testPokemons;
    
        // Test start method
        PokemonsBatch pokemonsBatch = new PokemonsBatch(testPokemonsList);
        
        String json2 = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(json2, 400));
        
        // Test finish method
        Test.startTest();
            pokemonsBatch.finish(null);
        Test.stopTest();
    
        // System.assertEquals(null);
    }
        
}