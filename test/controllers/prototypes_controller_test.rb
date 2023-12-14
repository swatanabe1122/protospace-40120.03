require "test_helper"

class PrototypesControllerTest < ActionDispatch::IntegrationTest
  test "should get indx" do
    get prototypes_indx_url
    assert_response :success
  end
end
