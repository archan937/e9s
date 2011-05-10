module E9s
  module Engine
    extend self

    def method_missing(method, *args)
      MODULES.detect do |mod|
        m = "rich/#{mod}/engine".camelize.constantize

        if m.respond_to?(method)
          m.send method, *args
          true
        end

      end
    end

  end
end