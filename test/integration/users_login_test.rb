require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid information followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

class RememberingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?, "Expected remember_token to be set, but it was not."
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?, "Expected remember_token to be set, but it was not."

    log_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?, "Expected remember_token to be blank, but it was not."
  end
end

class LogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "logging out should redirect to root and user should not be logged in" do
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!

    # Debugging output: print the response body
    puts @response.body

    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  # Log in as a particular user.
  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: 'password' } }
  end
end