
class ERB
  class Compiler
    class Buffer
      def push_with_e9s(cmd)
        push_without_e9s cmd#.match(/^#{@compiler.insert_cmd}\(\(.*\)\.to_s\)$/) ? cmd.gsub(/s\)$/, "es)") : cmd
      end
      alias_method_chain :push, :e9s
    end
  end
end
