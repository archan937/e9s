# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{e9s}
  s.version = "2.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Engel"]
  s.date = %q{2010-11-24}
  s.description = %q{E9s was created due to the need of simply implementing I18n within a Rails application. This simplifies internationalization of your Rails application making a Rails developers life much easier. E9s is divided into modules (as gem and plugin): Rich-CMS (http://github.com/archan937/rich_cms) , Rich-i18n (http://github.com/archan937/rich_i18n) and Rich-pluralization (http://github.com/archan937/rich_pluralization).}
  s.email = %q{paul.engel@holder.nl}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "MIT-LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "e9s.gemspec",
     "init.rb",
     "install.rb",
     "lib/e9s.rb",
     "lib/e9s/actionpack.rb",
     "lib/e9s/actionpack/action_view/base.rb",
     "lib/e9s/engine.rb",
     "lib/generators/enrichments/enrichments_generator.rb",
     "rails/init.rb",
     "rails_generators/enrichments/enrichments_generator.rb",
     "tasks/e9s_tasks.rake",
     "test/test_helper.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://codehero.es/rails_gems_plugins/e9s}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Enrichments (e9s) for a pluggable CMS, internationalization (i18n) and localized pluralization}
  s.test_files = [
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rich_cms>, [">= 2.1.6"])
      s.add_runtime_dependency(%q<rich_i18n>, [">= 1.3.4"])
      s.add_runtime_dependency(%q<rich_pluralization>, [">= 1.0.6"])
    else
      s.add_dependency(%q<rich_cms>, [">= 2.1.6"])
      s.add_dependency(%q<rich_i18n>, [">= 1.3.4"])
      s.add_dependency(%q<rich_pluralization>, [">= 1.0.6"])
    end
  else
    s.add_dependency(%q<rich_cms>, [">= 2.1.6"])
    s.add_dependency(%q<rich_i18n>, [">= 1.3.4"])
    s.add_dependency(%q<rich_pluralization>, [">= 1.0.6"])
  end
end

