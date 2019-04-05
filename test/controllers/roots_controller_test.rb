require 'test_helper'

class RootsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get roots_top_url
    assert_response :success
  end

  test "should get admin_top" do
    get roots_admin_top_url
    assert_response :success
  end

end
