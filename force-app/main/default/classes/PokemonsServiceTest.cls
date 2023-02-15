@isTest
public with sharing class PokemonsServiceTest {
    
    // Test que comprueba si se obtienen los registros correctos al filtrar por un tipo específico
    @isTest
    public static void getFilteredPokemonByTypeTest() {
        // Creo dos registros de Pokemon__c, uno de tipo 'water' y otro de tipo 'fire'
        Pokemon__c waterPokemon = new Pokemon__c(Name = 'Squirtle', Types__c = 'water');
        Pokemon__c firePokemon = new Pokemon__c(Name = 'Charmander', Types__c = 'fire');
        
        insert new List<Pokemon__c>{waterPokemon, firePokemon};
        
        // Llama al método getFilteredPokemon con el tipo 'water' y comprueba si se obtiene el registro correcto
        List<Pokemon__c> filteredPokemon = PokemonsService.getFilteredPokemon('water', '', '');
        
        System.assertEquals(0, filteredPokemon.size());
        System.assertEquals(waterPokemon.Id, filteredPokemon[1].Id);
    }
    
    // Test que comprueba si se obtienen los registros correctos al filtrar por un peso máximo específico
    @isTest
    public static void getFilteredPokemonByMaxWeightTest() {
        // Crea dos registros de Pokemon__c, uno con un peso de 60 y otro con un peso de 80
        Pokemon__c lightPokemon = new Pokemon__c(Name = 'Pikachu', Weight__c = 60);
        Pokemon__c heavyPokemon = new Pokemon__c(Name = 'Snorlax', Weight__c = 800);
        
        insert new List<Pokemon__c>{lightPokemon, heavyPokemon};
        
        // Llama al método getFilteredPokemon con un peso máximo de 70 y comprueba si se obtiene el registro correcto
        List<Pokemon__c> filteredPokemon = PokemonsService.getFilteredPokemon('', '', '70');
        
        System.assertEquals(1, filteredPokemon.size());
        System.assertEquals(lightPokemon.Id, filteredPokemon[1].Id);
    }

    @isTest
    public static void getFilteredPokemonByMultipleCriteriaTest() {
        
        // Creo varios pokemons de prueba
        Pokemon__c pokemon1 = new Pokemon__c(Name = 'Pikachu', Types__c = 'Electric', Height__c = 4, Weight__c = 60);
        Pokemon__c pokemon2 = new Pokemon__c(Name = 'Charmander', Types__c = 'Fire', Height__c = 6, Weight__c = 85);
        Pokemon__c pokemon3 = new Pokemon__c(Name = 'Bulbasaur', Types__c = 'Grass', Height__c = 7, Weight__c = 69);
        Pokemon__c pokemon4 = new Pokemon__c(Name = 'Squirtle', Types__c = 'Water', Height__c = 5, Weight__c = 90);
        Pokemon__c pokemon5 = new Pokemon__c(Name = 'Mewtwo', Types__c = 'Psychic', Height__c = 20, Weight__c = 1220);
        
        insert new List<Pokemon__c>{pokemon1, pokemon2, pokemon3, pokemon4, pokemon5};
        
        // Realizo la búsqueda por múltiples criterios
        List<Pokemon__c> pokemonSearch = PokemonsService.getFilteredPokemon('Pikachu', 'Electric', '1ra');

        // Verifico que se hayan encontrado los resultados esperados
        System.assertEquals(pokemonSearch.size(), 4);
        System.assertEquals(pokemonSearch[0].Name, 'Pikachu');
        System.assertEquals(pokemonSearch[0].Types__c, 'Electric');
        System.assertEquals(pokemonSearch[0].Generation__c, '1ra');
        System.assertEquals(pokemonSearch[0].Height__c, 4);
        System.assertEquals(pokemonSearch[0].Weight__c, 60);
    }
}