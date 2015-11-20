require 'shine'
require 'rails'

module Shine
  class Railtie < Rails::Railtie
    railtie_name :shine

    rake_tasks do
      load "tasks/shine_tasks.rake"
    end
  end
end
