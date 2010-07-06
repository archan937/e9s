
require "e9s/core/string/inflections"
require "e9s/core/string/internationalization"
require "e9s/core/string/concatenation"
require "e9s/core/string/enriched_representation"

class String
  include E9s::Core::String::Inflections
  include E9s::Core::String::Internationalization
  include E9s::Core::String::Concatenation
  include E9s::Core::String::EnrichedRepresentation
end
