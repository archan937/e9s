
module I18n
  class << self
    def available_locales; backend.available_locales; end
  end
  
  module Backend
    class Simple
      def available_locales; translations.keys.sort{|a, b| a.to_s <=> b.to_s}; end
    end
  end
end

I18n.backend.send(:init_translations)
AVAILABLE_LOCALES = I18n.backend.available_locales
