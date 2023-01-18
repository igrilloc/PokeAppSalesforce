/* DESCRIPCION:
 
La clase de prueba crea primero un conjunto de datos de prueba, inserta los objetos de 
habilidad en la base de datos y luego verifica que el método "start" devuelve la lista 
de habilidades de prueba esperada.

Luego, se utiliza el método "execute" para insertar los objetos de habilidad en la base 
de datos.

Finalmente, se utiliza el método "finish" y se verifica que se ejecuta correctamente.

Es importante tener en cuenta que esta es solo una posible implementación de una clase de 
prueba para esta clase Apex, y es posible que desee añadir más casos de prueba para cubrir 
escenarios adicionales.

*/

@isTest
public with sharing class AbilityBatchTest {
    
    @isTest
    static void testAbilityBatch() {
        
        // Create test data
        List<Integer> testAbilityList = new List<Integer> {1, 2, 3};
        List<Ability__c> testAbilities = new List<Ability__c>();
        
        for (Integer i : testAbilityList) {
            testAbilities.add(new Ability__c(Name = 'Ability ' + i));
        }
        
        insert testAbilities;

        // Test start method
        AbilityBatch abilityBatch = new AbilityBatch(testAbilityList);
        Iterable<Integer> startResult = abilityBatch.start(null);
        
        String json = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(json, 200));
        
        System.assertEquals(testAbilityList, startResult);

        // Test execute method
        Test.startTest();
            abilityBatch.execute(null, testAbilityList);
        Test.stopTest();

        // Verify that the abilities were inserted
        List<Ability__c> insertedAbilities = [
            SELECT Id 
            FROM Ability__c  
            LIMIT 1
        ];
        
        System.assertEquals(testAbilityList.size(), insertedAbilities.size());

        // Test finish method
        Test.startTest();
            abilityBatch.finish(null);
        Test.stopTest();
    }
    
    @isTest
    static void testAbilityBatchError() {
        
        // Create test data
        List<Integer> testAbilityList = new List<Integer> {1, 2, 3};
        List<Ability__c> testAbilities = new List<Ability__c>();
        
        for (Integer i : testAbilityList) {
            testAbilities.add(new Ability__c(Name = 'Ability ' + i));
        }
        
        insert testAbilities;
    
        // Test start method
        AbilityBatch abilityBatch = new AbilityBatch(testAbilityList);
        
        String json2 = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(json2, 400));
        
        // Test execute method
        Test.startTest();
            abilityBatch.execute(null, testAbilityList);
        Test.stopTest();
    
        // System.assertEquals(null);
    }
}