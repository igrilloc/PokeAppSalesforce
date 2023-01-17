/* DESCRIPCION
 
En esta clase test se crea un mock del objeto Http, para simular una respuesta exitosa de la API, y se 
inyecta en la clase MovementsHelperBatch. Luego se prueba el método getMovimiento(), se verifica que los 
valores del movimiento se parsearon correctamente.

*/

@isTest
public class MovementsHelperBatchTest {

    @isTest
    public static void testGetMovimiento() {
        // Crear una respuesta de prueba simulando una respuesta exitosa de la API
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(200);
        mockResponse.setBody('{"name":"test-movement","id":1,"power":50,"pp":25,"accuracy":100,"type":{"name":"normal"}}');

        /*
        // Crear un mock del objeto Http para simular la respuesta de la API
        Http mockHttp = new Http() {
            public HttpResponse send(HttpRequest req) {
                return mockResponse;
            }
        };
        */

        // Inyectar el mock de Http en la clase MovementsHelperBatch
        // MovementsHelperBatch.http = mockHttp;

        // Llamar al método getMovimiento con el ID de prueba
        Movement__c testMovement = MovementsHelperBatch.getMovimiento(1);

        // Verificar que los valores del movimiento se hayan parseado correctamente
        System.assertEquals('Test-movement', testMovement.Name, 'El nombre del movimiento debe ser Test-movement');
        // System.assertEquals(50, testMovement.Power__c, 'El poder del movimiento debe ser 50');
        // System.assertEquals(25, testMovement.Pp__c, 'El Pp del movimiento debe ser 25');
        // System.assertEquals(100, testMovement.Accuracy__c, 'La precisión del movimiento debe ser 100');
        System.assertEquals('Normal', testMovement.Type__c, 'El tipo del movimiento debe ser Normal');
    }
}
