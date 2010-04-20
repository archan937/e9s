
class String
  def upcase_first
    empty? ?
      self :
      self[0].chr.capitalize + self[1, size]
  end
  
  def upcase_first!
    self     == (result = upcase_first)       ? nil : replace(result)
  end
  
  def pluralize!
    downcase == (result = pluralize).downcase ? nil : replace(result)
  end
  
  def cp_case(s)
    send((:downcase unless s.dup.downcase!) || (:upcase unless s.dup.upcase!) || (:upcase_first unless s.dup.upcase_first!) || :to_s)
  end
  
  def t(options = {})
    self.split(" ").collect do |string|
      
      key              = string.include?(".") ? string : "word.#{string}"
      default          = key.split(".").last
      translating_word = key.starts_with?("word.")
      opts             = {:pluralize => true}.merge(options)
    
      key.downcase!

      if options.include? :default
        puts "INFO: I18n.t #{key.inspect}, #{options.reject{|k, v| k == :pluralize}.inspect}" if RAILS_ENV == "development"
        s = I18n.t key, options.reject{|k, v| k == :pluralize}
        s = s[:_base] if s.is_a?(Hash)
      else
        puts "INFO: I18n.t #{key.inspect}, #{opts.merge({:default => translating_word ? "" : default.humanize}).reject{|k, v| k == :pluralize}.inspect}" if RAILS_ENV == "development"
        s = I18n.t key, opts.merge({:default => translating_word ? "" : default.humanize}).reject{|k, v| k == :pluralize}
    
        if translating_word
          unless translated = !s.empty?
            puts "INFO: I18n.t #{key.singularize.inspect}, #{opts.merge({:default => ""}).reject{|k, v| k == :pluralize}.inspect}" if RAILS_ENV == "development"
            s = I18n.t key.singularize, opts.merge({:default => ""}).reject{|k, v| k == :pluralize}
          end
      
          if s.empty?
            s = default.humanize
          else
            s = s.pl(opts[:count]) unless !opts[:pluralize] or (opts[:count].nil? and default.dup.pluralize!)
          end
        end
      end
    
      s.gsub!(/^=\s+/, "") ? s : s.cp_case(default)
      
    end.join " "
  end
  
  def s
    E9s::Inflector.singularize self
  end
  
  def pl(count = nil)
    E9s::Inflector.pluralize self, count
  end
end
