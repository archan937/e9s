
(required_files = %w(object string enriched_string)).each do |file|
  require "e9s/core/#{file}"
end

Dir[File.join(File.dirname(__FILE__), "core", "*.rb")].each do |file|
  require file unless required_files.include?(File.basename file, ".rb")
end
