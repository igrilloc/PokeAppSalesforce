import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';



export default class PokemonTile extends NavigationMixin(LightningElement) {

    /* - - - - - - - - - TEST
    pokemon = {
        Name: 'Pikachu',
        Types__c: 'Electric',
        Generation__c: '1ra',
        Height__c: 4,
        Weight__c: 60,
        Id: 'a03Dn000001LN7KIAW',
        Image__c: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'
    };
    */

    @api pokemon;


    get isNormal() {
        return this.pokemon.Types__c.includes("Normal");
    }

    get isFighting() {
        return this.pokemon.Types__c.includes("Fighting");
    }
    
    get isFlying() {
        return this.pokemon.Types__c.includes("Flying");
    }

    get isPoison() {
        return this.pokemon.Types__c.includes("Poison");
    }

    get isGround() {
        return this.pokemon.Types__c.includes("Ground");
    }

    get isRock() {
        return this.pokemon.Types__c.includes("Rock");
    }

    get isBug() {
        return this.pokemon.Types__c.includes("Bug");
    }

    get isGhost() {
        return this.pokemon.Types__c.includes("Ghost");
    }

    get isSteel() {
        return this.pokemon.Types__c.includes("Steel");
    }

    get isFire() {
        return this.pokemon.Types__c.includes("Fire");
    }

    get isWater() {
        return this.pokemon.Types__c.includes("Water");
    }

    get isGrass() {
        return this.pokemon.Types__c.includes("Grass");
    }
    
    get isElectric() {
        return this.pokemon.Types__c.includes("Electric");
    }

    get isPsychic() {
        return this.pokemon.Types__c.includes("Psychic");
    }

    get isIce() {
        return this.pokemon.Types__c.includes("Ice");
    }

    get isDragon() {
        return this.pokemon.Types__c.includes("Dragon");
    }

    get isDark() {
        return this.pokemon.Types__c.includes("Dark");
    }

    get isFairy() {
        return this.pokemon.Types__c.includes("Fairy");
    }

    
    navigateToRecordViewPage() {
        // View a custom object record
        this[NavigationMixin.Navigate](
            {
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.pokemon.Id,
                    objectApiName: 'Pokemon__c', // objectApiName is optional
                    actionName: 'view'
                }
            }
        );
    }

}