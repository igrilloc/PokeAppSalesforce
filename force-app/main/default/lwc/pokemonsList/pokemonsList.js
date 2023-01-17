import { LightningElement } from 'lwc';
import getFilteredPokemon from '@salesforce/apex/PokemonsService.getFilteredPokemon';



export default class PokemonList extends LightningElement {

	// VARIABLES FOR PAGED:
	// All data
	allData = [];

	// Current page index
	pageNumber = 0;
	
	// Current page data rows
	pageData = [];


	// VARIABLES FOR FILTERS:
	searchText = '';
	generation = 'All';
	type = 'All';


	handleLoadPokemonsPage() {
        getFilteredPokemon({ searchText: this.searchText, generation: this.generation, type: this.type })
        .then((result) => {
            this.allData = result;
			this.updatePage();
        })
        .catch((error) => {
            this.error = error;
        });
    }


	get getType () {
		return (this.type === 'All');
	}

	get getGen () {
		return (this.generation === 'All');
	}


	connectedCallback() {
		// Initialize pages
		this.handleLoadPokemonsPage();
	}


	// Set current page state
	updatePage() {
		this.pageData = this.allData.slice(this.pageNumber * 10, this.pageNumber * 10 + 10);
	}
	
	// Back a page
	previous() {
		this.pageNumber = Math.max(0, this.pageNumber - 1);
		this.updatePage();
	}

	// Back to the beginning
	first() {
		this.pageNumber = 0;
		this.updatePage();
	}
	
	// Forward a page
	next() {
		this.pageNumber = Math.min(Math.floor((this.allData.length - 9) / 10), this.pageNumber + 1);
		this.updatePage();
	}

	// Forward to the end
	last() {
		this.pageNumber = Math.floor((this.allData.length - 9) / 10);
		this.updatePage();
	}



	// FILTER BY POKEMON NAME
	handleSearchTextChange(event) {
		
		// console.log(event.detail.value);
        window.clearTimeout(this.delayTimeout);
		const searchText = event.target.value;
		
		// eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout =  setTimeout(() => {
			this.searchText = searchText;
			this.handleLoadPokemonsPage();
		}, 100);
	}


	// FILTER BY POKEMON GENERATION
	get optionsGeneration () {
		return [
			{ label: 'All', value: 'All' },
			{ label: '1ra', value: '1ra' },
			{ label: '2da', value: '2da' },
			{ label: '3ra', value: '3ra' },
			{ label: '4ta', value: '4ta' },
			{ label: '5ta', value: '5ta' },
			{ label: '6ta', value: '6ta' },
			{ label: '7ma', value: '7ma' },
			{ label: '8va', value: '8va' }
		];
	}

	handleGeneracionChange(event) {

		// console.log(event.detail.value);
		window.clearTimeout(this.delayTimeout);
		const generation = event.target.value;

		// eslint-disable-next-line @lwc/lwc/no-async-operation
		this.delayTimeout = setTimeout(() => {
			this.generation = generation;
			this.handleLoadPokemonsPage();
		}, 300);
	}


	// FILTER BY POKEMON TYPE 
	get optionsType () {
		return [
			{ label: 'All', value: 'All' },
			{ label: 'Normal', value: 'Normal' },
			{ label: 'Fighting', value: 'Fighting' },
			{ label: 'Flying', value: 'Flying' },
			{ label: 'Poison', value: 'Poison' },
			{ label: 'Ground', value: 'Ground' },
			{ label: 'Rock', value: 'Rock' },
			{ label: 'Bug', value: 'Bug' },
			{ label: 'Ghost', value: 'Ghost' },
			{ label: 'Steel', value: 'Steel' },
			{ label: 'Fire', value: 'Fire' },
			{ label: 'Water', value: 'Water' },
			{ label: 'Grass', value: 'Grass' },
			{ label: 'Electric', value: 'Electric' },
			{ label: 'Psychic', value: 'Psychic' },
			{ label: 'Ice', value: 'Ice' },
			{ label: 'Dragon', value: 'Dragon' },
			{ label: 'Dark', value: 'Dark' },
			{ label: 'Fairy', value: 'Fairy' }
		];
	}

	handleTypeChange(event) {
		// console.log(event.detail.value);
		this.type = event.detail.value;
		this.handleLoadPokemonsPage();
	}

}