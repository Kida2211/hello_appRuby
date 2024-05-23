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
end
