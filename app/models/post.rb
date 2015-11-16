class Post < ActiveRecord::Base
  validates :contentful_id, presence: true

  def self.create_or_update_from_entry(entry)
    if post = Post.find_by(contentful_id: entry.id)
      post.update(attrs_from_entry(entry))
    else
      create(attrs_from_entry(entry))
    end
  end

  def self.attrs_from_entry(entry)
    {
      title:          entry.fields[:title],
      slug:           entry.fields[:slug],
      author:         convert_author(entry.fields[:author]),
      body:           entry.fields[:body],
      category:       convert_category(entry.fields[:category]),
      tags:           entry.fields[:tags],
      featured_image: convert_asset(entry.fields[:featured_image]),
      date:           entry.fields[:date],
      comments:       entry.fields[:comments]
    }
  end
end