
Dir.glob(File.join("**", "lib", "**", "*.rb")).each do |file|
  require file
end
require "e9s"

E9s::Plugin.init