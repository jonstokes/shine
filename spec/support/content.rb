def load_request(type:, action:)
  filename = if type == "asset"
    "ContentManagement.Asset.#{action}.json"
  else
    "ContentManagement.Entry.#{action}.json"
  end
  JSON.load(Rails.root.join('spec', 'fixtures', 'requests', type, filename))
end

module Content

  def self.delta_list=(list)
    @delta_list = list
  end

  def self.deletion_list=(list)
    @deletion_list = list
  end

  def self.delta_list
    @delta_list || []
  end

  def self.deletion_list
    @deletion_list || []
  end

  def self.sync_each_item(initial: false)
    delta_list.each do |item|
      yield item
    end
  end

  def self.sync_each_deletion(initial: false)
    deletion_list.each do |item|
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


def file_double(properties: nil)
  properties ||= {}
  double(
    "Contentful::File",
    properties: {
      :fileName => "lewis-carroll-1.jpg",
      :contentType => "image/jpeg",
      :details => {:image => {:width => 300, :height => 250}, :size => 21113},
      :url => "//images.contentful.com/rwvjblw7dr6a/2ReMHJhXoAcy4AyamgsgwQ/30a953013843db486c9adcc6282843d9/lewis-carroll-1.jpg"
    }.merge(properties.deep_symbolize_keys)
  )
end

def asset_double(id: nil, fields: nil)
  id ||= "2ReMHJhXoAcy4AyamgsgwQ"
  fields ||= {}
  double(
    "Contentful::Asset",
    sys: {
      type: "Asset",
      id: id
    },
    fields: {
      file: file_double,
      title: "Image file",
      description: "Image"
    }.merge(fields.deep_symbolize_keys),
    type: "Asset",
    id: id
  )
end

def author_double(id: nil, fields: nil)
  id ||= "3kTFGSVVi86OGOcA6ckqsk"
  fields ||= {}
  double(
    "Contentful::Entry",
    fields: {
      name: "Jon Stokes",
      website: "http://jonstokes.com",
      profilePhoto: asset_double,
      biography: "Jon Stokes is a swell guy."
    }.merge(fields.deep_symbolize_keys),
    sys: {
      type: "Entry",
      id: id
    },
    type: "Entry",
    id: id,
    content_type: double(
      "Contentful::Link",
      id: Figaro.env.author_id
    )
  )
end

def category_double(id: nil, fields: nil)
  id ||= "4Zk6ihvUM8Y0GcYiY24sq"
  fields ||= {}
  double(
    "Contentful::Entry",
    fields: {
      title: "Dogs",
      icon: asset_double
    }.merge(fields.deep_symbolize_keys),
    sys: {
      type: "Entry",
      id: id
    },
    type: "Entry",
    id: id,
    content_type: double(
      "Contentful::Link",
      id: Figaro.env.category_id
    )
  )
end

def post_double(id: nil, author: nil, category: nil, featured_image: nil)
  id ||= "2gUGl8pte0ug8QwoisiiI0"
  author ||= author_double
  category ||= category_double
  featured_image ||= asset_double

  double(
    "Contentful::Entry",
    fields: {
      title:         "This is a test entry",
      slug:          "this-is-a-test-entry",
      author:        [author],
      body:          "I am testing this entry.\n\n![Ernest Hemingway (1950)](//images.contentful.com/rwvjblw7dr6a/3S1ngcWajSia6I4sssQwyK/eacba4033620dcd5d36e985aa3271a55/Ernest_Hemingway_1950.jpg)\n\nThat is a picture of Papa.",
      category:      [category],
      tags:          ["foo", "bar"],
      featuredImage: featured_image,
      date:          "2015-11-17",
      comments:      true
    },
    sys: {
      type: "Entry",
      id: id
    },
    type: "Entry",
    id: id,
    content_type: double(
      "Contentful::Link",
      id: Figaro.env.post_id
    )
  )
end