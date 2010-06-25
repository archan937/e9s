
namespace :e9s do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.verbose    = false
    t.test_files = FileList.new("vendor/plugins/e9s/test/**/*.rb") do |list|
                     # list.exclude "foo.rb"
                   end
  end
  Rake::Task["e9s:test"].comment = "Run the e9s plugin tests"
end
