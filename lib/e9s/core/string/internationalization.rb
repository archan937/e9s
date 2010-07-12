
module E9s
  module Core
    module String
      module Internationalization

        def self.included(base)
          base.send :include, InstanceMethods
        end
        
        module InstanceMethods
          def t(options = {})
            self.split(" ").collect do |string|
              key              = string.include?(".") ? string.dup : "word.#{string}"
              default          = key.split(".").last
              translating_word = key.starts_with?("word.")
    
              key.downcase!
              options[:pluralize]          ||= true
              options[:translate_callback] ||= LOGGER_PROC if RAILS_ENV == "development"

              if options.include? :default
                options[:default] = [options[:default]].flatten << default.humanize
                s = i18n_t key, options
                s = s[:_base] if s.is_a?(Hash)
                value = s.dup
              else
                s = i18n_t key, options.merge({:default => translating_word ? "" : default.humanize})
                value = s.dup
    
                if translating_word
                  unless translated = !s.empty?
                    key.singularize!
                    s = i18n_t key, options.merge({:default => ""})
                    value = s.dup
                  end
      
                  if s.empty?
                    s = default.humanize
                    value = s.dup
                  else
                    s = s.pl(options[:count]) unless !options[:pluralize] or (options[:count].nil? and default.dup.pluralize!)
                  end
                end
              end
      
              unless s.gsub!(/^=\s+/, "")
                s.cp_case! options[:capitalize] ? default.capitalize : default
              end
              
              EnrichedString.new s, {:key => string, :actual_key => key, :actual_value => value}
      
            end.join(" ")
          end
          
        private

          E9S_OPTIONS = [:count, :pluralize, :capitalize, :translate_callback]
          LOGGER_PROC = Proc.new{|translation, key, options| puts "INFO: I18n.t #{key.inspect}, #{options.inspect}"}
          
          @@i18n_translations = {}

          def i18n_t(key, opts = {})
            options = opts.inject({}) do |hash, (k, v)|
                        hash[k] = v.is_a?(String) && v.include?("<i18n") ? v.gsub(/(\<i18n[^\>]+\>)|(\<\/i18n\>)/, "") : v unless E9S_OPTIONS.include?(k)
                        hash
                      end
            
            k = "#{key.inspect}, #{options.inspect}"
            translation = (@@i18n_translations[k] ||= I18n.t(key, options).dup)
            opts[:translate_callback].try :call, translation, key, options
    
            translation
          end
        end
                
      end
    end
  end
end
