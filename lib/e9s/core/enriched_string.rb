puts "enriched_string"
module E9s
  module Core
    class EnrichedString < ::String
      
      attr_accessor :meta_data
      
      def initialize(s = "", meta_data = nil)
        super s
        @meta_data = meta_data || (s.meta_data.try(:dup) if s.is_a?(EnrichedString)) || {}
      end
      
      def to_es
        @meta_data.empty? ? 
          to_s : 
          "<i18n #{@meta_data.collect{|k, v| "data-#{k}=#{v.inspect}"}.join(" ")}>#{to_s}</i18n>"
      end
        
    end
  end
end

EnrichedString = E9s::Core::EnrichedString
