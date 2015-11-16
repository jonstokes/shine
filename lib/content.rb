module Content
  def self.client
    @client ||= Contentful::Client.new(
      access_token: Figaro.env.contentful_access_token,
      space:        Figaro.env.contentful_space,
      api_url:      Figaro.env.contentful_api_url
    )
  end
end