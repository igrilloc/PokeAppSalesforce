@isTest
public class AbilityHelperBatchTest {

    @isTest
    public static void testGetAbility() {
        
        // Crear una respuesta de prueba simulando una respuesta exitosa de la API
        HttpResponse mockResponse = new HttpResponse();
        
        mockResponse.setStatusCode(200);
        mockResponse.setBody('{"name":"test-ability","id":1,"effect_entries":[{"short_effect":"Test effect"}]}');

        /*
        // Crear un mock del objeto Http para simular la respuesta de la API
        Http mockHttp = new Http() {
            public HttpResponse send(HttpRequest req) {
                return mockResponse;
            }
        };
        */

        // Inyectar el mock de Http en la clase AbilityHelperBatch
        // AbilityHelperBatch.http = mockHttp;

        // Llamar al método getAbility
        Ability__c result = AbilityHelperBatch.getAbility(1);

        // Verificar que el resultado sea el esperado
        System.assertEquals('Test-ability', result.Name__c, 'El nombre de la habilidad debe ser Test-ability');
        System.assertEquals('Test-ability', result.Name, 'El nombre de la habilidad debe ser Test-ability');
        System.assertEquals(1, result.ExtId__c, 'El id de la habilidad debe ser 1');
        System.assertEquals('Test effect', result.Effect__c, 'El efecto de la habilidad debe ser Test effect');
    }

    @isTest
    public static void testGetAbility_error() {
        
        // Crear una respuesta de prueba simulando un error en la respuesta de la API
        HttpResponse mockResponse = new HttpResponse();
        
        mockResponse.setStatusCode(404);

        /*
        // Crear un mock del objeto Http para simular la respuesta de la API
        Http mockHttp = new Http() {
            public HttpResponse send(HttpRequest req) {
                return mockResponse;
            }
        };
        */

        // Inyectar el mock de Http en la clase AbilityHelperBatch
        // AbilityHelperBatch.http = mockHttp;

        // Llamar al método getAbility
        Ability__c result = AbilityHelperBatch.getAbility(1);

        // Verificar que el resultado sea el esperado
        System.assertEquals(null, result, 'La habilidad debe ser null');
    }
}
