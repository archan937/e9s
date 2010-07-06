
module E9s
  module Core
    class EnrichedString < String
      
      def initialize(s, meta_data = {}, concats = [])
        super s
        @meta_data = meta_data
        @concats   = concats
        # puts "EnrichedString #{s} #{@meta_data.inspect} #{@concats.inspect}"
      end
      
      def push(s)
        @concats << s.to_enriched_string
        self
      end
        
      def to_es
        @concats.empty? ?
          to_i18n_tag : 
          @concats.collect(&:to_es).join(" ")
      end
      
      def to_i18n_tag
        @meta_data.empty? ? 
          to_s : 
          "<i18n #{@meta_data.collect{|k, v| "data-#{k} = #{v.inspect}"}.join(" ")}>#{to_s}</i18n>"
      end
        
    end
  end
end

# class Array
#   def join_with_e9s(sep = "")
#     s = E9s::Core::EnrichedString.new(join_without_e9s(sep), {}, collect{|x| x.instance_variable_get(:@concats)}.flatten)
#     puts s.to_i18n_tag
#     s
#   end
#   alias_method_chain :join, :e9s
# end
