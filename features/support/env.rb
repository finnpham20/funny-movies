require 'cucumber/rails'
require 'selenium-webdriver'
require 'pry'
require 'capybara'

ActionController::Base.allow_rescue = false

begin
  require 'database_cleaner-active_record'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Capybara.configure do |config|
  config.server_port = 4888
  config.javascript_driver = :headless_chrome
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu --no-sandbox])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.server = :puma, { Silent: true }
