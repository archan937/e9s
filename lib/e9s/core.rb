
Dir[File.join(File.dirname(__FILE__), "core", "*.rb")].each do |file|
  require file
end
