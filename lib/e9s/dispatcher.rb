
module E9s
  module Dispatcher
    extend self
    
    def init
      ActionController::Dispatcher.to_prepare :e9s_formtastic do
        if defined? ::Formtastic::SemanticFormBuilder
          ::Formtastic::SemanticFormBuilder.send :include, E9s::Formtastic unless ::Formtastic::SemanticFormBuilder.included_modules.include? E9s::Formtastic
        end
      end
    end
    
  end
end

E9s::Dispatcher.init
