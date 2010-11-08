class EnrichmentsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
    @user        = options[:user]
    @content     = options[:content]
    @translation = options[:translation]
  end

  def manifest
    record do |m|
      # do something
    end
  end

  def after_generate
    system "script/generate rich_authlogic_user   #{options[:user]       }" unless options[:user]        && options[:user]       .empty?
    system "script/generate rich_cms_content      #{options[:content]    }" unless options[:content]     && options[:content]    .empty?
    system "script/generate rich_i18n_translation #{options[:translation]}" unless options[:translation] && options[:translation].empty?

    system "rake db:migrate" if options[:migrate]
  end

protected

  def add_options!(opt)
    opt.separator ""
    opt.separator "Options:"
    opt.on("-u", "--user"       , "The name of the Authlogic user model which is User at default."         ) { |v| options[:user]        = v == true ? "" : v }
    opt.on("-c", "--content"    , "The name of the CMS content model which is CmsContent at default."      ) { |v| options[:content]     = v == true ? "" : v }
    opt.on("-t", "--translation", "The name of the I18n translation model which is Translation at default.") { |v| options[:translation] = v == true ? "" : v }
    opt.on("-m", "--migrate"    , "Run 'rake db:migrate' after generating model and migration."            ) {     options[:migrate]     =      true          }
  end

  def banner
    <<-EOS
Creates entities used by Enrichments (e9s).

USAGE: #{$0} #{spec.name}
EOS
  end

end