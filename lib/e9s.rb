
module E9s
  extend self
  
  MODULES = %w(i18n pluralization)
  
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
