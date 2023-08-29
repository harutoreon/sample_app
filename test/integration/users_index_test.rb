require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
    
  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_select "h1", "All users"
    assert_select 'ul.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end