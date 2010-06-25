require "test_helper"

module E9s
  module Test

    class EngineTest < ActiveSupport::TestCase
      setup do
        include Setup
        I18n.locale = ::E9s::Engine.init(Locales::NL)
      end
      
      test "singular_translations" do
        assert_equal "huis"  , "house".t
        assert_equal "straat", "street".t
        assert_equal "vraag" , "question".t
        assert_equal "vraag" , "word.question".t
      end
      
      test "plural_translations" do
        assert_equal "huizen" , "houses".t
        assert_equal "straten", "streets".t
        assert_equal "vragen" , "questions".t
      end
      
      test "cased_translations" do
        assert_equal "meer"   , "more".t
        assert_equal "Huis"   , "House".t
        assert_equal "Straten", "Streets".t
        assert_equal "VRAGEN" , "QUESTIONS".t
      end
      
      test "combined_translations" do
        assert_equal "Meer huizen"        , "More houses".t
        assert_equal "MEER STRATEN"       , "MORE STREETS".t
        assert_equal "meer vragen"        , "more questions".t
        assert_equal "meer vragen"        , "more questions".t
        assert_equal "Vragen & Antwoorden", "Questions & Answers".t
        assert_equal "vraag & antwoord"   , "question & answer".t
        assert_equal "Vraag & antwoord"   , "Question & answer".t
        assert_equal "Man / Vrouw"        , "Male / Female".t
        assert_equal "één huis"           , "one house".t
        # assert_equal "Één huis"           , "One house".t
      end
    end
    
  end
end