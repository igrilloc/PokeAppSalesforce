@isTest
public class AbilityBatchTest {

    @isTest
    static void testAbilitySuccessBatch() {
        
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> AbilityIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            AbilityIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"Name": "Overgrow", "id": 1, "effect_entries": [{"effect": "When the weather is sunny, the power of Grass-type moves is increased by 50%.", "language": {"name":"en", "url": "https://pokeapi.co/api/v2/language/9/"}, "short_effect": "Grass-type moves have 50% power in sun."}]}';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 200));
        
        // Ejecuta el proceso en batch y detiene la prueba
        AbilityBatch batch = new AbilityBatch(AbilityIdList);
        
        Test.startTest();
            Database.executeBatch(batch, 10);
        Test.stopTest();

        // Comprobacion de inserción del objeto "Ability" con el nombre "Test"
        List<Ability__c> abilityList = [
            SELECT Name, ExtId__c, Effect__c, Name__c 
            FROM Ability__c 
            WHERE Name = 'Adaptability'
        ];
        
        System.assertEquals(abilityList[0].Name, 'Adaptability');
    }

    
    @isTest
    static void testAbilityErrorBatch() {
    
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> AbilityIdList = new List<Integer>();
    
        for (Integer i = 1; i < 10; i++) {
            AbilityIdList.add(i);
        }
    
        // Crea una respuesta mock para la llamada HTTP a la API
        String mockResponse = '{"Name": "Overgrow", "id": 1, "effect_entries": [{"effect": "When the weather is sunny, the power of Grass-type moves is increased by 50%.", "language": {"name":"en", "url": "https://pokeapi.co/api/v2/language/9/"}, "short_effect": "Grass-type moves have 50% power in sun."}]}';
    
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 400));
    
        // Ejecuta el proceso en batch y detiene la prueba
        AbilityBatch batch = new AbilityBatch(AbilityIdList);
    
        Test.startTest();
            try {
                Database.executeBatch(batch, 10);
            } catch (Exception e) {
                System.assert(e.getMessage().contains('Status code: 400'));
            }
        Test.stopTest();
    }
}