class Post < ActiveRecord::Base
  validates :contentful_id, presence: true

  def self.upsert_from_entry(entry)
    if post = Post.find_by(contentful_id: entry.id)
      post.update(hash_from_entry(entry))
    else
      create(hash_from_entry(entry))
    end
  end

  def self.contentful_id
    @contentful_id ||= Figaro.env.author_id
  end

  def self.hash_from_entry(post)
    {
      title:          post.fields[:title],
      slug:           post.fields[:slug],
      author:         post.fields[:author].map { |author| Author.hash_from_entry(author) },
      body:           post.fields[:body],
      category:       post.fields[:category].map { |category| Category.hash_from_entry(category) },
      tags:           post.fields[:tags],
      featured_image: Content.extract_asset(entry.fields[:featured_image]),
      date:           post.fields[:date],
      comments:       post.fields[:comments]
    }
  end
end