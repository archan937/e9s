
module E9s  
  module Inflector
    extend self
    
    def inflections(locale = nil)
      Inflections.instance.locale = locale
      if block_given?
        yield Inflections.instance
      else
        Inflections.instance
      end
    end
    
    def singularize(word)
      inflect :singulars, word
    end
    
    def pluralize(word, count = nil)
      count == 1 ? singularize(word) : inflect(:plurals, word)
    end
    
  private
    
    [:singulars, :plurals, :irregulars, :uncountables].each do |type|
      define_method type do
        (Inflections.instance.send(type)[I18n.locale] || (type == :uncountables ? [] : {}))
      end
    end
      
    def inflect(type, word)
      return word if uncountable?(word) or irregular_counterpart?(type, word)
      
      if irregular = irregulars[word.downcase]
        return irregular.cp_case(word)
      end
      
      send(type).each do |inflection|
        if result = inflection.inflect!(word)
          return result.cp_case(word)
        end
      end
      
      word
    end
    
    def uncountable?(word)
      uncountables.include?(word.downcase)
    end
    
    def irregular_counterpart?(type, word)
      irregulars.send({:singulars => :keys, :plurals => :values}[type]).include?(word.downcase)
    end
    
  end
end
