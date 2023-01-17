public with sharing class PokemonsService {

    /*
    @AuraEnabled(Cacheable=true)
    public static Pokemon__c[] getAllPokemons() {
        return [
            SELECT Name, Id, ExtId__c, Generation__c, Image__c, Height__c, Weight__c, Types__c 
            FROM Pokemon__c
            WITH SECURITY_ENFORCED
            ORDER BY Name
            LIMIT 899
        ];
    }
    */

    @AuraEnabled(cacheable = true)
    public static List<Pokemon__c> getFilteredPokemon(String searchText, String generation, String type) {

        // System.debug('searchText: ', searchText);
        // System.debug('generation: ', generation);
        // System.debug('type: ', type);
        
        String likeValue = '%' + searchText + '%';
        String QUERY = 'SELECT Name, Id, ExtId__c, Generation__c, Image__c, Height__c, Weight__c, Types__c FROM Pokemon__c';

  
        if (likeValue != '') {
            QUERY += ' WHERE Name LIKE :likeValue';
        }
          
        if (type != 'All') {
            QUERY += ' AND Types__c INCLUDES(:type)';
        }
          
        if (generation != 'All') {
            QUERY += ' AND Generation__c =:generation';
        }
          
        QUERY += ' ORDER BY ExtId__c';
      

        return Database.query(QUERY);
    }
}