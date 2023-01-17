@isTest
public with sharing class PokemonsTest {
    
    @isTest
    public static void newPokemonTest() {
        
        String pokemonToTest = '{"height":8,"id":135,"name":"Test","order":218,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png"},"types":[{"type":{"name":"electric"}},{"type":{"name":"fire"}}],"weight":245}';
      

        Pokemons newPokemon = new Pokemons();
        newPokemon = Pokemons.parse(pokemonToTest);

        System.assertEquals(newPokemon.height, 8);
    }
}