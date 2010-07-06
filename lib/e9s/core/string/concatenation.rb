
module E9s
  module Core
    module String
      module Concatenation
        
        def self.included(base)
          base.class_eval do
            alias_method :original_init_copy    , :initialize_copy
            alias_method :original_add_string   , :+
            alias_method :original_concat_string, :<<
          
            alias_method :initialize_copy, :e9s_init_copy
            alias_method :+              , :e9s_string_add
            alias_method :<<             , :e9s_string_concat
            alias_method :concat         , :e9s_string_concat
          end
        end
        
        def e9s_init_copy(s)
          original_init_copy(s)
          @enriched_string = s.instance_variable_get :@enriched_string
        end
        
        def e9s_string_add(s)
          EnrichedString.new(original_add_string(s)).push(s)
        end
      
        def e9s_string_concat(s)
          to_enriched_string.push s
          original_concat_string s
        end
      
        def to_enriched_string
          (@enriched_string ||= EnrichedString.new(self) unless frozen?) || self
        end
                
      end
    end
  end
end
