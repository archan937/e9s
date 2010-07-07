
require "e9s/core/string/inflections"
require "e9s/core/string/internationalization"
require "e9s/core/string/enrichments"

class String
  include E9s::Core::String::Inflections
  include E9s::Core::String::Internationalization
  include E9s::Core::String::Enrichments
end
