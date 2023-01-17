@isTest
private class AbilitiesTest {
    
    @isTest
    static void testParse() {
        
        String json = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        
        Abilities abilities = Abilities.parse(json);

        // Assert that the parse method correctly deserializes the JSON into the Abilities object
        System.assertEquals('Adaptability', abilities.Name);
        System.assertEquals(91, abilities.id);
        System.assertEquals(1, abilities.effect_entries.size());
        System.assertEquals('This Pokémon moves are powered up a little by same-type attack bonuses.', abilities.effect_entries[0].effect);
        System.assertEquals('en', abilities.effect_entries[0].language.name);
        System.assertEquals('https://pokeapi.co/api/v2/language/9/', abilities.effect_entries[0].language.url);
        System.assertEquals('STAB moves have 1.2x power.', abilities.effect_entries[0].short_effect);
    }
}