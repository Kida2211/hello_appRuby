ENV['RAILS_ENV'] ||= 'test'
# Load Rails
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified number of workers
  parallelize(workers: :number_of_processors)
  
  # Set up all fixtures in test/fixtures/*.yml
  fixtures :all

  # Return true if the test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # Define the full_title method
  def full_title(page_title = '')
    base_title = "Sample App" # Update this to match your actual base title
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # Log in as a test user
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email, password: password, remember_me: remember_me } }
  end
end
