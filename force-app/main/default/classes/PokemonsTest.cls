@isTest
public with sharing class PokemonsTest {
    
    @isTest
    public static void newPokemonTest() {
        
        String pokemonToTest = '{"height":4,"id":25,"name":"Pikachu","order":35,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"},"types":[{"type":{"name":"electric"}}],"weight":60}';
      

        Pokemons newPokemon = new Pokemons();
        newPokemon = Pokemons.parse(pokemonToTest);

        System.assertEquals(newPokemon.height, 4);
    }
}