
module E9s
  module Core
    module ERB
      module Output
        
        def self.included(base)
          base.class_eval do
            alias_method_chain :push, :e9s
          end
        end
      
        def push_with_e9s(cmd)
          push_without_e9s cmd.match(/^#{@compiler.insert_cmd}\(\(.*\)\.to_s\)$/) ? cmd.gsub(/to_s\)$/, "print)") : cmd
        end
        
      end
    end
  end
end
