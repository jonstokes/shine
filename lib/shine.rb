require "shine/engine"
require 'figaro'
require 'troupe'
require 'kramdown'
require 'rest_client'
require "font-awesome-sass"
require 'bootswatch-rails'
require 'bootstrap-sass'
require 'bh'
require 'react-rails'

module Shine
  UUID_REGEXP = /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/i

  class Configuration < Struct.new(:access_token, :space, :api_url, :locale); end

  def self.configuration
    @configuration ||= Configuration.new(
      Figaro.env.contentful_access_token,
      Figaro.env.contentful_space,
      Figaro.env.contentful_api_url,
      Figaro.env.locale
    )
  end

  def self.connection
    @connection ||= RestClient::Resource.new(
      "https://#{configuration.api_url}",
      timeout: 5
    )
  end

  def self.locale
    configuration.locale
  end
end
