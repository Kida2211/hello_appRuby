require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "Sample App", full_title
    assert_equal "Help | Sample App", full_title("Help")
  end
end

