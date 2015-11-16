module Content
  def self.sync!
    client.sync.each_item do |entry|
      klass = if entry.fields[:name]
        Author
      elsif entry.fields[:slug]
        Post
      else
        Category
      end
      klass.create_or_update_from_entry(entry)
    end
  end

  def self.client
    @client ||= Contentful::Client.new(
      access_token: Figaro.env.contentful_access_token,
      space:        Figaro.env.contentful_space,
      api_url:      Figaro.env.contentful_api_url
    )
  end
end