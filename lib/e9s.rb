
module E9s
  module Plugin
    extend self
    
    def init
      AVAILABLE_LOCALES.each do |locale|
        I18n.locale = locale
        
        (I18n.t! "e9s" rescue []).each do |type, inflections|
          inflections.each do |inflection|
            E9s::Inflector.inflections.send type, inflection
          end
        end
      end
      
      I18n.locale = I18n.default_locale
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
      
      # result = begin
      #            if count == 1
      #              s
      #            elsif ends_with?("s")
      #              self
      #            else
      #              {
      #                "ja"               => "ja",
      #                "vraag"            => "vragen",
      #                "bod"              => "biedingen",
      #                "aanvraag"         => "aanvragen",
      #                "organisatie"      => "organisaties",
      #                "aanbieder"        => "aanbieders",
      #                "vraag & antwoord" => "vragen & antwoorden",
      #                "anoniem"          => "anoniem"
      #              }[self] || "#{self}en"
      #            end
      #          end
      # [count, result].compact.join " "
      
    end
    
    class Inflections
      include Singleton

      attr_reader :singulars, :plurals, :irregulars, :uncountables
      attr_writer :locale

      def initialize
        %w(singulars plurals irregulars uncountables).each do |x|
          instance_variable_set :"@#{x}", {}
        end
        @locale = I18n.default_locale
      end
      
      def singular(*args)
        add_inflection :singulars , *args
      end
      
      def plural(*args)
        add_inflection :plurals   , *args
      end
      
      def irregular(*args)
        add_inflection :irregulars, *args
      end
      
      # def uncountable(*args)
      #   (@uncountables[locale_for args.last] ||= []).concat words
      # end
      
      def dump
        puts "SINGULARS   : #{@singulars   .inspect}"
        puts "PLURAL      : #{@plurals     .inspect}"
        puts "IRREGULARS  : #{@irregulars  .inspect}"
        puts "UNCOUNTABLES: #{@uncountables.inspect}"
        puts "LOCALE      : #{@locale      .inspect}"
      end
      
    private
    
      def add_inflection(type, *args)
        inflections = instance_variable_get(:"@#{type}")
        locale      = locale_for       *args
        inflection  = Inflection.build *args
        
        (inflections[locale] ||= []).push inflection
      end
    
      def locale_for(*args)
        locale = args.first.is_a?(Hash) ? args.first[:locale] : args[3]
        
        [locale, @locale].detect{|x| x.is_a?(Symbol)} || I18n.default_locale
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
      
    def inflect(type, word)
      (Inflections.instance.send(type)[I18n.locale] || []).each do |inflection|
        if result = inflection.inflect!(word)
          return result
        end
      end
      word
    end
    
  end
end
