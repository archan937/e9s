module GemSuit
  class IntegrationTest

    # def login
    #   visit "/login"
    #   fill_in_and_submit "form#login", {:Email => "paul.engel@holder.nl", :Password => "test"}, "Login"
    # end

    # def logout
    #   find("a#logout").click_link "Logout"
    # end

    # def fill_in_and_submit(selector, with, submit)
    #   within "#{selector} fieldset.inputs" do
    #     with.each do |key, value|
    #       begin
    #         fill_in key.to_s, :with => value
    #       rescue Selenium::WebDriver::Error::ElementNotDisplayedError
    #         page.execute_script "var input = $('#{selector} [name=\"#{key}\"]');" +
    #                             "if (input.data('cleditor')) {" +
    #                             "  input.val('#{value}');" +
    #                             "  input.data('cleditor').updateFrame();" +
    #                             "}"
    #       end
    #     end
    #   end
    #   find(selector).find_button(submit).click
    #   sleep 2
    # end

    # def say_hello
    #   page.execute_script "Hello, you!"
    # end

  end
end