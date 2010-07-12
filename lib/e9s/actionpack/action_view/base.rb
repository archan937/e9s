
module ActionView
  class Base

    def render_with_e9s(*args, &block)
      (html = render_without_e9s(*args, &block)).include?("<i18n ") ?
        ::E9s::Actionpack::ActionView::Sanitizor.sanitize_html(html) :
        html
    end
    alias_method_chain :render, :e9s

  end
end
