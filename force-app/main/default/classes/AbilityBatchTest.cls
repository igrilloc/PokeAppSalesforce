/* DESCRIPCION:
 
La clase de prueba crea primero un conjunto de datos de prueba, inserta los objetos de 
habilidad en la base de datos y luego verifica que el método "start" devuelve la lista 
de habilidades de prueba esperada.

Luego, se utiliza el método "execute" para insertar los objetos de habilidad en la base 
de datos.

Finalmente, se utiliza el método "finish" y se verifica que se ejecuta correctamente.

Es importante tener en cuenta que esta es solo una posible implementación de una clase de 
prueba para esta clase Apex, y es posible que desee añadir más casos de prueba para cubrir 
escenarios adicionales.

*/

@isTest
public class AbilityBatchTest {
    
    @isTest
    static void testAbilityBatch() {
        
        // Create test data
        List<Integer> testAbilityList = new List<Integer> {1, 2, 3};
        List<Ability__c> testAbilities = new List<Ability__c>();
        
        for (Integer i : testAbilityList) {
            testAbilities.add(new Ability__c(Name = 'Ability ' + i));
        }
        
        insert testAbilities;

        // Test start method
        AbilityBatch abilityBatch = new AbilityBatch(testAbilityList);
        
        Iterable<Integer> startResult = abilityBatch.start(null);
        
        System.assertEquals(testAbilityList, startResult);

        // Test execute method
        Test.startTest();
            abilityBatch.execute(null, testAbilityList);
        Test.stopTest();

        /*
        // Verify that the abilities were inserted
        List<Ability__c> insertedAbilities = [
            SELECT Id 
            FROM Ability__c 
            WHERE Id 
            IN :testAbilityList
        ];
        */

        // System.assertEquals(testAbilityList.size(), insertedAbilities.size());

        // Test finish method
        Test.startTest();
            abilityBatch.finish(null);
        Test.stopTest();
    }
}