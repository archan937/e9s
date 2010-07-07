
module E9s
  module Core
    class EnrichedString < String
      
      attr_accessor :meta_data
      attr_accessor :enriched_strings
      
      def initialize(s = "", meta_data = nil)
        super s
        @meta_data        = meta_data || (s.meta_data.dup        if s.is_a?(EnrichedString)) || {}
        @enriched_strings =              (s.enriched_strings.dup if s.is_a?(EnrichedString)) || []
      end
      
      def enriche(s)
        @enriched_strings << self.dup if @enriched_strings.empty?
        @enriched_strings << s.dup
        self
      end
      
      def to_es
        @enriched_strings.empty? ?
          to_i18n_tag :
          @enriched_strings.collect(&:to_es).join(" ")
      end
      
    private
      
      def to_i18n_tag
        @meta_data.empty? ? 
          to_s : 
          "<i18n #{@meta_data.collect{|k, v| "data-#{k} = #{v.inspect}"}.join(" ")}>#{to_s}</i18n>"
      end
        
    end
  end
end

# class Array
#   EnrichedString = E9s::Core::EnrichedString
#   
#   def join_with_e9s(sep = "")
#     # if any?{|x| x.is_a? EnrichedString}
#     #   collect(&:to_s).join(sep.to_s_xss_protected).mark_as_xss_protected
#     # else
#       join_without_e9s(sep)
#     # end
#   end
#   alias_method_chain :join, :e9s
# end
