
module E9s
  module Engine
    extend self
    
    attr_accessor :taggify_restriction
    
    def init(test_class = nil)
      if test_class
        test_locale = test_class.name.demodulize.downcase.to_sym
        
        I18n.load_path = ["vendor/plugins/e9s/locales/#{test_locale}.yml"]
      else
        I18n.load_path += Dir[Rails.root.join("vendor", "plugins", "e9s", "locales", "*.yml")]
      end

      I18n.backend.reload!
      E9s::Inflector.inflections.reset_attrs if test_class
      
      initial_locale = I18n.locale
      
      I18n.backend.available_locales.each do |locale|
        I18n.locale = locale
        
        E9s::Inflector.inflections locale do |inflections|
          (I18n.t! "e9s" rescue []).each do |type, entries|
            entries.each do |inflection|
              inflections.send *[type, inflection].flatten
            end
          end
        end
      end
      
      I18n.locale = initial_locale
      
      test_locale
    end
    
  end
end
