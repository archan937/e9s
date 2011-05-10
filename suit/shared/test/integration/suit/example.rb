require File.expand_path("../../../suit_application.rb", __FILE__)

SuitApplication.test

class ExampleTest < GemSuit::IntegrationTest

  context "My example test" do
    setup do
    end

    teardown do
      SuitApplication.restore_all
    end

    should "assert css as expected" do
      visit "/"
      assert page.has_css?    "div#page"
      assert page.has_no_css? "div#paul_engel"

      # Hello World ;)
      page.execute_script <<-SCRIPT
        var div = document.createElement("div");
        div.innerHTML = "<h2>Hi. This is an GemSuit example test!</h2><p><br>Closing in <span id='seconds'>10</span> seconds.</p>";
        var divs = document.getElementsByTagName("div");
        for (var i = 0; i < divs.length; i++) {
          if (divs[i].className == "left") {
            divs[i].appendChild(div);
          }
        }
      SCRIPT

      # Counting down
      10.times do |i|
        sleep 1
        page.execute_script "document.getElementById('seconds').innerHTML = '#{9 - i}';"
      end
    end
  end

end