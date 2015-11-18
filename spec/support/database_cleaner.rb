require "database_cleaner"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, :js => true) do
    # truncation misses the sequences
    sequences = ActiveRecord::Base.connection.query("SELECT sequence_name FROM information_schema.sequences").flatten - ["delayed_jobs_id_seq"]
    commands  = sequences.map {|name| "DROP SEQUENCE #{name};"}
    ActiveRecord::Base.connection.execute(commands.join("\n"));
  end
end

