public class AbilityBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {


    List<Integer> abilityList;


    public AbilityBatch(List<Integer> abilityList) {
        this.abilityList = abilityList;
    }


    public Iterable<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return this.abilityList;
    }
    
    public void execute(Database.BatchableContext bc, List<Integer> records) {
        
        // process each batch of records
        List<Ability__c> abilityToInsert = AbilityHelperBatch.getAbilitiesList(records);

        if (abilityToInsert != null || !abilityToInsert.isempty()) {
            insert abilityToInsert;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
        System.debug('Batch processing finished');

        
        list<Integer> movementList = new list<Integer>();
	
        for (Integer i = 1 ; i <= 826 ; i++) {
            movementList.add(i);
        }
	
        MovementsBatch batch = new MovementsBatch(movementList);
        Database.executeBatch(batch, 20);
        
    }
}