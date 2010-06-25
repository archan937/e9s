require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "test_helper.rb"))

module E9s
  module Test
    module Core
      module String

        class InflectionsTest < ActiveSupport::TestCase
          setup do
            include Setup
          end
        
          test "upcase_first" do
            assert_equal ""   .upcase_first, ""
            assert_equal "e9s".upcase_first, "E9s"
            assert_equal "E9S".upcase_first, "E9S"
          end
      
          # test "cp_case" do
          #   assert true
          # end
      
          test "upcase_first!" do
            assert_equal ""   .upcase_first!, nil
            assert_equal "e9s".upcase_first!, "E9s"
            assert_equal "E9s".upcase_first!, nil
          end
      
          # test "pluralize!" do
          #   assert true
          # end
      
          # test "s" do
          #   assert true
          # end
      
          # test "pl" do
          #   assert true
          # end
        end
      end
   
    end 
  end
end