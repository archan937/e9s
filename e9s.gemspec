# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "e9s/version"

Gem::Specification.new do |s|
  s.name        = "e9s"
  s.version     = E9s::VERSION::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Engel"]
  s.email       = ["paul.engel@holder.nl"]
  s.homepage    = "http://codehero.es/rails_gems_plugins/e9s"
  s.summary     = %q{Enrichments (e9s) for a pluggable CMS, internationalization (i18n) and localized pluralization}
  s.description = %q{E9s was created due to the need of simply implementing I18n within a Rails application. This simplifies internationalization of your Rails application making a Rails developers life much easier. E9s is divided into modules (as gems): Rich-Support (http://github.com/archan937/rich_support), Rich-CMS (http://github.com/archan937/rich_cms), Rich-i18n (http://github.com/archan937/rich_i18n) and Rich-pluralization (http://github.com/archan937/rich_pluralization).}

  s.rubyforge_project = "e9s"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rich_cms"          , "~> 3.1.0"
  s.add_dependency "rich_i18n"         , "~> 1.4.0"
  s.add_dependency "rich_pluralization", "~> 1.0.7"
end