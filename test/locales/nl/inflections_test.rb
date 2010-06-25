require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "test_helper.rb"))

module E9s
  module Test
    module Locales
      module NL

        class InflectionsTest < ActiveSupport::TestCase
          setup do
            include Setup
            I18n.locale = ::E9s::Engine.init(self)
          end
        
          test "dutch_pluralizations" do
            assert_equal "vinnen"             , "vin".pl
            assert_equal "tassen"             , "tas".pl
            assert_equal "telefoons"          , "telefoon".pl
            assert_equal "vragen"             , "vraag".pl
            assert_equal "huizen"             , "huis".pl
            assert_equal "brieven"            , "brief".pl
            assert_equal "broeken"            , "broek".pl
            assert_equal "tekens"             , "teken".pl
            assert_equal "begrafenissen"      , "begrafenis".pl
            assert_equal "diners"             , "diner".pl
            assert_equal "jubilea"            , "jubileum".pl
            assert_equal "festivals"          , "festival".pl
            # assert_equal "vazen"              , "vaas".pl
            # assert_equal "vragen & antwoorden", "vraag & antwoord".pl
          end
        end
            
      end
    end
  end
end