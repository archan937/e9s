
module E9s
  module Core
    module String
      module Enrichments
        
        # TODO: override String literals (e.g. "foo") and interpolation (e.g. "foo #{"bar".t}")
        
        def self.included(base)
          base.class_eval do
            alias_method :original_init_copy    , :initialize_copy
            alias_method :original_add_string   , :+
            alias_method :original_concat_string, :<<
            alias_method :original_gsub_string  , :gsub!
            
            alias_method :initialize_copy, :e9s_init_copy
            alias_method :+              , :e9s_add_string
            alias_method :<<             , :e9s_concat_string
            alias_method :concat         , :e9s_concat_string
          end
        end
        
        def e9s_init_copy(s)
          returning original_init_copy(s) do |result|
            result.merged_strings.replace s.merged_strings.dup
            result.meta_data = s.meta_data if result.is_a?(EnrichedString)
          end
        end
        
        def e9s_add_string(s)
          return original_add_string(s) unless enriched_string? or s.enriched_string?

          strings = merged_strings.dup
          strings << self.dup if strings.empty?
          
          returning original_add_string(s) do |result|
            result.merged_strings.replace strings
            result.merged_strings << s.dup
            result.merged_strings.each{|x| x.merged_strings.clear}
          end
        end
        
        def e9s_concat_string(s)
          return original_concat_string(s) unless enriched_string? or s.enriched_string?
          
          merged_strings << (is_a?(EnrichedString) ? EnrichedString.new(self, meta_data) : to_s) if merged_strings.empty?
          
          returning original_concat_string(s) do |result|
            result.merged_strings << s.dup
            result.merged_strings.each{|x| x.merged_strings.clear}
          end
        end
        
        def merged_strings
          @merged_strings ||= []
        end
        
        def enriched_string?
          is_a?(EnrichedString) or merged_strings.any?(&:enriched_string?)
        end
        
        def to_output
          merged_strings.empty? ?
            to_es :
            merged_strings.collect(&:to_output).join
        end
        
      end
    end
  end
end

# module IRB
#   class Irb
#     alias_method :original_prompt, :prompt
#     def prompt(*args, &block)
#       result = original_prompt(*args, &block)
#       puts result.inspect
#       result
#     end
#     
#     alias_method :original_eval_input, :eval_input
#     def eval_input(*args, &block)
#       result = original_eval_input(*args, &block)
#       puts result.inspect
#       result
#     end
#   end
# end

# class RubyLex
#   def identify_string_with_e9s(*args)
#     result = identify_string_without_e9s(*args)
#     puts (result.methods - Object.methods).sort
#     result
#   end
#   alias_method_chain :identify_string, :e9s
# end

# module Kernel
#   alias_method :original_eval, :eval
#   def eval(*args, &block)
#     puts args.inspect
#     result = original_eval(*args, &block)
#     puts result.inspect
#     result
#   end
# end
