
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
            
            attr_accessor :enriched_string
          end
        end
        
        def e9s_init_copy(s)
          result = original_init_copy s
          result.merged_strings = s.merged_strings.dup if s.respond_to?(:merged_strings) and s.merged_strings
          result
        end
        
        def e9s_string_add(s)
          if enriched_string?
            self.dup.enriche(s)
          else
            s.enriched_string? ? EnrichedString.new(self).enriche(s) : original_add_string(s)
          end
        end
      
        def e9s_string_concat(s)
          if self.is_a?(String)
            s.is_a?(EnrichedString) ? (@enriched_string = )           : original_concat_string(s)
          else
            self.dup.enriche(s)
          end
          original_concat_string s
        end
      
        def enriched_string?
          to_enriched_string.is_a?(EnrichedString)
        end
        
      private
        
        def to_enriched_string(s)
          if self.is_a?(EnrichedString) or frozen?
            self
          elsif s
            (@enriched_string ||= EnrichedString.new(self)).enriche(s)
          end
        end
                
      end
    end
  end
end
