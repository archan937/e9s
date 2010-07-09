
module E9s
  module Core
    module Array
      module Merging
        
        def self.included(base)
          base.class_eval do
            alias_method :join, :e9s_join
          end
        end
        
        def e9s_join(sep = "")
          if size == 1 && first.is_a?(EnrichedString)
            first
          else
            returning ::String.new do |result|
              each_with_index{|s, i| result << "#{s}#{sep unless i == size - 1}"}
            end
          end
        end
        
      end
    end
  end
end
