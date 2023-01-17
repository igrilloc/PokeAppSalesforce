public with sharing class Abilities {
    
    public String Name;
    public Integer id;
    
    public cls_effect_entries[] effect_entries;

    public class cls_effect_entries {
        public String effect;          
        public cls_language language;
        public String short_effect;     
    }

    public class cls_language {
		public String name;	            // en
		public String url;	            // https://pokeapi.co/api/v2/language/9/
	}

    public static Abilities parse(String json){
		return (Abilities) System.JSON.deserialize(json, Abilities.class);
	}
}
