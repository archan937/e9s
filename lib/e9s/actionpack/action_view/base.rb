
module ActionView
  class Base

    def render_with_e9s(*args, &block)
      old_value = String.taggify_translations
      if ::E9s::Engine.taggify_restriction.nil? || (send(::E9s::Engine.taggify_restriction) rescue nil)
        String.taggify_translations = true
        ::E9s::Actionpack::ActionView::Sanitizor.sanitize_html render_without_e9s(*args, &block)
      else
        String.taggify_translations = false
        render_without_e9s(*args, &block)
      end
    ensure
      String.taggify_translations = old_value
    end
    alias_method_chain :render, :e9s

  end
end
