ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)

require "rspec/rails"
require "factory_girl_rails"
require "webmock/rspec"

abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
ActiveRecord::Migration.maintain_test_schema!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include(FactoryGirl::Syntax::Methods)

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  config.order = :random
end
