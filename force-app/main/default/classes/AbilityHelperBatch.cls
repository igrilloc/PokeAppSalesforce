public with sharing class AbilityHelperBatch {


    // Construct list of abilities Id for batch
    public static List<Ability__c> getAbilitiesList(List<Integer> abilityList) {

        List<Ability__c> abilitiesListResult = new List<Ability__c>();

        for (Integer idAbility : abilityList) {
			abilitiesListResult.add(getAbility(idAbility) != null ? getAbility(idAbility) : null);
		}

        return abilitiesListResult;
    }


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


    public static Ability__c returnedAbility(Abilities abilityBodyToParse) {
        
        Ability__c newAbility = new Ability__c();

        newAbility.Name__c = abilityBodyToParse.Name.capitalize();
        newAbility.Name = abilityBodyToParse.Name.capitalize();
        newAbility.ExtId__c = abilityBodyToParse.id;
        newAbility.Effect__c = abilityBodyToParse.effect_entries.isEmpty() ? 'None' : (abilityBodyToParse.id < 191 ? 
       	abilityBodyToParse.effect_entries[1].short_effect : abilityBodyToParse.effect_entries[0].short_effect);
            
        return newAbility;
    }
}