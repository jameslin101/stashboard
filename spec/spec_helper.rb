require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'clearance/testing'

require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  
  config.before(:each) do
    DatabaseCleaner.clean
  end
  
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def login_user 
  @user = User.create!(:email => "test@test.com", :password => "password")
  visit sign_in_path
  fill_in "Email", with: "test@test.com"
  fill_in "Password", with: "password"
  click_button "Sign in"
end

def create_service(name,desc)
  # From homepage, see post listing
  visit services_path
  click_button "Add service"

  page.current_path.should == new_service_path
  page.should have_content "New Service"

  fill_in "Name", with: name
  fill_in "Description", with: desc

  click_button "Create"
  sleep 3
end

def create_status(msg)
  visit services_path
  click_button "Statuses"
  page.find("title").should have_content "List of Statuses"
  click_button "Add status"
  choose('The service is up')
  fill_in "status_message", with: msg 
  click_button "Create Status"     
  sleep 3
end