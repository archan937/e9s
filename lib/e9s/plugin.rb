
module E9s
  module Plugin
    extend self
    
    def method_missing(method, *args)
      warn "DEPRECATION WARNING: E9s::Plugin is deprecated (use E9s::Engine instead) (called from #{caller.first.inspect})"
      Engine.send method, *args
    end
    
  end
end
