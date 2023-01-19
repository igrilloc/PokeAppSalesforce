public class PokemonsBatch implements Database.Batchable<Integer>,Database.AllowsCallouts,Database.Stateful{
    

    List<Integer> PokemonList;
    
    
    public PokemonsBatch(List<Integer> PokemonList) {
        this.PokemonList = PokemonList;
    }


    public Iterable<Integer> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return this.PokemonList;
    }

    public void execute(Database.BatchableContext bc, List<Integer> records) {
        
        // process each batch of records
        Integer pokemonId = Integer.valueOf(records[0]);
        Pokemon__c pokemonToInsert = PokemonsHelperBatch.getPokemon(pokemonId);

        if(pokemonToInsert != null) {
        	insert pokemonToInsert;
        }
    }

    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
        System.debug('Batch processing finished');
    }
}