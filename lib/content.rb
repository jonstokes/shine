module Content

  def self.client
    @client ||= Contentful::Client.new(
      access_token: Figaro.env.contentful_access_token,
      space:        Figaro.env.contentful_space,
      api_url:      Figaro.env.contentful_api_url
    )
  end

  def self.sync_each_item(initial: false)
    Contentful.client.sync(initial: initial).each_item do |item|
      yield item
    end
  end

  def self.sync_each_deletion(initial: false)
    Contentful.client.sync(initial: initial, type: 'Deletion').each_item do |item|
      yield item
    end
  end

  def self.locale
    @locale ||= Figaro.env.locale
  end

  def self.cid_to_class_name(cid)
    case cid
    when Figaro.env.post_id
      "Post"
    when Figaro.env.author_id
      "Author"
    when Figaro.env.category_id
      "Category"
    else
      "Asset"
    end
  end
end