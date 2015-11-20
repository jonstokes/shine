source 'https://rubygems.org'

# Declare your gem's dependencies in shine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'better_errors'
end

group :test do
  gem 'rspec-rails',  "~> 3.4"
  gem 'factory_girl_rails', "~> 4.4"
  gem "database_cleaner", "~> 1.2"
  gem 'webmock'
end
