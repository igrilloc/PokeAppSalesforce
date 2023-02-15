@isTest
public class MovementsBatchTest {

    @isTest
    static void testMovesSuccessBatch() {
        
        // Crea una lista de enteros con los IDs de los Movements
        List<Integer> MovesIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            MovesIdList.add(i);
        }

        // Crea una respuesta mock para la llamada HTTP a la API
		String jsonTest = '{"id": 1, "name": "Pound", "accuracy": 100, "effect_chance": "null", "power": 40, "pp": 35, "priority": 0, "target": {"target": [], "name": "selected-pokemon"}, "type": {"type": [], "name": "normal"}, "effect_entries": [{"effect": "Inflicts regular damage.", "short_effect": "Regular damage."}]}';        
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(jsonTest, 200));
        
        // Ejecuta el proceso en batch y detiene la prueba
        MovementsBatch batch = new MovementsBatch(MovesIdList);
        
        Test.startTest();
        	Database.executeBatch(batch, 10);
        Test.stopTest();

        // Comprobación de inserción del objeto "Movement" con el nombre "Pound"
        List<Movement__c> movements = [
            SELECT Name 
            FROM Movement__c 
            WHERE Name = 'Pound'
        ];

        System.assertEquals(9, movements.size(), 'El objeto "Movement" no se insertó correctamente');
    }
    
    @isTest
    static void testMovementNotFound() {
        
        // Creo una lista de enteros con los IDs de los Movements
        List<Integer> MovesIdList = new List<Integer>();
        
        // ID de un movimiento que no existe
        MovesIdList.add(-1);

        // Creo una respuesta mock para la llamada HTTP a la API
        String jsonTest = '{"message": "Not Found", "status": 404}';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(jsonTest, 404));
        
        // Ejecuto el proceso en batch y detiengo la prueba
        MovementsBatch batch = new MovementsBatch(MovesIdList);
        
        Test.startTest();
        	Database.executeBatch(batch, 10);
        Test.stopTest();

        // Comprobación de que no se insertó ningún objeto "Movement"
        List<Movement__c> movements = [
            SELECT Name 
            FROM Movement__c
        ];

        System.assertEquals(0, movements.size(), 'Se insertó un objeto "Movement" cuando no debía haber sido así');
    }
}