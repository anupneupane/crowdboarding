# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

# Capybara.default_driver = :selenium

def login!(email = "user@example.com", password = "secret")
  visit(new_user_session_path)
  within("form#user_new") do
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
  end
  find_button('Sign in').click
end

def create_a_user!(email = "user@example.com", password = "secret")
  @user = Factory(:user, :email => email, :password => password)
end

def create_user_and_login!(email = "user@example.com", password = "secret")
  create_a_user!(email, password)
  login!(email, password)
end
