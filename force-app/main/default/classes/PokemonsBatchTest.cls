@isTest
public with sharing class PokemonsBatchTest {
    
    @isTest
    public static void PokemonsBatchTest() {
        
        List<Pokemon__c> PokemonList= new List<Pokemon__c>();
    	
        for(integer i = 1; i < 200; i++) {
            
            Pokemon__c newPokemonId = new Pokemon__c();
            newPokemonId.ExtId__c = i;
            
            PokemonList.add(newPokemonId);
    	}
        
        if(!PokemonList.isEmpty()) insert PokemonList;

        String pokemonTest = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
        
        test.setMock(HttpCalloutMock.class, new PokemonBatchMock(pokemonTest, 200));
        // PokemonsBatch bacth = new PokemonsBatch(PokemonList);
            
        /*    
        Test.startTest();
        	Database.executeBatch(bacth, 100);
        Test.stopTest();
		*/

        List<Pokemon__c> pokemonToTest = [
            SELECT Name 
            FROM Pokemon__c 
            WHERE Name = 'Test'
        ];
		
        system.assertEquals(pokemonToTest.get(0).Name, 'Test');  
    }
}