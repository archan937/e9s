require File.expand_path(File.join(File.dirname(__FILE__), "test_helper.rb"))

module E9s
  module Test

    class Symbol < ActiveSupport::TestCase
      test "t" do
        assert true
      end
    end
    
  end
end