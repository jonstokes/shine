module Content
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