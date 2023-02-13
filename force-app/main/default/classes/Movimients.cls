public with sharing class Movimients {   

    public Integer id;
    public String name;
    public Integer accuracy;
    public String effect_chance;
    public Integer power;
    public Integer pp;
    public Integer priority;
    public cls_target target;
    public cls_type type;
    public cls_effect_entries[] effect_entries;
        
    public class cls_effect_entries {
        public String effect;	            
        public String short_effect;	         
    }
    
    public class cls_type{
        public cls_type[] type;
        public String name;
    }
        
    public class cls_target{
        public cls_target[] target;
        public String name;                 
    } 
        
    public static Movimients parse(String json) {
        return (Movimients) System.JSON.deserialize(json, Movimients.class);    
    }  
}