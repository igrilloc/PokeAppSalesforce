public with sharing class Pokemons {

	public Integer id;	                
	public String name;	                	            
	public Integer weight;	            
    public Integer height;	            
	public cls_sprites sprites;
	public cls_types[] types;
	public cls_abilities[] abilities;
	public cls_stats[] stats;
	public cls_moves[] moves;
	
	public class cls_moves {
		public cls_move move;
	}

	public class cls_move {
		public String name;	            
		public String url;	           
	}

	class cls_stats {
		public Integer base_stat;	    
		public Integer effort;	        
		public cls_stat stat;
	}

	public class cls_stat {
		public String name;	            
		public String url;	            
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