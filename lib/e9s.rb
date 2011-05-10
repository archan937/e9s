require "e9s/engine"
require "e9s/actionpack"
require "e9s/version"

module E9s
  extend self

  MODULES = %w(cms i18n pluralization)

  def require_modules
    MODULES.each do |mod|
      require "rich_#{mod}"
    end
  rescue LoadError => e
    # Re-raise as RuntimeError because Mongrel would swallow LoadError.
    raise e.to_s
  end

end

E9s.require_modules