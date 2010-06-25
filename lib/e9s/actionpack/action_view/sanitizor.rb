
module E9s
  module Actionpack
    module ActionView
      module Sanitizor
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
    
      private
    
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
  end
end
