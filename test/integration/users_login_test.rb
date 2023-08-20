require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_select "h1", "Log in"
    
    post login_path, params: { session: { email: "", password: "" } }
    assert_select "h1", "Log in"
    
    assert_not flash.empty?
    
    get root_path
    assert flash.empty?  # ここでテストが落ちる予定
  end
end
