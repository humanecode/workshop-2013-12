require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def mike
    @mike ||= users :mike
  end

  def test_show_login_form
    get :new
    assert_response :success
  end

  def test_log_in_with_valid_credentials
    post :create, user: { email: mike.email, password: "mike" }
    assert_redirected_to root_url
  end

  def test_wont_log_in_with_invalid_credentials
    post :create, user: { email: mike.email, password: "mike".reverse }
    assert_response :success
    assert_template :new
  end

  def test_destroy
    delete :destroy
    assert_redirected_to root_url
  end
end
