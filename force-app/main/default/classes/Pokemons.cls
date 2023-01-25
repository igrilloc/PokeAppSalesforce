public with sharing class Pokemons {
    
	public Integer id;	                // 25
	public String name;	                // Pikachu
	public Integer order;	            // 1
    public Integer height;	            // 60
	public cls_sprites sprites;
	public cls_types[] types;
	public Integer weight;	            // 69
	public cls_abilities[] abilities;
	public cls_versions versions;
	public cls_stats[] stats;
	public cls_moves[] moves;

	
	public class cls_moves {
		public cls_move move;
	}

	public class cls_move {
		public String name;	            // razor-wind
		public String url;	            // https://pokeapi.co/api/v2/move/13/
	}

	class cls_stats {
		public Integer base_stat;	    // 45
		public Integer effort;	        // 0
		public cls_stat stat;
	}

	public class cls_stat {
		public String name;	            // hp
		public String url;	            // https://pokeapi.co/api/v2/stat/1/
	}

	public class cls_versions {
		public cls_generationi generationi;
	}

	public class cls_generationi {
		public cls_redblue redblue;
	}

	public class cls_redblue {
		public String back_default;	      // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/3.png
		public String back_gray;	      // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/gray/3.png
		public String back_transparent;	  // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/back/3.png
		public String front_default;	  // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/3.png
		public String front_gray;	      // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/gray/3.png
		public String front_transparent;  // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/3.png
	}

	public class cls_abilities {
		public boolean is_hidden;
		public Integer slot;			
		public cls_ability ability;
	}
	
	public class cls_ability {
		public String name;	            
		public String url;	            
	}

	public class cls_sprites {
		public cls_other other;
	}

	public class cls_other {
		public cls_home home;
	}

	public class cls_home {
		public String front_default;
	}
	
	public class cls_types {
		public Integer slot;	        
		public cls_type type;
	}

	public class cls_type {
		public String name;	            
		public String url;	            
	}

    public static Pokemons parse(String json) {
        return (Pokemons) System.JSON.deserialize(json, Pokemons.class);
    }
}