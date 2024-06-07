require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael) # Retrieve a user from fixtures, adjust as per your setup
    mail = UserMailer.account_activation(user) # Pass the user object to the method
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi #{user.name}", mail.body.encoded
  end

  test "password_reset" do
    user = users(:michael) # Retrieve a user from fixtures, adjust as per your setup
    mail = UserMailer.password_reset(user) # Pass the user object to the method
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi #{user.name}", mail.body.encoded
  end
end
