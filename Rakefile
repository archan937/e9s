require "rake"
require "rake/testtask"
require "rake/rdoctask"

begin
  require "jeweler"
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "e9s"
    gemspec.summary     = "Enrichments (e9s) for a pluggable CMS, internationalization (i18n) and localized pluralization"
    gemspec.description = "E9s was created due to the need of simply implementing I18n within a Rails application. This simplifies internationalization of your Rails application making a Rails developers life much easier. E9s is divided into modules (as gem and plugin): Rich-CMS (http://github.com/archan937/rich_cms) , Rich-i18n (http://github.com/archan937/rich_i18n) and Rich-pluralization (http://github.com/archan937/rich_pluralization)."
    gemspec.email       = "paul.engel@holder.nl"
    gemspec.homepage    = "http://codehero.es/rails_gems_plugins/e9s"
    gemspec.author      = "Paul Engel"

    gemspec.add_dependency "rich_cms"          , ">= 2.1.1"
    gemspec.add_dependency "rich_i18n"         , ">= 1.3.1"
    gemspec.add_dependency "rich_pluralization", ">= 1.0.6"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

desc "Default: run unit tests."
task :default => :test

desc "Test the e9s plugin."
Rake::TestTask.new(:test) do |t|
  t.libs    << "lib"
  t.libs    << "test"
  t.pattern  = "test/**/*_test.rb"
  t.verbose  = true
end

desc "Generate documentation for the e9s plugin."
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "E9s"
  rdoc.options << "--line-numbers" << "--inline-source"
  rdoc.rdoc_files.include "README"
  rdoc.rdoc_files.include "MIT-LICENSE"
  rdoc.rdoc_files.include "lib/**/*.rb"
end