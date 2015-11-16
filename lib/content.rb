module Content
  def self.sync!
    client.sync.each_item do |entry|
      klass = case entry.content_type.id
      when Post.contenful_id
        Post
      when Author.contenful_id
        Author
      when Category.contenful_id
        Category
      end

      klass.upsert_from_entry(entry)
    end
  end

  def self.client
    @client ||= Contentful::Client.new(
      access_token: Figaro.env.contentful_access_token,
      space:        Figaro.env.contentful_space,
      api_url:      Figaro.env.contentful_api_url
    )
  end

  def self.extract_asset(asset)
    asset.fields[:file].properties
  end
end