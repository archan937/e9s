class EnrichmentsGenerator < Rails::Generators::Base

  desc         "Creates entities used by Enrichments (e9s)"
  class_option :user_model       , :type => :string , :default => "User"       , :aliases => "-u" , :desc => "The name of the Authlogic user model."
  class_option :content_model    , :type => :string , :default => "CmsContent" , :aliases => "-c" , :desc => "The name of the CMS content model."
  class_option :translation_model, :type => :string , :default => "Translation", :aliases => "-t" , :desc => "The name of the I18n translation model."
  class_option :migrate          , :type => :boolean, :default => false        , :aliases => "-m" , :desc => "Run 'rake db:migrate' after generating model and migration"

  def generate_rich_cms_files
    generate "rich:authlogic_user", options[:user_model]
    generate "rich:cms_content", options[:content_model]
  end

  def generate_rich_i18n_files
    generate "rich:translation", options[:translation_model]
  end

  def migrate
    rake "db:migrate" if options[:migrate]
  end

end