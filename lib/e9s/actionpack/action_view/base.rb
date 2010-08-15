
module ActionView
  class Base

    def e9s
      ::E9s::MODULES.collect do |mod|
        if respond_to?(method = "rich_#{mod}")
          send(method)
        end
      end.compact.join("\n")
    end
    
    def link(name, options = nil)
      options = {:class => options || name.underscore} unless options.is_a?(Hash)
      link_to name, "#", options
    end

  end
end
