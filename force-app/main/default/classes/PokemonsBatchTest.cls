@isTest
public class PokemonsBatchTest {
    
    @isTest
    static void testPokemonsBatch() {
        
        // Creo una lista de enteros con los IDs de los Pokemons
        List<Integer> pokeIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            pokeIdList.add(i);
        }
        
        // Creo test data para Movement__c
        Movement__c move1 = new Movement__c(Name='Toxic');
        Movement__c move2 = new Movement__c(Name='Poison-powder');
        Movement__c move3 = new Movement__c(Name='Ingrain');
        Movement__c move4 = new Movement__c(Name='Sludge');
        insert move1; 
        insert move2;
		insert move3;
		insert move4;
      
        // Creo una respuesta mock para la llamada HTTP a la API
        String body = '{"id": 1,"weight":69, "height":8, "name": "Bulbasaur", "sprites": {"other": {"home": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}}}, "types": [{"type": {"name": "grass"}}], "abilities": [{"ability": {"name": "overgrow"}}], "stats": [{"base_stat": 45}, {"base_stat": 49}, {"base_stat": 49}, {"base_stat": 65}, {"base_stat": 65}, {"base_stat": 45}], "moves": [{"move":{"name":"Toxic"}},{"move":{"name":"Poison-powder"}},{"move":{"name":"Ingrain"}},{"move":{"name":"Sludge"}}]}';
        HttpCalloutMock mock = new PokemonBatchMock(body, 200);
        
        // Asigno el mock para las llamadas HTTP en el test
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Ejecuta el proceso en batch y detiene la prueba
        PokemonsBatch batch = new PokemonsBatch(pokeIdList);
        
        Test.startTest();
            Database.executeBatch(batch, 10);
        Test.stopTest();
        
        // Comprobacion de inserción del objeto "Pokemon" con el nombre "Bulbasaur"
        List<Pokemon__c> poke = [
            SELECT Name, ExtId__c, Image__c, Types__c, Weight__c, Height__c
            FROM Pokemon__c 
            WHERE Name = 'Bulbasaur'
        ];
        
        System.assertEquals(poke[0].Name, 'Bulbasaur');
        System.assertEquals(poke[0].ExtId__c, 1);
        System.assertEquals(poke[0].Image__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png');
        System.assertEquals(poke[0].Types__c, 'Grass');
        System.assertEquals(poke[0].Weight__c, 6.90);
        System.assertEquals(poke[0].Height__c, 0.8);
		
    }
    
    
    @isTest
    static void testPokeErrorBatch() {
        
        // Crea una lista de enteros con los IDs de los Abilitys
        List<Integer> PokeIdList = new List<Integer>();
        
        for (Integer i = 1; i < 10; i++) {
            PokeIdList.add(i);
        }
        
        // Crea una respuesta mock para la llamada HTTP a la API
        String mockResponse = 'Not found';
        
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(mockResponse, 404));
        
        // Ejecuta el proceso en batch y detiene la prueba
        PokemonsBatch batch = new PokemonsBatch(PokeIdList);
        
        Test.startTest();
        	Database.executeBatch(batch, 10);
        Test.stopTest();
        
        // Comprobacion de inserción del objeto "Pokemon" con el nombre "Bulbasaur"
        List<Pokemon__c> poke = [
            SELECT Name, ExtId__c, Image__c, Types__c, Weight__c, Height__c
            FROM Pokemon__c 
        ];
        
        System.assertEquals(true, poke.isempty(),'La lista no está vacia');
    }    
}