
Dir.glob(File.join("vendor", "plugins", "e9s", "lib", "**", "*.rb")).each do |file|
  require file
end

E9s::Plugin.init