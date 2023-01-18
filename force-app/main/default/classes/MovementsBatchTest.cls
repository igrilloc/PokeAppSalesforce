@isTest
public with sharing class MovementsBatchTest {

    @isTest
    static void MovementsBatchTest() {
        
        // Create test data
        List<Integer> testMoveList = new List<Integer> {1, 2, 3};
        List<Movement__c> testMove = new List<Movement__c>();
        
        for (Integer i : testMoveList) {
            testMove.add(new Movement__c(Name = 'Movement ' + i));
        }
             
        insert testMove;
            
        // Test start method
        MovementsBatch movBatch = new MovementsBatch(testMoveList);
    	Iterable<Integer> startResult = movBatch.start(null);
    
       	String json = '{"id":1,"name":"Pound","accuracy":100,"effect_chance":"—","power":40,"pp":35,"priority":0,"target":{"name":"selected-pokemon"},"type":{"name":"normal"}}';
        Test.setMock(HttpCalloutMock.class, new PokemonBatchMock(json, 200));
        
         // Test execute method
         //Test.startTest();
         	//MovementsBatch.execute(null, testMoveList);
         //Test.stopTest();
	}
    
}