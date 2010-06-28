
module E9s
  module Core
    module String
      module Inflections
        
        def upcase_first
          empty? ?
            self :
            self[0].chr.capitalize + self[1, size]
        end
  
        def cp_case(s)
          send((:downcase unless s.dup.downcase!) || (:upcase unless s.dup.upcase!) || (:upcase_first unless s.dup.upcase_first!) || :to_s)
        end
  
        def upcase_first!
          self == (result = upcase_first) ? nil : replace(result)
        end
  
        def cp_case!(s)
          self == (result = cp_case(s))   ? nil : replace(result)
        end
  
        def singularize!
          downcase == (result = singularize).downcase ? nil : replace(result)
        end
  
        def pluralize!
          downcase == (result = pluralize).downcase   ? nil : replace(result)
        end
  
        # def s
        #   E9s::Inflector.singularize self
        # end
  
        def pl(count = nil)
          E9s::Inflector.pluralize self, count
        end
                
      end
    end
  end
end
