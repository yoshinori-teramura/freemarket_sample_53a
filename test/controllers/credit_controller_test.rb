require 'test_helper'

class CreditControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get credit_new_url
    assert_response :success
  end

  test "should get show" do
    get credit_show_url
    assert_response :success
  end

end
