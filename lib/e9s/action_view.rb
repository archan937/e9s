
module ActionView
  class Base

    def render_with_e9s(*args, &block)
      old_value = String.taggify_translations
      if ::E9s::Plugin.taggify_restriction.nil? || send(::E9s::Plugin.taggify_restriction)
        String.taggify_translations = true
        ::E9s::ActionView.sanitize_html render_without_e9s(*args, &block)
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

module E9s
  module ActionView
    extend self
    
    require "hpricot"
    
    def sanitize_html(html)
      return html unless (html || "").include?("<i18n ")
      
      doc = Hpricot html

      (doc/"head i18n").each do |i18n|
        i18n.swap i18n.inner_html
      end

      (doc/"i18n").each do |i18n|
        elem = Hpricot::Elem.new "span", i18n.raw_attributes.merge({:class => "i18n"})
        elem.inner_html = i18n.inner_html
        i18n.swap elem.to_html
      end

      (doc/"input").each do |input|
        sanitize_input(input)
      end

      (doc/"textarea").each do |input|
        sanitize_input(input)
      end

      doc.to_html
    rescue
      html.gsub(/(\<i18n[^\>]+\>)|(\<\/i18n\>)/, "")
    end
    
    def sanitize_input(input)
      %w(value seatholder).each do |input_attr|
        next unless input.attributes[input_attr].include?("<i18n ")

        i18n = Hpricot(input.attributes[input_attr]).children.first
        i18n.raw_attributes.each do |key, value|
          input.attributes[key] = value
        end
        
        input.attributes[input_attr] = i18n.inner_html
        input.attributes["class"] = ["i18n", input.attributes["class"]].uniq.join(" ").strip
      end
        
      input
    end
    
  end
end
