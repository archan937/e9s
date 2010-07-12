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
            assert_equal ""   , "".upcase_first
            assert_equal "E9s", "e9s".upcase_first
            assert_equal "E9S", "E9S".upcase_first
          end
          
          test "cp_case" do
            assert_equal "BTW"                   , "btw".cp_case("VAT")
            assert_equal "huis"                  , "huis".cp_case("house")
            assert_equal "Welkom thuis"          , "Welkom thuis".cp_case("Welcome home")
            assert_equal "Welkom bij CodeHero.es", "welkom bij CodeHero.es".cp_case("Welcome at CodeHero.es")
          end
          
          test "upcase_first!" do
            assert_equal nil  , "".upcase_first!
            assert_equal "E9s", "e9s".upcase_first!
            assert_equal nil  , "E9s".upcase_first!
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