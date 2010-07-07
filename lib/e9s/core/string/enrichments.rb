puts "enrichments"
module E9s
  module Core
    module String
      module Enrichments
        
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
          returning original_init_copy(s) do |result|
            result.merged_strings.replace s.merged_strings.dup
            result.meta_data = s.meta_data if result.is_a?(EnrichedString)
          end
        end
        
        def merged_strings
          @merged_strings ||= []
        end
        
        def e9s_string_add(s)
          return original_add_string(s) unless enriched_string? or s.enriched_string?
          
          strings = merged_strings.dup
          strings << self.dup if strings.empty?
          
          returning original_add_string(s) do |result|
            result.merged_strings.replace strings
            result.merged_strings << s.dup
            result.merged_strings.each{|x| x.merged_strings.clear}
          end
        end
        
        def e9s_string_concat(s)
          return original_concat_string(s) unless enriched_string? or s.enriched_string?
          
          strings = merged_strings.dup
          strings << self.dup if strings.empty?
          
          returning original_concat_string(s) do |result|
            result.merged_strings.replace strings
            result.merged_strings << s.dup
            result.merged_strings.each{|x| x.merged_strings.clear}
          end
        end
        
        def to_output
          merged_strings.empty? ?
            to_es :
            merged_strings.collect(&:to_output).join(" ")
        end
        
        def enriched_string?
          is_a?(EnrichedString) or merged_strings.any?(&:enriched_string?)
        end
        
      end
    end
  end
end
