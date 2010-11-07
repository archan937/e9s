
module ActionView
  class Base

    def e9s
      ::E9s::MODULES.collect do |mod|
        if respond_to?(method = "rich_#{mod}")
          send(method)
        end
      end.compact.join("\n").html_safe
    end

  end
end
