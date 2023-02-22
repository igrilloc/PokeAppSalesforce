public class MovementsBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    

    List<Integer> movementList;
    
    
    public MovementsBatch(List<Integer> movementList) {
        this.movementList = movementList;
    }


    public Iterable<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return this.movementList;
    }

    public void execute(Database.BatchableContext bc, List<Integer> records) {
        
        // process each batch of records
        List<Movement__c> movimientToInsert = MovementsHelperBatch.getMovementsList(records);

        if(movimientToInsert != null || !movimientToInsert.isempty()) {
            insert movimientToInsert;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
        System.debug('Batch processing finished');

        /*
        list<Integer> PokemonList = new list<Integer>();
        
        for (Integer i = 1 ; i <= 898 ; i++) {
            PokemonList.add(i);
        }
		
        PokemonsBatch batch = new PokemonsBatch(PokemonList);
        Database.executeBatch(batch, 20);
        */
    }
}