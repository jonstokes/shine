# Shine

Shine is a blog engine for `rails` apps that uses contentful.com as a CMS.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shine

## Setup

Shine uses `figaro` to set environment variables, and it uses postgres to cache content for two reasons, 1) so that you get an nice AR interface to your data, and 2) to cut down on API calls to contentful.com.

To set up the required `application.yml` and database migrations, do

`rails generate shine`

Then

`rake db:migrate`

Now you're ready to import your content into your rails blog, which you can do with a rake task:

`rake shine:sync_all`

If you've put the correct credentials and ids into `config/application.yml`, then this rake task will sync all of your entries and assets into postgres.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jonstokes/shine.

