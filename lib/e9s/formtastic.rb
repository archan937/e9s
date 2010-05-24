
module E9s
  module Formtastic
    
    def self.included(base)
      base.alias_method_chain :input, :enrichments
    end

    def input_with_enrichments(*args)
      object      = (@object.class.name.underscore if @object) || @object_name.match(/\[(\w+)_attributes\]/).captures.first
      method_arg  = args.shift
      method      = method_arg.to_s
      options     = args.extract_options!
      wrapper_tag = options.delete(:wrapper_tag)

      unless options.include?(:label)
        keys = [:"label.#{object}.#{method}", :"label.#{method}", :"word.#{method}"]
        
        if @options.include?(:name)
          keys.unshift :"label.forms.#{@options[:name]}.#{method}"
          keys.unshift :"label.forms.#{@options[:name]}.#{object}.#{method}"
        end
        
        options[:label] = keys.shift.t :default => keys, :capitalize => true
      end
      
      unless options.include?(:seatholder)
        keys = [:"seatholder.#{object}.#{method}", :"seatholder.#{method}", ""]
        
        if @options.include?(:name)
          keys.unshift :"seatholder.forms.#{@options[:name]}.#{method}"
          keys.unshift :"seatholder.forms.#{@options[:name]}.#{object}.#{method}"
        end
        
        seatholder = keys.shift.t :default => keys, :capitalize => true
        options[:seatholder] = seatholder unless seatholder.empty? 
      end
      
      (options[:input_html] ||= {}).store :seatholder, options.delete(:seatholder) unless @object && @object.respond_to?(:errors) && !@object.errors[method.to_sym].blank?
      
      if (output = input_without_enrichments method_arg, options) and wrapper_tag
        output.gsub(/^\<li/, "<#{wrapper_tag}").gsub(/\<\/li\>$/, "</#{wrapper_tag}>")
      else
        output
      end
    end
    
  end  
end
