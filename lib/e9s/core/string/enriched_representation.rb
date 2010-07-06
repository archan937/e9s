
module E9s
  module Core
    module String
      module EnrichedRepresentation
        
        def to_es
          @enriched_string.try(:to_es) || to_s
        end
        
      end
    end
  end
end
