require 'shine'
require 'rails/generators/base'
require "rails/generators/migration"
require "rails/generators/active_record"

module Shine
  class ShineGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_paths << File.join(File.dirname(__FILE__), 'templates')

    def create_config_file
      source = File.open(Shine::Engine.root.join("config", "application.example.yml")) { |f| f.read }
      destination = Rails.root.join("config", "application.yml")

      if File.exists?(destination)
        append_to_file destination, source
      else
        create_file destination, source
      end
    end

    def copy_uploadcare_file
      source = File.open(Shine::Engine.root.join("config", "uploadcare.yml")) { |f| f.read }
      destination = Rails.root.join("config", "uploadcare.yml")

      create_file destination, source
    end

    def create_migration_file
      migration_template "migration.rb", "db/migrate/create_shine_tables.rb"
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number dirname
    end
  end
end