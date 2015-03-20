require 'test_helper'

class SignInControllerTest < ActionController::TestCase
  test "should get signIn" do
    get :signIn
    assert_response :success
  end

end
