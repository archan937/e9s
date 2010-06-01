
module E9s
  module Plugin
    extend self
    
    attr_accessor :taggify_restriction
    
    def init(test_class = nil)
      if test_class
        test_locale = test_class.name.demodulize.downcase.to_sym
        
        I18n.load_path = ["vendor/plugins/e9s/locales/#{test_locale}.yml"]
      else
        I18n.load_path += Dir[Rails.root.join("vendor", "plugins", "e9s", "locales", "*.yml")]
      end

      I18n.backend.reload!
      E9s::Inflector.inflections.reset_attrs if test_class
      
      initial_locale = I18n.locale
      
      I18n.backend.available_locales.each do |locale|
        I18n.locale = locale
        
        E9s::Inflector.inflections locale do |inflections|
          (I18n.t! "e9s" rescue []).each do |type, entries|
            entries.each do |inflection|
              inflections.send *[type, inflection].flatten
            end
          end
        end
      end
      
      I18n.locale = initial_locale
      
      test_locale
    end
    
  end
  
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
    
    class Inflections
      include Singleton

      attr_reader :singulars, :plurals, :irregulars, :uncountables
      attr_writer :locale

      def initialize
        set_attrs
      end
      
      def set_attrs
        %w(singulars plurals irregulars uncountables).each do |x|
          instance_variable_set :"@#{x}", {}
        end
        @locale = I18n.default_locale
      end
      alias :reset_attrs :set_attrs
      
      def singular(*args)
        add_inflection :singulars, *args
      end
      
      def plural(*args)
        add_inflection :plurals  , *args
      end
      
      def irregular(*args)
        locale, s, pl = extract_args(*args)
        (@irregulars[locale] ||= {})[s.to_s] = pl
      end
      
      def uncountable(*args)
        locale, words = extract_args(*args)
        (@uncountables[locale] ||= []).concat [words].flatten
      end
      
      def dump
        puts "SINGULARS   : #{@singulars   .inspect}"
        puts "PLURAL      : #{@plurals     .inspect}"
        puts "IRREGULARS  : #{@irregulars  .inspect}"
        puts "UNCOUNTABLES: #{@uncountables.inspect}"
        puts "LOCALE      : #{@locale      .inspect}"
      end
      
    private
    
      def add_inflection(type, *args)
        locale, values = extract_args(*args)
        inflections    = instance_variable_get(:"@#{type}")
        inflection     = Inflection.build values
        
        (inflections[locale] ||= []).push inflection
      end
    
      def extract_args(*args)
        locale = begin
                   if args.last.is_a?(Symbol)
                     args.pop
                   elsif args.last.is_a?(Hash)
                     args.delete(:locale)
                   end
                 end
                 
        args.unshift [locale, @locale].detect{|x| x.is_a?(Symbol)} || I18n.default_locale
      end
    
      Inflection = Struct.new(:rule, :replacement, :exceptions) do

        def self.build(*args)
          self.new *(args.first.is_a?(Hash) ? args.first.values_at(*%w(rule replacement exceptions)) : args)
        end
        
        def exceptions
          (self[:exceptions] || "").downcase.split(",").collect{|x| x.strip}
        end
        
        def rule
          Regexp.new self[:rule], Regexp::IGNORECASE
        end
        
        def inflect(word)
          if exceptions.include?(word.downcase)
            word
          else
            word.dup.gsub!(rule, self[:replacement]) || word
          end
        end
        
        def inflect!(word)
          (result = inflect(word)) == word ? nil : result
        end
        
        def inspect
          to_hash.inspect
        end
        
        def to_hash
          Hash[*members.zip(values).flatten]
        end
        
      end
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
