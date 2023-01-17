public with sharing class AbilityHelperBatch {

    public static Ability__c getAbility(Integer abilityId) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://pokeapi.co/api/v2/ability/' + abilityId);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        Abilities abilityBodyToParse = new Abilities();


        if(response.getStatusCode() == 200) {

            String result = String.valueOf(response.getBody());
            abilityBodyToParse = Abilities.parse(result);

            return returnedAbility(abilityBodyToParse);
        }
        else {
            
            System.debug('Status code: ' + response.getStatusCode());
            return null;
        }
    }


    public static Ability__c returnedAbility(Abilities abilityParsed) {
        
        Ability__c newAbility = new Ability__c();

        newAbility.Name__c = abilityParsed.Name.capitalize();
        newAbility.Name = abilityParsed.Name.capitalize();
        newAbility.ExtId__c = abilityParsed.id;
        newAbility.Effect__c = abilityParsed.effect_entries.isEmpty() 
        ? 'None' 
        : (abilityParsed.id < 191)
        ? abilityParsed.effect_entries[1].short_effect
        : abilityParsed.effect_entries[0].short_effect;

        return newAbility;
    }
}