
require "e9s/core/object"
require "e9s/core/string"
require "e9s/core/enriched_string"

Dir[File.join(File.dirname(__FILE__), "core", "*.rb")].each do |file|
  require file unless %w(object string enriched_string).include?(File.basename file, ".rb")
end
