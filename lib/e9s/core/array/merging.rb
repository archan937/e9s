
module E9s
  module Core
    module Array
      module Merging
        
        def self.included(base)
          base.class_eval do
            alias_method_chain :join, :e9s
          end
        end
        
        def join_with_e9s(sep = "")
          if size == 1 && first.is_a?(EnrichedString)
            first
          else
            merged_strings = dup
            result = join_without_e9s(sep)
            result.merged_strings = merged_strings
            result
          end
        end
        
      end
    end
  end
end
