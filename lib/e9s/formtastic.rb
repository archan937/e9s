
module Formtastic
  module Enrichments
    
    def self.included(base)
      base.alias_method_chain :input, :enrichments
    end

    def input_with_enrichments(*args)
      object      = (@object.class.name.underscore if @object) || @object_name.match(/\[(\w+)_attributes\]/).captures.first
      method      = args.shift
      options     = args.extract_options!
      wrapper_tag = options.delete(:wrapper_tag)

      unless options.include?(:label)
        keys = [:"label.#{object}.#{method.to_s.capitalize}", :"label.#{method}", :"word.#{method}", method.to_s.humanize]
        
        if @options.include?(:name)
          keys.unshift :"label.forms.#{@options[:name]}.#{object}.#{method.to_s.capitalize}"
          keys.unshift :"label.forms.#{@options[:name]}.#{method.to_s.capitalize}"
        end
        
        options[:label] = keys.shift.t :default => keys
      end
      
      unless options.include?(:seatholder)
        keys = [:"seatholder.#{object}.#{method}", :"seatholder.#{method}", method, ""]
        
        if @options.include?(:name)
          keys.unshift :"seatholder.forms.#{@options[:name]}.#{object}.#{method.to_s.capitalize}"
          keys.unshift :"seatholder.forms.#{@options[:name]}.#{method.to_s.capitalize}"
        end
        
        seatholder = keys.shift.t :default => keys
        options[:seatholder] = seatholder unless seatholder.empty? 
      end
      
      (options[:input_html] ||= {}).store :seatholder, options.delete(:seatholder) unless @object && @object.respond_to?(:errors) && !@object.errors[method.to_sym].blank?
      
      if (output = input_without_enrichments method, options) and wrapper_tag
        output.gsub(/^\<li/, "<#{wrapper_tag}").gsub(/\<\/li\>$/, "</#{wrapper_tag}>")
      else
        output
      end
    end
    
  end  
end

Formtastic::SemanticFormBuilder.send :include, Formtastic::Enrichments if defined?(Formtastic::SemanticFormBuilder)
