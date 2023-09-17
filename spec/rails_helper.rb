# frozen_string_literal: true

require 'spec_helper'
require 'shoulda/matchers'
require 'support/chrome'
require 'support/request_spec_helper'
require 'sidekiq/testing'
require 'simplecov'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.before(:each) do
    Sidekiq::Testing.fake!
  end

  Dir[Rails.root.join('spec/supports/**/*.rb')].sort.each { |f| require f }

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Shoulda::Matchers::Independent
end

SimpleCov.start do
  enable_coverage :branch

  add_filter %r{^/config/}
  add_filter %r{^/db/}
  add_filter %r{^/spec/}
  add_filter %r{^/view/}
  add_filter %r{^/app/helper}
  add_filter %r{^/app/jobs}
  add_filter %r{^/app/mailer}

  add_group 'Controllers', 'app/controllers'
  add_group 'Jobs', %w[app/jobs app/workers app/clockworks]
  add_group 'Models', 'app/models'
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Libraries', 'lib/'
  add_group 'ActionCables', 'app/channels'

  track_files "{app,lib}/**/*.rb"
end
