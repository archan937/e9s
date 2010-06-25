require "test_helper"

module E9s
  module Test

    class EngineTest < ActiveSupport::TestCase
      setup do
        include Setup
        I18n.locale = ::E9s::Engine.init(Locales::NL)
      end
      
      # test "something" do
      #   assert true
      # end
    end
    
  end
end