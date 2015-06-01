ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "support/wait_for_ajax"
require "capybara/poltergeist"

# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include WaitForAjax, type: :feature

  config.before(:suite) do
    Warden.test_mode!
    WebMock.disable_net_connect!(allow_localhost: true)
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    driver = Capybara.current_driver
    strategy = driver == :rack_test ? :transaction : :truncation
    DatabaseCleaner.strategy = strategy
    DatabaseCleaner.start
  end

  config.after(:each) do
    Warden.test_reset!
    DatabaseCleaner.clean
  end

  # Mock Fog for carrierwave uploads to S3
  Fog.mock!
  Fog.credentials_path = "#{Rails.root}/config/fog_credentials.yml"
  connection = Fog::Storage.new(provider: "AWS")
  connection.directories.create(key: "mv-profile-pics")
end
