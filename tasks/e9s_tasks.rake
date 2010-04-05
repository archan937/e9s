namespace :e9s do
  Rake::TestTask.new :test do |t|
    t.libs << "test"
    t.verbose    = false
    t.test_files = FileList.new("vendor/plugins/e9s/test/**/*.rb") do |list|
                     # list.exclude "foo.rb"
                   end
  end
  Rake::Task["test:plugins"].comment = "Run tests for e9s"
end