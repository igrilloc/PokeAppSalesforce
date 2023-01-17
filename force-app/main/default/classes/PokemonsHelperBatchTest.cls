@isTest
private class PokemonsHelperBatchTest {

    @isTest
    static void testGetPokemon() {
        
        Integer pokemonId = 1;

        Pokemon__c pokemon = PokemonsHelperBatch.getPokemon(pokemonId);

        // Assert
        System.assertEquals(1, pokemon.ExtId__c);
        System.assertEquals('Bulbasaur', pokemon.Name);
        System.assertEquals(0.07, pokemon.Height__c);
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png', pokemon.Image__c);
        System.assertEquals(6.9, pokemon.Weight__c);
        System.assertEquals('grass;poison', pokemon.Types__c);
    }
}