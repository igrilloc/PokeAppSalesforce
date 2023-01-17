@isTest
private class MovimientsTest {
    
    @isTest
    static void testParse() {
        
        String json = '{"id":1,"name":"Pound","accuracy":100,"effect_chance":"—","power":40,"pp":35,"priority":0,"target":{"name":"selected-pokemon"},"type":{"name":"normal"}}';

        Movimients moviment = Movimients.parse(json);

        // Assert that the parse method correctly deserializes the JSON into the Movimients object
        System.assertEquals(1, moviment.id);
        System.assertEquals('Pound', moviment.name);
        System.assertEquals(100, moviment.accuracy);
        System.assertEquals('—', moviment.effect_chance);
        System.assertEquals(40, moviment.power);
        System.assertEquals(35, moviment.pp);
        System.assertEquals(0, moviment.priority);
        System.assertEquals('selected-pokemon', moviment.target.name);
        System.assertEquals('normal', moviment.type.name);
    }
}