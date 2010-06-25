
unless defined?(E9s::CONTROLLER_HOOKED)
  
  ActionController::Dispatcher.to_prepare :e9s_formtastic do
    if defined? Formtastic::SemanticFormBuilder
      Formtastic::SemanticFormBuilder.send :include, E9s::Formtastic unless Formtastic::SemanticFormBuilder.included_modules.include? E9s::Formtastic
    end
  end
  
  E9s::CONTROLLER_HOOKED = true
  
end
