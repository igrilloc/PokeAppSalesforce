/* DESCRIPCION:
La clase Apex "AbilityBatch" implementa la interfaz "Database.Batchable" y "Database.AllowsCallouts" y 
"Database.Stateful". Esto significa que esta clase puede ser utilizada para procesar datos en lotes y 
también permite hacer llamadas a servicios externos y almacenar información de estado.

La clase tiene un constructor que recibe una lista de números enteros, que se asigna a la variable de 
instancia "abilityList".

El método "start" es utilizado para recolectar los lotes de registros o objetos que serán procesados por 
el método "execute". En este caso, el método simplemente devuelve la lista de habilidades "abilityList".

El método "execute" es utilizado para procesar cada lote de registros. En este caso, se toma el primer 
elemento de la lista de registros y se utiliza para obtener un objeto de habilidad "Ability__c" utilizando 
el método "getAbility" de la clase "AbilityHelperBatch". Si el objeto de habilidad no es nulo, se inserta 
en la base de datos. Si ocurre una excepción durante la inserción, se muestra un mensaje de depuración.

Finalmente, el método "finish" es utilizado para ejecutar cualquier operación de procesamiento posterior. 
En este caso, simplemente se muestra un mensaje de depuración indicando que el procesamiento en lotes ha finalizado.
*/


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
        Integer abilityId = Integer.valueOf(records[0]);
        Ability__c abilityToInsert = AbilityHelperBatch.getAbility(abilityId);

            if(abilityToInsert != null) {
                insert abilityToInsert;
            }
    }
    
    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
        System.debug('Batch processing finished');
    }
}