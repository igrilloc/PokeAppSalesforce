public class MovementsBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    

    List<Integer> MovementList;
    
    
    public MovementsBatch(List<Integer> MovementList) {
        this.MovementList = MovementList;
    }


    public Iterable<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return this.MovementList;
    }

    public void execute(Database.BatchableContext bc, List<Integer> records) {
        
        // process each batch of records
        Integer movimientId = Integer.valueOf(records[0]);
        Movement__c movimientToInsert = MovementsHelperBatch.getMovimiento(movimientId);
        

        try {

            if(movimientToInsert != null) {
                insert movimientToInsert;
            }
        } 
        catch (Exception error) {
            System.debug('Error inserting ability');
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch processing finished');
    }
}