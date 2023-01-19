@isTest
public class MovementsBatchTest {

    @isTest
    static void testMovesSuccessBatch() {
        
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> MovesIdList = new List<Integer>();
        
        for (Integer i = 1; i < 150; i++) {
            MovesIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';        
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 200));
        
        // Ejecuta el proceso en batch y detiene la prueba
        MovementsBatch batch = new MovementsBatch(MovesIdList);
        
        Test.startTest();
        	Database.executeBatch(batch, 150);
        Test.stopTest();

        // Comprobacion de inserción del objeto "Movement" con el nombre "Test"
        List<Movement__c> ab = [
            SELECT Name 
            FROM Movement__c 
            WHERE Name = 'Test Movement'
        ];
        
        System.assertEquals(ab[0].Name, 'Test Movement');
    }

    
    @isTest
    static void testAbilityErrorBatch() {
        
        // Crea una lista de enteros con los IDs de los Movement
        List<Integer> MovesIdList = new List<Integer>();
        
        for (Integer i = 1; i < 150; i++) {
            MovesIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String mockResponse = '{"Name":"Adaptability","id":91,"effect_entries":[{"effect":"This Pokémon moves are powered up a little by same-type attack bonuses.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"STAB moves have 1.2x power."}]}';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 400));
        
        // Ejecuta el proceso en batch y detiene la prueba
        MovementsBatch batch = new MovementsBatch(MovesIdList);
        
        Test.startTest();
        	try {
            	Database.executeBatch(batch, 150);
        	} 
        	catch (Exception e) {
            	System.assert(e.getMessage().contains('Error inserting Movement'));
        	}
        Test.stopTest();
    }
}